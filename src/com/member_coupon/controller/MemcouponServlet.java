package com.member_coupon.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member_coupon.model.*;
import com.promo.model.PromoService;

@WebServlet("/front_end/getCoupon/getmemid.do")

	public class MemcouponServlet extends HttpServlet {
		public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
			doPost(req, res);
		}

		public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

			req.setCharacterEncoding("UTF-8");
			String action = req.getParameter("action");

			if ("getMemberid".equals(action)) { // 來自select_Promo.jsp的請求

				List<String> errorMsgs = new LinkedList<String>();
				// Store this set in the request scope, in case we need to
				// send the ErrorPage view.
				req.setAttribute("errorMsgs", errorMsgs);

				try {
					/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
					Integer member_id = new Integer(req.getParameter("member_id").trim());
					System.out.println("會員編號"+member_id);
					/*************************** 2.開始查詢資料 *****************************************/
					MemcouponService memcouponSvc = new MemcouponService();
					List<MemcouponVO> memcouponVO = memcouponSvc.getMemberid(member_id);
//					for(MemcouponVO memvo : memcouponVO) {
//						System.out.println("這"+memvo.getMember_id());
//					}

					if (memcouponVO == null) {
						errorMsgs.add("查無資料");
					}
					// Send the use back to the form, if there were errors
					if (!errorMsgs.isEmpty()) {
						RequestDispatcher failureView = req.getRequestDispatcher("/");
						failureView.forward(req, res);
						return;// 程式中斷
					}

					/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
					req.setAttribute("memcouponVO", memcouponVO); // 資料庫取出的promoVO物件,存入req
					String url = "/front_end/member_coupon/memCoupon.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOne_promo.jsp
					successView.forward(req, res);

					/*************************** 其他可能的錯誤處理 *************************************/
				} catch (Exception e) {
					errorMsgs.add("無法取得資料:" + e.getMessage());
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/getCoupon/NewFile.jsp");
					failureView.forward(req, res);
				}
			}

		if ("findByPrimaryKey".equals(action)) { // 來自listAll_promo.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer mem_coupon_id = new Integer(req.getParameter("mem_coupon_id"));
				System.out.print(mem_coupon_id);

				/*************************** 2.開始更改資料 ***************************************/
				MemcouponService memcouponSvc = new MemcouponService();
				memcouponSvc.findByPrimaryKey(mem_coupon_id);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
//				String url = "/back_end/promo/listAll_promo.jsp";
//				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
//				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo/listAll_pormo.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
