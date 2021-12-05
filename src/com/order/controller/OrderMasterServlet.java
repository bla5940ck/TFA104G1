package com.order.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.OrderListDAOImpl;
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
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				Integer listID = new Integer(req.getParameter("listID"));
				
				/*************************** 2.開始查詢資料 ****************************/

				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				OrderMasterVO omVO = omdao.findOrderMasterByPK(ordID);

				if (omVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				OrderListDAOImpl oldao = new OrderListDAOImpl();
				OrderListVO olVO = oldao.findOrderListByPK(listID);
				
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/			
				req.setAttribute("OrderMasterVO", omVO);			// 資料庫取出的VO物件,存入req
				req.setAttribute("OrderListVO", olVO);
				String url ="front_end/order/listOneOrderMaster.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
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
//				Integer listID = new Integer(req.getParameter("listID"));
//				System.out.println("明細編號"+listID);
				
				
				/*************************** 2.開始查詢資料 *****************************/
				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO omVO = omSVC.getOneOrderMaster(ordID);
				
				OrderListService olSVC = new OrderListService();
//				OrderListVO olVO = olSVC.getOneOrderList(listID);

				/***************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的omVO物件,存入req
//				req.setAttribute("OrderListVO", olVO);
				String url = "/front_end/order/updateOrderMasterInput.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
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

				Integer ordStatus = new Integer(req.getParameter("ordStatus").trim());
				Integer payStatus = new Integer(req.getParameter("payStatus").trim());
				
//				Integer shipCode = new Integer(req.getParameter("shipCode").trim());
//				Integer returnCode = new Integer(req.getParameter("returnCode").trim());
				
				String sc = (req.getParameter("shipCode").trim());				
				Integer shipCode = 0;				
				if(sc != null) {
					try {
						shipCode = new Integer(sc);
					} catch (Exception e) {
						errorMsgs.add("格式不正確" + e.getMessage());
					}
				};
				
				String rc = (req.getParameter("returnCode").trim());
				Integer returnCode = 0;
				if(rc != null) {
					try {
						returnCode = new Integer(rc);
					} catch (Exception e) {
						errorMsgs.add("格式不正確");
					}
				};				
				
//				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");				
				String strsd = req.getParameter("shipDate");
				Timestamp shipDate = null;
				if(strsd != null && strsd.length() != 0) {
					System.out.println("運送時間 : " + strsd);
					shipDate = new Timestamp(Long.valueOf(strsd));
					System.out.println(shipDate);				
				};
				
				String strad = req.getParameter("arrivalDate");
				Timestamp arrivalDate = null;
				if(strad != null && strad.length()!=0) {
				System.out.println(strad);
				System.out.println("到貨時間:" + strad);
				arrivalDate = new Timestamp(Long.valueOf(strad));
				System.out.println(arrivalDate);
				} ;
				
				String strrd = req.getParameter("returnDate");
				Timestamp returnDate = null;
				if(strrd != null && strrd.length()!=0) {
					System.out.println("歸還時間:" + strrd);
					returnDate = new Timestamp(Long.valueOf(strrd));
					System.out.println(returnDate);
				};
				
				Integer rentRank = new Integer(req.getParameter("rentRank").trim());
				Integer leaseRank = new Integer(req.getParameter("leaseRank").trim());
				String rentComt = req.getParameter("rentComt").trim();
				String leaseComt = req.getParameter("leaseComt").trim();

				Date date = new Date();

				long strrc = (date.getTime());
				Timestamp rentComtdate = new Timestamp(strrc);
//				System.out.println(rentComtdate);

				long strlc = (date.getTime());
				Timestamp leaseComtdate = new Timestamp(strlc);
//				System.out.println(leaseComtdate);	
				
				//存入訂單VO
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
				
				//接收VO參數
				
				Integer listID = new Integer(req.getParameter("listID"));
				//存入明細VO
				OrderListVO olVO = new OrderListVO();
				olVO.setOrdStatus(ordStatus);
				olVO.setListID(listID);
				olVO.setOrdID(ordID);
				
//				System.out.println(omVO.getOrdStatus());
//				System.out.println(olVO.getOrdStatus());
				if (!errorMsgs.isEmpty()) {
					
					try{
						req.setAttribute("OrderMasterVO", omVO); //含有輸入格式錯誤的omVO物件,也存入req
					} catch(Exception e) {
						e.printStackTrace();
//						System.out.println("錯了嗎?????????????");
						RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
						failureView.forward(req, res);
						return; // 程式中斷
					}
				}
	
				/*************************** 2.開始修改資料 ****************************/
				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				OrderListDAOImpl oldao = new OrderListDAOImpl();
				omdao.updateAllOrder(omVO, olVO);
				
				/**************************** NEW修改後的VO ****************************/
				OrderMasterVO omVO1 = omdao.findOrderMasterByPK(ordID);
				OrderListVO olVO1 = oldao.findOrderListByPK(listID);

				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", omVO1); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				req.setAttribute("OrderListVO", olVO1);
				String url = "/front_end/order/listOneOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //  修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				return;

				/*************************** 其他可能的錯誤處理 ***************************/
			} catch (Exception e) {
				System.out.println("失敗");
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateOrderMasterInput.jsp");
				failureView.forward(req, res);
			}
		}

		if ("submit_order".equals(action)) { // 來自addOrderMaster.jsp的請求
			
			System.out.println("進來servlet");
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			Integer rentID = new Integer(req.getParameter("rentID"));
			System.out.println("承租者會員編號 : " + rentID);
			
				Integer leaseID = new Integer(req.getParameter("leaseID"));
			System.out.println("出租者會員編號 : " + leaseID);
			
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
					System.out.println("日期下例外");
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			
				java.sql.Date estStart = java.sql.Date.valueOf(req.getParameter("estStart"));
			System.out.println("預定租借起日 : "+ estStart);
				
				java.sql.Date estEnd = java.sql.Date.valueOf(req.getParameter("estEnd"));
			System.out.println("預定租借訖日 : "+estEnd);		
						
				Integer rentDays = new Integer(req.getParameter("rentDays"));
			System.out.println("承租天數 : " + rentDays);	
				
			/********************付款資訊******************/
				Integer payID = new Integer (req.getParameter("payID"));
			System.out.println("付款方式編碼 : " + payID);
			
			String strcp = req.getParameter("couponID").trim();
			System.out.println(strcp);
			Integer couponID = null;
			if(strcp != null && strcp.length() != 0) {
				couponID = new Integer(strcp);
				System.out.println("折價券編碼 : " + couponID);	
			}
			
				Integer storeCode = new Integer(req.getParameter("code711"));
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
				omVO.setPayID(payID);		//付款方式編碼
				omVO.setCouponID(couponID); //折價券編碼
				omVO.setOrdDate(ordDate);	//訂單日期
				omVO.setStoreCode(storeCode); //超商編碼
				omVO.setEstStart(estStart);
				omVO.setEstEnd(estEnd);
				omVO.setRentDays(rentDays);
				omVO.setProdPrice(prodPrice);	//商品小計
				omVO.setShipFee(shipFee);	//運費
				omVO.setOrdPrice(ordPrice);		//訂單金額		
				
				System.out.println("訂單存入");
				
				/*************存入訂單明細VO***********/
				List<OrderListVO> list = new ArrayList<OrderListVO>();
				OrderListVO newol = new OrderListVO();
				newol.setProdID(prodID);
				newol.setProdPrice(prodPrice);
				newol.setEstStart(estStart);
				newol.setEstEnd(estEnd);
				list.add(newol);
				
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
				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();

//				omdao.insertAllOrder(omVO, olVO);
				omdao.inesetWithList(omVO, list);
				System.out.println("訂單+明細新增");
				
				/***********************新增完成準備轉交************************/
				String url = "/front_end/order/listAllOrderList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);				
				
			} catch (Exception e) {
				System.out.println("例外");
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/order/addOrderMaster.jsp");
				failureView.forward(req, res);
				
			}
		}
	}
}
