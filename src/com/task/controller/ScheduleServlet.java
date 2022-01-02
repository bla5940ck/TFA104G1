package com.task.controller;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.*;

import org.omg.PortableServer.CurrentOperations;

import com.promo.model.PromoService;
import com.promo.model.PromoVO;

import java.util.*;
@WebServlet("/back_end/promo/dateEnd")
public class ScheduleServlet extends HttpServlet{
	
		Timer timer;
	    int i=0;      
	   
	    public void init() throws ServletException {
	      TimerTask task = new TimerTask(){ 
		        public void run() {
//	            System.out.println("i="+i);
//	            i++;	      
//		        	SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
//			        String timeStamp = date.format(new Date());
//			        System.out.println("Current Time Stamp: "+timeStamp);
			
				
			        PromoService promoSvc = new PromoService();
					promoSvc.DateEnd(System.currentTimeMillis());
		        } 
	      };
	      timer = new Timer(); 
	      Calendar cal = new GregorianCalendar(2021, Calendar.DECEMBER, 1, 0, 0, 0);
	      timer.scheduleAtFixedRate(task, cal.getTime(), 10*1000);
	      System.out.println("已建立排程!");       
	    }
	    
	    public void destroy() {
	    	timer.cancel();
	    	System.out.println("已移除排程!");
	    }

//	    public void doGet(HttpServletRequest req, HttpServletResponse res)
//	                               throws ServletException, IOException {
//	    	SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
////	        String timeStamp = date.format(new Date());
////	        System.out.println("Current Time Stamp: "+timeStamp);
//	
//		
//	        PromoService promoSvc = new PromoService();
//			promoSvc.DateEnd(System.currentTimeMillis());
//	        
//	    }                           	

	    
	    
//	    Timer timer ; 
//	    int count = 0;        
//	    public void destroy(){
//	        timer.cancel();
//	    }
//	    
//	    public void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException{
//	    }
//	            
//	    public void init(){        
//	        timer = new Timer();
//	        Calendar cal = new GregorianCalendar(2011, Calendar.MARCH, 5, 0, 0, 0);        
//	        TimerTask task = new TimerTask(){
//	                   
//	            public void run(){
//	                System.out.println("This is Task"+ count);
//	                System.out.println("工作排定的時間 = " + new Date(scheduledExecutionTime()));
//	                System.out.println("工作執行的時間 = " + new Date() + "\n");                
//	                count++;
//	            }
//	        };
//	        timer.scheduleAtFixedRate(task, cal.getTime(), 60*60*1000); 
//	    }
	    
	    
//	    public static void main(String[] args) {
//	        Long datetime = System.currentTimeMillis();
//	        Timestamp timestamp = new Timestamp(datetime);
//	        System.out.println("Current Time Stamp: "+timestamp);
//	    }
	    
//	    public static void main(String[] args) {
////	    	SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd.HH:mm:ss");
//	    	SimpleDateFormat date = new SimpleDateFormat("yyyy.MM.dd");
//	        String timeStamp = date.format(new Date());
//	        System.out.println("Current Time Stamp: "+timeStamp);
//	    }
//	    
	}

