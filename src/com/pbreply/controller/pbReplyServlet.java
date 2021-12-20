package com.pbreply.controller;

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


import com.pbreply.model.*;



@WebServlet("/pbReplyServlet")
public class pbReplyServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		if ("getOne_For_Display".equals(action)) { // 來自postSingle.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer replyId = new Integer(req.getParameter("replyId").trim());

				/*************************** 2.開始查詢資料 *****************************************/
				pbReplyService pbrSvc = new pbReplyService();
				pbReplyVO pbrVO = pbrSvc.findByPrimaryKey(replyId);
				if (pbrVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("pbrVO", pbrVO); // 資料庫取出的postBoardVO物件,存入req
				String url = "/back_end/PostBoard/postSingle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 postSingle.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		if ("getOne_For_Update".equals(action)) { // 來自postSingle.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer replyId = new Integer(req.getParameter("replyId"));

				/*************************** 2.開始查詢資料 ****************************************/
				pbReplyService pbrSvc = new pbReplyService();
				pbReplyVO pbrVO = pbrSvc.findByPrimaryKey(replyId);
			
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("pbrVO", pbrVO); // 資料庫取出的promoVO物件,存入req
				String url = "/back_end/PostBoard/postSingle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 updatearticle.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("update".equals(action)) { // 來自postSingle.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//replyId,postId,replyCont,replyTime;

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer replyId = new Integer(req.getParameter("replyId").trim());
				System.out.println(replyId);

				Integer postId = null;

				Integer memberId = new Integer(req.getParameter("memberId").trim());
				System.out.println("memberId");

				String replyCont = req.getParameter("replyCont");

				String ts = req.getParameter("replyTime");
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				Date date = sdf.parse(ts);// date 格式
				Timestamp timeStamp = new Timestamp(date.getTime()); // new timestamp(long) =>long l = date.getTime();
				java.sql.Timestamp replyTime = java.sql.Timestamp.valueOf(ts);
				//System.out.println(ts);
			

				pbReplyVO pbrVO = new pbReplyVO();
				pbrVO.setReplyId(replyId);
				pbrVO.setPostId(postId);
				pbrVO.setReplyCont(replyCont);
				pbrVO.setReplyTime(replyTime);
			

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("pbrVO", pbrVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				pbReplyService pbrSvc = new pbReplyService();
				pbrVO = pbrSvc.update(replyId, postId, memberId, replyCont, replyTime);
						

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("pbrVO", pbrVO); // 資料庫取出的postBoardVO物件,存入req
				String url ="/back_end/PostBoard/postSingle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交postSingle.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
				failureView.forward(req, res);
			}
		}
		
		
		
		if ("insert".equals(action)) { //來自postSingle的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer postId = new Integer(req.getParameter("postId").trim());
				
				Integer memberId = new Integer(req.getParameter("memberId").trim());

				String replyCont = req.getParameter("replyCont");
				
				Date date = new Date();
				long time =date.getTime();
				Timestamp replyTime = new Timestamp(time);
				//DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				System.out.println(replyTime);

				pbReplyVO pbrVO = new pbReplyVO();
				pbrVO.setPostId(postId);
				pbrVO.setMemberId(memberId);
				pbrVO.setReplyCont(replyCont);
				pbrVO.setReplyTime(replyTime);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("pbrVO", pbrVO); // 含有輸入格式錯誤的pbrVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
					failureView.forward(req, res);

					return;
				}
				
				/*************************** 2.開始新增資料 ***************************************/
				pbReplyService pbrSvc = new pbReplyService();
				pbrVO = pbrSvc.add(postId, memberId, replyCont, replyTime);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back_end/PostBoard/postSingle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交postSingle.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/postSingle.jsp");
				failureView.forward(req, res);
			}
			
			
			
		}
		
		
	}

	
}
