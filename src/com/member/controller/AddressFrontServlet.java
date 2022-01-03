package com.member.controller;


import java.io.IOException;

import java.io.PrintWriter;
import java.util.ArrayList;

import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;




import com.member.model.*;


@WebServlet("/member/AddressFrontServlet")
@MultipartConfig()
public class AddressFrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	public AddressFrontServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");

		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		String marketURL="https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&&servicetype=1&url=http://107.167.179.66:8081/TFA104G1/member/AddressFrontServlet";

	
		
		// 711API接收資訊
//		https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&&servicetype=1&url=https://23e7-1-164-222-170.ngrok.io/TFA104G1/member/AddressFrontServlet
//		https://emap.presco.com.tw/c2cemap.ashx?eshopid=870&&servicetype=1&url=https://localhost:8081/TFA104G1/member/AddressFrontServlet
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				String memberId = req.getParameter("membedId");
				String storeid = req.getParameter("storeid");
				String storename = req.getParameter("storename");
				String storeaddress = req.getParameter("storeaddress");
System.out.println(storeid);
System.out.println(storename);
System.out.println(storeaddress);
				/*************************** 2.資料放入list *****************************************/
				List<String> arrayList = new ArrayList<String>();
				arrayList.add(storeid);
				arrayList.add(storename);
				arrayList.add(storeaddress);
				
				/*************************** 3.完成,準備轉交(Send the Success view) *************/
				HttpSession session = req.getSession();
				session.setAttribute("arrayList", arrayList);
				ServletContext context = getServletContext();
				
				System.out.println(context.getAttribute("memberId1"));
				String memberId = context.getAttribute("memberId1").toString();
				
				System.out.println("context memberId : "+memberId);
				System.out.println("存入session");
				session.setAttribute("memberId", memberId);
				System.out.println("session memberId : "+session.getAttribute("memberId").toString());

//				req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
				String url = "/front_end/member/LeasePageAddAddress.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交LeasePageAccount.jsp
//				successView.forward(req, res);
				res.sendRedirect(req.getContextPath()+url);
				return;
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePageAddAddress.jsp");
				failureView.forward(req, res);
				return;	
			}
		
	
			}
		
	}



