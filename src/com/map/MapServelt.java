package com.map;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

import com.google.gson.Gson;
import com.product.jedis.JedisPoolUtil;
import com.product.model.ProdService;
import com.product.model.ProdVO;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

@WebServlet("/MapServelt")
public class MapServelt extends HttpServlet {

	public MapServelt() {
	}

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");

		// 最外層
		JSONObject jsonObject4 = new JSONObject();

		ProdService prodSvc = new ProdService();
		ProdVO prodVO = prodSvc.findProductByPK(1);

		JedisPool pool = JedisPoolUtil.getJedisPool();
		Jedis jedis = null;
		
		if (req.getParameter("search") != null) {
			List<ProdVO> allList = prodSvc.getAllByKeyword(req.getParameter("search"));
			// 儲存會員商品資料
			List<JSONObject> listFeatures = new ArrayList<>();

			jedis = pool.getResource();

			String leaseStr = jedis.get("dataMap");

			JSONArray jsonArray = new JSONArray(leaseStr);

			System.out.println(jsonArray.length());

			int i = 0;
			for (ProdVO p : allList) {

				// geomtry.type
				JSONObject jsonObject = new JSONObject();
				// geomtry
				JSONObject jsonObject2 = new JSONObject();
				// properties
				JSONObject jsonObject3 = new JSONObject();
//				System.out.println(p.getProdID());
				List<String> listPosition = new ArrayList<>();

				String replace = jsonArray.toString().replace("\"", "");
				System.out.println(replace);
				JSONArray jsonArray2 = new JSONArray(replace);
				// 從jedis取得陣列後，找到會員編號一樣的 給予同樣的經緯度
				for (int j = 0; j < jsonArray2.length(); j++) {
					if (Integer.valueOf(((JSONObject) (jsonArray2.get(j))).getString("memId"))
							.equals(p.getMemberID())) {
						System.out.println("123");
						listPosition.add(((JSONObject) (jsonArray2.get(j))).getString("lat"));
						listPosition.add(((JSONObject) (jsonArray2.get(j))).getString("lng"));

						jsonObject.put("coordinates", listPosition);
						jsonObject.put("type", "Point");

						jsonObject3.put("id", p.getProdID());
						jsonObject3.put("url", "/TFA104G1/front_end/product/prodDetail.jsp?prodID=" + p.getProdID());

						jsonObject3.put("name", "會員編號" + p.getMemberID());
						jsonObject3.put("productName", p.getProdName());
						jsonObject3.put("site", ((JSONObject) (jsonArray2.get(j))).getString("site"));

						jsonObject2.put("geometry", jsonObject);
						jsonObject2.put("type", "Feature");
						jsonObject2.put("properties", jsonObject3);

						listFeatures.add(jsonObject2);
					}
				}
			}
			jsonObject4.put("features", listFeatures);
			jsonObject4.put("type", "FeatureCollection");
			req.getSession().setAttribute("mapDate", jsonObject4);
		}
		// 當搜尋完後跳轉 得到session存的資料
		if ("getMapData".equals(req.getParameter("action"))) {
			req.getSession().getAttribute("mapDate");
			if (req.getSession().getAttribute("mapDate") != null) {
//				System.out.println(req.getSession().getAttribute("mapDate"));
				res.getWriter().print((JSONObject) req.getSession().getAttribute("mapDate"));
				req.getSession().removeAttribute("mapDate");
			}
		}
		if (jedis != null) {
			jedis.close();
		}

		if ("search".equals(req.getParameter("action"))) {
			req.getSession().removeAttribute("searchCot");
			req.getSession().setAttribute("searchCot", req.getParameter("search"));
			res.sendRedirect("/TFA104G1/front_end/letswrite-google-map-api-5-master/mapProdSearch.jsp");
			return;
		}
		
		
		
		//會員加入地圖商品功能
		if ("dataMap".equals(req.getParameter("action"))) {
			System.out.println("進");
			String lat = req.getParameter("lat");
			String lng = req.getParameter("lng");
			String address = req.getParameter("address");
			Jedis jedis2 = pool.getResource();
			String memberID = "2";
			if (req.getSession().getAttribute("id") != null) {
				memberID = req.getSession().getAttribute("id").toString();
			}
			System.out.println("經度:" + lat + "  緯度:" + lng);
			// 加入一個新的json
			String mapJson = "{'lat':'" + lat + "','lng':'" + lng + "','memId':'" + memberID + "'," + "'site':'"
					+ address + "'}";

			String dataStr = null;
			System.out.println("map" + mapJson);
			JSONArray jsonArray = new JSONArray();
			JSONArray jsonArray2 = new JSONArray();
			if (jedis2.get("dataMap") != null) {
				// 取得redis資料
				dataStr = jedis2.get("dataMap");
				// 刪掉原本的redis
				jedis2.del("dataMap");

				System.out.println(dataStr);
				// 原本redis裡轉成jsonArray
				jsonArray = new JSONArray(dataStr);
				jsonArray2 = new JSONArray(dataStr.replace("\"", ""));
				System.out.println("長度:" + jsonArray.length());
				Boolean flag = true;
				// 判斷會員是否重複 如果重複 加入再加入新的->更新資料
				for (int i = 0; i < jsonArray.length(); i++) {
					System.out.println(((JSONObject) (jsonArray2.get(i))));
					if ((((JSONObject) (jsonArray2.get(i))).getString("memId").toString()).equals(memberID)) {
						jsonArray.put(mapJson);
						jsonArray.remove(i);

						flag = false;
					}
				}
				// 不重複 則直接加入到陣列
				if (flag) {
					jsonArray.put(mapJson);
				}

			} else {
				// 新增第一筆資料進去
				jsonArray.put(mapJson);

			}
			// 將新的json加入jsonArray

			jedis2.append("dataMap", jsonArray.toString());

			jedis2.close();

			res.sendRedirect("/TFA104G1/front_end/product/leaseProdPage.jsp");
			return;

		}
		
		
		
		
		if("showAddress".equals(req.getParameter("action"))) {
			System.out.println("進去顯示地址");
			
			Jedis jedis3 = pool.getResource();
			String dataStr = jedis3.get("dataMap");
			jedis3.close();
			String memberID = req.getSession().getAttribute("id").toString();
			JSONArray jsonArray = new JSONArray(dataStr);
			jsonArray = new JSONArray(dataStr.replace("\"", ""));
			for(int i=0;i<jsonArray.length();i++) {
				
				if ((((JSONObject) (jsonArray.get(i))).getString("memId").toString()).equals(memberID)) {
					String address = (((JSONObject) (jsonArray.get(i))).getString("site")).toString();
					res.getWriter().print(address);
					
					
				}
			}
			
			
			
		}
		
		
		
		
		
		
		

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
