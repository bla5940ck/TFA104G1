package com.product.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.memberservice.model.MemberServiceService;
import com.memberservice.model.MemberServiceVO;
import com.product.model.ProdService;
import com.product.model.ProdVO;

@WebServlet("/msg/MsgProdServlet")
public class MsgProdServlet extends HttpServlet {
       
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		
		if("selectItem".equals(req.getParameter("action"))) {
			ProdService prodSvc = new ProdService();
			MemberServiceService msSvc = new MemberServiceService();
			
			List<ProdVO> prodList =  prodSvc.getAll();
			List<MemberServiceVO> msList = msSvc.getAll();
			List<ProdVO> list = new ArrayList();
			//被檢舉商品
			if("2".equals(req.getParameter("value"))) {
				for(ProdVO prodVO:prodList) {
					boolean flag = true;
					for(MemberServiceVO msVO:msList) {
						
						if(prodVO.getProdID()==msVO.getProdID()) {
							if(flag)
							list.add(prodVO);
							flag=false;
						}
							
					}
				}
				
				req.setAttribute("list", list);
				req.getRequestDispatcher("/back_end/product/productManager.jsp").forward(req,res);
				return;
			}
			
			//上架中商品
			else if("1".equals(req.getParameter("value"))) {
				list =prodList.stream().filter(p->p.getProdStatus()==1).collect(Collectors.toList());
				
				req.setAttribute("list", list);
				req.getRequestDispatcher("/back_end/product/productManager.jsp").forward(req,res);
				return;
			}
			//下架中商品
			else if("0".equals(req.getParameter("value"))) {
				list =prodList.stream().filter(p->p.getProdStatus()==0).collect(Collectors.toList());
				
				req.setAttribute("list", list);
				req.getRequestDispatcher("/back_end/product/productManager.jsp").forward(req,res);
				return;
			}
			//停用商品
			else if("9".equals(req.getParameter("value"))) {
				list =prodList.stream().filter(p->p.getProdStatus()==9).collect(Collectors.toList());
				
				req.setAttribute("list", list);
				req.getRequestDispatcher("/back_end/product/productManager.jsp").forward(req,res);
				return;
			}
			//單筆查詢
			else if("10".equals(req.getParameter("value"))) {
				Integer prodID = Integer.valueOf(req.getParameter("prodID"));
				list=prodList.stream().filter(p->p.getProdID()==prodID).collect(Collectors.toList());
				
				
				req.setAttribute("list", list);
				req.getRequestDispatcher("/back_end/product/productManager.jsp").forward(req,res);
				return;
			}
			
			
			
		}
	
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
		
	}

}
