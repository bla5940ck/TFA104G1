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
			//儲存會員商品資料
			List<JSONObject> listFeatures = new ArrayList<>();
			
			jedis = pool.getResource();
			
			String leaseStr = jedis.get("leaseData");
		
			JSONArray jsonArray =new JSONArray(leaseStr);
			
			System.out.println(jsonArray.length());
			
			int i=0;
			for (ProdVO p : allList) {
				
				// geomtry.type
				JSONObject jsonObject = new JSONObject();
				// geomtry
				JSONObject jsonObject2 = new JSONObject();
				// properties
				JSONObject jsonObject3 = new JSONObject();
//				System.out.println(p.getProdID());
				List<String> listPosition = new ArrayList<>();
				
				for(int j=0;j<jsonArray.length();j++) {
					if(Integer.valueOf(((JSONObject)(jsonArray.get(j))).getString("memId")).equals(p.getMemberID())) {
						System.out.println("123");
				listPosition.add(((JSONObject)(jsonArray.get(j))).getString("lat"));
				listPosition.add(((JSONObject)(jsonArray.get(j))).getString("lng"));

				jsonObject.put("coordinates", listPosition);
				jsonObject.put("type", "Point");

				jsonObject3.put("id", p.getProdID());
				
				jsonObject3.put("name", "會員編號" + p.getMemberID());
				jsonObject3.put("productName", p.getProdName());
				jsonObject3.put("site", ((JSONObject)(jsonArray.get(j))).getString("site"));

				jsonObject2.put("geometry", jsonObject);
				jsonObject2.put("type", "Feature");
				jsonObject2.put("properties", jsonObject3);

				listFeatures.add(jsonObject2);
				i++;
					}
			}
			}
			jsonObject4.put("features", listFeatures);
			jsonObject4.put("type", "FeatureCollection");
			req.getSession().setAttribute("mapDate", jsonObject4);
		}
		// 當搜尋完後跳轉 得到session存的資料
		if ("getMapDate".equals(req.getParameter("action"))) {
			req.getSession().getAttribute("mapDate");
			if (req.getSession().getAttribute("mapDate") != null) {
//				System.out.println(req.getSession().getAttribute("mapDate"));
				res.getWriter().print((JSONObject) req.getSession().getAttribute("mapDate"));
				req.getSession().removeAttribute("mapDate");
			}
		}
		if(jedis!=null) {
		jedis.close();
}
		
		if ("search".equals(req.getParameter("action"))) {
			req.getSession().removeAttribute("searchCot");
			req.getSession().setAttribute("searchCot", req.getParameter("search"));
			res.sendRedirect("/TFA104G1/front_end/letswrite-google-map-api-5-master/mapProdSearch.jsp");
			return;
		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
