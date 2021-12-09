package com.promo_list.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.promo_list.model.PromolistService;
import com.promo_list.model.PromolistVO;
import com.member_coupon.model.*;

@WebServlet("/front_end/getCoupon/getcoupon.do")

public class getCouponServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getAmount".equals(action)) { // 來自select_Promo.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer amount = new Integer(req.getParameter("amount").trim());
				System.out.println("剩餘數量"+amount);
				/*************************** 2.開始查詢資料 *****************************************/
				PromolistService promolistSvc = new PromolistService();
				List<PromolistVO> promolistVO = promolistSvc.getAmount(amount);
				for(PromolistVO prvo : promolistVO) {
					System.out.println("這"+prvo.getAmount());
				}

				if (promolistVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("promolistVO", promolistVO); // 資料庫取出的promoVO物件,存入req
				String url = "/front_end/getCoupon/getCoupon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOne_promo.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/getCoupon/NewFile.jsp");
				failureView.forward(req, res);
			}
		}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////		
		if ("insert".equals(action)) { // 來自getCoupon.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
//			member_id, category_id, coupon_id, coupon_name, discount, status, start_date, end_date
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer member_id = new Integer(req.getParameter("member_id").trim());
				Integer category_id = new Integer(req.getParameter("category_id").trim());
				Integer coupon_id = new Integer(req.getParameter("coupon_id").trim());
				String coupon_name = new String (req.getParameter("coupon_name"));
				Double discount = new Double(req.getParameter("discount").trim());
				Integer status = new Integer(req.getParameter("status").trim());
				java.sql.Date start_date =  java.sql.Date.valueOf(req.getParameter("start_date").trim());
				java.sql.Date end_date =  java.sql.Date.valueOf(req.getParameter("end_date").trim());
				
				MemcouponVO memcouponVO = new MemcouponVO();
				memcouponVO.setMember_id(member_id);
				memcouponVO.setCategory_id(category_id);
				memcouponVO.setCoupon_id(coupon_id);
				memcouponVO.setDiscount(discount);
				memcouponVO.setCoupon_name(coupon_name);
				memcouponVO.setStatus(status);
				memcouponVO.setStart_date(start_date);
				memcouponVO.setEnd_date(end_date);
			
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memcouponVO", memcouponVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/getCoupon/getCoupon.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				MemcouponService memcouponSvc = new MemcouponService();
				memcouponVO = memcouponSvc.insert(member_id, category_id, coupon_id, discount, coupon_name, 
						status, start_date, end_date);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("memcoupoVO", memcouponVO); // 資料庫取出的promoVO物件,存入req
				String url = "/front_end/getCoupon/getCoupon.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOne_promo.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/getCoupon/getCoupon.jsp");
				failureView.forward(req, res);
			}
		}
	}
}