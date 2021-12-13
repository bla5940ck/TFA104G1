package com.pbreply.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.*;


public class pbReplyJDBCDAO implements pbReplyDAOIpml {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "password";

	private static final String INSERT_STMT = 
		"INSERT INTO pb_reply (post_id,member_id,reply_cont,reply_time) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT * FROM pb_reply order by reply_id";
	private static final String GET_ONE_STMT = 
		"SELECT reply_id,post_id,member_id,reply_cont,reply_time FROM pb_reply where reply_id = ?";
	private static final String DELETE = 
		"DELETE FROM pb_reply where reply_id = ?";
	private static final String UPDATE = 
		"UPDATE pb_reply set post_id=?, member_id=?, reply_cont=?,reply_time  where reply_id = ?";
	
	
	
	@Override
	public void insert(pbReplyVO pbreplyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, pbreplyVO.getPostId());
			pstmt.setInt(2, pbreplyVO.getMemberId());
			pstmt.setString(3, pbreplyVO.getReplyCont());
			pstmt.setTimestamp(4, pbreplyVO.getReplyTime());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public void update(pbReplyVO pbreplyVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, pbreplyVO.getPostId());
			pstmt.setInt(2, pbreplyVO.getMemberId());
			pstmt.setString(3, pbreplyVO.getReplyCont());
			pstmt.setTimestamp(4, pbreplyVO.getReplyTime());
			pstmt.setInt(5, pbreplyVO.getReplyId());
		

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public void delete(Integer replyId) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, replyId);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
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
	public pbReplyVO findByPrimaryKey(Integer replyId) {
		pbReplyVO pbreplyVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, replyId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				pbreplyVO = new pbReplyVO();
				pbreplyVO.setReplyId(rs.getInt("reply_id"));
				pbreplyVO.setPostId(rs.getInt("post_id"));
				pbreplyVO.setMemberId(rs.getInt("member_id"));
				pbreplyVO.setReplyCont(rs.getString("reply_cont"));
				pbreplyVO.setReplyTime(rs.getTimestamp("reply_time"));
				
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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
		return pbreplyVO;
	}
	@Override
	public List<pbReplyVO> getAll() {
		List<pbReplyVO> list = new ArrayList<pbReplyVO>();
		pbReplyVO pbreplyVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				
				pbreplyVO = new pbReplyVO();
				pbreplyVO.setReplyId(rs.getInt("reply_id"));
				pbreplyVO.setPostId(rs.getInt("post_id"));
				pbreplyVO.setMemberId(rs.getInt("member_id"));
				pbreplyVO.setReplyCont(rs.getString("reply_cont"));
				pbreplyVO.setReplyTime(rs.getTimestamp("reply_time"));
				list.add(pbreplyVO); // Store the row in the list
			}

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. "
					+ e.getMessage());
			// Handle any SQL errors
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

		pbReplyJDBCDAO dao = new pbReplyJDBCDAO();
		long time = System.currentTimeMillis();
		Timestamp timestamp = new Timestamp(time);

		// 新增--ok
//		pbReplyVO pbreplyVO1 = new pbReplyVO();
//		pbreplyVO1.setReplyId(505);
//		pbreplyVO1.setPostId(3);
//		pbreplyVO1.setMemberId(5);
//		pbreplyVO1.setReplyCont("test2");
//		pbreplyVO1.setReplyTime(timestamp);
//		dao.insert(pbreplyVO1);

//		// 修改--ok
//		pbReplyVO pbreplyVO2 = new pb_replyVO();
//		pbreplyVO2.setReplyId(4);
//		pbreplyVO2.setPostId(1);
//		pbreplyVO2.setMemberId(5);
//		pbreplyVO2.setReplyCont("test2");
//		pbreplyVO2.setReplyTime(timestamp);
//		dao.insert(pbreplyVO2);
	
//
//		// 刪除--ok
//		dao.delete(4);
//
//		// 查詢--ok
//		pbReplyVO pbreplyVO3 = new pbReplyVO();
//		pbreplyVO3.setReplyId(1);
//		pbreplyVO3.setPostId(1);
//		pbreplyVO3.setMemberId(1);
//		pbreplyVO3.setReplyCont("test");
//		pbreplyVO3.setReplyTime(timestamp);
//		dao.findByPrimaryKey(1);
//		System.out.print(pbreplyVO3.getReplyId() + ",");
//		System.out.print(pbreplyVO3.getPostId() + ",");
//		System.out.print(pbreplyVO3.getMemberId() + ",");
//		System.out.print(pbreplyVO3.getReplyCont() + ",");
//		System.out.print(pbreplyVO3.getReplyTime() + ",");

//
//		// 查詢--ok
		List<pbReplyVO> list = dao.getAll();
		for (pbReplyVO pbReply : list) {
			System.out.print(pbReply.getReplyId() + ",");
			System.out.print(pbReply.getPostId() + ",");
			System.out.print(pbReply.getMemberId() + ",");
			System.out.print(pbReply.getReplyCont() + ",");
			System.out.print(pbReply.getReplyTime() + ",");
			System.out.println();
		}
	}
	
	
	
	
	


}
