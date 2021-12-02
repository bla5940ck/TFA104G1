package com.post_borad.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;



public class PostBoradDAO implements PostBoradDAOInterface {
	
		private static DataSource ds = null;
		static {
			try {
				Context ctx = new InitialContext();
				ds = (DataSource) ctx.lookup("java:comp/env/jdbc/root");
			} catch (NamingException e) {
				e.printStackTrace();
			}
		}
	
		private static final String INSERT_STMT = 
			"INSERT INTO post_borad (post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic) VALUES (?, ?, ?, ?, ?, ?,?,?)";
		private static final String GET_ALL_STMT = 
			"SELECT post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic FROM post_borad order by post_id";
		private static final String GET_ONE_STMT = 
			"SELECT post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic FROM post_borad where post_id = ?";
		private static final String DELETE = 
			"DELETE FROM post_borad where post_id = ?";
		private static final String UPDATE = 
			"UPDATE post_borad set post_id=?, category_id=?, member_id=?, post_title=?, post_cont=?, post_time=?,reply_count=?,pic=? where post_id = ?";
			
			
			@Override
			public void insert(PostBoradVO postboradVO) {
				
				Connection con = null;
				PreparedStatement pstmt = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(INSERT_STMT);

					pstmt.setInt(1, postboradVO.getPostId());
					pstmt.setInt(2, postboradVO.getCategoryId());
					pstmt.setInt(3,  postboradVO.getMemberId());
					pstmt.setString(4, postboradVO.getPostTitle());
					pstmt.setString(5, postboradVO.getPostCont());
					pstmt.setTimestamp(6, postboradVO.getPostTime());
					pstmt.setInt(7, postboradVO.getReplyCount());
					pstmt.setBytes(8, postboradVO.getPic());
					

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
			public void update(PostBoradVO postboradVO) {
				Connection con = null;
				PreparedStatement pstmt = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(UPDATE);

					pstmt.setInt(1, postboradVO.getPostId());
					pstmt.setInt(2, postboradVO.getCategoryId());
					pstmt.setInt(3,  postboradVO.getMemberId());
					pstmt.setString(4, postboradVO.getPostTitle());
					pstmt.setString(5, postboradVO.getPostCont());
					pstmt.setTimestamp(6,  postboradVO.getPostTime());
					pstmt.setInt(7,  postboradVO.getReplyCount());
					pstmt.setBytes(8, postboradVO.getPic());

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
			public void delete(Integer postId) {
				Connection con = null;
				PreparedStatement pstmt = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(DELETE);

					pstmt.setInt(1, postId);

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
			public PostBoradVO findByPrimaryKey(Integer postId) {
				PostBoradVO postboradVO = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(GET_ONE_STMT);

					pstmt.setInt(1, postId);

					rs = pstmt.executeQuery();

					while (rs.next()) {
						postboradVO = new PostBoradVO();
						postboradVO.setPostId(rs.getInt("post_id"));
						postboradVO.setCategoryId(rs.getInt("category_id"));
						postboradVO.setMemberId(rs.getInt("member_id"));
						postboradVO.setPostTitle(rs.getString("post_title"));
						postboradVO.setPostCont(rs.getString("post_cont"));
						postboradVO.setPostTime(rs.getTimestamp("post_time"));
						postboradVO.setReplyCount(rs.getInt("reply_count"));
						postboradVO.setPic(rs.getBytes("pic"));
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
				return postboradVO;
				
			}
			@Override
			public List<PostBoradVO> getAll() {
				
				List<PostBoradVO> list = new ArrayList<PostBoradVO>();
				PostBoradVO postboradVO = null;

				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {

					con = ds.getConnection();
					pstmt = con.prepareStatement(GET_ALL_STMT);
					rs = pstmt.executeQuery();

					while (rs.next()) {
						postboradVO = new PostBoradVO();
						postboradVO.setPostId(rs.getInt("post_id"));
						postboradVO.setCategoryId(rs.getInt("category_id"));
						postboradVO.setMemberId(rs.getInt("member_id"));
						postboradVO.setPostTitle(rs.getString("post_title"));
						postboradVO.setPostCont(rs.getString("post_cont"));
						postboradVO.setPostTime(rs.getTimestamp("post_time"));
						postboradVO.setReplyCount(rs.getInt("reply_count"));
						postboradVO.setPic(rs.getBytes("pic"));
						list.add(postboradVO); // Store the row in the list
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
