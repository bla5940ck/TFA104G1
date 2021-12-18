package com.order.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedList;
import java.util.List;
import java.util.function.Consumer;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.booking.model.BookingService;
import com.booking.model.BookingVO;
import com.google.gson.Gson;
import com.member_coupon.model.MemcouponDAO;
import com.member_coupon.model.MemcouponVO;
import com.order.model.OrderListDAOImpl;
import com.order.model.OrderListService;
import com.order.model.OrderListVO;
import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterService;
import com.order.model.OrderMasterVO;
import com.product.jedis.JedisPoolUtil;
import com.product.model.CartVO;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;


@WebServlet("/BackEndOrderServlet")
public class BackEndOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
//		String path = req.getRequestURI();
//		System.out.println(path);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getlist_For_Manager".equals(action)) { // 來自listStatusOrderList.jsp
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("進來了");
			
			try {
				
				String str = req.getParameter("ordID");
				System.out.println(str);
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入訂單編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				Integer ordID = null;
				try {
					ordID = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(req.getContextPath() + "/back_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				/**************** 2.開始查詢資料 ****************/
				
				OrderListDAOImpl oldao = new OrderListDAOImpl();
				List<OrderListVO> olVO = oldao.findOrderListByOrdID(ordID);
				
				if (olVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(req.getContextPath() + "/back_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				for (OrderListVO ols : olVO) {
					
					/************** 3.查詢完成,準備轉交 *************/
					req.setAttribute("OrderListVO", ols);
					String url = "/back_end/order/listOrdIDOrderListManager.jsp";
					RequestDispatcher successView = req.getRequestDispatcher(url);
					successView.forward(req, res);
					return;
				}
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
				return;
			}
		}
		
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
								
				/*************************** 2.開始查詢資料 ****************************/

				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				OrderMasterVO omVO = omdao.findOrderMasterByPK(ordID);

				if (omVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				OrderListDAOImpl oldao = new OrderListDAOImpl();				
				
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/			
				req.setAttribute("OrderMasterVO", omVO);			// 資料庫取出的VO物件,存入req
				String url ="back_end/order/listOneOrderMaster.jsp"; 
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllOrderMaster.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 *****************************/
				Integer ordID = new Integer(req.getParameter("ordID"));
				
				/*************************** 2.開始查詢資料 *****************************/
				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO omVO = omSVC.getOneOrderMaster(ordID);
				OrderListService olSVC = new OrderListService();

				/***************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的omVO物件,存入req
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
		
		
		if ("getOne_For_Manager_Update".equals(action)) { 
			
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
				
				/***************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的omVO物件,存入req
				String url = "/back_end/order/updateOrderManager2.jsp";
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

		if ("update_for_manager".equals(action)) {
			System.out.println("後台訂單更新");
			List<String> errorMsgs = new LinkedList<String>();
			
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer ordID = new Integer(req.getParameter("ordID").trim());
				
				Integer shipStatus = new Integer(req.getParameter("shipStatus").trim());
				
				Integer ordStatus = new Integer(req.getParameter("ordStatus").trim());
				Integer payStatus = new Integer(req.getParameter("payStatus").trim());
				
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
				
				String strrr = req.getParameter("rentRank");
				System.out.println(strrr);
				Integer rentRank = null;
				if(strrr != null && strrr.length() != 0) {
					rentRank = new Integer(strrr);
					System.out.println(rentRank);
				}
				
				String strlr = req.getParameter("leaseRank");
				System.out.println(strlr);
				Integer leaseRank = null;
				if(strlr != null && strlr.length() != 0) {
					leaseRank = new Integer(strlr);
					System.out.println(leaseRank);
				}
				
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
				
				System.out.println(omVO.getOrdStatus());
				System.out.println(olVO.getOrdStatus());
				if (!errorMsgs.isEmpty()) {
					
					try{
						req.setAttribute("OrderMasterVO", omVO); //含有輸入格式錯誤的omVO物件,也存入req
					} catch(Exception e) {
						e.printStackTrace();
//						System.out.println("錯了嗎?????????????");
						RequestDispatcher failureView = req.getRequestDispatcher("/back_end/order/listAllOrderList.jsp");
						failureView.forward(req, res);
						return; // 程式中斷
					}
				}
				
				/*************************** 2.開始修改資料 ****************************/
				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				OrderListDAOImpl oldao = new OrderListDAOImpl();
				omdao.updateAllOrder(omVO, olVO);
				omdao.updateWithListStatus(omVO, olVO);
				
				/*************************** 3.預約單判斷 ****************************/
				BookingService bkSVC = new BookingService();
				List<BookingVO> bkVO = bkSVC.getAll();
				for(BookingVO bkVOUpdate : bkVO) {
					if(bkVOUpdate.getOrdID().equals(ordID) && ordStatus == 9) {
						bkSVC.deleteBk(bkVOUpdate.getBkID());
						System.out.println("因為訂單狀態修改為已取消，故刪除該預約單");
					}
				}
				/**************************** NEW修改後的VO ****************************/
				OrderMasterVO omVO1 = omdao.findOrderMasterByPK(ordID);
				OrderListVO olVO1 = oldao.findOrderListByPK(listID);
				
				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", omVO1); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				req.setAttribute("OrderListVO", olVO1);
				
				String url = "/back_end/order/listAllOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //  修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				return;
				
				/*************************** 其他可能的錯誤處理 ***************************/
			} catch (Exception e) {
				System.out.println("失敗");
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/order/updateOrderMasterInput.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("get_Status_Display_Manager".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			System.out.println("進來了");
			
			Integer ordStatus = new Integer(req.getParameter("ordStatus"));
			
			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			List<OrderMasterVO> omVO = omdao.findOrderMasterByStatus(ordStatus);
			
			if(omVO == null) {
				errorMsgs.add("查無資料");
			}
			
			for(OrderMasterVO oms : omVO) {
				req.setAttribute("OrderMasterVO", oms);
				String url = "/back_end/order/listStatusOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;
			}
		}	
		
		if ("getComment_For_Display".equals(action)) { // 來自listAllOrderMaster.jsp的請求

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
				
				OrderListService olSVC = new OrderListService();

				/***************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的omVO物件,存入req
				String url = "/front_end/order/updateLeaseComment.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateLeaseComment.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("update_lease_comment".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
				String strlr = req.getParameter("leaseRank");
				System.out.println("出租者評分 : " + strlr);
				Integer leaseRank = null;
				if(strlr != null && strlr.length() != 0) {
					leaseRank = new Integer(strlr);
					System.out.println(leaseRank);
				}
									
				String leaseComt = req.getParameter("leaseComt").trim();
				System.out.println("出租者評論內容 : " + leaseComt);
				
				Date date = new Date();

				long strlc = (date.getTime());
				Timestamp leaseComtdate = new Timestamp(strlc);
				System.out.println("評價日期 :" + leaseComtdate);
				
				Integer ordID = new Integer(req.getParameter("ordID"));
				System.out.println("訂單編號 : " + ordID);
				
				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setLeaseRank(leaseRank);
				omVO.setLeaseComt(leaseComt);
				omVO.setLeaseComtdate(leaseComtdate);
				omVO.setOrdID(ordID);
				 
				System.out.println("這邊");
				
				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO leaseCom = omSVC.addLeaseComment(leaseRank, leaseComt, leaseComtdate, ordID);
				
				System.out.println("這邊2");
				
				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", leaseCom); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				String url = "/front_end/order/listSuccessOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //  修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				return;		
				
				
			}catch(Exception e) {
				System.out.println("失敗");
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateLeaseComment.jsp");
				failureView.forward(req, res);
			}
		}
		
		if ("getRentComment_For_Display".equals(action)) { // 來自listAllOrderMaster.jsp的請求

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
				
				OrderListService olSVC = new OrderListService();

				/***************** 3.查詢完成,準備轉交(Send the Success view) ***********/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的omVO物件,存入req
				String url = "/front_end/order/updateRentComment.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);//成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateRentComment.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("update_rent_comment".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				
				String strrr = req.getParameter("rentRank");
				System.out.println("承租者評分 : " + strrr);
				Integer rentRank = null;
				if(strrr != null && strrr.length() != 0) {
					rentRank = new Integer(strrr);
					System.out.println(rentRank);
				}
									
				String rentComt = req.getParameter("rentComt").trim();
				System.out.println("承租者評論內容 : " + rentComt);
				
				Date date = new Date();

				long strrc = (date.getTime());
				Timestamp rentComtdate = new Timestamp(strrc);
				System.out.println("評價日期 :" + rentComtdate);
				
				Integer ordID = new Integer(req.getParameter("ordID"));
				System.out.println("訂單編號 : " + ordID);
				
				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setRentRank(rentRank);
				omVO.setRentComt(rentComt);
				omVO.setRentComtdate(rentComtdate);
				omVO.setOrdID(ordID);
				 
				System.out.println("這邊");
				
				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO rentCom = omSVC.addRentComment(rentRank, rentComt, rentComtdate, ordID);
				
				System.out.println("這邊2");
				
				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", rentCom); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				String url = "/front_end/order/listSuccessOrderForRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); //  修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				return;		
			}catch(Exception e) {
				System.out.println("失敗");
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateRentComment.jsp");
				failureView.forward(req, res);
			}
		}
		
		if("get_date_forRent_order".equals(action)) {
			System.out.println("近來日期判斷");
			DateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
			
			String startDate = (String)req.getParameter("startDate");
			String endDate = (String)req.getParameter("endDate");
			Integer memID = (Integer) req.getSession().getAttribute("id");
			System.out.println(startDate);
						
			java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
			java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);
							
					
			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			List<OrderMasterVO> list = omdao.getAllOrderMaster();
//			List<OrderMasterVO> list2 = list.stream()
//										.filter(om -> om.getRentID() == memID)
//											.filter(om -> om.getOrdStatus() == 2)
//												.filter(om -> om.getReturnDate() != null)
//													.filter(om -> om.getReturnDate().after(sd))
//														.filter(om -> om.getReturnDate().before(ed))
//																.collect(Collectors.toList());
																	
					
//			list2.forEach(o->System.out.println(o.getOrdID()));
//			list.forEach(o->System.out.println(o.getReturnDate()));
			List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
			for(OrderMasterVO omVO : list) {
				if(omVO.getOrdStatus() == 2 && omVO.getReturnDate() != null && omVO.getReturnDate().before(ed) && omVO.getReturnDate().after(sd) && omVO.getRentID() == memID) {
					long time = omVO.getReturnDate().getTime();
					Integer ordID = omVO.getOrdID();
					System.out.println("訂單編號 :" + ordID + "歸還時間" + time);
					list2.add(omVO);
				}
			}
			req.setAttribute("list", list2);
			req.getRequestDispatcher("/front_end/order/listSuccessOrderForRent.jsp").forward(req,res);
			return;
		}		
		if("get_date_forLease_order".equals(action)) {
			System.out.println("近來日期判斷");
			DateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");
			
			String startDate = (String)req.getParameter("startDate");
			String endDate = (String)req.getParameter("endDate");
			Integer memID = (Integer) req.getSession().getAttribute("id");
			System.out.println(startDate);
			
			java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
			java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);
			
			
			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			List<OrderMasterVO> list = omdao.getAllOrderMaster();

			List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
			for(OrderMasterVO omVO : list) {
				if(omVO.getOrdStatus() == 2 && omVO.getReturnDate() != null && omVO.getReturnDate().before(ed) && omVO.getReturnDate().after(sd) && omVO.getLeaseID() == memID) {
					long time = omVO.getReturnDate().getTime();
					Integer ordID = omVO.getOrdID();
					System.out.println("訂單編號 :" + ordID + "歸還時間" + time);
					list2.add(omVO);
				}
			}
			req.setAttribute("list", list2);
			req.getRequestDispatcher("/front_end/order/listSuccessOrder.jsp").forward(req,res);
			return;
		}		
	}
}
