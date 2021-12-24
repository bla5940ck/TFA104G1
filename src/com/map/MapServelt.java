package com.map;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.product.model.ProdService;
import com.product.model.ProdVO;

@WebServlet("/MapServelt")
public class MapServelt extends HttpServlet {
       
    public MapServelt() {
    }

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		res.setContentType("text/html; charset=utf-8");
		
		
		
	
		//最外層
		JSONObject jsonObject4 = new JSONObject();
		
		

		
		
		
		
		
		
		
		ProdService prodSvc = new ProdService();
		ProdVO prodVO = prodSvc.findProductByPK(1);
		if(req.getParameter("search")!=null) {
			List<ProdVO> allList = prodSvc.getAllByKeyword(req.getParameter("search"));
		
			List<JSONObject> listFeatures = new ArrayList<>();
		
		System.out.println(allList.size());
		for(ProdVO p:allList) {
			//geomtry.type
			JSONObject jsonObject = new JSONObject();
			//geomtry
			JSONObject jsonObject2 = new JSONObject();
			//properties
			JSONObject jsonObject3 = new JSONObject();
			System.out.println(p.getProdID());
		List<String> listPosition = new ArrayList<>();
		listPosition.add("25.0405919");
		listPosition.add("121.5647644");
		
		jsonObject.put("coordinates", listPosition);
		jsonObject.put("type","Point");
	
		jsonObject3.put("id", p.getProdID());
		jsonObject3.put("name", "會員編號"+ p.getMemberID());
		jsonObject3.put("productName",p.getProdName());
		jsonObject3.put("site", "110台北市信義區市府路1號市府大樓");


		jsonObject2.put("geometry", jsonObject);
		jsonObject2.put("type","Feature");
		jsonObject2.put("properties",jsonObject3);
		
		listFeatures.add(jsonObject2);
		
		}
		
		jsonObject4.put("features",listFeatures);
		jsonObject4.put("type", "FeatureCollection");
		req.getSession().setAttribute("mapDate", jsonObject4);
		}
		
		if("getMapDate".equals(req.getParameter("action"))) {
			req.getSession().getAttribute("mapDate");
			if(req.getSession().getAttribute("mapDate")!=null) {
			System.out.println(req.getSession().getAttribute("mapDate"));
			res.getWriter().print((JSONObject)req.getSession().getAttribute("mapDate"));	
			req.getSession().removeAttribute("mapDate");
			}}
		
		if("search".equals(req.getParameter("action"))) {
			res.sendRedirect("/TFA104G1/front_end/letswrite-google-map-api-5-master/index.html");
			return;
		}
		
		
		
	
		
		
		
		
		
	
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
