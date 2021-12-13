package com.member.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.member.model.MemberJDBCDAO;
import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public LoginServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	// 【檢查使用者輸入的帳號(loginId) 密碼(password)是否有效】
	// 【實際上應至資料庫搜尋比對】
	protected boolean allowUser(String loginId, String password) {
		// 進資料庫開始查詢資料
		MemberService memSvc = new MemberService();
		MemberVO memberVO = memSvc.login(loginId, password);
		if (null == loginId || "".equals(loginId) || null == password || "".equals(password) || null == memberVO)
			return false;
//		if (memberVO.getLoginId().equals(loginId) && memberVO.getPassword().equals(password))
		if (loginId.equals(memberVO.getLoginId()) && password.equals(memberVO.getPassword()))
//     if ("123".equals(loginId) && "123".equals(password))
			return true;
		else
			return false;
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		// 【取得使用者 帳號(account) 密碼(password)】
		String loginId = req.getParameter("loginId");
		String password = req.getParameter("password");

//		req.setAttribute("memberVO", memberVO);

		// 【檢查該帳號 , 密碼是否有效】

		if (!allowUser(loginId, password)) { // 【帳號 , 密碼無效時】
			out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
			out.println("<BODY>你的帳號 , 密碼無效或尚未開通!<BR>");
			out.println("請按此重新登入 <A HREF=" + req.getContextPath() + "/front_end/member/LeaseLogin.jsp>重新登入</A>");
			out.println("<BR>或10秒後自動回到登入畫面 ");
			out.println("</BODY></HTML>");
//			設定10秒鐘後自動導回登入畫面
			res.setHeader("Refresh", "10; URL=" + req.getContextPath() + "/front_end/member/LeaseLogin.jsp");
//       res.sendRedirect(req.getContextPath()+"/front_end/member/LeaseLogin.jsp");  
		} else { // 【帳號 , 密碼有效時, 才做以下工作】
			HttpSession session = req.getSession();
			// *工作1: 才在session內做已經登入過的標識

			session.setAttribute("loginId", loginId);
			MemberService memSvc = new MemberService();
			MemberVO memberVO = memSvc.getLoginMember(loginId);
			session.setAttribute("MemberVO", memberVO);
//			System.out.print(memberVO.getLoginId());
//			session.getAttribute("MemberVO");  
			try {
				String location = (String) session.getAttribute("location");

				// *工作2: 看看有無來源網頁 (-->如有來源網頁:則重導至來源網頁)
				if (location != null) {
					session.removeAttribute("location");
					res.sendRedirect(location);
					return;
				}
			} catch (Exception ignored) {
				ignored.printStackTrace(System.err);
			}
			// *工作3: (-->如無來源網頁:則導至出租專區或承租專區.jsp)
			if ("LeaseLogin".equals(action)) {
				/*************************** 開始查詢資料 ****************************************/
//				System.out.println(memberVO.getLoginId());
//				MemberService memSvc = new MemberService();
//				MemberVO memberVO = memSvc.getLoginMember(loginId);

				/*************************** 查詢完成,準備轉交(Send the Success view) *************/

//				session.setAttribute("MemberVO", memberVO);    // 資料庫取出的list物件,存入session
				// Send the Success view
//				String url = "/front_end/member/LeasePage.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllEmp2_getFromSession.jsp
//				successView.forward(req, res);
//				return;
				res.sendRedirect(req.getContextPath() + "/front_end/member/LeasePage.jsp");

			}
			if ("RentLogin".equals(action)) {
				res.sendRedirect(req.getContextPath() + "/front_end/member/RentPage.jsp");

			}
		}
	}
}
