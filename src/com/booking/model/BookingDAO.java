package com.booking.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.TreeMap;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import util.Util;

public class BookingDAO implements BookingDAO_interface {

	static {
		try {
			Class.forName(Util.DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	public void add(BookingVO bk) {
		String sql = "INSERT INTO booking(`prod_id`, `status`, `est_start`, `est_end` ,`ord_id`) VALUES (?, ?, ?, ?,?);";
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,bk.getProdID());
			pstmt.setInt(2,bk.getStatus());
			pstmt.setDate(3, bk.getEstStart());
			pstmt.setDate(4, bk.getEstEnd());
			pstmt.setInt(5, bk.getOrdID());
			
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
	}

	@Override
	public void update(BookingVO bk) {
		String sql = "update booking set `status`= ? where bk_id =?;";
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bk.getStatus());
			pstmt.setInt(2, bk.getBkID());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		
	}

	@Override
	public void delete(Integer bkID) {

	String sql = "DELETE FROM booking WHERE `bk_id` = ?;";
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, bkID);
		pstmt.executeUpdate();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}finally {
		try {
			con.close();
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
	}
	}

	@Override
	public List<BookingVO>  findDateByProdID(Integer prodID) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from booking where prod_id = ? &&( status =1 ||status =0)" ;
		BookingVO bk = null;
		List<BookingVO> list = new ArrayList<BookingVO>();
		try {
			con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, prodID);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bk = new BookingVO();
				
				bk.setEstStart(rs.getDate("est_start"));
				bk.setEstEnd(rs.getDate("est_end"));
				
				list.add(bk);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return list;
	}
	
	
	
	public BookingVO findBookingByPK(Integer bkID) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String sql = "select * from booking where bk_id = ?" ;
		BookingVO bk = null;
		List<BookingVO> list = new ArrayList<BookingVO>();
		try {
			con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bkID);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bk = new BookingVO();
				bk.setProdID(rs.getInt("prod_id"));
				bk.setBkID(rs.getInt("bk_id"));
				bk.setStatus(rs.getInt("status"));
				bk.setEstStart(rs.getDate("est_start"));
				bk.setEstEnd(rs.getDate("est_end"));
				bk.setOrdID(rs.getInt("ord_id"));
				
				
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return bk;
	}
	
	
	

	@Override
	public List<BookingVO> getAll() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String sql = "select * from booking";
		BookingVO bk = null;
		List<BookingVO> list = new ArrayList<BookingVO>();
		
		try {
			con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
		
			while(rs.next()) {
				bk  = new BookingVO();
				bk.setBkID(rs.getInt("bk_id"));
				bk.setProdID(rs.getInt("prod_id"));
				bk.setStatus(rs.getInt("status"));
				bk.setEstStart(rs.getDate("est_start"));
				bk.setEstEnd(rs.getDate("est_end"));
				bk.setOrdID(rs.getInt("ord_id"));
				list.add(bk);
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return list;
	}
	
	
	public Map<Integer,Integer> getSortByCount() {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null; 
		String sql ="SELECT prod_id,count(bk_id) as countBk FROM booking group by prod_id order by count(bk_id) desc";
		BookingVO bk = null;
		List<Integer> list = new ArrayList<>();
		List<Integer> listCount = new ArrayList();
		Map<Integer,Integer> map = new LinkedHashMap<Integer, Integer>();
		
		try {
			con = DriverManager.getConnection(Util.URL,Util.USER,Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getInt("prod_id"));
				listCount.add(rs.getInt(2));
				
				map.put(rs.getInt(1), rs.getInt(2));
			}
			
			 
			
		}catch (Exception e) {
			
			e.printStackTrace();
		}finally {
			try {
				con.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
		}
		return map;
	}
	
	
	
	
	
	
	
	
	public static void main(String[] args) {
		
		BookingDAO b = new BookingDAO();
//		
//		List<BookingVO> bk = b.getAll();
//		
//		bk.forEach(bb->System.out.println(bb.getBkID()));
		
//		Map<Integer,Integer> map = b.getSortByCount();
//		Set<Integer> keySet = map.keySet();
//		List<Integer> prodIDList = new ArrayList();
//		List<Integer> countList = new ArrayList();
//		for(int i :keySet) {
//			System.out.println("key: " +i + " value: "+ map.get(i));
//			prodIDList.add(i);
//			countList.add(map.get(i));
//		}
//		
//		BookingDAO bk = new BookingDAO();
//		List<BookingVO> list = bk.getAll();
//		
//		Map<Integer, Long> collect = list.stream()
//		        					.collect(Collectors
//		        						.groupingBy(BookingVO::getProdID,Collectors.counting()));
//		        							
//		
//	Set<Integer> keySet = collect.keySet();
//		
//		for(Integer k : keySet) {
//			System.out.println("key: " + k+ " value: " + collect.get(k));
//		
//		
//		}
		
	}

}
