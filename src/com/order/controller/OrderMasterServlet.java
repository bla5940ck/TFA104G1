package com.order.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.booking.model.BookingService;
import com.booking.model.BookingVO;
import com.google.gson.Gson;
import com.member.model.MailService;
import com.member.model.MemberJDBCDAO;
import com.member.model.MemberVO;
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
import com.product.model.ProdService;
import com.product.model.ProdVO;

import ecpay.payment.integration.AllInOne;
import ecpay.payment.integration.domain.AioCheckOutALL;
import ecpay.payment.integration.domain.InvoiceObj;
import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.FileSystems;
import java.nio.file.Path;
import java.text.SimpleDateFormat;
import java.util.Base64;
import java.util.Hashtable;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;

@WebServlet("/OrderMasterServlet")
public class OrderMasterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static JedisPool pool = JedisPoolUtil.getJedisPool();
	public static AllInOne all;

	public static void main(String[] args) {
		initial();
//		System.out.println("aioCheckOutALL: " + genAioCheckOutALL());

	}

	private static void initial() {
		all = new AllInOne("");
	}

	public static boolean cmprChkMacValue() {
		Hashtable<String, String> dict = new Hashtable<String, String>();
		dict.put("MerchantID", "2000132");
		dict.put("CheckMacValue", "50BE3989953C1734E32DD18EB23698241E035F9CBCAC74371CCCF09E0E15BD61");
		return all.compareCheckMacValue(dict);
	}

	private String convert2Byte(InputStream input) throws IOException {
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
		byte[] buff = new byte[100];
		int length = 0;
		while ((length = input.read(buff, 0, 100)) > 0) {
			baos.write(buff, 0, length);
		}
		byte[] in2b = baos.toByteArray();
		baos.flush();
		baos.close();
		input.close();
		return new String(Base64.getEncoder().encodeToString(in2b));

	}

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

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的VO物件,存入req
				String url = "front_end/order/listOneOrderMaster.jsp";
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
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_Rent_Update".equals(action)) { // 來自listAllOrderMaster.jsp的請求

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
				String url = "/front_end/order/updateOrderRentInput.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update_for_Lease".equals(action)) { // 來自updateOrderMasterInput.jsp的請求
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

				String sc = (req.getParameter("shipCode").trim());
				Integer shipCode = 0;
				if (sc != null) {
					try {
						shipCode = new Integer(sc);
					} catch (Exception e) {
						errorMsgs.add("格式不正確" + e.getMessage());
					}
				}
				;

				String rc = (req.getParameter("returnCode").trim());
				Integer returnCode = 0;
				if (rc != null) {
					try {
						returnCode = new Integer(rc);
					} catch (Exception e) {
						errorMsgs.add("格式不正確");
					}
				}
				;

				String strsd = req.getParameter("shipDate");
				Timestamp shipDate = null;
				if (strsd != null && strsd.length() != 0) {
					System.out.println("運送時間 : " + strsd);
					shipDate = new Timestamp(Long.valueOf(strsd));
					System.out.println(shipDate);
				}
				;

				String strad = req.getParameter("arrivalDate");
				Timestamp arrivalDate = null;
				if (strad != null && strad.length() != 0) {
					System.out.println(strad);
					System.out.println("到貨時間:" + strad);
					arrivalDate = new Timestamp(Long.valueOf(strad));
					System.out.println(arrivalDate);
				}
				;

				String strrd = req.getParameter("returnDate");
				Timestamp returnDate = null;
				if (strrd != null && strrd.length() != 0) {
					System.out.println("歸還時間:" + strrd);
					returnDate = new Timestamp(Long.valueOf(strrd));
					System.out.println(returnDate);
				}
				;

				String strrr = req.getParameter("rentRank");
				System.out.println(strrr);
				Integer rentRank = null;
				if (strrr != null && strrr.length() != 0) {
					rentRank = new Integer(strrr);
					System.out.println(rentRank);
				}

				String strlr = req.getParameter("leaseRank");
				System.out.println(strlr);
				Integer leaseRank = null;
				if (strlr != null && strlr.length() != 0) {
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

				Timestamp estTrfDa = null;
				Integer trfStatus = 0;
				Timestamp payDate = null;

				// 存入訂單VO
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
				omVO.setEstTrfDa(estTrfDa);
				omVO.setTrfStatus(trfStatus);
				omVO.setPayDate(payDate);

				// 接收VO參數

				Integer listID = new Integer(req.getParameter("listID"));
				// 存入明細VO
				OrderListVO olVO = new OrderListVO();
				olVO.setOrdStatus(ordStatus);
				olVO.setListID(listID);
				olVO.setOrdID(ordID);

//				System.out.println(omVO.getOrdStatus());
//				System.out.println(olVO.getOrdStatus());
				if (!errorMsgs.isEmpty()) {

					try {
						req.setAttribute("OrderMasterVO", omVO); // 含有輸入格式錯誤的omVO物件,也存入req
					} catch (Exception e) {
						e.printStackTrace();
//						System.out.println("錯了嗎?????????????");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
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
				for (BookingVO bkVOUpdate : bkVO) {
					if (bkVOUpdate.getOrdID().equals(ordID) && ordStatus == 9) {
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

				String url = "/front_end/order/listOneOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrderMaster.jsp
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

		if ("update_for_Rent".equals(action)) { // 來自updateOrderMasterInput.jsp的請求
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

				String sc = (req.getParameter("shipCode").trim());
				Integer shipCode = 0;
				if (sc != null && sc.length() != 0) {
					try {
						shipCode = new Integer(sc);
					} catch (Exception e) {
						errorMsgs.add("格式不正確" + e.getMessage());
					}
				}

				String rc = (req.getParameter("returnCode").trim());
				Integer returnCode = 0;
				if (rc != null && rc.length() != 0) {
					try {
						returnCode = new Integer(rc);
					} catch (Exception e) {
						errorMsgs.add("格式不正確");
					}
				}

				String strsd = req.getParameter("shipDate");
				Timestamp shipDate = null;
				if (strsd != null && strsd.length() != 0) {
					System.out.println("運送時間 : " + strsd);
					shipDate = new Timestamp(Long.valueOf(strsd));
					System.out.println(shipDate);
				}

				String strad = req.getParameter("arrivalDate");
				Timestamp arrivalDate = null;
				if (strad != null && strad.length() != 0) {
					System.out.println(strad);
					System.out.println("到貨時間:" + strad);
					arrivalDate = new Timestamp(Long.valueOf(strad));
					System.out.println(arrivalDate);
				}

				String strrd = req.getParameter("returnDate");
				Timestamp returnDate = null;
				if (strrd != null && strrd.length() != 0) {
					System.out.println("歸還時間:" + strrd);
					returnDate = new Timestamp(Long.valueOf(strrd));
					System.out.println(returnDate);
				}

				String strrr = req.getParameter("rentRank");
				System.out.println(strrr);
				Integer rentRank = null;
				if (strrr != null && strrr.length() != 0) {
					rentRank = new Integer(strrr);
					System.out.println(rentRank);
				}

				String strlr = req.getParameter("leaseRank");
				System.out.println(strlr);
				Integer leaseRank = null;
				if (strlr != null && strlr.length() != 0) {
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

				Timestamp estTrfDa = null;
				Integer trfStatus = 0;
				Timestamp payDate = null;

				// 存入訂單VO
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
				omVO.setEstTrfDa(estTrfDa);
				omVO.setTrfStatus(trfStatus);
				omVO.setPayDate(payDate);

				// 接收VO參數

				Integer listID = new Integer(req.getParameter("listID"));
				// 存入明細VO
				OrderListVO olVO = new OrderListVO();
				olVO.setOrdStatus(ordStatus);
				olVO.setListID(listID);
				olVO.setOrdID(ordID);

//				System.out.println(omVO.getOrdStatus());
//				System.out.println(olVO.getOrdStatus());
				if (!errorMsgs.isEmpty()) {

					try {
						req.setAttribute("OrderMasterVO", omVO); // 含有輸入格式錯誤的omVO物件,也存入req
					} catch (Exception e) {
						e.printStackTrace();
//						System.out.println("錯了嗎?????????????");
						RequestDispatcher failureView = req
								.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
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
				for (BookingVO bkVOUpdate : bkVO) {
					if (bkVOUpdate.getOrdID().equals(ordID) && ordStatus == 9) {
						bkSVC.deleteBk(bkVOUpdate.getBkID());
						System.out.println("因為訂單狀態修改為已取消，故刪除該預約單");
					}
				}
				/**************************** NEW修改後的VO ****************************/
				OrderMasterVO omVO1 = omdao.findOrderMasterByPK(ordID);
				OrderListVO olVO1 = oldao.findOrderListByPK(listID);

				MemberJDBCDAO memdao = new MemberJDBCDAO();

				if (omVO1.getShipStatus() == 2) {
					MailService mailService = new MailService();
					Integer rentID = omVO1.getRentID();
					MemberVO memVO = memdao.findByPrimaryKey(rentID);
					String to = memVO.getEmail();
					String subject = "JoyLease訂單出貨通知";
					String messageText = "親愛的會員 : " + memVO.getNickName() + "您好 : 你的訂單" + omVO1.getOrdID()
							+ "已出貨，請留意近期通知 !";

					mailService.sendMail(to, subject, messageText);

				}

				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", omVO1); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				req.setAttribute("OrderListVO", olVO1);

				String url = "/front_end/order/listOneOrderMasterForRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrderMaster.jsp
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

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer rentID = new Integer(req.getParameter("rentID"));
			Integer leaseID = new Integer(req.getParameter("leaseID"));
			try {
				String prodName = req.getParameter("prodName");
//				System.out.println("商品名稱為 : " + prodName);
				Integer prodID = new Integer(req.getParameter("prodID"));
//				System.out.println("商品編號為 : " + prodID);

				/*************************** 日期部分 ******************************/
				Date date = new Date();
				long ord = date.getTime();
				Timestamp ordDate = new Timestamp(ord);
				DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

				java.sql.Date estStart = java.sql.Date.valueOf(req.getParameter("estStart"));

				java.sql.Date estEnd = java.sql.Date.valueOf(req.getParameter("estEnd"));

				Integer rentDays = new Integer(req.getParameter("rentDays"));

				/******************** 付款資訊 ******************/
				Integer payID = new Integer(req.getParameter("payID"));

				String strcp = req.getParameter("couponID").trim();
				Integer couponID = null;
				if (strcp != null && strcp.length() != 0) {
					couponID = new Integer(strcp);
					System.out.println("選到的折價券" + couponID);
				}

				Integer storeCode = new Integer(req.getParameter("code711"));

				Integer prodPrice = new Integer(req.getParameter("prodPrice"));

				Integer shipFee = new Integer(req.getParameter("shipFee"));

				Integer ordPrice = new Integer(req.getParameter("ordPrice"));

				/************* 存入VO **************/
				OrderMasterVO omVO = new OrderMasterVO();
				OrderListVO olVO = new OrderListVO();

				/************* 存入訂單主檔VO ***********/
				omVO.setRentID(rentID); // 承租方編號
				omVO.setLeaseID(leaseID);
				omVO.setPayID(payID); // 付款方式編碼
				omVO.setCouponID(couponID); // 折價券編碼
				omVO.setOrdDate(ordDate); // 訂單日期
				omVO.setStoreCode(storeCode); // 超商編碼
				omVO.setEstStart(estStart);
				omVO.setEstEnd(estEnd);
				omVO.setRentDays(rentDays);
				omVO.setProdPrice(prodPrice); // 商品小計
				omVO.setShipFee(shipFee); // 運費
				omVO.setOrdPrice(ordPrice); // 訂單金額

				/************* 存入訂單明細VO ***********/
				System.out.println(req.getSession().getAttribute("list1"));
				List<OrderListVO> list = (List<OrderListVO>) req.getSession().getAttribute("list1");
//				System.out.println(list.size());

//				System.out.println("明細存入");

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("OrderMasterVO", omVO); // 含有輸入格式錯誤的VO物件,也存入req
					req.setAttribute("OrderListVO", olVO);
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/addOrderMaster.jsp");
					failureView.forward(req, res);
					return;
				}

				/*********************** 開始新增 ************************/
				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				omdao.inesetWithList(omVO, list);
				/*********************** 產生QRcodecode *************************/
				byte[] in2b = null;
				if (payID == 2) {

					Integer QRcofeordID = list.get(0).getOrdID();
String url = "http://192.168.50.150:8081/TFA104G1/QRCodeTest?action=check&memID=" + QRcofeordID;

					int width = 300;
					int height = 300;
					String format = "jpg";
					// 設定編碼格式與容錯率
					Hashtable<EncodeHintType, Object> hints = new Hashtable<>();
					hints.put(EncodeHintType.CHARACTER_SET, "UTF-8");
					hints.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.H);

					BitMatrix matrix;

					try {
						matrix = new MultiFormatWriter().encode(url, BarcodeFormat.QR_CODE, width, height, hints);

						// 把產生的QRCode存到指定的目錄
						ByteArrayOutputStream baos = new ByteArrayOutputStream();
						MatrixToImageWriter.writeToStream(matrix, format, baos);

						in2b = baos.toByteArray();
						baos.flush();
						baos.close();

						omdao = new OrderMasterDAOImpl();
						OrderMasterVO qrcodeOM = omdao.findOrderMasterByPK(QRcofeordID);
						qrcodeOM.setQrcode(in2b);
						System.out.println(in2b);

						omdao.addQRCode(qrcodeOM);

					} catch (WriterException e) {
						e.printStackTrace();
					}
				}

				/*********************** 修改會員折價券狀態 ************************/

				MemcouponDAO mcdao = new MemcouponDAO();
				List<MemcouponVO> mclist = mcdao.getMemberid(rentID);
				for (MemcouponVO mcVO : mclist) {
					if (mcVO.getCoupon_id().equals(couponID)) {
						mcVO.getMem_coupon_id();
						Integer mem_coupon_id = mcVO.getMem_coupon_id();

						mcdao.findByPrimaryKey(mem_coupon_id);
					}
				}

				/*********************** 刪除購物車 ************************/
				for (OrderListVO cartList : list) {
					cartList.getProdID();
					Integer memberID = (Integer) req.getSession().getAttribute("id");
					System.out.println("memberID" + memberID);
					Jedis jedis = null;
					jedis = pool.getResource();
					Gson gson = new Gson();

					if (memberID != null) {
						List<String> cart = jedis.lrange("member" + memberID, 0, jedis.llen("member" + memberID));
						for (String item : cart) {
							CartVO cartVO = gson.fromJson(item, CartVO.class);
							System.out.println("ProdID" + cartVO.getProdID());
							if (cartVO.getProdID().equals(cartList.getProdID())) {
								jedis.lrem("member" + memberID, 1, item);
							}
						}
						jedis.close();
					}
				}

				/************* 綠界串接 ***********/

				ArrayList<String> array = new ArrayList<String>();
				for (OrderListVO listprod : list) {
					System.out.println("取到的商品編號" + listprod.getProdID());
					ProdService prodSVC = new ProdService();
					ProdVO prodVO = prodSVC.findProductByPK(listprod.getProdID());
					String prodNa = prodVO.getProdName();
					array.add(prodNa);
				}

				String join = String.join("#", array);
				System.out.println(join);

				AllInOne all = new AllInOne("");
				AioCheckOutALL obj = new AioCheckOutALL(); // 產生訂單
				String ordDateNum = String.valueOf(ord); // 產生訂單日期long值
				Integer ordForEc = list.get(0).getOrdID();
//				System.out.println("OrderMaster 生成的訂單" + ordForEc);
//				System.out.println("727 取得訂單編號" + ordForEc);

				SimpleDateFormat sdf3 = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
				String ecord = sdf3.format(ordDate);

				obj.setMerchantID("2000132"); // 特店編號
				obj.setMerchantTradeNo("JL" + ordDateNum + ordForEc.toString()); // 訂單編號
				obj.setMerchantTradeDate(ecord); // 交易日期S
				obj.setTotalAmount(ordPrice.toString()); // 交易金額
				obj.setTradeDesc("感謝您使用joyLease平台"); // 交易描述
				obj.setItemName(join); // 商品名稱
	obj.setReturnURL("https://6de8-119-77-246-24.ngrok.io/TFA104G1/ECreturn"); // 付款完成通知回傳網址
				obj.setNeedExtraPaidInfo("N");
				obj.setChooseSubPayment("ALL");
	obj.setClientBackURL(req.getContextPath() + "/front_end/order/listAllOrderForRent.jsp");

				String form = all.aioCheckOut(obj, null);

				req.getSession().setAttribute("ordIDForEC", ordForEc);

				req.setAttribute("EC", form);
				all.aioCheckOut(obj, null);

				req.getRequestDispatcher("/front_end/order/ECpage.jsp").forward(req, res);
			
				

			} catch (Exception e) {
				System.out.println("例外");
				e.printStackTrace();
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/addOrderMaster.jsp");
				failureView.forward(req, res);

			}
		}

		if ("get_Status_Display_Manager".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer ordStatus = new Integer(req.getParameter("ordStatus"));

			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			List<OrderMasterVO> omVO = omdao.findOrderMasterByStatus(ordStatus);

			if (omVO == null) {
				errorMsgs.add("查無資料");
			}

			for (OrderMasterVO oms : omVO) {
				req.setAttribute("OrderMasterVO", oms);
				String url = "/back_end/order/listStatusOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;
			}
		}

		if ("getComment_For_Display".equals(action)) { // 來自listAllOrderMaster.jsp的請求

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
				String url = "/front_end/order/updateLeaseComment.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateLeaseComment.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update_lease_comment".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String strlr = req.getParameter("leaseRank");
				System.out.println("出租者評分 : " + strlr);
				Integer leaseRank = null;
				if (strlr != null && strlr.length() != 0) {
					leaseRank = new Integer(strlr);
				}

				String leaseComt = req.getParameter("leaseComt").trim();

				Date date = new Date();
				long strlc = (date.getTime());
				Timestamp leaseComtdate = new Timestamp(strlc);

				Integer ordID = new Integer(req.getParameter("ordID"));

				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setLeaseRank(leaseRank);
				omVO.setLeaseComt(leaseComt);
				omVO.setLeaseComtdate(leaseComtdate);
				omVO.setOrdID(ordID);

				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO leaseCom = omSVC.addLeaseComment(leaseRank, leaseComt, leaseComtdate, ordID);

				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", leaseCom); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				String url = "/front_end/order/listSuccessOrder.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				return;

			} catch (Exception e) {
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
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateRentComment.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update_rent_comment".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String strrr = req.getParameter("rentRank");
				System.out.println("承租者評分 : " + strrr);
				Integer rentRank = null;
				if (strrr != null && strrr.length() != 0) {
					rentRank = new Integer(strrr);
				}

				String rentComt = req.getParameter("rentComt").trim();
				System.out.println("承租者評論內容 : " + rentComt);

				Date date = new Date();

				long strrc = (date.getTime());
				Timestamp rentComtdate = new Timestamp(strrc);

				Integer ordID = new Integer(req.getParameter("ordID"));

				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setRentRank(rentRank);
				omVO.setRentComt(rentComt);
				omVO.setRentComtdate(rentComtdate);
				omVO.setOrdID(ordID);

				OrderMasterService omSVC = new OrderMasterService();
				OrderMasterVO rentCom = omSVC.addRentComment(rentRank, rentComt, rentComtdate, ordID);

				/******************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", rentCom); // 資料庫update成功後,正確的的ordermasterVO物件,存入req
				String url = "/front_end/order/listSuccessOrderForRent.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				return;
			} catch (Exception e) {
				System.out.println("失敗");
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateRentComment.jsp");
				failureView.forward(req, res);
			}
		}

		if ("get_date_forRent_order".equals(action)) {
			System.out.println("近來日期判斷");
			DateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {

				String startDate = (String) req.getParameter("startDate");
				String endDate = (String) req.getParameter("endDate");
				Integer memID = (Integer) req.getSession().getAttribute("id");

				java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
				java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);

				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				List<OrderMasterVO> list = omdao.getAllOrderMaster();

				List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
				for (OrderMasterVO omVO : list) {
					if (omVO.getOrdStatus() == 2 && omVO.getReturnDate() != null && omVO.getReturnDate().before(ed)
							&& omVO.getReturnDate().after(sd) && omVO.getRentID().equals(memID)) {
						long time = omVO.getReturnDate().getTime();
						Integer ordID = omVO.getOrdID();
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listSuccessOrderForRent.jsp").forward(req, res);
				return;
			} catch (Exception e) {

			}
		}
		if ("get_date_forLease_order".equals(action)) {

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			DateFormat sdf = new SimpleDateFormat("yyyy-mm-dd");

			try {

				String startDate = (String) req.getParameter("startDate");
				String endDate = (String) req.getParameter("endDate");
				Integer memID = (Integer) req.getSession().getAttribute("id");
				System.out.println(startDate);

				java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
				java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);

				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				List<OrderMasterVO> list = omdao.getAllOrderMaster();

				List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
				for (OrderMasterVO omVO : list) {
					if (omVO.getOrdStatus() == 2 && omVO.getReturnDate() != null && omVO.getReturnDate().before(ed)
							&& omVO.getReturnDate().after(sd) && omVO.getLeaseID().equals(memID)) {
						long time = omVO.getReturnDate().getTime();
						Integer ordID = omVO.getOrdID();
						System.out.println("訂單編號 :" + ordID + "歸還時間" + time);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listSuccessOrder.jsp").forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listSuccessOrder.jsp");
				failureView.forward(req, res);
			}
		}

		if ("get_Date_Display".equals(action)) {
			String month = req.getParameter("month");

			Integer memID = (Integer) req.getSession().getAttribute("id");
			OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
			List<OrderMasterVO> list = omdao.getAllOrderMaster();
			List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
			if (month.equals("12")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-12-31";
				String bdate = "2021-12-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("11")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-11-3";
				String bdate = "2021-11-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("10")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-10-31";
				String bdate = "2021-10-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("9")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-09-30";
				String bdate = "2021-09-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("8")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-08-31";
				String bdate = "2021-08-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("7")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-07-31";
				String bdate = "2021-07-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("6")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-06-30";
				String bdate = "2021-06-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("5")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-05-31";
				String bdate = "2021-05-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("4")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-04-30";
				String bdate = "2021-04-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("3")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-03-31";
				String bdate = "2021-03-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("2")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-02-29";
				String bdate = "2021-02-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}
			if (month.equals("1")) {
				System.out.println("選到的月份 : " + month);
				String edate = "2021-01-31";
				String bdate = "2021-01-01";
				java.sql.Date sqlDate3 = java.sql.Date.valueOf(edate);
				java.sql.Date sqlDate4 = java.sql.Date.valueOf(bdate);
				for (OrderMasterVO omVO : list) {
					if (omVO.getLeaseID().equals(memID) && omVO.getOrdDate().after(sqlDate4)
							&& omVO.getOrdDate().before(sqlDate3)) {
						Integer ordID = omVO.getOrdID();
						System.out.println(ordID);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/front_end/order/listAllOrderMaster.jsp").forward(req, res);
				return;
			}

		}
	}
}
