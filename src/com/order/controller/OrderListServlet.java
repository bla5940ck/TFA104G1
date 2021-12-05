package com.order.controller;

import java.io.IOException;
import java.sql.Date;
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
import com.order.model.OrderListService;
import com.order.model.OrderListVO;
import com.order.model.OrderMasterVO;

@WebServlet("/OrderListServlet")
public class OrderListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req, res);
//		String path = req.getRequestURI();
//		System.out.println(path);
	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自listAllOrderList.jsp
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				String str = req.getParameter("listID");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("格式錯誤 ! 請輸入訂單明細編號");
				}
				if (!errorMsgs.isEmpty()) {
					System.out.println("這");
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer listID = null;
				try {
					listID = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("格式不正確");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("這2");
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/**************** 2.開始查詢資料 ****************/

				OrderListDAOImpl oldao = new OrderListDAOImpl();
				OrderListVO olVO = oldao.findOrderListByPK(listID);

				if (olVO == null) {
					errorMsgs.add("查無該筆訂單明細");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					System.out.println("這3");
					RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/************** 3.查詢完成,準備轉交 *************/
				req.setAttribute("OrderListVO", olVO);
				String url = "front_end/order/listOneOrderList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);
				successView.forward(req, res);
				return;

			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/listAllOrderList.jsp");
				failureView.forward(req, res);
			}
		}

		if ("get_Status_Display".equals(action)) { // 來自listStatusOrderList.jsp
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("進來了");

			try {

				String str = req.getParameter("ordStatus");
				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入明細編號");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer ordStatus = null;
				try {
					ordStatus = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("編號格式不正確");
				}
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/**************** 2.開始查詢資料 ****************/

				OrderListDAOImpl oldao = new OrderListDAOImpl();
				List<OrderListVO> olVO = oldao.findOrderListByStatus(ordStatus);

				if (olVO == null) {
					errorMsgs.add("查無資料");
				}
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req
							.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				for (OrderListVO ols : olVO) {

					/************** 3.查詢完成,準備轉交 *************/
					req.setAttribute("OrderListVO", ols);
					String url = "/front_end/order/listStatusOrderList.jsp";
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

		if ("getlist_For_Display".equals(action)) { // 來自listStatusOrderList.jsp
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
							.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
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
							.getRequestDispatcher(req.getContextPath() + "/front_end/order/listAllOrderList.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				for (OrderListVO ols : olVO) {

					/************** 3.查詢完成,準備轉交 *************/
					req.setAttribute("OrderListVO", ols);
					String url = "/front_end/order/listOrdIDOrderList.jsp";
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

		if ("getOne_For_Update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				Integer listID = new Integer(req.getParameter("listID"));

				OrderListService olSVC = new OrderListService();
				OrderListVO olVO = olSVC.getOneOrderList(listID);

				req.setAttribute("OrderListVO", olVO);
				String url = "/front_end/order/updateOrderListInput.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交
				successView.forward(req, res);

			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateOrderListInput.jsp");
				failureView.forward(req, res);
			}
		}

		if ("update".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				
				String list = req.getParameter("listID");
				Integer listID = new Integer(req.getParameter("listID"));
				Integer ordStatus = new Integer(req.getParameter("ordStatus"));
				Integer ordID = new Integer(req.getParameter("ordID"));
				
				OrderListVO olVO = new OrderListVO();
				olVO.setOrdStatus(ordStatus);
				olVO.setListID(listID);
				olVO.setOrdID(ordID);
				System.out.println("這邊");
				OrderListDAOImpl oldao = new OrderListDAOImpl();
				oldao.update(olVO);
				req.setAttribute("OrderListVO", olVO);
				
//				OrderListDAOImpl oldao = new OrderListDAOImpl();
//				List<OrderListVO> uplist = new ArrayList<OrderListVO>();
//				OrderListVO upol = new OrderListVO();
//				upol.setListID(listID);
//				upol.setOrdStatus(ordStatus);
//				upol.setOrdID(ordID);
				
				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setOrdStatus(ordStatus);
				
				

				String url = "/front_end/order/listOrdIDOrderList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneOrderMaster.jsp
				successView.forward(req, res);
				System.out.println("完成");
				return;

			} catch (Exception e) {

				System.out.println("失敗");
				e.printStackTrace();
//				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/order/updateOrderMasterInput.jsp");
				failureView.forward(req, res);
			}
		}

	}
}
