package com.order.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;

import com.google.gson.JsonArray;
import com.order.model.OrderMasterDAOImpl;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		if ("report".equals(req.getParameter("action"))) {
			
			System.out.println("進");
			OrderMasterDAOImpl orderMaster = new OrderMasterDAOImpl();
			 List<Map<String, String>> list = orderMaster.getDate();
			
			JSONObject jsonObj = new JSONObject();
			jsonObj.put("list", list);
		
			System.out.println(jsonObj);
			
			//{
        		
//              y: 1,
//              label: "January"
//          }
			
		
			
			
			res.getWriter().print(jsonObj);

		}
	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
