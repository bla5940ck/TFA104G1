package com.member.controller;

import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.member.model.MemberService;
import com.member.model.MemberVO;


@WebServlet("/member/MemRegServlet")
public class MemRegServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemRegServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	public void doGet(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");
		String action = req.getParameter("action");
		
if ("insert".equals(action)) { // 來自MemRegister.jsp的請求  
			
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String name = req.getParameter("name").trim();
				
				String enameReg = "^[(\u4e00-\u9fa5)(a-zA-Z0-9_)]{2,10}$";
				if (name == null || name.trim().length() == 0) {
					errorMsgs.add("姓名: 請勿空白");
				} else if(!name.trim().matches(enameReg)) { //以下練習正則(規)表示式(regular-expression)
					errorMsgs.add("姓名: 只能是中、英文字母、數字和_ , 且長度必需在2到10之間");
	            }
				
				String loginId = req.getParameter("loginId").trim();
				if (loginId == null || loginId.trim().length() == 0) {
					errorMsgs.add("帳號請勿空白");
				}
//				
				String password = req.getParameter("password").trim();
				if (password == null || password.trim().length() == 0) {
					errorMsgs.add("密碼請勿空白");
				}
				
				String idcn = req.getParameter("idcn").trim();
				if (idcn == null || idcn.trim().length() == 0) {
					errorMsgs.add("身分證號請勿空白");
				}
				
				
				java.sql.Date birthday = null;
				try {
					birthday = java.sql.Date.valueOf(req.getParameter("birthday").trim());
				} catch (IllegalArgumentException e) {
					birthday=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入生日!");
				}
				
				String phoneNum = req.getParameter("phoneNum").trim();
				if (phoneNum == null || phoneNum.trim().length() == 0) {
					errorMsgs.add("手機號請勿空白");
				}
				
				String email = req.getParameter("email").trim();
				if (email == null || email.trim().length() == 0) {
					errorMsgs.add("Email請勿空白");
				}
				String addNum = req.getParameter("addNum").trim();
				if (addNum == null || addNum.trim().length() == 0) {
					errorMsgs.add("郵遞區號請勿空白");
				}
				String add = req.getParameter("add").trim();
				if (add == null || add.trim().length() == 0) {
					errorMsgs.add("行政區域請勿空白");
				}
				String address = req.getParameter("address").trim();
				if (address == null || address.trim().length() == 0) {
					errorMsgs.add("地址請勿空白");
				}
				String bankCode = null ;
				Integer status=0;
				String nickName =name;
				String bankAccount = null;
				String accountName = null;
				Double rentScore =null;
				Double leaseScore =null;
				java.sql.Timestamp creatDate= null;
				byte[] pic =null;
				Integer foul = null;
				byte[] idcF =null;
				byte[] idcB =null;
				
				// 2.獲取檔案儲存的路徑
				String savePath = this.getServletContext().getRealPath("Files");

				// 3.獲取form表單的Multipart請求的檔案的name屬性
				Part part = req.getPart("idcF");
				
				// 4.獲取原檔名
				/*
				 * 經過過request請求資訊的分析， 原檔名在頭資訊的Content-Disposition中 所以獲取Content-Disposition的值如下
				 * form-data; name="photo"; filename="測試檔案.txt"
				 */
				String header = part.getHeader("Content-Disposition");
				int start = header.lastIndexOf("=");
				String fileName = header.substring(start + 1)
						.replace("\"", "");

				// 5.儲存到第二步獲取的檔案儲存路徑下
				if (fileName != null && !"".equals(fileName)) {
					part.write(savePath + "/" + fileName);
				}
				
				
				
				
//				Integer deptno = new Integer(req.getParameter("deptno").trim());

				MemberVO memberVO = new MemberVO();
				memberVO.setName(name);
				memberVO.setAccountName(accountName);
				memberVO.setAddress(address);
				memberVO.setBankAccount(bankAccount);
				memberVO.setBankCode(bankCode);
				memberVO.setBirthday(birthday);
				memberVO.setCreatDate(creatDate);
				memberVO.setEmail(email);
				memberVO.setFoul(foul);
				memberVO.setIdcB(idcB);
				memberVO.setIdcF(idcF);
				memberVO.setIdcn(idcn);
				memberVO.setLeaseScore(leaseScore);
				memberVO.setLoginId(loginId);
				memberVO.setNickName(nickName);
				memberVO.setPassword(password);
				memberVO.setPhoneNum(phoneNum);
				memberVO.setPic(pic);
				memberVO.setRentScore(rentScore);
				memberVO.setStatus(status);
				
				// Send the use back to the form, if there were errors
				if (!errorMsgs.isEmpty()) {
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("front_end/member/MemRegister.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				MemberService memberSvc = new MemberService();
				memberVO = memberSvc.addMem(bankCode, email, loginId, idcn, phoneNum, password, status, name, nickName, birthday, address, bankAccount, accountName, rentScore, leaseScore, creatDate, pic, idcF, idcB, foul);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "front_end/member/Suss.jsp";
				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交Suss.jsp
				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				RequestDispatcher failureView = req
						.getRequestDispatcher("front_end/member/ForgetPW.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}

}
