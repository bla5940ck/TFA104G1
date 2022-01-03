package com.order.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONArray;
import org.json.JSONObject;

//import com.google.gson.JsonArray;
import com.order.model.OrderMasterDAOImpl;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		if ("report".equals(req.getParameter("action"))) {
			
			System.out.println("進");
			OrderMasterDAOImpl orderMaster = new OrderMasterDAOImpl();
			 List<Map<String, String>> list = orderMaster.getDate();
			 
//				jsonObj.put("list", list);
			 List list2 = new ArrayList();
			 
			for(Map<String, String> abc : list) {
				Set<String> set = abc.keySet();
				for (String label : set) {
					JSONObject jsonObj = new JSONObject();
					jsonObj.put("label", label);
					jsonObj.put("y", Integer.valueOf(abc.get(label)));
					System.out.println(jsonObj);
					list2.add(jsonObj);
//					jsonArray.put(jsonObj);
					
				}
			}
			for(Object a :list2) {
				System.out.println("123"+a.toString());
			}
		
			
			res.getWriter().print(list2);
			
			
			//{
        		
//              y: 1,
//              label: "January"
//          }
			
		
			
			
//			res.getWriter().print(jsonObj);

		}
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
