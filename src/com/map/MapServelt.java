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

@WebServlet("/MapServelt")
public class MapServelt extends HttpServlet {
       
    public MapServelt() {
    }

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String type="FeatureCollection";
		JSONObject jsonObject = new JSONObject();
		JSONObject jsonObject2 = new JSONObject();
		List<String> listPosition = new ArrayList<>();
		listPosition.add("25.0405919");
		listPosition.add("121.5647644");
		
		jsonObject.put("coordinates", listPosition);
		jsonObject.put("type","Point");
		
		
		
		jsonObject.put("type", "Feature");
		
		
	
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
