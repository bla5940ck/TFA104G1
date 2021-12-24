package com.pbreply.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class pbReplyDAO implements pbReplyDAOIpml {
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
				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);
				
				
				pstmt.setInt(1, pbreplyVO.getPostId());
				pstmt.setInt(2, pbreplyVO.getMemberId());
				pstmt.setString(3, pbreplyVO.getReplyCont());
				pstmt.setTimestamp(4, pbreplyVO.getReplyTime());
				
				pstmt.executeUpdate();

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

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);

				
				pstmt.setInt(1, pbreplyVO.getMemberId());
				pstmt.setString(2, pbreplyVO.getReplyCont());
				pstmt.setTimestamp(3, pbreplyVO.getReplyTime());
				pstmt.setInt(4, pbreplyVO.getReplyId());

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
		public void delete(Integer replyId) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);

				pstmt.setInt(1, replyId);

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
		public pbReplyVO findByPrimaryKey(Integer replyId) {
			pbReplyVO pbreplyVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
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

				con = ds.getConnection();
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

		
	
	
	
	

}
