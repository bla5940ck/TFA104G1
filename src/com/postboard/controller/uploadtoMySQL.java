package com.postboard.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

@WebServlet("/uploadtoMySQL")
public class uploadtoMySQL extends HttpServlet {
	
	protected void doGet(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		
		res.setContentType("text/html; charset=UTF-8");
		req.setCharacterEncoding("UTF-8");
		res.setCharacterEncoding("UTF-8");
		PrintWriter out = res.getWriter();
		
		PreparedStatement pstmt;
		//獲得PreparedStatment物件 ，PreparedStatment執行SQL查詢語句的API,比 Statement更快
		//載入資料庫驅動
		Connection con;
		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (ClassNotFoundException e) {
			System.out.println("驅動找不到");
		}
		
		List Files = new ArrayList();
		//存取上傳檔案 String name = "";
		//存取上傳人姓名 DiskFileItemFactory factory = new DiskFileItemFactory();
		//建立一個解析器工廠
		
        DiskFileItemFactory fu =new DiskFileItemFactory ();
        //得到解析器，處理上傳的檔案資料，並將表單中每個輸入項封裝成一個FileItem 物件中
        
        ServletFileUpload upload = new ServletFileUpload(fu);
		upload.setHeaderEncoding("UTF-8");
		
	}


	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
		doGet(req, res);
	}

}
