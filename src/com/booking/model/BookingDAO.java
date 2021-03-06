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

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import util.Util;

public class BookingDAO implements BookingDAO_interface {
	private static final String INSERT = "INSERT INTO BOOKING(`PROD_ID`, `STATUS`, `EST_START`, `EST_END` ,`ORD_ID`) VALUES (?, ?, ?, ?,?);";
	private static final String UPDATE = "UPDATE BOOKING SET `STATUS`= ? WHERE BK_ID =?;";
	private static final String FINDDATEBYPRODID = "SELECT * FROM BOOKING WHERE PROD_ID = ? &&( STATUS =1 ||STATUS =0)" ;
	private static final String FINDBOOKINGBYPK = "SELECT * FROM BOOKING WHERE BK_ID = ?" ;
	private static final String DELETE = "DELETE FROM BOOKING WHERE `BK_ID` = ?;";
	private static final String ALL = "SELECT * FROM BOOKING";
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/JoyLease");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	public void add(BookingVO bk) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT);
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
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
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
	
	Connection con = null;
	PreparedStatement pstmt = null;
	
	try {
		con = ds.getConnection();
		pstmt = con.prepareStatement(DELETE);
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
		BookingVO bk = null;
		List<BookingVO> list = new ArrayList<BookingVO>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDDATEBYPRODID);
			pstmt.setInt(1, prodID);
			
			rs=pstmt.executeQuery();
			while(rs.next()) {
				bk = new BookingVO();
				
				bk.setEstStart(rs.getDate("est_start"));
				bk.setEstEnd(rs.getDate("est_end"));
				bk.setBkID(rs.getInt("bk_id"));
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
		BookingVO bk = null;
		List<BookingVO> list = new ArrayList<BookingVO>();
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDBOOKINGBYPK);
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
		BookingVO bk = null;
		List<BookingVO> list = new ArrayList<BookingVO>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ALL);
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
		String sql ="SELECT B.PROD_ID ,COUNT(B.PROD_ID) AS COUNT FROM BOOKING B JOIN PRODUCT P  ON B.PROD_ID= P.PROD_ID WHERE P.PROD_STATUS=1 GROUP BY B.PROD_ID ORDER BY COUNT(B.PROD_ID) DESC;";
		BookingVO bk = null;
		List<Integer> list = new ArrayList<>();
		List<Integer> listCount = new ArrayList();
		Map<Integer,Integer> map = new LinkedHashMap<Integer, Integer>();
		
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				list.add(rs.getInt(1));
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

	@Override
	public void add2(BookingVO bk, Connection con) {
		String sql = "INSERT INTO booking(`prod_id`, `status`, `est_start`, `est_end` ,`ord_id`) VALUES (?, ?, ?, ?,?);";
		PreparedStatement pstmt = null;
		
		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1,bk.getProdID());
//			System.out.println("??????bookingDAO");
//			System.out.println(bk.getProdID());
			pstmt.setInt(2,bk.getStatus());
//			System.out.println(bk.getStatus());
			pstmt.setDate(3, bk.getEstStart());
//			System.out.println(bk.getEstStart());
			pstmt.setDate(4, bk.getEstEnd());
//			System.out.println(bk.getEstEnd());
			pstmt.setInt(5, bk.getOrdID());
//			System.out.println(bk.getOrdID());
			
			pstmt.executeUpdate();
		} catch (SQLException se) {
			if (con != null) {
				try {
					se.printStackTrace();
					System.err.print("Transaction is being ");
					System.err.println("rolled back-???-bookingDAO");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
	}
		
	

}
