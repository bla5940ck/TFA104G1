package com.postboard.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import java.io.*;
import java.util.*;

import javax.servlet.*;
import javax.servlet.http.*;
import com.google.gson.Gson;
import com.postboard.model.*;

import javafx.scene.effect.ImageInput;

@WebServlet("/back_end/PostBoard/pb.do")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, maxFileSize = 5 * 1024 * 1024, maxRequestSize = 5 * 5 * 1024 * 1024)

public class PostBoardServlet extends HttpServlet {

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自articleList.jsp的請求
			System.out.println("1");

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer memberId = new Integer(req.getParameter("memberId").trim());

				/*************************** 2.開始查詢資料 *****************************************/
				PostBoardService pbSvc = new PostBoardService();
				List<PostBoardVO> pbVO = pbSvc.getAll();
//				for(PostBoardVO pdid : pbVO) {
//					if(pdid.getMemberId()== memberId) {
//						System.out.println("取到的會員編號 :" + memberId);
//						System.out.println(pdid.getPostId());
//						
//					}
//				}
				
				
				if (pbVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/articleList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("pbVO", pbVO); // 資料庫取出的postBoardVO物件,存入req
				String url = "/back_end/PostBoard/articleList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 articleList.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/articleList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自articleList.jsp的請求
			System.out.println("2");

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer memberId = new Integer(req.getParameter("memberId"));
				//System.out.println("pbservlet 抓到的 : "+memberId);				
//				System.out.println("會員編號" + memberId);
				String postId = req.getParameter("postId");
//				Integer postId = new Integer(req.getParameter("postId").trim());
				//System.out.println("文章編號" + postId);

				/*************************** 2.開始查詢資料 ****************************************/
				PostBoardService pbSvc = new PostBoardService();
				PostBoardVO pbVO = pbSvc.findByPrimaryKey(Integer.valueOf(postId));
//				System.out.println(pbVO.getMemberId());

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("pbVO", pbVO); 
//				System.out.println("servlet "+req.getAttribute("pbVO"));
				String url = "/back_end/PostBoard/updateArticle.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 updatearticle.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/updateArticle.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自updateArticle.jsp的請求
			System.out.println("3");

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

//postId; categoryId; memberId; postTitle; postCont; postTime; replyCount; pic;

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer postId = new Integer(req.getParameter("postId").trim());
				System.out.println(postId);

				Integer categoryId = new Integer(req.getParameter("categoryId").trim());

//				try {
//					categoryId = new Integer(req.getParameter("categoryId").trim());
//				} catch (NumberFormatException e) {
//					categoryId = 0;
//					errorMsgs.add("商品類別請選擇");
//				}
				System.out.println(categoryId);

				Integer memberId = new Integer(req.getParameter("memberId").trim());
				System.out.println("mid");

				String postTitle = req.getParameter("postTitle");

				String postTitleReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)($!@#^&*-_+=~<>/?;:)]{1,100}$";
				if (postTitle == null || postTitle.trim().length() == 0) {
					errorMsgs.add("徵求標題: 請勿空白");
				}
//				else if (!postTitle.trim().matches(postTitleReg)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("徵求標題: 只能是中、英文及數字");
//				}
				//System.out.println(postTitle);

				String postCont = req.getParameter("postCont");

				String postContReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)($!@#^&*-_+=~<>/?;:)]{1,600}$";
				if (postCont == null || postCont.trim().length() == 0) {
					errorMsgs.add("徵求內容: 請勿空白");
				}
//				else if (!postCont.trim().matches(postContReg)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("徵求內容: 只能是中、英文及數字");
//				}
				//System.out.println(postCont);

//				String ts = req.getParameter("posttime");
//				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
//				Date date = sdf.parse(ts);// date 格式
//				Timestamp timeStamp = new Timestamp(date.getTime()); // new timestamp(long) =>long l = date.getTime();
//				java.sql.Timestamp postTime = java.sql.Timestamp.valueOf(ts);
				
				Date date = new Date();
				long time =date.getTime();
				Timestamp postTime = new Timestamp(time);
				//DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				System.out.println(postTime);

				Integer replyCount = 0;
				//System.out.println(replyCount);

				Part part = req.getPart("pic"); 
				System.out.println("testpic");
				InputStream in = part.getInputStream();
				byte[] buf = new byte[in.available()];
				in.read(buf);
				in.close();
				System.out.println("buffer length: " + buf.length);
				

				PostBoardVO pbVO = new PostBoardVO();
				pbVO.setPostId(postId);
				pbVO.setCategoryId(categoryId);
				pbVO.setMemberId(memberId);
				pbVO.setPostTitle(postTitle);
				pbVO.setPostCont(postCont);
				pbVO.setPostTime(postTime);
				pbVO.setReplyCount(replyCount);
				pbVO.setPic(part2Bytes(part));
				
				PostBoardService pbSvc = new PostBoardService();
				PostBoardVO pbVO2 = pbSvc.findByPrimaryKey(postId);
				//System.out.println("2: "+pbVO2.getPic().length);
				//System.out.println("1: "+pbVO.getPic().length);
				
			    byte[] pic1 = pbVO.getPic().length == 0?  pbVO2.getPic() : pbVO.getPic();	
			    //System.out.println(pic1.length);
			    pbSvc.updatearticle(postId, categoryId, memberId, postTitle, postCont, 
					postTime, replyCount,pic1);
			    req.getSession().setAttribute("postId",postId);
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("pbVO", pbVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/updateArticle.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
//				PostBoardService pbSvc1 = new PostBoardService();
//				pbVO = pbSvc1.updatearticle(postId, categoryId, memberId, postTitle, postCont, postTime, replyCount,
//						part2Bytes(part));

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("pbVO", pbVO); // 資料庫取出的postBoardVO物件,存入req
				String url = "/back_end/PostBoard/postAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交articleList.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
				} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/updateArticle.jsp");
				failureView.forward(req, res);
			}
		}
		

		// ok
		if ("insert".equals(action)) { // 來自addarticle.jsp的請求
			System.out.println("4");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				// Integer postId = new Integer(req.getParameter("postId").trim());
				Integer categoryId = new Integer(req.getParameter("categoryId").trim());

				try {
					categoryId = new Integer(req.getParameter("categoryId").trim());
				} catch (NumberFormatException e) {
					categoryId = 0;
					errorMsgs.add("商品類別請選擇");
				}

				Integer memberId = new Integer(req.getParameter("memberId").trim());

				String postTitle = req.getParameter("postTitle");
				System.out.println(postTitle);
				String postTitleReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)($!@#^&*-_+=~<>/?;:)]{1,100}$";
				if (postTitle == null || postTitle.trim().length() == 0) {
					errorMsgs.add("徵求標題: 請勿空白");
				}
				
//				else if (!postTitle.trim().matches(postTitleReg)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("徵求標題: 只能是中、英文及數字");
//				}

				String postCont = req.getParameter("postCont");

				String postContReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)($!@#^&*-_+=~<>/?;:)]{1,600}$";
				if (postCont == null || postCont.trim().length() == 0) {
					errorMsgs.add("徵求內容: 請勿空白");
				}
//				else if (!postCont.trim().matches(postContReg)) { // 以下練習正則(規)表示式(regular-expression)
//					errorMsgs.add("徵求內容: 只能是中、英文及數字");
//				}

//				long postTime = System.currentTimeMillis();
//				Timestamp timestamp = new Timestamp(postTime);
//				String ts = "2021-12-02 20:20:20" ;
//				SimpleDateFormat sd = 
				//String ts = req.getParameter("posttime");
				Date date = new Date();
				long time =date.getTime();
				Timestamp postTime = new Timestamp(time);
				//DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				System.out.println(postTime);

				// Integer replyCount = null;
				// Integer replyCount = new Integer(req.getParameter("replyCount").trim());


				Part part = req.getPart("pic"); 
				if(part.getInputStream().available() == 0) {
					errorMsgs.add("至少上傳一張圖片");
				}else {
					InputStream in = part.getInputStream();
					byte[] buf = new byte[in.available()];
					in.read(buf);
					in.close();
				}
				
				
				

				PostBoardVO pbVO = new PostBoardVO();
				// pbVO.setPostId(postId);
				pbVO.setCategoryId(categoryId);
				pbVO.setMemberId(memberId);
				pbVO.setPostTitle(postTitle);
				pbVO.setPostCont(postCont);
				pbVO.setPostTime(postTime);
				// pbVO.setReplyCount(replyCount);
				pbVO.setPic(part2Bytes(part));

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("pbVO", pbVO);  // 資料庫取出的postBoardVO物件,存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/addArticle.jsp");
					failureView.forward(req, res);

					return;
				}
				
				/*************************** 2.開始新增資料 ***************************************/
				PostBoardService pbSvc = new PostBoardService();
				pbVO = pbSvc.addarticle(categoryId, memberId, postTitle, postCont, postTime, part2Bytes(part));

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back_end/PostBoard/postAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交postAll.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				e.printStackTrace();
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/addArticle.jsp");
				failureView.forward(req, res);
			}
		}

