package com.member.model;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;


public class DefAddressDAO implements DefAddressDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/JoyLease");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
			"INSERT INTO def_address ( member_id, code_711, name_711, add_711 ,status, recipient, recpt_phone) VALUES ( ? , ? , ? , ? , ? ,?,?  )";
		private static final String GET_ALL_STMT = 
			"SELECT def_711, member_id, code_711, name_711, add_711, status, recipient, recpt_phone FROM def_address order by def_711";
		private static final String GET_ONE_STMT = 
			"SELECT def_711, member_id, code_711, name_711, add_711, status, recipient, recpt_phone FROM def_address where def_711  =  ?";
		private static final String DELETE = 
			"DELETE FROM def_address where def_711 = ? ";
		private static final String UPDATE = 
			"UPDATE def_address set member_id=?, code_711=?, name_711=?, add_711=?, status=?, recipient=?,recpt_phone=? where def_711  =  ?";
		private static final String UPDATESTATUS =
				"update def_address set status=0 where member_id=?";
	
	@Override
	public void insert(DefAddressVO defAddressVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

//			pstmt.setInt(1, defAddressVO.getDef711());
			pstmt.setInt(1, defAddressVO.getMemberId());
			pstmt.setInt(2, defAddressVO.getCode711());
			pstmt.setString(3, defAddressVO.getName711());
			pstmt.setString(4, defAddressVO.getAdd711());
			pstmt.setInt(5, defAddressVO.getStatus());
			pstmt.setString(6, defAddressVO.getRecipient());
			pstmt.setString(7, defAddressVO.getRecptPhone());

			pstmt.executeUpdate();

			// Handle any driver errors
		
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

		
	}

	@Override
	public void update(DefAddressVO defAddressVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			
			pstmt.setInt(1, defAddressVO.getMemberId());
			pstmt.setInt(2, defAddressVO.getCode711());
			pstmt.setString(3, defAddressVO.getName711());
			pstmt.setString(4, defAddressVO.getAdd711());
			pstmt.setInt(5, defAddressVO.getStatus());
			pstmt.setString(6, defAddressVO.getRecipient());
			pstmt.setString(7, defAddressVO.getRecptPhone());
			pstmt.setInt(8, defAddressVO.getDef711());


			pstmt.executeUpdate();

			// Handle any driver errors
		
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public DefAddressVO findByPrimaryKey(Integer def711) {

		DefAddressVO defAddressVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, def711);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				defAddressVO = new DefAddressVO();
				defAddressVO.setDef711(rs.getInt("def_711"));
				defAddressVO.setMemberId(rs.getInt("member_Id"));
				defAddressVO.setCode711(rs.getInt("code_711"));
				defAddressVO.setName711(rs.getString("name_711"));
				defAddressVO.setAdd711(rs.getString("add_711"));
				defAddressVO.setStatus(rs.getInt("status"));
				defAddressVO.setRecipient(rs.getString("recipient"));
				defAddressVO.setRecptPhone(rs.getString("recpt_Phone"));
			}

			// Handle any driver errors
	
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return defAddressVO;
	}

	@Override
	public List<DefAddressVO> getAll() {
		
		List<DefAddressVO> list = new ArrayList<DefAddressVO>();
		DefAddressVO defAddressVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// defAddressVO ???]???????? Domain objects
				defAddressVO = new DefAddressVO();
				defAddressVO.setDef711(rs.getInt("def_711"));
				defAddressVO.setMemberId(rs.getInt("member_Id"));
				defAddressVO.setCode711(rs.getInt("code_711"));
				defAddressVO.setName711(rs.getString("name_711"));
				defAddressVO.setAdd711(rs.getString("add_711"));
				defAddressVO.setStatus(rs.getInt("status"));
				defAddressVO.setRecipient(rs.getString("recipient"));
				defAddressVO.setRecptPhone(rs.getString("recpt_Phone"));
				list.add(defAddressVO); // Store the row in the list
			}

			// Handle any driver errors
	
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	public static void main(String[] args) {
		
		DefAddressDAO dao = new DefAddressDAO();
//		// ??????
//		DefAddressVO defAddressVO1 = new DefAddressVO();
//		defAddressVO1.setMemberId(1);
//		defAddressVO1.setCode711(193742);
//		defAddressVO1.setName711("????????????????????");
//		defAddressVO1.setAdd711("???s???_??????XXXXXXTEST");
//		defAddressVO1.setStatus(0);
//		defAddressVO1.setRecipient("?????????");
//		defAddressVO1.setRecptPhone("0988666777");
//		dao.insert(defAddressVO1);
		
		// ??????
//		DefAddressVO defAddressVO2 = new DefAddressVO();
//		defAddressVO2.setDef711(6);
//		defAddressVO2.setMemberId(1);
//		defAddressVO2.setCode711(193742);
//		defAddressVO2.setName711("????????????????????");
//		defAddressVO2.setAdd711("UPDATE???s???_??????XXXXXXTEST");
//		defAddressVO2.setStatus(1);
//		defAddressVO2.setRecipient("?????????");
//		defAddressVO2.setRecptPhone("0988666777");
//		dao.update(defAddressVO2);
		
		// ????????????
//		DefAddressVO defAddressVO2 = dao.findByPrimaryKey(6);
//				System.out.print(defAddressVO2.getDef711() + ",");
//				System.out.print(defAddressVO2.getMemberId() + ",");
//				System.out.print(defAddressVO2.getCode711() + ",");
//				System.out.print(defAddressVO2.getName711() + ",");
//				System.out.print(defAddressVO2.getAdd711() + ",");
//				System.out.print(defAddressVO2.getStatus() + ",");
//				System.out.print(defAddressVO2.getRecipient() + ",");
//				System.out.println(defAddressVO2.getRecptPhone());
//				System.out.println("---------------------");
				
		// ????????????
		List<DefAddressVO> list = dao.getOneMemAll(1);
			for (DefAddressVO aDefAddress : list) {
				System.out.print(aDefAddress.getDef711() + ",");
				System.out.print(aDefAddress.getMemberId() + ",");
				System.out.print(aDefAddress.getCode711() + ",");
				System.out.print(aDefAddress.getName711() + ",");
				System.out.print(aDefAddress.getAdd711() + ",");
				System.out.print(aDefAddress.getStatus() + ",");
				System.out.print(aDefAddress.getRecipient() + ",");
				System.out.print(aDefAddress.getRecptPhone());
				System.out.println();		
			}
	}

	
	private static final String GET_ONE_MEM_ALL_STMT = 
			"SELECT def_711, member_id, code_711, name_711, add_711, status, recipient, recpt_phone FROM def_address WHERE member_id = ? order by def_711 DESC";
	@Override
	public List<DefAddressVO> getOneMemAll(Integer memberId ) {
		// TODO Auto-generated method stub
		List<DefAddressVO> list = new ArrayList<DefAddressVO>();
		DefAddressVO defAddressVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_MEM_ALL_STMT);
			
			pstmt.setInt(1, memberId);
			rs = pstmt.executeQuery();
			
			while (rs.next()) {
				// defAddressVO  Domain objects
				defAddressVO = new DefAddressVO();
				defAddressVO.setDef711(rs.getInt("def_711"));
				defAddressVO.setMemberId(rs.getInt("member_Id"));
				defAddressVO.setCode711(rs.getInt("code_711"));
				defAddressVO.setName711(rs.getString("name_711"));
				defAddressVO.setAdd711(rs.getString("add_711"));
				defAddressVO.setStatus(rs.getInt("status"));
				defAddressVO.setRecipient(rs.getString("recipient"));
				defAddressVO.setRecptPhone(rs.getString("recpt_Phone"));
				list.add(defAddressVO); // Store the row in the list
			}

			// Handle any driver errors
	
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return list;
	}

	@Override
	public void delete(Integer def711) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, def711);
			

			pstmt.executeUpdate();

			// Handle any driver errors
	
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void updateStatus(DefAddressVO defAddressVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATESTATUS);

			pstmt.setInt(1, defAddressVO.getMemberId());
			
			pstmt.executeUpdate();

			// Handle any driver errors
	
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
}
