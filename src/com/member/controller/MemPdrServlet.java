package com.member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.model.MemberService;
import com.member.model.MemberVO;

@WebServlet("/member/MemPdrServlet")
public class MemPdrServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public MemPdrServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(req, res);
		/*
		res.setContentType("image/jpeg");
		ServletOutputStream out=res.getOutputStream();
		
		try {
			String memberId = req.getParameter("memberId").trim();
			MemberService MemSvc = new MemberService();
			MemberVO memberVO = MemSvc.getOneMember(Integer.valueOf(memberId));
			byte[] IdcF = memberVO. getIdcF();
			out.write(IdcF);
			
			System.out.println("檢查點102");
			
		}
		catch(Exception e) {
			InputStream in = getServletContext().getResourceAsStream("");
			byte[] buf = new byte[in.available()];
			in.read(buf);
			out.write(buf);
			in.close();
			
			System.out.println("檢查點103");
			
		}
		*/
		}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// TODO Auto-generated method stub
		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");

		List<String> errorMsgs = new LinkedList<String>();
		req.setAttribute("errorMsgs", errorMsgs);

//		單筆審核查詢
		if ("updateStatus".equals(action)) {
			try {
				/*************************** 1.接收請求參數 ****************************************/
				Integer memberId = new Integer(req.getParameter("memberId"));

				/*************************** 2.開始查詢資料 ****************************************/
				MemberService memSvc = new MemberService();
				MemberVO memberVO = memSvc.getOneMember(memberId);
				
//				if (memberVO.getIdcF().length > 0 && memberVO.getIdcF() != null) 
//					System.out.println("999999999");
//			memberVO.setIdcF(new byte[req.getPart("idcF").getInputStream().available()]);
//				System.out.println("999999999888888888888888888888888888");
			   
//			    List<MemberVO> list = memSvc.getPdrMember();
//			    MemberVO memberVO =list.get(0);
			    
				System.out.println(memberVO.getIdcB());
				System.out.println(memberVO.getIdcF());
				/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
				req.setAttribute("memberVO", memberVO); // 資料庫取出的memberVO物件,存入req
				String url = "/back_end/member/updateList.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 updateList.jsp
				successView.forward(req, res);
//			一個是跳轉一個內轉
//			res.sendRedirect(req.getContextPath() + url);

				/*************************** 其他可能的錯誤處理 **********************************/
			} catch (Exception e) {
				errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
				RequestDispatcher failureView = req.getRequestDispatcher("/back_end/member/updateList.jsp");
				failureView.forward(req, res);
			}
		}

//		待審核會員全部查詢
		
		
		
		
//		try {
			/*************************** 1.接收請求參數 ****************************************/
//			Integer status = new Integer(req.getParameter("0"));

			/*************************** 2.開始查詢資料 ****************************************/
//			MemberService memSvc = new MemberService();
//			List<MemberVO> memberVO = memSvc.getAll();

			/*************************** 3.查詢完成,準備轉交(Send the Success view) ************/
//			req.getSession().setAttribute("memberVO", memberVO); // 資料庫取出的memberVO物件,存入req
//			String url = "/back_end/member/listAllPdrMember.jsp";
//			RequestDispatcher successView = req.getRequestDispatcher(url);// 成功轉交 listALL_member.jsp
//			successView.forward(req, res);
//			一個是跳轉一個內轉
//			res.sendRedirect(req.getContextPath() + url);

			/*************************** 其他可能的錯誤處理 **********************************/
//		} catch (Exception e) {
//			errorMsgs.add("無法取得要修改的資料:" + e.getMessage());
////			RequestDispatcher failureView = req.getRequestDispatcher("/back_end/member/listAllPdrMember.jsp");
////			failureView.forward(req, res);
//			
//		}
//		return;
	}
}
