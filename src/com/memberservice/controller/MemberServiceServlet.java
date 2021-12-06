package com.memberservice.controller;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import com.memberservice.model.MemberServiceService;
import com.memberservice.model.MemberServiceVO;

@WebServlet("/MemberServiceServlet")
public class MemberServiceServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();

			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("msgID");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訊息編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				Integer msgID = null;
				try {
					msgID = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("問題編號格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				MemberServiceService msSvc = new MemberServiceService();
				MemberServiceVO msVO = msSvc.getOneMemberService(msgID);
				if (msVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("msVO", msVO); // 資料庫取出的empVO物件,存入req
				String url = "/emp/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer msgID = new Integer(req.getParameter("msgID"));

				/*************************** 2.開始查詢資料 ****************************************/
				MemberServiceService msSvc = new MemberServiceService();
				MemberServiceVO msVO = msSvc.getOneMemberService(msgID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("msVO", msVO); // 資料庫取出的empVO物件,存入req
				String url = "/emp/update_emp_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer msgID = new Integer(req.getParameter("msgID").trim());
				Integer prodID = new Integer(req.getParameter("prodID").trim());
				Integer memberID = new Integer(req.getParameter("memberID").trim());
				Integer managerID = new Integer(req.getParameter("managerID").trim());
				Integer typeID = new Integer(req.getParameter("typeID").trim());
				Integer ordID = new Integer(req.getParameter("ordID").trim());

				Date date = new Date();
				long ord = date.getTime();
				Timestamp msgDate = new Timestamp(ord);
			
			System.out.println("訂單日期 : " + msgDate);

String problemMsg = req.getParameter("problemMsg");
				String problemMsgReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (problemMsg == null || problemMsg.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if (!problemMsg.trim().matches(problemMsgReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
String msgRes = req.getParameter("msgRes").trim();
				if (msgRes == null || msgRes.trim().length() == 0) {
					errorMsgs.add("職位請勿空白");
				}

			Part pic1 =	req.getPart("pic1");
			InputStream in1 = pic1.getInputStream();
			byte[] buf1 = new byte[in1.available()];
			in1.read(buf1);
			in1.close();
			System.out.println("buffer lenght:"+ buf1.length);
			
			Part pic2 =	req.getPart("pic2");
			InputStream in2 = pic2.getInputStream();
			byte[] buf2 = new byte[in2.available()];
			in2.read(buf2);
			in2.close();
			System.out.println("buffer lenght:"+ buf2.length);
			
			Part pic3 =	req.getPart("pic3");
			InputStream in3 = pic3.getInputStream();
			byte[] buf3 = new byte[in3.available()];
			in3.read(buf3);
			in3.close();
			System.out.println("buffer lenght:"+ buf3.length);
			
			
			
Integer problemStatus = new Integer(req.getParameter("problemStatus").trim());

				MemberServiceVO msVO = new MemberServiceVO();
				
				msVO.setMsgID(msgID);
				msVO.setProdID(prodID);
				msVO.setMemberID(memberID);
				msVO.setManagerID(managerID);
				msVO.setTypeID(typeID);
				msVO.setOrdID(ordID);
				msVO.setMsgDate(msgDate);
				msVO.setProblemMsg(problemMsg);
				msVO.setMsgRes(msgRes);				
				msVO.setPic1(buf1);
				msVO.setPic2(buf2);
				msVO.setPic3(buf3);
				msVO.setProblemStatus(problemStatus);
				msVO.setProdID(prodID);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("msVO", msVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/emp/update_emp_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				MemberServiceService msSvc = new MemberServiceService();
				msVO = msSvc.updateMemberService(msgID, prodID, memberID, managerID, typeID, ordID, msgDate,problemMsg,msgRes,buf1,buf2,buf3,problemStatus);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("msVO", msVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/emp/listOneEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/emp/update_emp_input.jsp");
				failureView.forward(req, res);
			}
		}
		if ("insert".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("進來瞜");
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
//				Integer prodID = new Integer(req.getParameter("prodID").trim());
//				Integer memberID = new Integer(req.getParameter("memberID").trim());
//				Integer managerID = new Integer(req.getParameter("managerID").trim());
//				Integer typeID = new Integer(req.getParameter("typeID").trim());
//				Integer ordID = new Integer(req.getParameter("ordID").trim());
				
				Date date = new Date();
				long ord = date.getTime();
				Timestamp msgDate = new Timestamp(ord);
				
				System.out.println("訂單日期 : " + msgDate);
				
				String problemMsg = req.getParameter("problemMsg");
				String problemMsgReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (problemMsg == null || problemMsg.trim().length() == 0) {
					errorMsgs.add("員工姓名: 請勿空白");
				} else if (!problemMsg.trim().matches(problemMsgReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("員工姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
				String msgRes = req.getParameter("msgRes").trim();
				if (msgRes == null || msgRes.trim().length() == 0) {
					errorMsgs.add("職位請勿空白");
				}
				
				Part pic1 =	req.getPart("pic1");
				InputStream in1 = pic1.getInputStream();
				byte[] buf1 = new byte[in1.available()];
				in1.read(buf1);
				in1.close();
				System.out.println("buffer lenght:"+ buf1.length);
				
				Part pic2 =	req.getPart("pic2");
				InputStream in2 = pic2.getInputStream();
				byte[] buf2 = new byte[in2.available()];
				in2.read(buf2);
				in2.close();
				System.out.println("buffer lenght:"+ buf2.length);
				
				Part pic3 =	req.getPart("pic3");
				InputStream in3 = pic3.getInputStream();
				byte[] buf3 = new byte[in3.available()];
				in3.read(buf3);
				in3.close();
				System.out.println("buffer lenght:"+ buf3.length);
				
				
				
				Integer problemStatus = new Integer(req.getParameter("problemStatus").trim());
				
				MemberServiceVO msVO = new MemberServiceVO();
				
				
//				msVO.setProdID(prodID);
//				msVO.setMemberID(memberID);
//				msVO.setManagerID(managerID);
//				msVO.setTypeID(typeID);
//				msVO.setOrdID(ordID);
//				msVO.setMsgDate(msgDate);
//				msVO.setProblemMsg(problemMsg);
//				msVO.setMsgRes(msgRes);				
//				msVO.setPic1(buf1);
//				msVO.setPic2(buf2);
//				msVO.setPic3(buf3);
//				msVO.setProblemStatus(problemStatus);
//				msVO.setProdID(prodID);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("msVO", msVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/problemTypeReport.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
				
				/*************************** 2.開始新增資料 *****************************************/
				MemberServiceService msSvc = new MemberServiceService();
//				msVO = msSvc.addMemberService(prodID, memberID, managerID, typeID, ordID, msgDate,problemMsg,msgRes,buf1,buf2,buf3,problemStatus);
				
				/*************************** 3.新增完成,準備轉交(Send the Success view) *************/
//				String url = "/emp/listOneEmp.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
//				successView.forward(req, res);
				
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/problemTypeReport.jsp");
				failureView.forward(req, res);
			}
		}
		if ("delete".equals(action)) { // 來自listAllEmp.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
	
			try {
				/***************************1.接收請求參數***************************************/
				Integer msgID = new Integer(req.getParameter("msgID"));
				
				/***************************2.開始刪除資料***************************************/
				MemberServiceService msSvc = new MemberServiceService();
				msSvc.deleteMemberService(msgID);
				
				/***************************3.刪除完成,準備轉交(Send the Success view)***********/								
				String url = "/emp/listAllEmp.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:"+e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/emp/listAllEmp.jsp");
				failureView.forward(req, res);
			}
		}
	}

}
	