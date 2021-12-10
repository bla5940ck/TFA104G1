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
import java.sql.Date;
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
//	Timer timer;

	public void destroy() {
//		timer.cancel();
	}

	public void init() {
//		timer = new Timer();
////	        Calendar cal = new GregorianCalendar(2021, Calendar.MARCH, 0, 0, 0, 0);  
//
//		TimerTask task = new TimerTask() {
//
//			public void run() {
//
//				BookingDAO bkDao = new BookingDAO();
//				List<BookingVO> list = bkDao.getAll();
//				// 歸還時間比現在時間小
//				for (BookingVO bk : list) {
//					if ((bk.getEstEnd().getTime() + 24 * 60 * 60 * 1000) < new Date().getTime()) {
//						bk.setStatus(2);
//						bkDao.update(bk);
//
//					}
//				}
//
//				System.out.println(new Date(scheduledExecutionTime()));
//			}
//		};
//
//		timer.scheduleAtFixedRate(task, 1000, 30 * 1000);

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

			Jedis jedis = null;
			jedis = pool.getResource();

			List<String> list = new ArrayList();
			
			// 驗證商品
			String[] labels = req.getParameterValues("checkbox1");

			String name = req.getParameter("product_name");
			prod.setProdName(name);
//			System.out.println(name.trim().length() == 0);
			if (name == null || (name.trim().length() == 0))
				errorMsgs.add("商品名稱不能空白");

			int rent = 0;
			try {
				rent = Integer.parseInt(req.getParameter("product_rent"));
				prod.setProdRent(rent);
			} catch (Exception e) {
				errorMsgs.add("租金只能填寫數字");
			}
			if (rent <= 0)
				errorMsgs.add("租金不能小於0元");

			int price = 0;
			try {
				price = Integer.parseInt(req.getParameter("product_price"));
				prod.setProdPrice(price);
			} catch (Exception e) {
				errorMsgs.add("價錢只能填寫數字");
			}

			if (price <= 0)
				errorMsgs.add("價錢不能小於0元");

			String cot = req.getParameter("product_cot");
			prod.setProdCot(cot);

			if (cot == null || (cot.trim().length() == 0))
				errorMsgs.add("商品內容不能為空白");

			String comt = req.getParameter("comt");
			prod.setComt(comt);
			int cate = 0;
			try {
				cate = Integer.parseInt(req.getParameter("categorySelect"));
				prod.setCategoryID(cate);
			} catch (NumberFormatException e) {
				errorMsgs.add("商品類別沒有選擇");
			}
			Collection<Part> filePart = req.getParts();
			int i = 1;

			boolean flag = true;

			for (Part part : filePart) {

				if (part.getContentType() != null) {
					if (part.getContentType().contains("image")) {
						flag = false;
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

					} else if (!part.getContentType().contains("image") && part.getInputStream().available() != 0) {
						errorMsgs.add("商品圖片必須為img格式");
//						res.getWriter().print("<script language='javascript'>alert('�ФW�ǹϤ��榡')</script>");
//						res.getWriter().print("<script>history.go(-1);</script>");

					}

				}

			}
			if (flag) { // 都沒有讀到img 代表沒上傳任何圖片
				errorMsgs.add("圖片上傳至少一張");
			}

			if (!errorMsgs.isEmpty()) {
				req.setAttribute("prodVO", prod);
				jedis.close();
				RequestDispatcher failureView = req.getRequestDispatcher("/front_end/product/uploadProd.jsp");
				failureView.forward(req, res);
				return;

			}

			// 進行資料新增
			ProdService prodService = new ProdService();

			// 更新並取得剛插入的自增
			Integer key = prodService.AddProd(cate, name, cot, rent, price, comt, prod.getPic1(), prod.getPic2(),
					prod.getPic3(), prod.getShelfDate());

			for (int k = 0; k < labels.length; k++) {
				jedis.rpush("prod" + key, labels[k]);

			}

			ProdService prodSvc = new ProdService();
			ProdVO product = prodSvc.findProductByPK(key);

			req.setAttribute("picAmount", i - 1);
			req.setAttribute("product", product);
			req.setAttribute("prodID", key);
//			res.sendRedirect(req.getContextPath() + "/front_end/product/showProd.jsp");
			req.getRequestDispatcher("/front_end/product/showProd.jsp").forward(req, res);

		}

		//////////////////////// 商品圖/////////////////////////////

		if ("detail".equals(req.getParameter("action"))) {
			Integer prodID = 0;
			ProdService prodSvc = new ProdService();
			// 讀圖片用
			if (req.getParameter("prodID") != null && !req.getParameter("prodID").isEmpty()) {
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

////////////////////////上架商品更新/////////////////////////////

		if ("update".equals(req.getParameter("action"))) {
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			String[] labels = req.getParameterValues("checkbox1");
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

			Integer cate = null;
			try {
				cate = Integer.parseInt(req.getParameter("categorySelect"));
			} catch (Exception e) {
				errorMsgs.add("商品類別記得選");
			}
			int prodID = Integer.parseInt(req.getParameter("prodID"));
			String comt = req.getParameter("comt");
			long date = System.currentTimeMillis();
			Timestamp shelfTime = null;

			Jedis jedis = pool.getResource();
			
			
			
			
			ProdVO prodVO = new ProdVO();
			prodVO.setProdName(name);
			prodVO.setProdRent(rent);
			prodVO.setProdPrice(price);
			prodVO.setProdCot(cot);
			prodVO.setCategoryID(cate);
			prodVO.setComt(comt);
			prodVO.setProdID(Integer.valueOf(req.getParameter("prodID")));
			int prodStatus = 0;
			if (req.getParameter("prodStatus") != null) {
				prodStatus = Integer.valueOf(req.getParameter("prodStatus"));
			}

			int i = 1;

			Collection<Part> filePart = req.getParts();
//			System.out.println(req.getParameter("file_name1"));
//			System.out.println(req.getParameter("file_name2"));
//			System.out.println(req.getParameter("file_name3"));

			boolean flag = true;
			// 用來判斷圖片是否用過
			boolean flag1 = true;
			boolean flag2 = true;
			boolean flag3 = true;
			for (Part part : filePart) {
//					System.out.println(part);

				if (part.getContentType() != null) {
					if (part.getContentType().contains("image")) {
						System.out.println("更新圖片");
						flag = false;
						InputStream in = part.getInputStream();
//					byte[] b = new byte[in.available()];
						ByteArrayOutputStream out = new ByteArrayOutputStream();
						byte[] buff = new byte[1024];
						int len;
						while ((len = in.read(buff)) != -1) {
							out.write(buff, 0, len);
						}

						byte[] pic = out.toByteArray();

						// flag判斷 假如有存取過 就不再存取
						System.out.println(pic.length);
						if ("1".equals(req.getParameter("picNo1")) && flag1) {
							prodVO.setPic1(pic);
							flag1 = false;
							System.out.println("圖片1更新");
						} else if ("2".equals(req.getParameter("picNo2")) && flag2) {
							prodVO.setPic2(pic);
							flag2 = false;
							System.out.println("圖片2更新");

						} else if ("3".equals(req.getParameter("picNo3")) && flag3) {
							prodVO.setPic3(pic);
							flag3 = false;
							System.out.println("圖片3更新");

						}

//						System.out.println(part.getContentType());
						i++;
						if (i > 3)
							break;

					} else if (!part.getContentType().contains("image") && part.getInputStream().available() != 0) {
						errorMsgs.add("商品圖片必須為img格式");
//						res.getWriter().print("<script language='javascript'>alert('�ФW�ǹϤ��榡')</script>");
//						res.getWriter().print("<script>history.go(-1);</script>");

					}
					ProdService prodSvc = new ProdService();
					ProdVO product = prodSvc.findProductByPK(prodID);

					int picAmount = 0;
					// //動態算出 資料庫圖片個數
					if (product != null) {
						if (product.getPic1() != null)
							picAmount++;
						if (product.getPic2() != null)
							picAmount++;
						if (product.getPic3() != null)
							picAmount++;
					}

					// 錯誤回傳
					if (!errorMsgs.isEmpty()) {
						req.setAttribute("prodID", prodID);
						req.setAttribute("product", prodVO);
						req.setAttribute("picAmount", picAmount);
						jedis.close();

						req.getRequestDispatcher("/front_end/product/modifyProd.jsp").forward(req, res);
						return;

					}

				}

			}

			// 更新
			if ("shelf".equals(req.getParameter("status"))) {
				prodStatus = 1;
				shelfTime = new Timestamp(date);
			} else if ("complete".equals(req.getParameter("status"))) {
				prodStatus = 0;
				shelfTime = null; // 下架時候上架時間空
			}

			System.out.println("更新後... " + prodID);

			//更新標籤
			jedis.del("prod"+prodID);
			
			if(labels!=null) {
					jedis.rpush("prod"+prodID, labels);
			}
			ProdService prodSvc = new ProdService();
			ProdVO prod_original = prodSvc.findProductByPK(prodID);

			// 沒有上傳 回傳舊的值
			byte[] pic1 = prodVO.getPic1() == null ? prod_original.getPic1() : prodVO.getPic1();
			byte[] pic2 = prodVO.getPic2() == null ? prod_original.getPic2() : prodVO.getPic2();
			byte[] pic3 = prodVO.getPic3() == null ? prod_original.getPic3() : prodVO.getPic3();

			prodSvc.updateProd(prodID, cate, name, cot, rent, price, comt, pic1, pic2, pic3, shelfTime, prodStatus);
			req.getSession().setAttribute("prodID", prodID);// 修改後

			if ("shelf".equals(req.getParameter("status"))) {
				res.sendRedirect(req.getContextPath() + "/front_end/product/productPage.jsp");
				return;
			}

			ProdVO product = prodSvc.findProductByPK(prodID);
			int picAmount = 0;
			if (product != null) {
				if (product.getPic1() != null)
					picAmount++;
				if (product.getPic2() != null)
					picAmount++;
				if (product.getPic3() != null)
					picAmount++;
			}

			req.setAttribute("picAmount", picAmount);
			req.setAttribute("product", product);
			req.setAttribute("prodID", prodID);
			jedis.close();
//			res.sendRedirect(req.getContextPath()+"/front_end/product/showProd.jsp");
			req.getRequestDispatcher("/front_end/product/showProd.jsp").forward(req, res);
		}

		///////////// 到商品修改頁面///////////////////////

		if ("modify".equals(req.getParameter("action"))) {
			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			ProdService prodSvc = new ProdService();
			ProdVO product = prodSvc.findProductByPK(prodID);
			int picAmount = 0;
			// 動態算出 資料庫圖片個數
			if (product != null) {
				if (product.getPic1() != null)
					picAmount++;
				if (product.getPic2() != null)
					picAmount++;
				if (product.getPic3() != null)
					picAmount++;
			}

			req.setAttribute("picAmount", picAmount);
			req.setAttribute("prodID", prodID);
			req.setAttribute("product", product);

			req.getRequestDispatcher("/front_end/product/modifyProd.jsp").forward(req, res);
		}

		/////////////// 商品篩選///////////////////////
		if ("select".equals(req.getParameter("action"))) {
			ProdService prodSvc = new ProdService();
			ProdCategoryService cateSvc = new ProdCategoryService();
			String cateNo = null;
			String categoryName = null;
			if (req.getParameter("cateNo") != null && req.getParameter("cateNo").length() != 0) {
				cateNo = req.getParameter("cateNo");
				categoryName = cateSvc.findCategoryByPK((Integer.valueOf(cateNo))).getCategoryName();

			}

			categoryName = categoryName == null ? "所有商品" : categoryName;
//			System.out.println("prodS:" + req.getParameter("prodSelect"));
//			System.out.println("cateNo: "+cateNo);
			if (req.getParameter("prodSelect").equals("2")) {
				// 依價格排序

				// 遞增排列 以及回傳得到的類別ID
				List<ProdVO> list = prodSvc.getSortAsc();
				req.setAttribute("flag", "asc");
				req.setAttribute("prodList", list);
				req.setAttribute("prodSelect", "2");
				req.setAttribute("cateNo", cateNo);
				req.setAttribute("categoryName", categoryName);

				req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
				return;

			}
			// 遞增排列 以及回傳得到的類別ID
			else if (req.getParameter("prodSelect").equals("3")) {
				List<ProdVO> list = prodSvc.getSortDesc();
				req.setAttribute("flag", "desc");
				req.setAttribute("prodList", list);
				req.setAttribute("prodSelect", "3");
				req.setAttribute("cateNo", cateNo);
				req.setAttribute("categoryName", categoryName);

				req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
				return;
			}

			else {
				// 以正常排列(上傳時間) 以及回傳得到的類別ID
				req.setAttribute("flag", "time");
				req.setAttribute("categoryName", categoryName);
				req.setAttribute("cateNo", cateNo);
				req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
				return;
			}

		}
		// 搜尋商品
		if ("search".equals(req.getParameter("action"))) {
			String searchCot = null;
			if (req.getParameter("searchCot") != null) {
				searchCot = req.getParameter("searchCot");
			}

			System.out.println(searchCot.trim());
			ProdService prodSvc = new ProdService();
			List<ProdVO> listSearch = prodSvc.getAllByKeyword(searchCot.trim());
			System.out.println(listSearch.size());
			req.setAttribute("listSearch", listSearch);
			req.setAttribute("searchCot", searchCot);

			req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);
			;

		}

		/////////// 商品狀態更改///////////////////

		if ("changeStaus".equals(req.getParameter("action"))) {

			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			Integer prodStatus = Integer.valueOf(req.getParameter("prodStatus"));
			long date = System.currentTimeMillis();
			Timestamp shelfTime = null;
			
			ProdService prodSvc = new ProdService();
			ProdVO prodVO = prodSvc.findProductByPK(prodID);
			
			if(prodStatus==1) {
				shelfTime = new Timestamp(date);
			}
			
			prodSvc.updateProd(prodID, prodVO.getCategoryID(), prodVO.getProdName(), prodVO.getProdCot(),
					prodVO.getProdRent(), prodVO.getProdPrice(), prodVO.getComt(), prodVO.getPic1(), prodVO.getPic2(),
					prodVO.getPic3(), shelfTime, prodStatus);

			res.sendRedirect(req.getContextPath() + "/front_end/product/leaseProdPage.jsp");

		}
		
		
		
		
		//////////////標籤點擊//////////////
		

		if ("labelClick".equals(req.getParameter("action"))) {
			String prodID = req.getParameter("prodID");

			String labelNo = req.getParameter("labelNo");
			String prodLabel = "";
			List<ProdVO> matchProdList = new ArrayList();
			List<Integer> matchProdList1 = new ArrayList();
			ProdService prodSvc = new ProdService();
			Jedis jedis = null;
			jedis = pool.getResource();
			String regEx = "[^0-9]";
			//從詳細圖片
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
							// 取代redis的prod為我們要的prodID為數字 並加入到陣列
							matchProdList.add(prodSvc.findProductByPK(Integer.valueOf(prod.replaceAll(regEx, ""))));

						}
					}

				}
			}
			// 從主頁標籤
			else if (req.getParameter("labelName") != null && !req.getParameter("labelName").isEmpty()) {
				Set<String> set = jedis.keys("prod*");
				System.out.println(req.getParameter("labelName"));
				for (String prod : set) {
					List<String> prodAll = jedis.lrange(prod, 0, jedis.llen(prod));
					for (String label : prodAll) {
						if (req.getParameter("labelName").equals(label)) {
							prodLabel = label;
							matchProdList.add(prodSvc.findProductByPK(Integer.valueOf(prod.replaceAll(regEx, ""))));
						}

					}

				}


			}
			jedis.close();
			req.setAttribute("prodLabel", prodLabel);
			req.setAttribute("matchProdList", matchProdList);
