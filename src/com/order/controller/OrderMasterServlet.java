package com.order.controller;

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

import com.order.model.OrderListService;
import com.order.model.OrderListVO;
import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterService;
import com.order.model.OrderMasterVO;

import com.member.model.DefAddressVO;
import com.member.model.MemberVO;
import com.booking.model.BookingDAO;
import com.booking.model.BookingVO;
import com.product.model.ProdDAO;
import com.product.model.ProdVO;


@WebServlet("/OrderMasterServlet")
public class OrderMasterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
//		String path = req.getRequestURI();
//		System.out.println(path);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("ordID");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer ordID = null;

				try {
					ordID = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				/*************************** 2.開始查詢資料 ****************************/

				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				OrderMasterVO omVO = omdao.findOrderMasterByPK(ordID);

				if (omVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/			
				req.setAttribute("OrderMasterVO", omVO);			// 資料庫取出的VO物件,存入req
				String url ="front_end/order/listOneOrderMaster.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllOrderMaster.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 *****************************/
				Integer ordID = new Integer(req.getParameter("ordID"));

				/*************************** 2.開始查詢資料 *****************************/
				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO omVO = omSVC.getOneOrderMaster(ordID);

				/***************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的omVO物件,存入req
				String url = "/front_end/order/updateOrderMasterInput.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) { // 來自updateOrderMasterInput.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer ordID = new Integer(req.getParameter("ordID").trim());

				Integer shipStatus = new Integer(req.getParameter("shipStatus").trim());

				if (shipStatus == 0) {
					req.setAttribute("shipStatus", "待出貨");
				} else {
					req.setAttribute("shipStatus", "已出貨");
				}

				Integer ordStatus = new Integer(req.getParameter("payStatus").trim());
				Integer payStatus = new Integer(req.getParameter("ordStatus").trim());
				String shipCode = req.getParameter("shipCode").trim();
				if (shipCode == null || shipCode.trim().length() == 0) {
					errorMsgs.add("出貨代碼請勿空白");
				}

				String returnCode = req.getParameter("returnCode").trim();

				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				String strsd = req.getParameter("shipDate");
				long lsd = sdf.parse(strsd).getTime();
				Timestamp shipDate = new Timestamp(lsd);

				String strad = req.getParameter("arrivalDate");
				long lad = sdf.parse(strad).getTime();
				Timestamp arrivalDate = new Timestamp(lad);

				String strrd = req.getParameter("returnDate");
				long lrd = sdf.parse(strrd).getTime();
				Timestamp returnDate = new Timestamp(lrd);

				Integer rentRank = new Integer(req.getParameter("rentRank").trim());
				Integer leaseRank = new Integer(req.getParameter("leaseRank").trim());
				String rentComt = req.getParameter("rentComt").trim();
				String leaseComt = req.getParameter("leaseComt").trim();

				Date date = new Date();

				long strrc = (date.getTime());
				Timestamp rentComtdate = new Timestamp(strrc);
				System.out.println(rentComtdate);

				long strlc = (date.getTime());
				Timestamp leaseComtdate = new Timestamp(strlc);
				System.out.println(leaseComtdate);

				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setOrdID(ordID);
				omVO.setShipStatus(shipStatus);
				omVO.setOrdStatus(ordStatus);
				omVO.setPayStatus(payStatus);
				omVO.setShipCode(shipCode);
				omVO.setReturnCode(returnCode);
				omVO.setShipDate(shipDate);
				omVO.setArrivalDate(arrivalDate);
				omVO.setReturnDate(returnDate);
				omVO.setRentRank(rentRank);
				omVO.setLeaseRank(leaseRank);
				omVO.setRentComt(rentComt);
				omVO.setLeaseComt(leaseComt);
				omVO.setRentComtdate(rentComtdate);
				omVO.setLeaseComtdate(leaseComtdate);

				System.out.println(omVO);
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("OrderMasterVO", omVO); //含有輸入格式錯誤的omVO物件,也存入req

					System.out.println("錯了嗎?????????????");

					RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}
	
				/*************************** 2.開始修改資料 ****************************/
				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				omdao.updateOrderMaster(omVO);

				/**************************** NEW修改後的VO ****************************/
				OrderMasterVO omVO1 = omdao.findOrderMasterByPK(ordID);

				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", omVO1); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				String url = "/front_end/order/listOneOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //  修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				System.out.println(omVO);
				System.out.println(omVO1);
				return;

				/*************************** 其他可能的錯誤處理 ***************************/
			} catch (Exception e) {
				System.out.println("失敗");
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher(req.getContextPath() + "/front_end/order/updateOrderMasterInput.jsp");
				failureView.forward(req, res);
			}
		}

		if ("submit_order".equals(action)) { // 來自addOrderMaster.jsp的請求
			
			System.out.println("進來了");
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				String prodName = req.getParameter("prodName");
				
			System.out.println("商品名稱 : " + prodName);				
				
				Integer prodID = new Integer(req.getParameter("prodID"));
				
			System.out.println("商品編號 :" + prodID);
			
			/***************************日期部分******************************/
				Date date = new Date();
				long ord = date.getTime();
				Timestamp ordDate = new Timestamp(ord);
			
			System.out.println("訂單日期 : " + ordDate);
					
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
				java.sql.Date estStart = java.sql.Date.valueOf(req.getParameter("estStart"));
			
			System.out.println(estStart);
				
				java.sql.Date estEnd = java.sql.Date.valueOf(req.getParameter("estEnd"));
			
			System.out.println(estEnd);		
						
				Integer rentDays = 1;
				
				/***************************************************************/	
				
				Integer leaseID = 2;
				
				Integer rentID = new Integer(req.getParameter("rentID"));
				
			System.out.println("承租者會員編號 : " + rentID);
			
				Integer payID = new Integer (req.getParameter("payID"));
				
			System.out.println("付款方式編碼 : " + payID);
			
				Integer couponID = new Integer(req.getParameter("couponID"));
			
			System.out.println("折價券編碼 : " + couponID);	
							
				String storeCode = req.getParameter("storeCode");
				
			System.out.println("預設物流 : " + storeCode);
			
				Integer prodPrice = new Integer(req.getParameter("prodPrice"));
				
			System.out.println("商品小計 :" + prodPrice);	
			
				Integer shipFee = new Integer(req.getParameter("shipFee"));
				
			System.out.println("運費 : " + shipFee);
			
				Integer ordPrice = new Integer(req.getParameter("ordPrice"));
			
			System.out.println("訂單金額 :" + ordPrice);	
			
				/*************存入VO**************/
				OrderMasterVO omVO = new OrderMasterVO();
				OrderListVO olVO = new OrderListVO();
				
				/*************存入訂單主檔VO***********/
				omVO.setLeaseID(leaseID);
				omVO.setRentID(rentID); 	//承租方編號
				omVO.setOrdDate(ordDate);	//訂單日期
				omVO.setPayID(payID);		//付款方式編碼
				omVO.setCouponID(couponID); //折價券編碼
				omVO.setStoreCode(storeCode); //超商編碼
				omVO.setEstStart(estStart);
				omVO.setEstEnd(estEnd);
				omVO.setRentDays(rentDays);
				omVO.setProdPrice(prodPrice);	//商品小計
				omVO.setShipFee(shipFee);	//運費
				omVO.setOrdPrice(ordPrice);		//訂單金額		
				
				System.out.println("訂單存入");
				
				/*************存入訂單明細VO***********/
				
				olVO.setProdID(prodID);
				olVO.setProdPrice(prodPrice);
				olVO.setEstStart(estStart);
				olVO.setEstEnd(estEnd);
				
				System.out.println("明細存入");
	
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("OrderMasterVO", omVO); // 含有輸入格式錯誤的VO物件,也存入req
					req.setAttribute("OrderListVO", olVO);
					System.out.println("這裡");
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/order/addOrderMaster.jsp");
					failureView.forward(req, res);
					return;
				}
			
				/***********************開始新增************************/
				System.out.println("這裡1");
				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				System.out.println("這裡2");

				omdao.insertAllOrder(omVO, olVO);
				
				System.out.println("訂單+明細新增");
				
				/***********************新增完成準備轉交************************/
				String url = "/front_end/order/listAllOrderList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
			} catch (Exception e) {
				System.out.println("這裡3");
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/order/addOrderMaster.jsp");
				failureView.forward(req, res);
				
			}
		}
	}
}
