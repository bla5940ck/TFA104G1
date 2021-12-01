package com.post_borad.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostBoradJDBCDAO implements PostBoradDAOInterface {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "password";

	private static final String INSERT_STMT = 
			"INSERT INTO post_borad (post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic) VALUES (?, ?, ?, ?, ?, ?, ?)";
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, postboradVO.getPostId());
			pstmt.setInt(2, postboradVO.getCategoryId());
			pstmt.setInt(3, postboradVO.getMemberId());
			pstmt.setString(4, postboradVO.getPostTitle());
			pstmt.setString(5, postboradVO.getPostCont());
			pstmt.setTimestamp(6, postboradVO.getPostTime());
			pstmt.setInt(7, postboradVO.getReplyCount());
			pstmt.setBytes(8, postboradVO.getPic());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, postboradVO.getPostId());
			pstmt.setInt(2, postboradVO.getCategoryId());
			pstmt.setInt(3, postboradVO.getMemberId());
			pstmt.setString(4, postboradVO.getPostTitle());
			pstmt.setString(5, postboradVO.getPostCont());
			pstmt.setTimestamp(6, postboradVO.getPostTime());
			pstmt.setInt(7, postboradVO.getReplyCount());
			pstmt.setBytes(8, postboradVO.getPic());

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, postId);

			pstmt.executeUpdate();

			// Handle any driver errors
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
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
		} catch (ClassNotFoundException e) {
			throw new RuntimeException("Couldn't load database driver. " + e.getMessage());
			// Handle any SQL errors
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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

		PostBoradJDBCDAO dao = new PostBoradJDBCDAO();
		long time = System.currentTimeMillis();
		Timestamp timestamp = new Timestamp(time);

		// 新增--ok
//		postboradVO postboradVO1 = new postboradVO();
//		postboradVO1.setPostId(5);
//		postboradVO1.setCategoryId(1);
//		postboradVO1.setMemberId(1);
//		postboradVO1.setPostTitle("test");
//		postboradVO1.setPostCont("test");
//		postboradVO1.setPostTime(timestamp);
//		postboradVO1.setReplyCount(0);
//		postboradVO1.setPic(null);
//		dao.insert(postboradVO1);

//		// 修改--ok
//		postboradVO postboradVO2 = new postboradVO();
//		postboradVO2.setPostId(6);
//		postboradVO2.setCategoryId(1);
//		postboradVO2.setMemberId(1);
//		postboradVO2.setPostTitle("test");
//		postboradVO2.setPostCont("test2");
//		postboradVO2.setPostTime(timestamp);
//		postboradVO2.setReplyCount(0);
//		postboradVO2.setPic(null);
//		dao.insert(postboradVO2);
//
//		// 刪除--ok
//		dao.delete(6);
//
//		// 查詢--ok
//		postboradVO postboradVO3 = new postboradVO();
//		postboradVO3.setPostId(1);
//		postboradVO3.setCategoryId(1);
//		postboradVO3.setMemberId(1);
//		postboradVO3.setPostTitle("test");
//		postboradVO3.setPostTime(timestamp);
//		postboradVO3.setReplyCount(1);
//		postboradVO3.setPic(null);
//		dao.findByPrimaryKey(1);
//		System.out.print(postboradVO3.getPostId() + ",");
//		System.out.print(postboradVO3.getCategoryId()+ ",");
//		System.out.print(postboradVO3.getMemberId()+ ",");
//		System.out.print(postboradVO3.getPostTitle()+ ",");
//		System.out.print(postboradVO3.getPostCont()+ ",");
//		System.out.print(postboradVO3.getPostTime()+ ",");
//		System.out.print(postboradVO3.getReplyCount()+ ",");
//		System.out.print(postboradVO3.getPic()+ ",");

//		// 查詢--ok
		List<PostBoradVO> list = dao.getAll();
		for (PostBoradVO pPost : list) {
			System.out.print(pPost.getPostId() + ",");
			System.out.print(pPost.getCategoryId() + ",");
			System.out.print(pPost.getMemberId() + ",");
			System.out.print(pPost.getPostTitle() + ",");
			System.out.print(pPost.getPostCont() + ",");
			System.out.print(pPost.getPostTime() + ",");
			System.out.print(pPost.getReplyCount() + ",");
			System.out.print(pPost.getPic()+ ",");
			System.out.println();
		}
	}

}
