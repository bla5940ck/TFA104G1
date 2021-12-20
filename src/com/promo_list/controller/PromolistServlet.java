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

@WebServlet("/back_end/promo_list/promolist.do")

public class PromolistServlet extends HttpServlet {
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getPromolist".equals(action)) { // 來自select_Promolist.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				
				Integer promo_id = new Integer(req.getParameter("promo_id").trim());
				
				
				
//				System.out.println("專案編號 "+promo_id);
				/*************************** 2.開始查詢資料 *****************************************/
//				PromolistService promolistSvc = new PromolistService();
//				List<PromolistVO> promolistVO = promolistSvc.getPromoid(promo_id);
//				for(PromolistVO prvo : promolistVO) {
//					System.out.println("這"+prvo.getPromo_id());
//				}

//				if (promolistVO == null) {
//					errorMsgs.add("查無資料");
//				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo/listAll_promo.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("promolistVO", promolistVO); // 資料庫取出的promoVO物件,存入req
				req.setAttribute("promoID", promo_id);
				String url = "/back_end/promo_list/promolistAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOne_promo.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo/listAll_promo.jsp");
				failureView.forward(req, res);
			}
		}
		if ("getOne_For_Insert".equals(action)){ // 來自select_Promo.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer promo_id = new Integer(req.getParameter("promo_id").trim());
				System.out.println("專案編號 "+promo_id);
				/*************************** 2.開始查詢資料 *****************************************/
//				PromolistService promolistSvc = new PromolistService();
//				PromolistVO promolistVO = promolistSvc.getPromoid(promo_id);
//				for(PromolistVO prvo : promolistVO) {
//					System.out.println("這"+prvo.getPromo_id());
//				}

//				if (promolistVO == null) {
//					errorMsgs.add("查無資料");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo/listAll_promo.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("promolistVO", promolistVO); // 資料庫取出的promoVO物件,存入req
				String url = "/back_end/promo_list/add_promolist.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_promo_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo/listAll_promo.jsp");
				failureView.forward(req, res);
			}
		}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ("getOne_For_Display".equals(action)) { // 來自select_Promo.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer coupon_id = new Integer(req.getParameter("coupon_id").trim());
//				String str = req.getParameter("coupon_id");
//				if (str == null || (str.trim()).length() == 0) {
//					errorMsgs.add("請輸入專案編號");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/promo_list/select_promolist.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}
//
//				Integer coupon_id = null;
//				try {
//					coupon_id = new Integer(str);
//				} catch (Exception e) {
//					errorMsgs.add("專案編號格式不正確");
//				}
//				// Send the use back to the form, if there were errors
//				if (!errorMsgs.isEmpty()) {
//					RequestDispatcher failureView = req.getRequestDispatcher("/promo_list/select_promo.jsp");
//					failureView.forward(req, res);
//					return;// 程式中斷
//				}

				/*************************** 2.開始查詢資料 *****************************************/
				PromolistService promolistSvc = new PromolistService();
				PromolistVO promolistVO = promolistSvc.findByPrimaryKey(coupon_id);
				if (promolistVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/promo_list/select_promolist.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("promolistVO", promolistVO); // 資料庫取出的promoVO物件,存入req
				String url = "/back_end/promo_list/listOne_promolist.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOne_promo.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo_list/select_promolist.jsp");
				failureView.forward(req, res);
			}
		}

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ("getOne_For_Update".equals(action)) { // 來自listAll_promo.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer coupon_id = new Integer(req.getParameter("coupon_id"));

				/*************************** 2.開始查詢資料 ****************************************/
				PromolistService promolistSvc = new PromolistService();
				PromolistVO promolistVO = promolistSvc.findByPrimaryKey(coupon_id);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("promolistVO", promolistVO); // 資料庫取出的promoVO物件,存入req
				String url = "/back_end/promo_list/update_promolist.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_promo_input.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo_list/listAll_promolist.jsp");
				failureView.forward(req, res);
			}
		}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ("update".equals(action)) { // 來自update_promo.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			// coupon_id, promo_id, category_id, coupon_name, discount, amount, used,
			// start_date, end_date
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer coupon_id = new Integer(req.getParameter("coupon_id").trim());

				Integer promo_id = null;
				try {
					promo_id = new Integer(req.getParameter("promo_id").trim());
				} catch (NumberFormatException e) {
					promo_id = 0;
					errorMsgs.add("專案編號請填數字");
				}

				Integer category_id = null;
				try {
					category_id = new Integer(req.getParameter("category_id").trim());
				} catch (NumberFormatException e) {
					category_id = 0;
					errorMsgs.add("商品類別請填數字");
				}

				String coupon_name = req.getParameter("coupon_name");
				String coupon_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (coupon_name == null || coupon_name.trim().length() == 0) {
					errorMsgs.add("折價券名稱: 請勿空白");
				} else if (!coupon_name.trim().matches(coupon_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("折價券名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				Double discount = null;
				try {
					discount = new Double(req.getParameter("discount").trim());
				} catch (NumberFormatException e) {
					discount = 0.0;
					errorMsgs.add("折扣金額請填數字.");
				}

				Integer amount = null;
				try {
					amount = new Integer(req.getParameter("amount").trim());
				} catch (NumberFormatException e) {
					amount = 0;
					errorMsgs.add("總數請填位數字");
				}
				Integer used = null;
				try {
					used = new Integer(req.getParameter("used").trim());
				} catch (NumberFormatException e) {
					used = 0;
					errorMsgs.add("已領取請填數字");
				}
				java.sql.Date start_date = null;
				try {
					start_date = java.sql.Date.valueOf(req.getParameter("start_date").trim());
				} catch (IllegalArgumentException e) {
					start_date = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				java.sql.Date end_date = null;
				try {
					end_date = java.sql.Date.valueOf(req.getParameter("end_date").trim());
				} catch (IllegalArgumentException e) {
					end_date = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				PromolistVO promolistVO = new PromolistVO();
				promolistVO.setCoupon_id(coupon_id);
				promolistVO.setPromo_id(promo_id);
				promolistVO.setCategory_id(category_id);
				promolistVO.setCoupon_name(coupon_name);
				promolistVO.setDiscount(discount);
				promolistVO.setAmount(amount);
				promolistVO.setUsed(used);
				promolistVO.setStart_date(start_date);
				promolistVO.setEnd_date(end_date);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("promolistVO", promolistVO); // 含有輸入格式錯誤的promoVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo/update_promo.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
				PromolistService promoSvc = new PromolistService();
				promolistVO = promoSvc.update(coupon_id, promo_id, category_id, coupon_name, discount, amount, used,
						start_date, end_date);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
//				req.setAttribute("promolistVO", promolistVO); // 資料庫update成功後,正確的的promoVO物件,存入req
				req.setAttribute("promoID", promo_id);
				String url = "/back_end/promo_list/";
				RequestDispatcher successView = req.getRequestDispatcher(url); // promolistAll.jsp修改成功後,轉交listOne_promo.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo_list/promolistAll.jsp");
				failureView.forward(req, res);
			}
		}
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ("insert".equals(action)) { // 來自add_promo.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				Integer promo_id = new Integer(req.getParameter("promo_id").trim());
//				Integer promo_id = null;
//				try {
//					promo_id = new Integer(req.getParameter("promo_id").trim());
//				} catch (NumberFormatException e) {
//					promo_id = 0;
//					errorMsgs.add("專案編號請填數字");
//				}

				Integer category_id = null;
				try {
					category_id = new Integer(req.getParameter("category_id").trim());
				} catch (NumberFormatException e) {
					category_id = 0;
					errorMsgs.add("商品類別請填數字");
				}

				String coupon_name = req.getParameter("coupon_name");
				String coupon_nameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (coupon_name == null || coupon_name.trim().length() == 0) {
					errorMsgs.add("折價券名稱: 請勿空白");
				} else if (!coupon_name.trim().matches(coupon_nameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("折價券名稱: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				Double discount = null;
				try {
					discount = new Double(req.getParameter("discount").trim());
				} catch (NumberFormatException e) {
					discount = 0.0;
					errorMsgs.add("折扣金額請填數字.");
				}

				Integer amount = null;
				try {
					amount = new Integer(req.getParameter("amount").trim());
				} catch (NumberFormatException e) {
					amount = 0;
					errorMsgs.add("總數請填位數字");
				}
				Integer used = null;
				try {
					used = new Integer(req.getParameter("used").trim());
				} catch (NumberFormatException e) {
					used = 0;
					errorMsgs.add("已領取請填數字");
				}
				java.sql.Date start_date = null;
				try {
					start_date = java.sql.Date.valueOf(req.getParameter("start_date").trim());
				} catch (IllegalArgumentException e) {
					start_date = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				java.sql.Date end_date = null;
				try {
					end_date = java.sql.Date.valueOf(req.getParameter("end_date").trim());
				} catch (IllegalArgumentException e) {
					end_date = new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入日期!");
				}

				PromolistVO promolistVO = new PromolistVO();
				promolistVO.setPromo_id(promo_id);
				promolistVO.setCategory_id(category_id);
				promolistVO.setCoupon_name(coupon_name);
				promolistVO.setDiscount(discount);
				promolistVO.setAmount(amount);
				promolistVO.setUsed(used);
				promolistVO.setStart_date(start_date);
				promolistVO.setEnd_date(end_date);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("promolistVO", promolistVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo_list/add_promolist.jsp");
					failureView.forward(req, res);
					return;
				}

				/*************************** 2.開始新增資料 ***************************************/
				PromolistService promolistSvc = new PromolistService();
				promolistVO = promolistSvc.insert(promo_id, category_id, coupon_name, discount, amount, used,
						start_date, end_date);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("promoID", promo_id);
				String url = "/back_end/promo_list/promolistAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAll_promo.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo_list/add_promolist.jsp");
				failureView.forward(req, res);
			}
		}
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		if ("delete".equals(action)) { // 來自listAll_promo.jsp

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer coupon_id = new Integer(req.getParameter("coupon_id").trim());

				/*************************** 2.開始刪除資料 ***************************************/
				PromolistService promolistSvc = new PromolistService();
				promolistSvc.delete(coupon_id);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/back_end/promo_list/listAll_promolist.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/promo_list/listAll_pormolist.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
