package com.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MailService;
import com.member.model.MemberService;
import com.member.model.MemberVO;


@WebServlet("/member/MemberForgotPwServlet")
public class MemberForgotPwServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemberForgotPwServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	// 【檢查使用者輸入的Mail(email)是否有效】
	// 【實際上應至資料庫搜尋比對】
	protected boolean allowEmail(String email) {
		// 進資料庫開始查詢資料
		MemberService memSvc = new MemberService();
		MemberVO memberVO = memSvc.findEmail(email);
		if (null == email || "".equals(email) || null == memberVO)
			return false;
		if (email.equals(memberVO.getEmail()))
			return true;
		else
			return false;
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
		System.out.println("111110000000");
		if ("forgetPW".equals(action)) { // 來自update_emp_input.jsp的請求
			System.out.println("222220000000");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String email = req.getParameter("email").trim();

//			String reg = "^[(a-zA-Z0-9_@.)]{2,30}$";

			if (!allowEmail(email)) { // 【EMAIL無效時】
				out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
				out.println("<BODY>Email 不存在<BR>");
				out.println("請重新輸入<A HREF=" + req.getContextPath() + "/front_end/member/LoginForgetPW.jsp>重新修改</A>");
				out.println("</BODY></HTML>");
//				res.setHeader("Refresh", "3; URL=" + req.getContextPath() + "/front_end/member/LeaseLogin.jsp");
			} else { // 【帳號 , 密碼有效時, 才做以下工作】
				try {
					// 取得jsp傳進來的email
					req.setAttribute("email", email);
					MemberService memSvc = new MemberService();
					MemberVO memVO = memSvc.findEmail(email);
					// 亂數取一個新密碼
					String password = getRandomString(8);
					// 取得這個Email的loginId
					String loginId = memVO.getLoginId();
					// 把亂數產生的新密碼更新至資料庫
					System.out.println(password);
					System.out.println(loginId);
					/*************************** 2.開始修改資料 *****************************************/
					memVO = memSvc.updatePw(password, loginId);

					/**************************** 3.寄送新密碼資料給使用者 *****************************************/
					String to = email;
					String subject = "【JoyLease】密碼通知";
					String ch_name = "親愛的【JoyLease】用戶您好~";
					String passRandom = password;
					String messageText = "Hello! " + ch_name + " 請使用此密碼 :【 " + passRandom + "】\n"
							+ " 登入，提醒您盡快登入後更改個人密碼，謝謝";
					MailService mailService = new MailService();
					mailService.sendMail(to, subject, messageText);
					
					/*************************** 4.修改完成,準備轉交(Send the Success view) *************/
					String url = "/front_end/member/LoginForgetPW.jsp";
					out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
					out.println("<BODY>密碼修改成功<BR>");
					out.println("<BR>2秒後回到登入頁面");
					out.println("</BODY></HTML>");
					res.setHeader("Refresh", "2; URL=" + req.getContextPath() + url);

					/*************************** 其他可能的錯誤處理 *************************************/
				} catch (Exception e) {
					errorMsgs.add("修改資料失敗:" + e.getMessage());
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LoginForgetPW.jsp");
					failureView.forward(req, res);
				}
			}
		}
	}

	// 亂數產生新密碼方法
	static String getRandomString(int i) {
		String theAlphaNumericS;
		StringBuilder builder;

		theAlphaNumericS = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + "abcdefghijklmnopqrstuvwxyz" + "_!@" + "0123456789";

		// create the StringBuffer
		builder = new StringBuilder(i);

		for (int m = 0; m < i; m++) {

			// generate numeric
			int myindex = (int) (theAlphaNumericS.length() * Math.random());

			// add the characters
			builder.append(theAlphaNumericS.charAt(myindex));
		}

		return builder.toString();
	}
}
