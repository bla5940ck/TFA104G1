package com.product.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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
			prodSvc.updateProd(prodID, prodVO.getCategoryID(), prodVO.getProdName(), prodVO.getProdCot(),prodVO.getProdRent(), prodVO.getProdPrice(), prodVO.getComt(), prodVO.getPic1(), prodVO.getPic2(), prodVO.getPic3(), prodVO.getShelfDate(), status);
			res.getWriter().print(status);
			
		}

	}

	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
