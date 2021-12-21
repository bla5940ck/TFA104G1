package com.postboard.controller;

import java.io.*;
import java.sql.*;

import javax.naming.Context;
import javax.naming.NamingException;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;

import util.Util;

@WebServlet("/PbPhotoShow")
public class PbPhotoShow extends HttpServlet {
	static {
		try {
			Class.forName(Util.DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	Connection con;
    
	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		//System.out.println("1234");
		res.setContentType("image/gif");
		ServletOutputStream out = res.getOutputStream();
		
		try {
			//System.out.println("1111");
			Connection con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			//System.out.println("2222");
			Statement stmt = con.createStatement();
			
			String postId = req.getParameter("postId").trim();
			System.out.println("postId : " + postId);
			//System.out.println("3333");
			ResultSet rs = stmt.executeQuery(
				"select pic from post_board where post_id =" + "\"" + postId +"\"");
			//System.out.println("4444");
			if (rs.next()) {
				BufferedInputStream in = new BufferedInputStream(rs.getBinaryStream("pic"));
				byte[] buf = new byte[4 * 1024]; // 4K buffer
				int len;
				while ((len = in.read(buf)) != -1) {
					out.write(buf, 0, len);
				}
				in.close();
			} else {
				res.sendError(HttpServletResponse.SC_NOT_FOUND);
			}
				rs.close();
				stmt.close();
				
		}catch (Exception e) {
			System.out.println(e);
		}
	}



}
