package com.promo.controller;

import java.io.IOException;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class PromoServlet extends HttpServlet {
		public void doGet(HttpServletRequest req,HttpServletResponse res) throws IOException {
			res.setContentType("text/html;charset=utf-8");
			req.setCharacterEncoding("utf-8");
			res.getWriter().print("�д��դ@�U�ݬ�");
		}
		public void doPost(HttpServletRequest req,HttpServletResponse res) throws IOException {
			doGet(req,res);
		}
	
}
