package com.manager.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.manager.model.ManagerVO;
import com.manager.model.ManagerDAO;
import com.manager.model.ManagerService;

@WebServlet("/ManagerServlet")
public class ManagerServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		System.out.println("doget");
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		System.out.println(action);
if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求
//			System.out.println("123");
//			System.out.println(req.getParameter("managerID"));
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.

			try {
////				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("managerID");
				System.out.println(str);
				Integer managerID = new Integer(req.getParameter("managerID"));

//				/*************************** 2.開始查詢資料 *****************************************/
				ManagerService msSvc = new ManagerService();
				ManagerVO managerVO = msSvc.getOneManager(managerID);

//				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("managerVO", managerVO); // 資料庫取出的managerVO物件,存入req
				String url = "/Manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/select_page.jsp");
				failureView.forward(req, res);
			}
		}

if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer managerID = new Integer(req.getParameter("managerID"));

				/*************************** 2.開始查詢資料 ****************************************/
				ManagerService msSvc = new ManagerService();
				ManagerVO managerVO = msSvc.getOneManager(managerID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("managerVO", managerVO); // 資料庫取出的empVO物件,存入req
				String url = "/Manager/update_manager_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/listAll.jsp");
				failureView.forward(req, res);
			}
		}

if ("update".equals(action)) { // 來自update_emp_input.jsp的請求
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer managerID = new Integer(req.getParameter("managerID").trim());

				String managerUser = req.getParameter("managerUser");

				String managerName = req.getParameter("managerName");

				String managerPassword = req.getParameter("managerPassword");

				Integer status = new Integer(req.getParameter("status").trim());

				ManagerVO managerVO = new ManagerVO();
			
				managerVO.setManagerID(managerID);
				managerVO.setManagerUser(managerUser);
				managerVO.setManagerName(managerName);
				managerVO.setManagerPassword(managerPassword);
				managerVO.setStatus(status);
				System.out.println("managerVO="+managerVO);
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("managerVO", managerVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/Manager/update_manager_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
//				ManagerService msSvc = new ManagerService();
//				managerVO = msSvc.updateManager(managerID, managerUser, managerName, managerPassword, status);
				ManagerDAO dao = new ManagerDAO();
				dao.update(managerVO);
				
				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("managerVO", managerVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/Manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/update_manager_input.jsp");
//				failureView.forward(req, res);
			}
		}

if ("insert".equals(action)) { // 來自addEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("1232132131");
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String managerUser = req.getParameter("managerUser");
				System.out.println(managerUser);

				String managerName = req.getParameter("managerName");
				System.out.println(managerName);

				String managerPassword = req.getParameter("managerPassword");
				System.out.println(managerPassword);

				Integer status = new Integer(req.getParameter("status").trim());

				ManagerVO managerVO = new ManagerVO();

				managerVO.setManagerUser(managerUser);
				managerVO.setManagerName(managerName);
				managerVO.setManagerPassword(managerPassword);
				managerVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("managerVO", managerVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/Manager/update_manager_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/
//					ManagerService msSvc = new ManagerService();
//					managerVO = msSvc.addManager(managerUser, managerName, managerPassword, status);

				ManagerDAO dao = new ManagerDAO();
				dao.insert(managerVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/Manager/listAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/addManager.jsp");
				failureView.forward(req, res);
			}
		}

if ("delete".equals(action)) { // 來自listAllEmp.jsp
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ***************************************/
				Integer managerID = new Integer(req.getParameter("managerID"));

				/*************************** 2.開始刪除資料 ***************************************/
				ManagerService msSvc = new ManagerService();
				msSvc.deleteManager(managerID);

				/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
				String url = "/Manager/listAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/listAll.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
