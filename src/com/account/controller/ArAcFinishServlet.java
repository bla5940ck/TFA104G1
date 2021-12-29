package com.account.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.order.model.OrderListDAOImpl;
import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterVO;
import com.product.jedis.JedisPoolUtil;

import redis.clients.jedis.JedisPool;

/**
 * Servlet implementation class ArAcServlet
 */
@WebServlet("/account/ArAcFinishServlet")
public class ArAcFinishServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static JedisPool pool = JedisPoolUtil.getJedisPool();
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ArAcFinishServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
//		String path = req.getRequestURI();
//		System.out.println(path);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		//依訂單編號查詢
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
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
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				OrderListDAOImpl oldao = new OrderListDAOImpl();

				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("OrderMasterVO", omVO); // 資料庫取出的VO物件,存入req
				String url = "/back_end/order/listOneOrderMaster.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
				failureView.forward(req, res);
			}
		}
	
		
		
		//依訂單日期篩選		
		if ("get_orDdate_order".equals(action)) {
					
					List<String> errorMsgs = new LinkedList<String>();
					req.setAttribute("errorMsgs", errorMsgs);

					DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
					
					try {

						String startDate =(String)req.getParameter("startDate");
//						startDate = sdf.format(startDate);
						if (startDate == null || (startDate.trim()).length() == 0) {
							errorMsgs.add("請選擇日期");
						}
						System.out.println(startDate);
						if (!errorMsgs.isEmpty()) {
							RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
							failureView.forward(req, res);
							return;// 程式中斷
						}
						
						
						String endDate = (String) req.getParameter("endDate");
						if (endDate == null || (endDate.trim()).length() == 0) {
							errorMsgs.add("請選擇日期");
						}
						if (!errorMsgs.isEmpty()) {
							RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
							failureView.forward(req, res);
							return;// 程式中斷
						}
						
//					Integer memID = (Integer) req.getSession().getAttribute("id");

						java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
						java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);

						OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
						List<OrderMasterVO> list = omdao.getAllOrderMaster();

						List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
						for (OrderMasterVO omVO : list) {
							if (omVO.getTrfStatus() == 1 && omVO.getOrdStatus() == 2 && omVO.getOrdDate() != null && omVO.getOrdDate().before(ed)
									&& omVO.getOrdDate().after(sd)) {
								long time = omVO.getReturnDate().getTime();
								Integer ordID = omVO.getOrdID();
								System.out.println("訂單編號 :" + ordID + "完成時間" + time);
								list2.add(omVO);
							}
						}
						req.setAttribute("list", list2);
						req.getRequestDispatcher("/back_end/account/ACFinish.jsp").forward(req, res);
						return;
					} catch (Exception e) {
						e.printStackTrace();
						errorMsgs.add("修改資料失敗:" + e.getMessage());
						RequestDispatcher failureView = req.getRequestDispatcher("/bcak_end/account/ACFinish.jsp");
						failureView.forward(req, res);
					}
		}
		
//依訂單完成日期篩選		
if ("get_arVdate_order".equals(action)) {
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			try {

				String startDate = req.getParameter("startDate");
//				startDate = sdf.format(startDate);
				if (startDate == null || (startDate.trim()).length() == 0) {
					errorMsgs.add("請選擇日期");
				}
				System.out.println(startDate);
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
				
				String endDate = (String) req.getParameter("endDate");
				if (endDate == null || (endDate.trim()).length() == 0) {
					errorMsgs.add("請選擇日期");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/account/ACFinish.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				
//			Integer memID = (Integer) req.getSession().getAttribute("id");

				java.sql.Timestamp sd = java.sql.Timestamp.valueOf(startDate);
				java.sql.Timestamp ed = java.sql.Timestamp.valueOf(endDate);

				OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();
				List<OrderMasterVO> list = omdao.getAllOrderMaster();

				List<OrderMasterVO> list2 = new ArrayList<OrderMasterVO>();
				for (OrderMasterVO omVO : list) {
					if (omVO.getTrfStatus() == 1 && omVO.getOrdStatus() == 2 && omVO.getReturnDate() != null && omVO.getReturnDate().before(ed)
							&& omVO.getReturnDate().after(sd)) {
						long time = omVO.getReturnDate().getTime();
						Integer ordID = omVO.getOrdID();
						System.out.println("訂單編號 :" + ordID + "完成時間" + time);
						list2.add(omVO);
					}
				}
				req.setAttribute("list", list2);
				req.getRequestDispatcher("/back_end/account/ACFinish.jsp").forward(req, res);
				return;
			} catch (Exception e) {
				e.printStackTrace();
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/bcak_end/account/ACFinish.jsp");
				failureView.forward(req, res);
			}
		
		
		
}
		
	}

}
