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

import com.member.model.DefAddressService;
import com.member.model.MemberJDBCDAO;
import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/MemFrontServlet")
public class MemFrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemFrontServlet() {
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
		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();

		if ("updatePassword".equals(action)) { // 來自LeasePagePW.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String loginId = req.getParameter("loginId").trim();
				LoginServlet lgst = new LoginServlet();
				String password = req.getParameter("password").trim();
				String newPW = req.getParameter("newPW").trim();
				String newPW2 = req.getParameter("newPW2").trim();
				if (!newPW.equals(newPW2)) {
					errorMsgs.add("新密碼與確認密碼不相同");
				}
				String pwReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (password == null || password.trim().length() == 0 || newPW == null || newPW.trim().length() == 0
						|| newPW2 == null || newPW2.trim().length() == 0) {
					errorMsgs.add("密碼請勿設定空白");
				} else if (!newPW.trim().matches(pwReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add(" 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}

				if (!lgst.allowUser(loginId, password)) { // 【帳號 , 密碼無效時】
					out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
					out.println("<BODY>原密碼無效!<BR>");
					out.println("請重新輸入 <A HREF=" + req.getContextPath() + "/front_end/member/LeasePagePW.jsp>重新修改</A>");
					out.println("</BODY></HTML>");
					res.setHeader("Refresh", "3; URL=" + req.getContextPath() + "/front_end/member/LeaseLogin.jsp");
				} else { // 【帳號 , 密碼有效時, 才做以下工作】
					MemberService memSvc = new MemberService();
					MemberVO memVO = memSvc.updatePw(newPW2, loginId);

					System.out.println(memVO.getPassword());

					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("memVO", memVO); // 含有輸入格式錯誤的memberVO物件,也存入req
						RequestDispatcher failureView = req.getRequestDispatcher("/emp/update_emp_input.jsp");
						failureView.forward(req, res);
						return; // 程式中斷
						/*************************** 2.開始修改資料 *****************************************/

					}
				}

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("memVO", memVO); // 資料庫update成功後,正確的的memberVO物件,存入req
				String url = "/front_end/member/LeasePagePW.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/update_emp_input.jsp");
				failureView.forward(req, res);
			}
		}

		if ("updateAccount".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer memberId = new Integer(req.getParameter("memberId").trim());

				String bankCode = req.getParameter("bankCode");
				String bankAccount = req.getParameter("bankAccount");
				String accountName = req.getParameter("accountName");
				String reg = "^[(0-9)]{2,20}$";
				String nameReg = "^[(\u4e00-\u9fa5)]{2,20}$";

				if (!accountName.trim().matches(nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("戶名 : 只能是中文, 且長度必需在2到20之間");
				}
				if (!bankAccount.trim().matches(reg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("銀行帳號 : 只能是數字, 且長度必需在2到20之間");
				}

				MemberVO memberVO = new MemberVO();
				memberVO.setMemberId(memberId);
				memberVO.setBankCode(bankCode);
				memberVO.setBankAccount(bankAccount);
				memberVO.setAccountName(accountName);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePageAccount.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemberService memSvc = new MemberService();
				memberVO = memSvc.updateAccount(memberId, bankCode, accountName, bankAccount);
				memberVO = memSvc.getOneMember(memberId);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
				String url = "/front_end/member/LeasePageAccount.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePageAccount.jsp");
				failureView.forward(req, res);
			}
		}

		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
//			System.out.println("111111111111");
			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer def711 = new Integer(req.getParameter("def711"));

				/*************************** 2.開始刪除資料 ***************************************/
				DefAddressService defSvc = new DefAddressService();
				defSvc.deleteDefaddress(def711);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/member/LeasePageAddress.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePageAddress.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
