package com.postboard.model;

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



public class PostBoardDAO implements PostBoardDAOImpl {
		String url = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
		String userid = "root";
		String passwd = "password";

	
		private static final String INSERT_STMT = 
				"INSERT INTO post_board (category_id,member_id,post_title,post_cont,post_time,pic) VALUES (?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
				"SELECT * FROM post_board order by post_id";
		private static final String GET_ONE_STMT = 
				"SELECT post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic FROM post_board where post_id = ?";
		private static final String DELETE = 
				"DELETE FROM post_board where post_id = ?";
		private static final String UPDATE = 
				"UPDATE post_board set category_id=?, member_id=?, post_title=? ,post_cont=? ,post_time=? ,pic=? where post_id = ?";
			
			
			@Override
			public void insert(PostBoardVO postboardVO) {
				
				Connection con = null;
				PreparedStatement pstmt = null;

				try {
					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(INSERT_STMT);

					pstmt.setInt(1, postboardVO.getCategoryId());
					pstmt.setInt(2, postboardVO.getMemberId());
					pstmt.setString(3, postboardVO.getPostTitle());
					pstmt.setString(4, postboardVO.getPostCont());
					pstmt.setTimestamp(5, postboardVO.getPostTime());
					pstmt.setBytes(6, postboardVO.getPic());

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
			public void update(PostBoardVO postboardVO) {
				Connection con = null;
				PreparedStatement pstmt = null;

				try {

					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(UPDATE);

					pstmt.setInt(1, postboardVO.getCategoryId());
					pstmt.setInt(2, postboardVO.getMemberId());
					pstmt.setString(3, postboardVO.getPostTitle());
					pstmt.setString(4, postboardVO.getPostCont());
					pstmt.setTimestamp(5, postboardVO.getPostTime());
//					pstmt.setInt(6, postboardVO.getReplyCount());
					pstmt.setBytes(6, postboardVO.getPic());
					pstmt.setInt(7, postboardVO.getPostId());

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

					con = DriverManager.getConnection(url, userid, passwd);
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
			public PostBoardVO findByPrimaryKey(Integer postId) {
				PostBoardVO postboardVO = null;
				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {

					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(GET_ONE_STMT);

					pstmt.setInt(1, postId);

					rs = pstmt.executeQuery();

					while (rs.next()) {
						postboardVO = new PostBoardVO();
						postboardVO.setPostId(rs.getInt("post_id"));
						postboardVO.setCategoryId(rs.getInt("category_id"));
						postboardVO.setMemberId(rs.getInt("member_id"));
						postboardVO.setPostTitle(rs.getString("post_title"));
						postboardVO.setPostCont(rs.getString("post_cont"));
						postboardVO.setPostTime(rs.getTimestamp("post_time"));
						postboardVO.setReplyCount(rs.getInt("reply_count"));
						postboardVO.setPic(rs.getBytes("pic"));
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
				return postboardVO;
				
			}
			@Override
			public List<PostBoardVO> getAll() {
				
				List<PostBoardVO> list = new ArrayList<PostBoardVO>();
				PostBoardVO postboardVO = null;

				Connection con = null;
				PreparedStatement pstmt = null;
				ResultSet rs = null;

				try {

					con = DriverManager.getConnection(url, userid, passwd);
					pstmt = con.prepareStatement(GET_ALL_STMT);
					rs = pstmt.executeQuery();
// post_id, category_id, member_id, post_title, post_cont, post_time, reply_count, pic
					while (rs.next()) {
						postboardVO = new PostBoardVO();
						postboardVO.setPostId(rs.getInt("post_id"));
						postboardVO.setCategoryId(rs.getInt("category_id"));
						postboardVO.setMemberId(rs.getInt("member_id"));
						postboardVO.setPostTitle(rs.getString("post_title"));
						postboardVO.setPostCont(rs.getString("post_cont"));
						postboardVO.setPostTime(rs.getTimestamp("post_time"));
						postboardVO.setReplyCount(rs.getInt("reply_count"));
						postboardVO.setPic(rs.getBytes("pic"));
						list.add(postboardVO); // Store the row in the list
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
