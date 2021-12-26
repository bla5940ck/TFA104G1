package com.order.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterVO;
import com.sun.org.apache.xalan.internal.xsltc.compiler.util.CompareGenerator;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;

@WebServlet("/ECreturn")
public class ECreturn extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("進入回傳");
		req.setCharacterEncoding("UTF-8");

//		if ("1".equals(request.getParameter("EncryptType"))) {
		AllInOne all = new AllInOne("");
		AioCheckOutALL obj = new AioCheckOutALL();
		System.out.println(obj.getMerchantID());
//		Enumeration en = req.getParameterNames();
//		System.out.println("所有參數 : ");
//		while (en.hasMoreElements()) {
//			Object nextElement = en.nextElement();
//			System.out.println(nextElement);
//
//		}

		String paymentDate = req.getParameter("PaymentDate");
		SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy-mm-dd hh:mm:ss");
		System.out.println(paymentDate);

		SimpleDateFormat ssss = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		Date parse = null;
		try {
			parse = ssss.parse(paymentDate);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		java.sql.Timestamp payDate = new java.sql.Timestamp(parse.getTime());

		Integer trfStatus = Integer.valueOf(req.getParameter("RtnCode"));
		if (trfStatus == 1) {
			String ordid = req.getParameter("MerchantTradeNo");
			Integer ordID = Integer.valueOf(ordid.substring(ordid.length() - 4, ordid.length())); //取串接之訂單編號末四碼為訂單編號
			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			OrderMasterVO omVO = omdao.findOrderMasterByPK(ordID);
			
			omVO.setTrfStatus(trfStatus); // 轉帳狀態
			System.out.println("轉帳狀態" + omVO.getTrfStatus());

			omVO.setPayDate(payDate); // 付款日期
			System.out.println("付款日期" + omVO.getPayDate());

			omVO.setPayStatus(1); //付款狀態
			
			omdao.updateOrderMaster(omVO);
		}
	}

//			return;
//	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doGet(req, res);
	}

}
