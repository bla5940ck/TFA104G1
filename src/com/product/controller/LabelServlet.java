package com.product.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;
import java.util.Random;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.chatroom.jedis.JedisPoolUtil;
import com.product.model.ProdService;
import com.product.model.ProdVO;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@WebServlet("/prod/LabelServlet")
public class LabelServlet extends HttpServlet {
       
  
	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		  res.setContentType("text/html;charset=utf-8");
			req.setCharacterEncoding("utf-8");
		if("showLabel".equals(req.getParameter("action"))) {
		JedisPool pool = JedisPoolUtil.getJedisPool();
		Jedis jedis = pool.getResource();
		Set<String> set = jedis.keys("prod*");
		Set<String> all_label = new HashSet();
		JSONObject jsonObj =new JSONObject();
		List<String> list = new ArrayList();
		for(String prod :set) {
			List<String> prodAll = jedis.lrange(prod, 0, jedis.llen(prod));
			for(String label :prodAll) {
				
				all_label.add(label);
			}
		}
		for(String a :all_label) {
			list.add(a);
		}
		//進行洗牌 隨機產生標籤
		Collections.shuffle(list);
		
		jsonObj.put("all_label", list);
		
		
		res.getWriter().print(jsonObj);
		jedis.close();
		}
		
		
		
		
		
		if ("labelClick".equals(req.getParameter("action"))) {
			String prodID = req.getParameter("prodID");

			String labelNo = req.getParameter("labelNo");
			String prodLabel = "";
			List<ProdVO> matchProdList = new ArrayList();
			List<Integer> matchProdList1 = new ArrayList();
			ProdService prodSvc = new ProdService();
			JedisPool pool = JedisPoolUtil.getJedisPool();
			Jedis jedis = null;
			jedis = pool.getResource();
			String regEx = "[^0-9]";
			String flag = "no";
			//從商品詳圖
			if (labelNo != null && prodID != null) {
				List<String> list = jedis.lrange("prod" + prodID, Long.valueOf(labelNo), Long.valueOf(labelNo));
				prodLabel = list.get(0);
				
				// 找到所有prodKey
				Set<String> set = jedis.keys("prod*");
				for (String prod : set) {
//				//用prod裡面的值找到符合我們點擊的值
					List<String> prodAll = jedis.lrange(prod, 0, jedis.llen(prod));
					for (String label : prodAll) {

						if (label.equals(prodLabel)) {
							ProdVO product = prodSvc.findProductByPK(Integer.valueOf(prod.replaceAll(regEx, "")));
							// 取代redis的prod為我們要的prodID為數字 並加入到陣列
							matchProdList.add(product);
						
							if(product!=null&& product.getProdStatus()==1)
								flag="yes";
						}
					}

				}
			}
			// 從主頁標籤
			else if (req.getParameter("labelName") != null && !req.getParameter("labelName").isEmpty()) {
				
				Set<String> set = jedis.keys("prod*");
				for (String prod : set) {
					List<String> prodAll = jedis.lrange(prod, 0, jedis.llen(prod));
					for (String label : prodAll) {
						if (req.getParameter("labelName").equals(label)) {
							prodLabel = label;
							ProdVO product = prodSvc.findProductByPK(Integer.valueOf(prod.replaceAll(regEx, "")));
							matchProdList.add(product);
							if(product!=null&& product.getProdStatus()==1)
								flag="yes";
						
						}

					}

				}
				System.out.println(matchProdList.size());

			}
			jedis.close();
			req.setAttribute("flag", flag);
			req.setAttribute("prodLabel", req.getParameter("labelName"));
			req.setAttribute("matchProdList", matchProdList);
//			
//			
			req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
		
		
		}
		
		
		
	
	
	
	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
