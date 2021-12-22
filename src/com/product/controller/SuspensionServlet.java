package com.product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.member.model.MemberService;
import com.member.model.MemberVO;
import com.product.model.MailService;
import com.product.model.ProdService;
import com.product.model.ProdVO;

@WebServlet("/prod/SuspensionServlet")
public class SuspensionServlet extends HttpServlet {
       
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		if("offShelf".equals(req.getParameter("action"))) {
			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			ProdService prodSvc = new ProdService();
			ProdVO prodVO = prodSvc.findProductByPK(prodID);
			Integer status = Integer.valueOf(req.getParameter("status"));
			String memberID = req.getParameter("memberID");
			MemberService mbSvc = new MemberService();
			MemberVO memberVO = mbSvc.getOneMember(Integer.valueOf(memberID));
			String mail = memberVO.getEmail();
			String name = memberVO.getNickName();
			if(status==9) {
			String to = mail;
		      
		      String subject = "親愛的用戶您好";
		      
		      String ch_name = name;
		      String passRandom = "111";
		      String messageText = "Hello! " + ch_name + "您的帳戶已被停用"+ "\n"+"JoyLease 啟"; 
		       
		      MailService mailService = new MailService();
		      mailService.sendMail(to, subject, messageText);
			}
			prodSvc.updateProd(prodID, prodVO.getCategoryID(), prodVO.getProdName(), prodVO.getProdCot(),prodVO.getProdRent(), prodVO.getProdPrice(), prodVO.getComt(), prodVO.getPic1(), prodVO.getPic2(), prodVO.getPic3(), prodVO.getShelfDate(), status);
			res.getWriter().print(status);
			
		}

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
