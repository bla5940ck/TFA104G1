package com.product.controller;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

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
import java.sql.Timestamp;
import java.text.*;
import java.util.*;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/prod/ProdServlet")
@MultipartConfig()
public class ProdServlet extends HttpServlet {
	private static JedisPool pool = JedisPoolUtil.getJedisPool();
	Timer timer;

	public void destroy() {
		timer.cancel();
	}

	public void init() {
		timer = new Timer();
//	        Calendar cal = new GregorianCalendar(2021, Calendar.MARCH, 0, 0, 0, 0);  

		TimerTask task = new TimerTask() {

			public void run() {

				BookingDAO bkDao = new BookingDAO();
				List<BookingVO> list = bkDao.getAll();
				// 歸還時間比現在時間小
				for (BookingVO bk : list) {
					if ((bk.getEstEnd().getTime() + 24 * 60 * 60 * 1000) < new Date().getTime()) {
						bk.setStatus(2);
						bkDao.update(bk);

					}
				}

				System.out.println(new Date(scheduledExecutionTime()));
			}
		};

		timer.scheduleAtFixedRate(task, 1000, 30 * 1000);

	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		doPost(req, res);
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
		res.setContentType("text/html;charset=utf-8");
		req.setCharacterEncoding("utf-8");
		ProdDAO prodDao = new ProdDAO();
		BookingDAO bkDao = new BookingDAO();
		Gson gson = new Gson();

////////////////////////商品上架/////////////////////////////

		if ("upload".equals(req.getParameter("action"))) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			ProdVO prod = new ProdVO();
			System.out.println(ServletFileUpload.isMultipartContent(req));

			String name = req.getParameter("product_name");
//			System.out.println(name.trim().length() == 0);
			if (name == null || (name.trim().length() == 0)) {
				errorMsgs.add("商品名稱稱不能空白");
				System.out.println("yes");
			}
			if (!errorMsgs.isEmpty()) {
				RequestDispatcher failureView = req
						.getRequestDispatcher(req.getContextPath() + "/front_end/product/ModifyProdPage.jsp");
				failureView.forward(req, res);
				return;

			}

			int rent = Integer.parseInt(req.getParameter("product_rent"));
			int price = Integer.parseInt(req.getParameter("product_price"));
			String cot = req.getParameter("product_cot");
			String comt = req.getParameter("comt");
			int cate = Integer.parseInt(req.getParameter("categorySelect"));

			Collection<Part> filePart = req.getParts();
			int i = 1;
			for (Part part : filePart) {

				if (part.getContentType() != null) {
					if (part.getContentType().contains("image")) {
						InputStream in = part.getInputStream();
//					byte[] b = new byte[in.available()];
						ByteArrayOutputStream out = new ByteArrayOutputStream();
						byte[] buff = new byte[1024];
						int len;
						while ((len = in.read(buff)) != -1) {
							out.write(buff, 0, len);
						}

						byte[] pic = out.toByteArray();

						switch (i) {
						case 1:
							prod.setPic1(pic);
							break;
						case 2:
							prod.setPic2(pic);
							break;
						case 3:
							prod.setPic3(pic);
							break;
						}
						System.out.println(part.getContentType());
						i++;
						if (i > 3)
							break;

					} else if (!part.getContentType().contains("image")) {
						res.getWriter().print("<script language='javascript'>alert('�ФW�ǹϤ��榡')</script>");
						res.getWriter().print("<script>history.go(-1);</script>");

					}

				}

			}
			ProdService prodService = new ProdService();
			ProdDAO dao = new ProdDAO();

			prodService.AddProd(cate, name, cot, rent, price, comt, prod.getPic1(), prod.getPic2(), prod.getPic3(),
					prod.getShelfDate());
			req.removeAttribute("prodID");

			req.getSession().setAttribute("prodID", dao.getLastKey());

			res.sendRedirect(req.getContextPath() + "/front_end/product/showUpdload.jsp");
//			req.getRequestDispatcher("/front_end/product/showUpdload.jsp").forward(req, res);
			return;

		}

		//////////////////////// 商品細項/////////////////////////////

		if ("detail".equals(req.getParameter("action"))) {
			Integer prodID = 0;
			ProdService prodSvc = new ProdService();
			if (req.getParameter("picNo") != null ) {
				prodID = Integer.parseInt(req.getParameter("picNo"));
			}
			else if (req.getParameter("prodID") != null) {
				prodID = Integer.parseInt(req.getParameter("prodID"));
				
			}
			ProdVO prod = prodSvc.findProductByPK(prodID);
			
			
			OutputStream os = res.getOutputStream();
			byte[] pic1 = prod.getPic1();
			byte[] pic2 = prod.getPic2();
			byte[] pic3 = prod.getPic3();

			String no = req.getParameter("no");
			if (no != null) {
				switch (no) {
				case "1":
					if (pic1 != null)
						os.write(pic1);
					break;
				case "2":
					if (pic2 != null)
						os.write(pic2);
					break;
				case "3":
					if (pic3 != null)
						os.write(pic3);
					break;
				}

			}

		}

////////////////////////商品更新/////////////////////////////

		if ("update".equals(req.getParameter("action"))) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			String name = req.getParameter("product_name");

