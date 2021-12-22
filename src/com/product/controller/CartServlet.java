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
					if (prodID == cartVO1.getProdID()) {
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
				List<String> cart = jedis.lrange("member" + memberID, 0, jedis.llen("member" + memberID));
				for (String item : cart) {
					CartVO cartVO1 = gson.fromJson(item, CartVO.class);
					if (cartVO1.getProdID() == prodID) {
						jedis.lrem("member" + memberID, 1, item);
					}
				}

				jedis.close();
			}

		}
		
		if("directCheckout".equals(req.getParameter("action"))) {
			System.out.println(req.getParameter("prodID"));
			ProdService prodSvc = new ProdService();
			ProdVO prodVO= prodSvc.findProductByPK(Integer.valueOf(req.getParameter("prodID")));
			String eDateStr = req.getParameter("eDate");
			String sDateStr= req.getParameter("sDate");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			java.util.Date sDate =null;
			java.util.Date eDate =null;
			try {
				sDate = sdf.parse(sDateStr);
				eDate = sdf.parse(eDateStr);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			long diffDay = (eDate.getTime()-sDate.getTime())/(24*60*60*1000) +1;
			int totalPrice = (int)diffDay * prodVO.getProdRent();
			System.out.println(diffDay);
			CartVO cartVO = new CartVO();
			
			cartVO.setEstStart(new Date(sDate.getTime()));
			cartVO.setEstEnd(new Date(eDate.getTime()));
			cartVO.setProdID(Integer.valueOf(req.getParameter("prodID")));
			cartVO.setRent(prodVO.getProdRent());
			cartVO.setProdName(prodVO.getProdName());
			cartVO.setLeaseID(prodVO.getMemberID());
			cartVO.setTotalPrice(totalPrice);
			
			cartVO.setProdID(prodVO.getProdID());
			
			List<CartVO> cartList1 = new ArrayList();
			cartList1.add(cartVO);
			req.getSession().setAttribute("cartVO", cartVO);
			req.getRequestDispatcher("/front_end/product/cart.jsp").forward(req, res);
			
		}
		

	}

}
