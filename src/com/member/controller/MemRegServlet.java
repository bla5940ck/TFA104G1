package com.member.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import com.member.model.MemberService;
import com.member.model.MemberVO;


@WebServlet("/member/MemRegServlet")
@MultipartConfig()
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
		res.setCharacterEncoding("UTF-8");
		res.setContentType("text/html; charset=UTF-8");
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		
if ("insert".equals(action)) { // 來自MemRegister.jsp的請求  
	System.out.println("111111");
			List<String> errorMsgs = new LinkedList<String>();
			// Store this set in the request scope, in case we need to
			// send the ErrorPage view.
			System.out.println("222222");
			req.setAttribute("errorMsgs", errorMsgs);

			try {
				/***********************1.接收請求參數 - 輸入格式的錯誤處理*************************/
				String name = req.getParameter("name").trim();
				System.out.println("333333");
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
//				
				
				java.sql.Date birthday = null;
				try {
					System.out.println("444444");
					birthday = java.sql.Date.valueOf(req.getParameter("birthday").trim());
				} catch (IllegalArgumentException e) {
					birthday=new java.sql.Date(System.currentTimeMillis());
					errorMsgs.add("請輸入生日!");
				}
				System.out.println(birthday);
				System.out.println("55555");
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
				System.out.println("5556666");
				address = add+address;
				System.out.println("6666666");
				String bankCode = null ;
				Integer status=0;
				String nickName =name;
				String bankAccount = null;
				String accountName = null;
				Double rentScore =5.0;
				Double leaseScore =5.0;
//				 Long datetime = System.currentTimeMillis();
//			       = new Timestamp(datetime);
				java.sql.Timestamp creatDate=new java.sql.Timestamp(System.currentTimeMillis());
				Integer foul = 0;
				byte[] pic =null;
				byte[] idcF =null;
				byte[] idcB =null;
				System.out.println("777777");
//				// 2.獲取檔案儲存的路徑
//				String savePath = this.getServletContext().getRealPath("Files");
//
//				// 3.獲取form表單的Multipart請求的檔案的name屬性
//				Part part = req.getPart("idcF");
//				
//				// 4.獲取原檔名
//				/*
//				 * 經過過request請求資訊的分析， 原檔名在頭資訊的Content-Disposition中 所以獲取Content-Disposition的值如下
//				 * form-data; name="photo"; filename="測試檔案.txt"
//				 */
//				String header = part.getHeader("Content-Disposition");
//				int start = header.lastIndexOf("=");
//				String fileName = header.substring(start + 1)
//						.replace("\"", "");
//
//				// 5.儲存到第二步獲取的檔案儲存路徑下
//				if (fileName != null && !"".equals(fileName)) {
//					part.write(savePath + "/" + fileName);
//				}
//				身分證正面寫入
				Part part = req.getPart("file_name1");
				MemFrontServlet mfs = new MemFrontServlet();
				String filename = mfs.getFileNameFromPart(part);
				System.out.println("121444444");
				InputStream in = part.getInputStream();
				idcF = new byte[in.available()];
//				if (filename!= null && part.getContentType()!=null) {
//					String name = part.getName();
//					String ContentType = part.getContentType();
//					long size = part.getSize();
//					System.out.println("121355555");
//					File f = new File(fsaveDirectory, filename);
//					System.out.println("1213666666");
//					part.write(f.toString());
//					part.write(fileName);
					System.out.println(idcF);
					System.out.println("72133333333");
					System.out.println("82133333333");
					in.read(idcF);
					in.close();
				System.out.println("8888");
				
//				身分證反面寫入
				Part part2 = req.getPart("file_name2");
				MemFrontServlet mfs2 = new MemFrontServlet();
				String filename2 = mfs2.getFileNameFromPart(part2);
				System.out.println("121444444");
				InputStream in2 = part2.getInputStream();
				idcB = new byte[in2.available()];
//				if (filename!= null && part.getContentType()!=null) {
//					String name = part.getName();
//					String ContentType = part.getContentType();
//					long size = part.getSize();
//					System.out.println("121355555");
//					File f = new File(fsaveDirectory, filename);
//					System.out.println("1213666666");
//					part.write(f.toString());
//					part.write(fileName);
					System.out.println(idcB);
					System.out.println("72133333333");
					System.out.println("82133333333");
					in2.read(idcB);
					in2.close();
				System.out.println("8888");
				
				
//				Integer deptno = new Integer(req.getParameter("deptno").trim());
				System.out.println("9999999");
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
					System.out.println("10101111");
					req.setAttribute("memberVO", memberVO); // 含有輸入格式錯誤的memberVO物件,也存入req
					RequestDispatcher failureView = req
							.getRequestDispatcher("/front_end/member/MemRegister.jsp");
					failureView.forward(req, res);
					return;
				}
				
				/***************************2.開始新增資料***************************************/
				MemberService memberSvc = new MemberService();
				System.out.println("1212121121");
				memberVO = memberSvc.addMem(bankCode, email, loginId, idcn, phoneNum, password, status, name, nickName, birthday, address, bankAccount, accountName, rentScore, leaseScore, creatDate, pic, idcF, idcB, foul);
				/***************************3.新增完成,準備轉交(Send the Success view)***********/
				String url = "/front_end/product/homePage.jsp";
				out.println("<HTML><HEAD><TITLE>Access Denied</TITLE></HEAD>");
				out.println("<BODY>會員註冊成功，待審核通過後會MAIL通知您，3秒後會轉往【JoyLease】首頁<BR>");
				out.println("</BODY></HTML>");
				res.setHeader("Refresh", "3; URL=" + req.getContextPath() + url);
//				RequestDispatcher successView = req.getRequestDispatcher(url); // 新增成功後轉交Suss.jsp
				
//				successView.forward(req, res);				
				
				/***************************其他可能的錯誤處理**********************************/
			} catch (Exception e) {
				errorMsgs.add(e.getMessage());
				System.out.println("1331131311");
				RequestDispatcher failureView = req
						.getRequestDispatcher("/front_end/member/MemRegister.jsp");
				failureView.forward(req, res);
			}
		}
		
		
	}

}
