package com.member.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.Enumeration;
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
import javax.servlet.http.Part;

import com.member.model.DefAddressService;
import com.member.model.DefAddressVO;
import com.member.model.MemberJDBCDAO;
import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/MemFrontServlet")
@MultipartConfig()
public class MemFrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
//	String saveDirectory = "/images_uploaded"; // 上傳檔案的目的地目錄;
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
		res.setContentType("text/html; charset=UTF-8");

		String action = req.getParameter("action");
		PrintWriter out = res.getWriter();
//		String realPath = getServletContext().getRealPath(saveDirectory);
//		File fsaveDirectory = new File(realPath);
		
		// 會員一般資料修改
				if ("updateBasic".equals(action)) { // 來自update_emp_input.jsp的請求
					System.out.println("00000000000");
					List<String> errorMsgs = new LinkedList<String>();
					// Store this set in the request scope, in case we need to
					// send the ErrorPage view.
					req.setAttribute("errorMsgs", errorMsgs);

					try {
						/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
						System.out.println("111111");
						Integer memberId = new Integer(req.getParameter("memberId"));
						String nickName = req.getParameter("nickName").trim();
						
						String email = req.getParameter("email").trim();
						String regex = "^\\w{1,63}@[a-zA-Z0-9]{2,63}\\.[a-zA-Z]{2,63}(\\.[a-zA-Z]{2,63})?$";
						if (!email.matches(regex)) { // 以下練習正則(規)表示式(regular-expression)
							errorMsgs.add("Email格式不正確 : 允許大小寫字母、數字和底線且必須包含@");
						}
						String phoneNum = req.getParameter("phoneNum").trim();
						
						String reg = "^09[0-9]{8}$";
						if (!phoneNum.matches(reg)) { // 以下練習正則(規)表示式(regular-expression)
							errorMsgs.add("手機號碼 : 只能是09開頭數字, 且長度必需在10碼");
						}
						System.out.println("2222222");
//						byte[] pic = reg.getBytes();
//						if (!fsaveDirectory.exists())
//							 fsaveDirectory.mkdirs();
						byte[] pic =null;
						MemberVO memberVO = new MemberVO();
						memberVO.setMemberId(memberId);
						memberVO.setNickName(nickName);
						memberVO.setPhoneNum(phoneNum);
						memberVO.setEmail(email);
						System.out.println("12133333333");
						Part part = req.getPart("file_name1");
						
							String filename = getFileNameFromPart(part);
							System.out.println("121444444");
							InputStream in = part.getInputStream();
							pic = new byte[in.available()];
//							if (filename!= null && part.getContentType()!=null) {
//								String name = part.getName();
//								String ContentType = part.getContentType();
//								long size = part.getSize();
//								System.out.println("121355555");
//								File f = new File(fsaveDirectory, filename);
//								System.out.println("1213666666");
//								part.write(f.toString());
//								part.write(fileName);
								System.out.println("72137777");
								System.out.println("72133333333");
								System.out.println("82133333333");
								in.read(pic);
								in.close();
							
							
//						}
						
						memberVO.setPic(pic);
						System.out.println(memberId);
						System.out.println(nickName);
						System.out.println(phoneNum);
						System.out.println(email);
						System.out.println(pic);
//						memberVO.setBankAccount(bankAccount);
//						memberVO.setAccountName(accountName);
						// Send the use back to the form, if there were errors
						if (!errorMsgs.isEmpty()) {
							System.out.println("3333333");
							req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
							RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePage.jsp");
							failureView.forward(req, res);
							
							return; // 程式中斷
						}

						/*************************** 2.開始修改資料 *****************************************/
						System.out.println("3333344444444");
						MemberService memSvc = new MemberService();
						System.out.println("333335555555");
						memberVO = memSvc.updateMemberBasicInformation(memberId, nickName, email, phoneNum, pic);
						System.out.println("44444444");
						memberVO = memSvc.getOneMember(memberId);
						String loginId = memberVO.getLoginId();
						System.out.println("5555555");
						/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
						HttpSession session = req.getSession();
						// *工作1: 才在session內做已經登入過的標識

						session.setAttribute("memberId", memberId);
//						MemberService memSvc = new MemberService();
						MemberVO memberVO2 = memSvc.getLoginMember(loginId);
						session.setAttribute("MemberVO", memberVO2);
//						req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
						String url = "/front_end/member/LeasePage.jsp";
						RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交LeasePageAccount.jsp
						successView.forward(req, res);

						/*************************** 其他可能的錯誤處理 *************************************/
					} catch (Exception e) {
						System.out.println("666666");
						errorMsgs.add("修改資料失敗:" + e.getMessage());
						RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePage.jsp");
						failureView.forward(req, res);
					}
				}
		
		
		// 密碼修改
		if ("updatePassword".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			String loginId = req.getParameter("loginId");
			String password = req.getParameter("password");
			String newPW = req.getParameter("newPW").trim();
			String newPW2 = req.getParameter("newPW2").trim();

			String reg = "^[(a-zA-Z0-9)]{2,10}$";

			LoginServlet lgst = new LoginServlet();

			if (!lgst.allowUser(loginId, password)) { // 【帳號 , 密碼無效時】
				out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
				out.println("<BODY>原密碼無效!<BR>");
				out.println("請重新輸入 <A HREF=" + req.getContextPath() + "/front_end/member/LeasePagePW.jsp>重新修改</A>");
				out.println("</BODY></HTML>");
//				res.setHeader("Refresh", "3; URL=" + req.getContextPath() + "/front_end/member/LeaseLogin.jsp");
			} else if (!newPW.equals(newPW2)) { // 以下練習正則(規)表示式(regular-expression)
				out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
				out.println("<BODY>newPW!=newPW2<BR>");
				out.println("請重新輸入 <A HREF=" + req.getContextPath() + "/front_end/member/LeasePagePW.jsp>重新修改</A>");
				out.println("</BODY></HTML>");
			} else if (!newPW.trim().matches(reg)) { // 以下練習正則(規)表示式(regular-expression)
				out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
				out.println("<BODY>newPW無效!<BR>");
				out.println("請重新輸入 <A HREF=" + req.getContextPath() + "/front_end/member/LeasePagePW.jsp>重新修改</A>");
				out.println("</BODY></HTML>");
			}

			else { // 【帳號 , 密碼有效時, 才做以下工作】
				HttpSession session = req.getSession();
				// *工作1: 才在session內做已經登入過的標識

				session.setAttribute("loginId", loginId);
				MemberService memSvc = new MemberService();
				MemberVO memVO = memSvc.updatePw(newPW2, loginId);

				// Send the use back to the form, if there were errors

				try {

					MemberVO memberVO = new MemberVO();

					/*************************** 2.開始修改資料 *****************************************/
//				MemberService memSvc = new MemberService();
//				memberVO = memSvc.updatePw(newPW, loginId);
					Integer memberId = memberVO.getMemberId();
//				memberVO = memSvc.getOneMember(memberId);
//				String loginId = memberVO.getLoginId();
					/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				HttpSession session = req.getSession();
					// *工作1: 才在session內做已經登入過的標識

					session.setAttribute("memberId", memberId);
//				MemberService memSvc = new MemberService();
					MemberVO memberVO2 = memSvc.getLoginMember(loginId);
					session.setAttribute("MemberVO", memberVO2);
//				req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
					String url = "/front_end/member/LeasePagePW.jsp";
					out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
					out.println("<BODY>Password reset complete<BR>");
//				out.println("<BR>或3秒後自動回到密碼畫面 ");
					out.println("</BODY></HTML>");
					res.setHeader("Refresh", "2; URL=" + req.getContextPath() + url);
//					RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交LeasePageAccount.jsp
//				successView.forward(req, res);

					/*************************** 其他可能的錯誤處理 *************************************/
				} catch (Exception e) {
//				errorMsgs.add("修改資料失敗:" + e.getMessage());
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePagePW.jsp");
					failureView.forward(req, res);
				}
			}
		}

		// 銀行帳戶資料修改
		if ("updateAccount".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer memberId = new Integer(req.getParameter("memberId"));
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
				memberVO = memSvc.updateAccount(memberId, bankCode, bankAccount, accountName);
				memberVO = memSvc.getOneMember(memberId);
				String loginId = memberVO.getLoginId();
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				HttpSession session = req.getSession();
				// *工作1: 才在session內做已經登入過的標識

//				session.setAttribute("memberId", memberId);
				
				System.out.println("context memberId : "+memberId);
//				MemberService memSvc = new MemberService();
				MemberVO memberVO2 = memSvc.getLoginMember(loginId);
				session.setAttribute("MemberVO", memberVO2);
//				req.setAttribute("memberVO", memberVO); // 資料庫update成功後,正確的的memberVO物件,存入req
				String url = "/front_end/member/LeasePageAccount.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交LeasePageAccount.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePageAccount.jsp");
				failureView.forward(req, res);
			}
		}
		// 超商收件地址新增
		if ("insertAddress".equals(action)) { // 來自LeaseAddAddress.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer memberId = new Integer(req.getParameter("memberId").trim());

				// checkbox 沒選擇時會回傳null要先做處理
				Integer status = 0;
				if(req.getParameter("status")!=null) {
					status = new Integer(req.getParameter("status").trim());
				Enumeration e = req.getParameterNames();
				while (e.hasMoreElements()) {
					String name = (String) e.nextElement();
					String values[] = req.getParameterValues(name);
					if (values != null) {
						status = new Integer(1);
						DefAddressService addSvc2 = new DefAddressService();
						DefAddressVO addVO2 = addSvc2.updateAddStatus(memberId);
					}
					}
				}

				String recipient = req.getParameter("recipient").trim();
				String recipientReg = "^[(\u4e00-\u9fa5)]{2,20}$";
//				if (recipient == null || recipient.length() == 0) {
//					errorMsgs.add("收件姓名: 請勿空白");
//				} else if (!recipient.trim().matches(recipientReg)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("收件姓名: 只能是中文, 且長度必需在2到20之間");
//				}

				String recptPhone = req.getParameter("recptPhone").trim();
				String recptPhoneReg = "^09[0-9]{8}$";
//				if (recptPhone == null || recptPhone.length() == 0) {
//					errorMsgs.add("收件電話: 請勿空白");
//				} else if (!recptPhone.trim().matches(recptPhoneReg)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("收件電話: 只能是數字, 且長度必需在10");
//				}

				Integer code711 = new Integer(req.getParameter("code711").trim());
				String name711 = req.getParameter("name711").trim();
				String add711 = req.getParameter("add711").trim();

				DefAddressVO addVO = new DefAddressVO();
				addVO.setMemberId(memberId);
				addVO.setStatus(status);
				addVO.setRecipient(recipient);
				addVO.setRecptPhone(recptPhone);
				addVO.setCode711(code711);
				addVO.setName711(name711);
				addVO.setAdd711(add711);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("addVO", addVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/member/LeasePageAddAddress.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				DefAddressService addSvc = new DefAddressService();
				addVO = addSvc.addDefaddress(memberId, code711, name711, add711, status, recipient, recptPhone);
				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/front_end/member/LeasePageAddress.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/member/LeasePageAddAddress.jsp");
				failureView.forward(req, res);
			}
		}

		// 超商收件地址設為預設

		// 超商收件地址刪除
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
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

	// 取出上傳的檔案名稱 (因為API未提供method,所以必須自行撰寫)
		public String getFileNameFromPart(Part part) {
			String header = part.getHeader("content-disposition");
			System.out.println("header=" + header); // 測試用
			String filename = new File(header.substring(header.lastIndexOf("=") + 2, header.length() - 1)).getName();
			System.out.println("filename=" + filename); // 測試用
			if (filename.length() == 0) {
				return null;
			}
			return filename;
		}
}
