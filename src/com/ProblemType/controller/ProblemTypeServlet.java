package com.problemtype.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.problemtype.model.ProblemTypeDAO;
import com.problemtype.model.ProblemTypeService;
import com.problemtype.model.ProblemTypeVO;



@WebServlet("/ProblemTypeServlet")
public class ProblemTypeServlet extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doPost(req,res);
	}

	
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
		
		
if("getone_For_Display".equals(action)) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				String str = req.getParameter("typeID");
			

				if (str == null || (str.trim()).length() == 0) {
					errorMsgs.add("請輸入問題編號");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				Integer typeID = null;

				try {
					typeID = new Integer(str);
				} catch (Exception e) {
					errorMsgs.add("格式不正確");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}

				/*************************** 2.開始查詢資料 *****************************************/
				typeID = new Integer(req.getParameter("typeID"));
				ProblemTypeService ptSvc = new ProblemTypeService();
				ProblemTypeVO problemtypeVO = ptSvc.getOneProblemType(typeID);

				if (problemtypeVO == null) {
					errorMsgs.add("查無資料");
				}

				if (!errorMsgs.isEmpty()) {
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/select_page.jsp");
					failureView.forward(req, res);
					return;// 程式中斷
				}
				/*************************** 3.查詢完成,準備轉交(Send the Success view) *************/
				req.setAttribute("problemtypeVO", problemtypeVO); // 資料庫取出的managerVO物件,存入req
				String url = "/back_end/manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 成功轉交 listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/select_page.jsp");
				failureView.forward(req, res);
			
		}
	}
if ("getOne_For_Update".equals(action)) { // 來自listAllEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer typeID = new Integer(req.getParameter("typeID"));

				/*************************** 2.開始查詢資料 ****************************************/
				ProblemTypeService ptSvc = new ProblemTypeService();
				ProblemTypeVO problemtypeVO = ptSvc.getOneProblemType(typeID);

				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("problemtypeVO", problemtypeVO); // 資料庫取出的empVO物件,存入req
				String url = "/back_end/problemtype/update_problemtype_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 update_emp_input.jsp
				successView.forward(req, res);
				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/listAllProblemType.jsp");
				failureView.forward(req, res);
			}
		}
if ("update".equals(action)) { 

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.接收請求參數 - 輸入格式的錯誤處理 **********************/
				Integer typeID = new Integer(req.getParameter("typeID"));
//				System.out.println(typeID);
				
				String typeName = req.getParameter("typeName");
				
				
				System.out.println(typeName);
				String typeNameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9-)]{2,10}$";
				if (typeName == null || typeName.trim().length() == 0) {
					errorMsgs.add("問題名子: 請勿空白");
				} else if(!typeName.trim().matches(typeNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("問題名子: 只能是中、英文字母、數字和- , 且長度必需在2到10之間");
	            }
				ProblemTypeVO problemtypeVO = new ProblemTypeVO();
				

				
				problemtypeVO.setTypeID(typeID);
				problemtypeVO.setTypeName(typeName);
				
				
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("problemtypeVO", problemtypeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/update_problemtype_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始修改資料 *****************************************/
//				
				ProblemTypeDAO dao = new ProblemTypeDAO();
				dao.update(problemtypeVO);

				/*************************** 3.修改完成,準備轉交(Send the Success view) *************/
				req.setAttribute("problemtypeVO", problemtypeVO); // 資料庫update成功後,正確的的empVO物件,存入req
				String url = "/back_end/problemtype/listAllProblemType.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 修改成功後,轉交listOneEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 *************************************/
			} catch (Exception e) {
				errorMsgs.add("修改資料失敗:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/update_problemtype_input.jsp");
				failureView.forward(req, res);
			}
		}
if ("insert".equals(action)) { // 來自addEmp.jsp的請求
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			
			try {
				/*********************** 1.接收請求參數 - 輸入格式的錯誤處理 *************************/
				String typeName = req.getParameter("typeName");
				String typeNameReg = "^[(\\u4e00-\\u9fa5)(a-zA-Z0-9-)]{2,10}$";
				if (typeName == null || typeName.trim().length() == 0) {
					errorMsgs.add("問題名子: 請勿空白");
				} else if(!typeName.trim().matches(typeNameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("問題名子:  只能是中、英文字母、數字和-, 且長度必需在2到10之間");
	            }

				
			
				

				ProblemTypeVO problemtypeVO = new ProblemTypeVO();
				problemtypeVO.setTypeName(typeName);
				

				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("problemtypeVO", problemtypeVO); // 含有輸入格式錯誤的empVO物件,也存入req
					RequestDispatcher failureView = req.getRequestDispatcher("/back_end/problemtype/update_problemtype_input.jsp");
					failureView.forward(req, res);
					return; // 程式中斷
				}

				/*************************** 2.開始新增資料 ***************************************/
//					ManagerService msSvc = new ManagerService();
//					managerVO = msSvc.addManager(managerUser, managerName, managerPassword, status);

				ProblemTypeDAO dao = new ProblemTypeDAO();
				dao.insert(problemtypeVO);

				/*************************** 3.新增完成,準備轉交(Send the Success view) ***********/
				String url = "/back_end/problemtype/listAllProblemType.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交listAllEmp.jsp
				successView.forward(req, res);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("/back_end/problemtype/addProblemType.jsp");
				failureView.forward(req, res);
			}
		}
if ("delete".equals(action)) { // 來自listAllEmp.jsp
	List<String> errorMsgs = new LinkedList<String>();
	req.setAttribute("errorMsgs", errorMsgs);
	try {
		/*************************** 1.接收請求參數 ***************************************/
		Integer typeID = new Integer(req.getParameter("typeID"));

		/*************************** 2.開始刪除資料 ***************************************/
		ProblemTypeService ptSvc = new ProblemTypeService();
		ptSvc.deleteProblemType(typeID);

		/*************************** 3.刪除完成,準備轉交(Send the Success view) ***********/
		String url = "/back_end/problemtype/listAllProblemType.jsp";
		RequestDispatcher successView = req.getRequestDispatcher(url);// 刪除成功後,轉交回送出刪除的來源網頁
		successView.forward(req, res);

		/*************************** 其他可能的錯誤處理 **********************************/
	} catch (Exception e) {
		errorMsgs.add("刪除資料失敗:" + e.getMessage());
		RequestDispatcher failureView = req
				.getRequestDispatcher("/back_end/problemtype/listAllProblemType.jsp");
		failureView.forward(req, res);
	}
	}


	}
	}
