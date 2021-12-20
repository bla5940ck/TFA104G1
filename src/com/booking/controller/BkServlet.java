package com.booking.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONException;
import org.json.JSONObject;

import com.booking.model.BookingService;
import com.booking.model.BookingVO;

@WebServlet("/bk/BkServlet")
public class BkServlet extends HttpServlet {

	public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {

		if ("searchBk".equals(req.getParameter("action"))) {
			Integer prodID = Integer.valueOf(req.getParameter("prodID"));
			BookingService bkSvc = new BookingService();
			List<BookingVO> bkList = bkSvc.findDateByProdID(prodID);
			JSONObject obj = new JSONObject();
			try {
				obj.put("bkList", bkList);
			} catch (JSONException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			res.getWriter().print(obj);

		}

	}

	public void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		doGet(req, res);
	}

}
