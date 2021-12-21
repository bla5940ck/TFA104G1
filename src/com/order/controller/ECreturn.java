package com.order.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			Enumeration en = req.getParameterNames();

			while (en.hasMoreElements()) {
				Object nextElement = en.nextElement();

			}
			System.out.println(req.getParameter("MerchantTradeNo"));
			System.out.println(req.getParameter("RtnMsg"));
			System.out.println(req.getParameter("PaymentDate"));
			System.out.println(req.getParameter("CheckMacValue"));
		}
//	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doGet(req, res);
	}

}
