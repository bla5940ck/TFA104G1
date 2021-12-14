package com.member.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/MemServlet")
public class MemServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

       
    public MemServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}


    public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
    	
    	req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		String actionOne = req.getParameter("actionOne");
		
//單筆查詢
		if ("getOneMember".equals(action)) { // 來自listAllMember.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***************************1.接收請求參數 - 輸入格式的錯誤處理**********************/
				String str = req.getParameter("memberId");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入會員資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/member/listAllMember.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				Integer memberId = null;
				try {
					memberId = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("會員編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/member/listAllMember.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************2.開始查詢資料*****************************************/
				MemberService memSvc = new MemberService();
				MemberVO memberVO = memSvc.getOneMember(memberId);
				if (memberVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/member/listAllMember.jsp");
					failureView.forward(req, res);
					return;//程式中斷
				}
				
				/***************************3.查詢完成,準備轉交(Send the Success view)*************/
				req.setAttribute("memberVO", memberVO); // 資料庫取出的memberVO物件,存入req
				String url = "/back_end/member/listOneMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneMember.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理*************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/member/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		
//修改		
		if ("updateMember".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/***************************1.接收請求參數****************************************/
				Integer memberId = new Integer(req.getParameter("memberId"));
				
				/***************************2.開始查詢資料****************************************/
				MemberService memSvc = new MemberService();
				MemberVO memberVO = memSvc.getOneMember(memberId);
								
				/***************************3.查詢完成,準備轉交(Send the Success view)************/
				req.setAttribute("memberVO", memberVO);         // 資料庫取出的memberVO物件,存入req
				String url = "/back_end/member/updateOneMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/member/index.jsp");
				failureView.forward(req, res);
			}
		}
		
		

//全部查詢停權		
		if ("9".equals(action) &&
				(req.getContextPath()+"/back_end/member/listAllMember.jsp")!=(req.getContextPath()+"/back_end/member/listAllMember.jsp")) { // 來自listALL_Member.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer memberId = new Integer(req.getParameter("memberId"));
				Integer status = new Integer(req.getParameter("action"));
//				Integer status = 9;
				
				/***************************2.開始修改資料***************************************/
				MemberService memSvc = new MemberService();
				MemberVO memberVO = memSvc.updateStatus(status, memberId);
				
				/***************************3.修改準備轉交(Send the Success view)***********/								
				String url = "/back_end/member/listAllMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 修改後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
//				res.sendRedirect(req.getContextPath() + url);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("停權失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/member/listAllMember.jsp");
				failureView.forward(req, res);
			}
		}
		
//單筆查詢停權
		if ("9".equals(actionOne) ) { // 來自listOneMember.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
//	System.out.println("000000000000000000000000000000000000");
			try {
				/***************************1.接收請求參數***************************************/
				Integer memberId = new Integer(req.getParameter("memberId"));
//				System.out.println("01");
//				String name = new String(req.getParameter("name"));
//				System.out.println("02");
//				String email= new String(req.getParameter("email"));
//				System.out.println("03");
//				String loginId= new String(req.getParameter("loginId"));
//				System.out.println("04");
//				String phoneNum= new String(req.getParameter("phoneNum"));
//				System.out.println("05");
				Integer status = new Integer(req.getParameter("actionOne"));
//				System.out.println("06");
//		//		String dateStr = new String(req.getParameter("creatDate"));
//		//		Timestamp creatDate = Timestamp.valueOf(dateStr);
//				java.sql.Timestamp creatDate = null;
//				try {
//					creatDate = java.sql.Timestamp.valueOf(req.getParameter("creatDate").trim());
//				} catch (IllegalArgumentException e) {
//					creatDate = new java.sql.Timestamp(System.currentTimeMillis());
//					errorMsgs.add("請輸入日期!");
//				}
//				System.out.println("11111111111111111111111111111111111111111");

//				Date df = new SimpleDateFormat("yyyy-MM-dd").parse(dateStr);
//				long time = df.getTime();
//				Timestamp creatDate = new Timestamp(time);
				//				Timestamp creatDate =Timestamp.valueOf(dateStr);
//				Timestamp creatDate = (Timestamp) new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").parse(dateStr);
				//				Integer status = 9;
				
				/***************************2.開始修改資料***************************************/
				MemberService memSvc = new MemberService();
				MemberVO memberVO = memSvc.updateStatus(status, memberId);
				MemberVO memberVO2 = memSvc.getOneMember(memberId);
//				MemberVO memberVO = memSvc.updateOneMember(memberId, name, email, creatDate, loginId, phoneNum, status);
				/***************************3.修改準備轉交(Send the Success view)***********/	
				req.setAttribute("memberVO", memberVO2); // 資料庫取出的empVO物件,存入req
				String url = "/back_end/member/listOneMember.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 修改後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
//				res.sendRedirect(req.getContextPath() + url);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("停權失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/member/index.jsp");
				failureView.forward(req, res);
			}
		}		
		
		
		
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			
////			全部查詢
//			try {
//				/***************************1.接收請求參數****************************************/
////				Integer memberId = new Integer(req.getParameter("memberId"));
//				
//				/***************************2.開始查詢資料****************************************/
//				MemberService memSvc = new MemberService();
//				List<MemberVO> memberVO = memSvc.getAll();
//								
//				/***************************3.查詢完成,準備轉交(Send the Success view)************/
//				req.setAttribute("memberVO", memberVO);         // 資料庫取出的memberVO物件,存入req
//				String url = "/back_end/member/listAllMember.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 listAllMember.jsp
//				successView.forward(req, res);
////				一個是跳轉一個內轉
////				res.sendRedirect(req.getContextPath() + url);
//
//				/***************************其他可能的錯誤處理**********************************/
//			} catch (Exception e) {
//				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
//				RequestDispatcher failureView = req
//						.getRequestDispatcher("/back_end/member/listAllMember.jsp");
//				failureView.forward(req, res);
//			}
		}
    }

//}