//			
//			
			req.getRequestDispatcher("/front_end/product/productPage.jsp").forward(req, res);

		}

		///////////// 結帳////////////////////
		if ("checkout".equals(req.getParameter("action"))) {
			System.out.println("點到結帳");
			Jedis jedis = null;
			jedis = pool.getResource();
			List<String> errorMsgs = new LinkedList<String>();
			req.setAttribute("errorMsgs", errorMsgs);
			Integer memberID = (Integer) req.getSession().getAttribute("id");
			List<String> cart = jedis.lrange("member" + memberID, 0, jedis.llen("member" + memberID));

			List<CartVO> checkoutList = new ArrayList();
			String[] checkbox = req.getParameterValues("cartCheckbox");
			if (req.getParameterValues("cartCheckbox") == null) {
				// 錯誤判斷
				errorMsgs.add("請勾選至少一樣商品");

			} else {
				for (String i : checkbox) {

					Integer prodID = Integer.valueOf(i);

					if (memberID != null) {

						for (String item : cart) {
							CartVO cartVO1 = gson.fromJson(item, CartVO.class);
							if (cartVO1.getProdID() == prodID) {
								checkoutList.add(cartVO1);
								System.out.println("vo: " + cartVO1.getProdID());
							}
						}
					}
				}

			}
			// 錯誤返回
			if (!errorMsgs.isEmpty()) {
				req.getRequestDispatcher("/front_end/product/cart.jsp").forward(req, res);

				return;

			}

			jedis.close();
			req.setAttribute("checkoutList", checkoutList);
			req.getRequestDispatcher("/front_end/order/addOrderMaster.jsp").forward(req, res);
		}

	}

}
