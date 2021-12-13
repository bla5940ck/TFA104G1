package com.member.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.model.MailService;
import com.member.model.MemberService;
import com.member.model.MemberVO;

/**
 * Servlet implementation class MemStatusServlet
 */
@WebServlet("/member/MemStatusServlet")
public class MemStatusServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemStatusServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		String actionOne = req.getParameter("actionOne");

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);


//		//單筆查詢停權
//		if ("9".equals(actionOne) ) { // 來自listOneMember.jsp
//
//			errorMsgs = new LinkedList<String>();
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.
//			req.setAttribute("errorMsgs", errorMsgs);
//	
//			try {
//				/***************************1.接收請求參數***************************************/
//				Integer memberId = new Integer(req.getParameter("memberId"));
//				Integer status = new Integer(req.getParameter("actionOne"));
////				Integer status = 9;
//				
//				/***************************2.開始修改資料***************************************/
//				MemberService memSvc = new MemberService();
//				MemberVO memberVO = memSvc.updateStatus(status, memberId);
//				
//				/***************************3.修改準備轉交(Send the Success view)***********/								
//				String url = "/back_end/member/listOneMember.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 修改後,轉交回來源網頁
//				successView.forward(req, res);
////				res.sendRedirect(req.getContextPath() + url);
//				
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("停權失敗:"+e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/back_end/member/listOneMember.jsp");
//				failureView.forward(req, res);
//			}
//		}		
		
		
//		審核更新
		try {
			/*************************** 1.接收請求參數 ****************************************/
			Integer memberId = new Integer(req.getParameter("memberId"));
			Integer status = new Integer(req.getParameter("status"));

			/**************************** 2.開始修改狀態資料****************************************/
			MemberService memSvc = new MemberService();
			MemberVO memberVO = memSvc.updateStatus(status, memberId);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//				req.setAttribute("memberVO", memberVO); // 資料庫取出的memberVO物件,存入req
			String url = "/back_end/member/listAllPdrMember.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 updateList.jsp
//			successView.forward(req, res);
//			一個是跳轉一個內轉
			res.sendRedirect(req.getContextPath() + url);
			/**************************** 4.寄送審核通過通知給使用者 *****************************************/
			memberVO=memSvc.getOneMember(memberId);
			String to = memberVO.getEmail();
			String subject = "【JoyLease】帳號審核通過通知";
			String ch_name =  memberVO.getName();
			String url2 = "/front_end/member/LeaseLogin.jsp";
			String indexUrl =  req.getContextPath() + url2;
			String messageText = "Hello! 親愛的 " + ch_name + "您好~您已通過會員審核，歡迎點選以下連結登入使用 【JoyLease】樂借所平台~ \n"
					+ indexUrl ;
			MailService mailService = new MailService();
			mailService.sendMail(to, subject, messageText);
			/*************************** 其他可能的錯誤處理 **********************************/
		} catch (Exception e) {
			errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
			RequestDispatcher failureView = req.getRequestDispatcher("/back_end/member/listAllPdrMember.jsp");
			failureView.forward(req, res);
		}
		
		
		

	}

}
