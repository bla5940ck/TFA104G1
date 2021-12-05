package com.member.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.emp.model.EmpDAO;
import com.emp.model.EmpVO;
import com.member.model.MemberJDBCDAO;
import com.member.model.MemberVO;

@WebServlet("/member/MemForntServlet")
public class MemFrontServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemFrontServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	doPost(req, res);
    	}

    public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
    	req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
	
		if ("getOneMember".equals(action)) {
			/***************************開始查詢資料 ****************************************/
			MemberJDBCDAO dao = new MemberJDBCDAO();
			List<MemberVO> list = dao.getAll();

			/***************************查詢完成,準備轉交(Send the Success view)*************/
			HttpSession session = req.getSession();
			session.setAttribute("list", list);    // 資料庫取出的list物件,存入session
			// Send the Success view
			String url = "/emp/listAllEmp2_getFromSession.jsp";
			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交listAllEmp2_getFromSession.jsp
			successView.forward(req, res);
			return;
		}
		
		
		
		
		
		
		
		
		
		
	}

}