//jsp顯示圖片		
		if("writePic".equals(req.getParameter("action"))) {
			System.out.println("");
			PostBoardService pbSvc = new PostBoardService();
			Integer postId = Integer.valueOf(req.getParameter("postId"));
			if(req.getParameter("postId") != null && req.getParameter("postId").isEmpty()){
				postId = Integer.parseInt(req.getParameter("postId"));
		}
		
			PostBoardVO pbVO = pbSvc.findByPrimaryKey(postId);
			OutputStream os = res.getOutputStream();
		
			byte[] pic = pbVO.getPic();
			os.write(pic);
		
		
	}
		
		
		
		
		
		
		
		
		
		
		
		
		// ok
		if ("delete".equals(action)) { // 來自articleList.jsp
			System.out.println("5");

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer postId = new Integer(req.getParameter("postId").trim());

				/*************************** 2.開始刪除資料 ***************************************/
				PostBoardService pbSvc = new PostBoardService();
				pbSvc.delet(postId);
				System.out.println("test");

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back_end/PostBoard/articleList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/PostBoard/articleList.jsp");
				failureView.forward(req, res);
			}
		}
	}

	private byte[] part2Bytes(Part part) {
		try (
			InputStream is = part.getInputStream();
			ByteArrayOutputStream baos = new ByteArrayOutputStream()
		) {
			byte[] chunk = new byte[4096];
			int amountRead;
			while ((amountRead = is.read(chunk)) != -1) {
				baos.write(chunk, 0, amountRead);
			}
			return baos.toByteArray();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
