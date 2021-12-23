package com.order.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Date;
import java.util.Hashtable;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterService;
import com.order.model.OrderMasterVO;

@WebServlet("/QRCodeTest")
public class QRCodeTest extends HttpServlet {

	private String convert2Byte(InputStream input) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buff = new byte[100];
		int length = 0;
		while ((length = input.read(buff, 0, 100)) > 0) {
			baos.write(buff, 0, length);
		}
		byte[] in2b = baos.toByteArray();
		baos.flush();
		baos.close();
		input.close();
		return new String(Base64.getEncoder().encodeToString(in2b));

	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if("toQRcode".equals(action)) {
			
			System.out.println("進來了");
			Integer ordID = Integer.valueOf(req.getParameter("ordID"));
//			String memID = req.getParameter("memID");
			
			OrderMasterService omSVC = new OrderMasterService();
			OrderMasterVO omVO = omSVC.getOneOrderMaster(ordID);
			
			OutputStream os = res.getOutputStream();
			
			byte[] qrcode = omVO.getQrcode();
//			System.out.println(qrcode);
			
			os.write(qrcode);
			os.close();
			
		}
		
		if("check".equals(action)) {
			Integer ordID = Integer.valueOf(req.getParameter("memID"));
			System.out.println("從QR Code來的" + ordID);
			
			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			OrderMasterVO omVO = omdao.findOrderMasterByPK(ordID);
			
			Date date = new Date();
			long ord = date.getTime();
			Timestamp qrdate = new Timestamp(ord);
			
			omVO.setShipStatus(3);
			omVO.setOrdStatus(1);
			omVO.setShipCode(0);
			omVO.setShipDate(qrdate);
			omVO.setArrivalDate(qrdate);
			
			omdao.updateOrderMaster(omVO);
			
			System.out.println("這裡");
		}
		
	}
}
