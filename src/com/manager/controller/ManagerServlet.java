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
if ("getOne_For_Display".equals(action)) { // �Ӧ�select_page.jsp���ШD
//			System.out.println("123");
//			System.out.println(req.getParameter("managerID"));
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
//			// Store this set in the request scope, in case we need to
//			// send the ErrorPage view.

			try {
////				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
				String str = req.getParameter("managerID");
				System.out.println(str);
				Integer managerID = new Integer(req.getParameter("managerID"));

//				/*************************** 2.�}�l�d�߸�� *****************************************/
				ManagerService msSvc = new ManagerService();
				ManagerVO managerVO = msSvc.getOneManager(managerID);

//				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) *************/
				req.setAttribute("managerVO", managerVO); // ��Ʈw���X��managerVO����,�s�Jreq
				String url = "/Manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // ���\��� listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/select_page.jsp");
				failureView.forward(req, res);
			}
		}

if ("getOne_For_Update".equals(action)) { // �Ӧ�listAllEmp.jsp���ШD
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.�����ШD�Ѽ� ****************************************/
				Integer managerID = new Integer(req.getParameter("managerID"));

				/*************************** 2.�}�l�d�߸�� ****************************************/
				ManagerService msSvc = new ManagerService();
				ManagerVO managerVO = msSvc.getOneManager(managerID);

				/*************************** 3.�d�ߧ���,�ǳ����(Send the Success view) ************/
				req.setAttribute("managerVO", managerVO); // ��Ʈw���X��empVO����,�s�Jreq
				String url = "/Manager/update_manager_input.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// ���\��� update_emp_input.jsp
				successView.forward(req, res);
				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�L�k���o�n�ק諸���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/listAll.jsp");
				failureView.forward(req, res);
			}
		}

if ("update".equals(action)) { // �Ӧ�update_emp_input.jsp���ШD
			
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z **********************/
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
					req.setAttribute("managerVO", managerVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/Manager/update_manager_input.jsp");
					failureView.forward(req, res);
					return; // �{�����_
				}

				/*************************** 2.�}�l�ק��� *****************************************/
//				ManagerService msSvc = new ManagerService();
//				managerVO = msSvc.updateManager(managerID, managerUser, managerName, managerPassword, status);
				ManagerDAO dao = new ManagerDAO();
				dao.update(managerVO);
				
				/*************************** 3.�ק粒��,�ǳ����(Send the Success view) *************/
				req.setAttribute("managerVO", managerVO); // ��Ʈwupdate���\��,���T����empVO����,�s�Jreq
				String url = "/Manager/listOne.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �ק令�\��,���listOneEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z *************************************/
			} catch (Exception e) {
				errorMsgs.add("�ק��ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/update_manager_input.jsp");
//				failureView.forward(req, res);
			}
		}

if ("insert".equals(action)) { // �Ӧ�addEmp.jsp���ШD
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			System.out.println("1232132131");
			try {
				/*********************** 1.�����ШD�Ѽ� - ��J�榡�����~�B�z *************************/
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
					req.setAttribute("managerVO", managerVO); // �t����J�榡���~��empVO����,�]�s�Jreq
					RequestDispatcher failureView = req.getRequestDispatcher("/Manager/update_manager_input.jsp");
					failureView.forward(req, res);
					return; // �{�����_
				}

				/*************************** 2.�}�l�s�W��� ***************************************/
//					ManagerService msSvc = new ManagerService();
//					managerVO = msSvc.addManager(managerUser, managerName, managerPassword, status);

				ManagerDAO dao = new ManagerDAO();
				dao.insert(managerVO);

				/*************************** 3.�s�W����,�ǳ����(Send the Success view) ***********/
				String url = "/Manager/listAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // �s�W���\�����listAllEmp.jsp
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/addManager.jsp");
				failureView.forward(req, res);
			}
		}

if ("delete".equals(action)) { // �Ӧ�listAllEmp.jsp
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			try {
				/*************************** 1.�����ШD�Ѽ� ***************************************/
				Integer managerID = new Integer(req.getParameter("managerID"));

				/*************************** 2.�}�l�R����� ***************************************/
				ManagerService msSvc = new ManagerService();
				msSvc.deleteManager(managerID);

				/*************************** 3.�R������,�ǳ����(Send the Success view) ***********/
				String url = "/Manager/listAll.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// �R�����\��,���^�e�X�R�����ӷ�����
				successView.forward(req, res);

				/*************************** ��L�i�઺���~�B�z **********************************/
			} catch (Exception e) {
				errorMsgs.add("�R����ƥ���:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/Manager/listAll.jsp");
				failureView.forward(req, res);
			}
		}
	}
}
