package com.manager.controller;

import java.io.IOException;
import java.util.Enumeration;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.Manager;

import com.manager.model.ManagerVO;
import com.mysql.cj.Session;
import com.manager.model.ManagerDAO;
import com.manager.model.ManagerService;

@WebServlet("/ManagerServlet")
public class ManagerServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		doPost(req, res);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		if ("getOne_For_Display".equals(action)) { // 來自select_page.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("managerID");

				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入管理員編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer managerID = null;

				try {
					managerID = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("格式不正確");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				managerID = new Integer(req.getParameter("managerID"));
				ManagerService msSvc = new ManagerService();
				ManagerVO managerVO = msSvc.getOneManager(managerID);

				if (managerVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("managerVO", managerVO); // 資料庫取出的managerVO物件,存入req
				String url = "/back_end/manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/select_page.jsp");
				failureView.forward(req, res);
			}
		}

		if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			/*************************** 1.接收請求參數 ****************************************/
			System.out.println(req.getParameter("managerID"));
			Integer managerID = new Integer(req.getParameter("managerID"));

			/*************************** 2.開始查詢資料 ****************************************/
			ManagerService msSvc = new ManagerService();
			ManagerVO managerVO = msSvc.getOneManager(managerID);

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
			req.setAttribute("managerVO", managerVO); // 資料庫取出的empVO物件,存入req
			String url = "/back_end/manager/update_manager_input.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
			successView.forward(req, res);
			/*************************** 其他可能的錯誤處理 **********************************/

		}

		if ("update".equals(action)) { // 來自update_emp_input.jsp的請求

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/

				Integer managerID = new Integer(req.getParameter("managerID"));

				String managerUser = req.getParameter("managerUser");
				String managerUserReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (managerUser == null || managerUser.trim().length() == 0) {
					errorMsgs.add("管理員帳號: 請勿空白");
				} else if (!managerUser.trim().matches(managerUserReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員帳號: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}
				String managerName = req.getParameter("managerName");
				String managerNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (managerName == null || managerName.trim().length() == 0) {
					errorMsgs.add("管理員姓名: 請勿空白");
				} else if (!managerName.trim().matches(managerNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}
				String managerPassword = req.getParameter("managerPassword");
				String managerPasswordReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (managerPassword == null || managerPassword.trim().length() == 0) {
					errorMsgs.add("管理員帳號: 請勿空白");
				} else if (!managerPassword.trim().matches(managerPasswordReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員帳號: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}
				Integer status = new Integer(req.getParameter("status"));

				ManagerVO managerVO = new ManagerVO();

				managerVO.setManagerID(managerID);
				managerVO.setManagerUser(managerUser);
				managerVO.setManagerName(managerName);
				managerVO.setManagerPassword(managerPassword);
				managerVO.setStatus(status);

				if (!errorMsgs.isEmpty()) {
					req.setAttribute("managerVO", managerVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/manager/update_manager_input.jsp");
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
				String url = "/back_end/manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/update_manager_input.jsp");
//				failureView.forward(req, res);
			}
		}

		if ("insert".equals(action)) { // 來自addEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String managerUser = req.getParameter("managerUser");
				String managerUserReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (managerUser == null || managerUser.trim().length() == 0) {
					errorMsgs.add("管理員帳號: 請勿空白");
				} else if (!managerUser.trim().matches(managerUserReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員帳號: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String managerName = req.getParameter("managerName");
				String managerNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (managerName == null || managerName.trim().length() == 0) {
					errorMsgs.add("管理員姓名: 請勿空白");
				} else if (!managerName.trim().matches(managerNameReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
				}

				String managerPassword = req.getParameter("managerPassword");
				String managerPasswordReg = "^[(a-zA-Z0-9_)]{2,10}$";
				if (managerPassword == null || managerPassword.trim().length() == 0) {
					errorMsgs.add("管理員帳號: 請勿空白");
				} else if (!managerPassword.trim().matches(managerPasswordReg)) { // 以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("管理員帳號: 只能是英文字母、數字和_ , 且長度必需在2到10之間");
				}

				Integer status = new Integer(req.getParameter("status"));

				ManagerVO managerVO = new ManagerVO();
				managerVO.setManagerUser(managerUser);
				managerVO.setManagerName(managerName);
				managerVO.setManagerPassword(managerPassword);
				managerVO.setStatus(status);

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("managerVO", managerVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/back_end/manager/update_manager_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/

				ManagerDAO dao = new ManagerDAO();
				dao.insert(managerVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back_end/manager/listAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/addManager.jsp");
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
				String url = "/back_end/manager/listAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("刪除資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/listAll.jsp");
				failureView.forward(req, res);
			}
		}
		if ("login".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			System.out.println("進來1234");
			
			ManagerDAO dao = new ManagerDAO();
			List<ManagerVO> list = dao.getAll();
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String managerUser = req.getParameter("managerUser");
				
				System.out.println(managerUser);
				
				if (managerUser == null || managerUser.trim().length() == 0) {
					errorMsgs.add("管理員帳號: 請勿空白");
				}

				String managerPassword = req.getParameter("managerPassword");
				if (managerPassword == null || managerPassword.trim().length() == 0) {
					errorMsgs.add("管理員姓名: 請勿空白");
				}

//				System.out.println(managerUser);
//				System.out.println(managerPassword);
//				System.out.println("共有幾位管理員 : " + list.size());

				for (int i = 0; i < list.size(); i++) {

//					System.out.println(list.get(i));

					String user = list.get(i).getManagerUser();
					String password = list.get(i).getManagerPassword();
					Integer id = list.get(i).getManagerID();

//					System.out.println("帳號 : " + user);
//					System.out.println("密碼 : " + password);

					if ((managerUser.trim().equals(user)) && (managerPassword.trim().equals(password))) {

					      System.out.println(req.getParameter("managerUser") + "你好");

					      req.getSession().setAttribute("managerID", id);
					      req.getSession().setAttribute("managerUser", user);
					      req.getSession().setAttribute("managerPassword", password);
					      System.out.println("loginServlet: "+(String)req.getSession().getAttribute("location"));
					      if(req.getSession().getAttribute("location")!=null) {
					       res.sendRedirect((String)req.getSession().getAttribute("location"));       
					      }else {
					       res.sendRedirect("/TFA104G1/back_end/manager/select_page.jsp");
					      }
					      
					      return;
					     }
				}
				errorMsgs.add("帳號密碼不符合");
				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/managerlogin.jsp");
					failureView.forward(req, res);
					return;
				}

			} catch (Exception e) {
				errorMsgs.add("登入失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/manager/managerlogin.jsp");
				failureView.forward(req, res);
			}

		}
		
		if("sign_out".equals(action)) {
			req.getSession().invalidate();
			RequestDispatcher successView = req.getRequestDispatcher("/back_end/manager/managerlogin.jsp");
			successView.forward(req, res);
			return;
		}
	}
}
