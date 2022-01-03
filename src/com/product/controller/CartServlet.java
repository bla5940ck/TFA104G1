package com.product.controller;

import com.google.gson.Gson;
import com.product.jedis.JedisPoolUtil;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import com.product.jedis.JedisPoolUtil;
import com.product.model.*;
import com.booking.model.*;
import com.category.model.*;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Date;
import java.sql.Timestamp;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/cart/CartServlet")
public class CartServlet extends HttpServlet {
	private static JedisPool pool = JedisPoolUtil.getJedisPool();

	public CartServlet() {

	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		Gson gson = new Gson();

		//////////// 加入購物車/////////////////////
		if ("cart".equals(req.getParameter("action"))) {

			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			String estStart = req.getParameter("startDate");
			String estEnd = req.getParameter("endDate");
			String prodName = req.getParameter("prodName");
			Integer rent = Integer.valueOf(req.getParameter("rent"));
			Integer leaseID = Integer.valueOf(req.getParameter("leaseID"));
			Integer tatolPrice = null;
			System.out.println(req.getParameter("tatolPrice"));
			if (req.getParameter("tatolPrice") != null && !req.getParameter("tatolPrice").equals("NaN")) {

				tatolPrice = Integer.valueOf(req.getParameter("tatolPrice"));
			} else {
				res.getWriter().print(404);
				return;
			}
			Integer index = Integer.valueOf(req.getParameter("index"));
//				Integer status = 0;
			java.sql.Date sdate = null;
			java.sql.Date edate = null;
			Integer memberID = (Integer) req.getSession().getAttribute("id");
			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			try {
				sdate = new java.sql.Date(df.parse(estStart).getTime());
				edate = new java.sql.Date(df.parse(estEnd).getTime());
			} catch (ParseException e) {
				System.out.println("日期格式錯誤");
			}
			CartVO cartVO = new CartVO();
//				BookingVO bk = new BookingVO();
			cartVO.setProdID(prodID);
//				bk.setStatus(status);
			cartVO.setEstStart(sdate);
			cartVO.setEstEnd(edate);
			cartVO.setProdName(prodName);
			cartVO.setRent(rent);
			cartVO.setTotalPrice(tatolPrice);
			cartVO.setLeaseID(leaseID);
//				JedisPool pool = JedisPoolUtil.getJedisPool();
			Jedis jedis = null;
			jedis = pool.getResource();

			String jsonString = gson.toJson(cartVO);

//				jedis.set("prod"+req.getParameter("prodID"),jsonString);
			if (memberID != null) {
				List<String> cart = jedis.lrange("member" + memberID, 0, jedis.llen("member" + memberID));
				boolean flag = true;
				for (String item : cart) {
					CartVO cartVO1 = gson.fromJson(item, CartVO.class);
					if (prodID.equals(cartVO1.getProdID())) {
						flag = false;
					}
				}
				// 購物車不重複的話 就加入進去redis
				if (flag) {
					jedis.rpush("member" + memberID, jsonString);
					System.out.println("加入購物車: " + jsonString);
					res.getWriter().print(index + 1);
				} else {
					res.getWriter().print(index);
				}

			}

			jedis.close();

		}

		////////////////// 購物車刪除///////////////////////
		if ("delete".equals(req.getParameter("action"))) {

			Integer memberID = (Integer) req.getSession().getAttribute("id");
			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			Integer index = Integer.valueOf(req.getParameter("index")) - 1;
			
			res.getWriter().print(index);
//				JedisPool pool = JedisPoolUtil.getJedisPool();
			Jedis jedis = null;
			jedis = pool.getResource();

			if (memberID != null) {
				System.out.println("進memberID!=null");
				List<String> cart = jedis.lrange("member" + memberID, 0, jedis.llen("member" + memberID));
				System.out.println("購物車數量"+cart.size());
				System.out.println(prodID);
				for (String item : cart) {
					CartVO cartVO1 = gson.fromJson(item, CartVO.class);
					System.out.println(cartVO1.getProdID());
					if (cartVO1.getProdID().equals(prodID)) {
						System.out.println("商品刪除: " +prodID);
						System.out.println("商品刪除Redis: " +cartVO1.getProdID());
						System.out.println("會員編號: " +memberID);
						jedis.lrem("member" + memberID, 1, item);
						
					}
				}
				
				jedis.close();
			}

		}
		//直接結帳動作
		if ("directCheckout".equals(req.getParameter("action"))) {
			ProdService prodSvc = new ProdService();
			ProdVO prodVO = prodSvc.findProductByPK(Integer.valueOf(req.getParameter("prodID")));
			String eDateStr = req.getParameter("eDate");
			String sDateStr = req.getParameter("sDate");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			java.util.Date sDate = null;
			java.util.Date eDate = null;
			try {
				sDate = sdf.parse(sDateStr);
				eDate = sdf.parse(eDateStr);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			long diffDay = (eDate.getTime() - sDate.getTime()) / (24 * 60 * 60 * 1000) + 1;
			int totalPrice = (int) diffDay * prodVO.getProdRent();
			CartVO cartVO = new CartVO();
			//存入cartVO 準備登入後給memberID直接取得
			cartVO.setEstStart(new Date(sDate.getTime()));
			cartVO.setEstEnd(new Date(eDate.getTime()));
			cartVO.setProdID(Integer.valueOf(req.getParameter("prodID")));
			cartVO.setRent(prodVO.getProdRent());
			cartVO.setProdName(prodVO.getProdName());
			cartVO.setLeaseID(prodVO.getMemberID());
			cartVO.setTotalPrice(totalPrice);

			cartVO.setProdID(prodVO.getProdID());

			
			req.getSession().setAttribute("cartVO", cartVO);
			res.sendRedirect(req.getContextPath()+"/front_end/product/cart.jsp");

		}
		//進入cart後 取得Redis cart最新物品
		if ("cartTest".equals(req.getParameter("action"))) {
			HttpSession session = req.getSession();
			Jedis jedis = null;
			jedis = pool.getResource();
			Integer memberID = (Integer) session.getAttribute("id");
			System.out.println("開始" + session.getAttribute("cartVO"));

			if (session.getAttribute("cartVO") != null) {
				//直接結帳的商品
				CartVO cartVO = (CartVO) session.getAttribute("cartVO");
				
				//redis裡商品
				List<String> cart = jedis.lrange("member" + memberID, 0, jedis.llen("member" + memberID));
				boolean flag = true;
				for (String item : cart) {
					CartVO cartVO1 = gson.fromJson(item, CartVO.class);
					if (cartVO.getProdID().equals(cartVO1.getProdID())) {
						flag = false;
					}
				}

				
				String jsonString = gson.toJson(cartVO);
				
				//假如 為自己的商品 將不加入商品
				if(flag==true && cartVO.getLeaseID().equals(memberID)) {
					
					res.getWriter().print(3);
					session.removeAttribute("cartVO");
				}
				else if (flag == true) {
					jedis.rpush("member" + memberID, jsonString);
					//刪除後 下次進來後 則會直接到else
					//給購物車對應直接結帳的prodID
					session.setAttribute("prodIDCheck", cartVO.getProdID());
					//刪除按下直接結帳後的seesion避免重複更新
					session.removeAttribute("cartVO");

					res.getWriter().print(1);
				} else {
					res.getWriter().print(0);
					
					
				}
			}else {
				//給購物車對應直接結帳的prodID，第二次進入刪除
				session.removeAttribute("prodIDCheck");
			}

			jedis.close();
		}

	}

}
