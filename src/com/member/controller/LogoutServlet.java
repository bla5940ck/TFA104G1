package com.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/LogoutServlet")
public class LogoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
    public LogoutServlet() {
        super();
    }


    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //使用request.getSession().invalidate();讓session失效
    	request.getSession().invalidate();
        //request.getRequestDispatcher("/main/index.jsp").forward(request, response);
    	
    	//    	使用response.sendRedirect(url);進行重定向。不使用轉發是為了讓url列更新。進行重定向需先準備好絕對路徑。
        String path = request.getContextPath();
        String basePath = request.getScheme() + "://" + request.getServerName()  
        + ":" + request.getServerPort() + path + "/";
        response.sendRedirect(basePath + "index.jsp");
      }

}
