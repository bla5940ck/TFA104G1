package com.member;


import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class LeaseLoginFilter implements Filter {

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
		Object loginId = session.getAttribute("loginId");
		if (loginId == null) {
			session.setAttribute("location", req.getRequestURI());
			res.sendRedirect(req.getContextPath() + "/front_end/member/LoginForgetPW.jsp");
			
			return;
		}
		/*
		Object account = session.getAttribute("account");                  // 從 session內取出 (key) account的值
    if (account == null) {                                             // 如為 null, 代表此user未登入過 , 才做以下工作
      session.setAttribute("location", req.getRequestURI());       //*工作1 : 同時記下目前位置 , 以便於login.html登入成功後 , 能夠直接導至此網頁(須配合LoginHandler.java)
      res.sendRedirect(req.getContextPath()+"/login.html");   //*工作2 : 請該user去登入網頁(login.html) , 進行登入
      return;
    }
		*/ 
		else {
			chain.doFilter(request, response);
			//res.sendRedirect((String)(req.getAttribute("location")));
		}
	}
}