package com.manager.controller;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LoginFilter implements Filter {

	private FilterConfig config;

	public void init(FilterConfig config) {
		this.config = config;
	}

	public void destroy() {
		config = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws ServletException, IOException {

		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;
		// 【取得 session】
		HttpSession session = req.getSession();
		// 【從 session 判斷此user是否登入過】
		Object account = session.getAttribute("managerUser");
		
		System.out.println("有值"+account);
		
		if (account == null) {
			session.setAttribute("location", req.getRequestURI());
			
			res.sendRedirect(req.getContextPath() + "/back_end/manager/managerlogin.jsp");
			return;
		} else {
			session.removeAttribute("location");
			chain.doFilter(request, response);
			
		}
			
			
		
	}
}