			if (name == null || (name.trim().length() == 0)) {
				errorMsgs.add("商品名稱不能空白");

			}

			int rent = 0;
			try {
				rent = Integer.parseInt(req.getParameter("product_rent"));

			} catch (Exception e) {
				errorMsgs.add("租金只能填寫數字");
			}
			if (rent <= 0) {
				errorMsgs.add("租金不能小於0元");
			}

			int price = 0;
			try {
				price = Integer.parseInt(req.getParameter("product_price"));
			} catch (Exception e) {
				errorMsgs.add("價錢只能填寫數字");
			}

			if (price <= 0) {
				errorMsgs.add("價錢不能小於0元");
			}

			String cot = req.getParameter("product_cot");

			if (cot == null || (cot.trim().length() == 0)) {
				errorMsgs.add("商品內容不能為空白");

			}

			String comt = req.getParameter("comt");
			int cate = Integer.parseInt(req.getParameter("categorySelect"));

			long date = System.currentTimeMillis();
			Timestamp shelfTime = null;

			ProdVO prodVO = new ProdVO();
			prodVO.setProdName(name);
			prodVO.setProdRent(rent);
			prodVO.setProdPrice(price);
			prodVO.setProdCot(cot);
			prodVO.setCategoryID(cate);
			prodVO.setComt(comt);
			prodVO.setProdID(Integer.valueOf(req.getParameter("prodID")));
			int status = 0;
			if (!errorMsgs.isEmpty()) {
				req.setAttribute("proVO", prodVO);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/product/ModifyProdPage.jsp");
				failureView.forward(req, res);
				return;

			}

			int prodID = Integer.parseInt(req.getParameter("prodID"));
			// 上架
			if ("shelf".equals(req.getParameter("status"))) {
				status = 1;
				shelfTime = new Timestamp(date);
			} else if ("complete".equals(req.getParameter("status"))) {
				status = 0;
				shelfTime = null; // 下架時候上架時間空
			}

			ProdVO prod = prodDao.findProductByPK(prodID);

			ProdService prodService = new ProdService();
			prodService.updateProd(prodID, cate, name, cot, rent, price, comt, prod.getPic1(), prod.getPic2(),
					prod.getPic3(), shelfTime, status);

		}

		////////////// 加入購物車/////////////////////////////
		if ("cart".equals(req.getParameter("action"))) {
//				System.out.println("加入購物車");

			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			String estStart = req.getParameter("startDate");
			String estEnd = req.getParameter("endDate");
			String prodName = req.getParameter("prodName");
			Integer rent = Integer.valueOf(req.getParameter("rent"));
			Integer tatolPrice = Integer.valueOf(req.getParameter("tatolPrice"));
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
			cartVO.setTatolPrice(tatolPrice);

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

				if (flag) {
					jedis.rpush("member" + memberID, jsonString);
					System.out.println("加入購物車: " + jsonString);
//					res.getWriter().print("<script language='javascript'>alert('??��?��?�入購物�?');</script>");
					res.getWriter().print(index + 1);
				} else {
					res.getWriter().print(index);
//					res.getWriter().print("<script language='javascript'>alert('此�?��?�已??��?��?��?�確認購?���?');</script>");

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

		/////////////// 商品篩選///////////////////////
		if ("select".equals(req.getParameter("action"))) {
			ProdService prodSvc = new ProdService();
			System.out.println(req.getParameter("prodSelect"));
			if (req.getParameter("prodSelect").equals("2")) {
				// 依價格排序

				List<ProdVO> list = prodSvc.getSortAsc();
				req.setAttribute("flag", "asc");
				req.setAttribute("prodList", list);

				req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
				return;
			} else if (req.getParameter("prodSelect").equals("3")) {
				List<ProdVO> list = prodSvc.getSortDesc();
				req.setAttribute("flag", "desc");
				req.setAttribute("prodList", list);

				req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
				return;
			}

			else {
				req.setAttribute("flag", "time");
				req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
				return;
			}

		}

		///////////// 結帳////////////////////
		if ("checkout".equals(req.getParameter("action"))) {
			System.out.println("點到結帳");

			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);

			Integer prodID = Integer.valueOf(req.getParameter("prodID"));

			String startDate = req.getParameter("startDate");
			String endDate = req.getParameter("endDate");
			System.out.println(startDate);
			System.out.println(endDate);
			System.out.println("---------");
			java.sql.Date sdate = null;
			java.sql.Date edate = null;
			BookingVO bk = new BookingVO();

			if (startDate.trim().length() == 0) {
				errorMsgs.add("租借日期不能為空白");
			}

			if (endDate.trim().length() == 0) {
				errorMsgs.add("租借日期不能為空白");
			}

			DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			try {

				sdate = new java.sql.Date(df.parse(startDate).getTime());
				edate = new java.sql.Date(df.parse(endDate).getTime());
			} catch (Exception e) {

				errorMsgs.add("日期格式為 yyyy-MM-DD");
			}

			System.out.println(prodID);
			System.out.println(sdate);
			System.out.println(endDate);

			BookingService bkService = new BookingService();
			bk.setProdID(prodID);

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("bk", bk);
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/product/productDetail.jsp");
				failureView.forward(req, res);
				return;

			}

			bkService.addBk(prodID, 1, sdate, edate);
		}

	}

}
