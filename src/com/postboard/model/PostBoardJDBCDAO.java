package com.postboard.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class PostBoardJDBCDAO implements PostBoardDAOImpl {

	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "password";

	private static final String INSERT_STMT = 
			"INSERT INTO post_board (category_id,member_id,post_title,post_cont,post_time,pic) VALUES (?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic FROM post_board order by post_id";
	private static final String GET_ONE_STMT = 
			"SELECT post_id,category_id,member_id,post_title,post_cont,post_time,reply_count,pic FROM post_board where post_id = ?";
	private static final String DELETE = 
			"DELETE FROM post_board where post_id = ?";
	private static final String UPDATE = 
			"UPDATE post_board set category_id=?, member_id=?, post_title=? ,post_cont=? ,post_time=? ,reply_count=? ,pic=? where post_id = ?";

	@Override
	public void insert(PostBoardVO postboardVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(INSERT_STMT);

			
			pstmt.setInt(1, postboardVO.getCategoryId());
			pstmt.setInt(2, postboardVO.getMemberId());
			pstmt.setString(3, postboardVO.getPostTitle());
			pstmt.setString(4, postboardVO.getPostCont());
			pstmt.setTimestamp(5, postboardVO.getPostTime());
			pstmt.setBytes(6, postboardVO.getPic());

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
	public void update(PostBoardVO postboardVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			
			pstmt.setInt(1, postboardVO.getCategoryId());
			pstmt.setInt(2, postboardVO.getMemberId());
			pstmt.setString(3, postboardVO.getPostTitle());
			pstmt.setString(4, postboardVO.getPostCont());
			pstmt.setTimestamp(5, postboardVO.getPostTime());
			pstmt.setInt(6, postboardVO.getReplyCount());
			pstmt.setBytes(7, postboardVO.getPic());
			pstmt.setInt(8, postboardVO.getPostId());

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
	public PostBoardVO findByPrimaryKey(Integer postId) {
		PostBoardVO postboardVO = null;
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

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ALL_STMT);
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
				list.add(postboardVO); // Store the row in the list

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

		PostBoardJDBCDAO dao = new PostBoardJDBCDAO();
		long time = System.currentTimeMillis();
		Timestamp timestamp = new Timestamp(time);

		// 新增--ok
//		PostBoardVO postboardVO1 = new PostBoardVO();
//		postboardVO1.setCategoryId(6);
//		postboardVO1.setMemberId(1);
//		postboardVO1.setPostTitle("test");
//		postboardVO1.setPostCont("test1206");
//		postboardVO1.setPostTime(timestamp);
//		postboardVO1.setReplyCount(0);
//		postboardVO1.setPic(null);
//		dao.insert(postboardVO1);

//		// 修改--ok
//		PostBoardVO postboardVO2 = new PostBoardVO();
//		postboardVO2.setPostId(109);
//		postboardVO2.setCategoryId(1);
//		postboardVO2.setMemberId(1);
//		postboardVO2.setPostTitle("test");
//		postboardVO2.setPostCont("test1test");
//		postboardVO2.setPostTime(timestamp);
//		postboardVO2.setReplyCount(0);
//		postboardVO2.setPic(null);
//		dao.update(postboardVO2);
//
//		// 刪除--ok
//		dao.delete(109);
//
//		// 查詢--ok
//		PostBoardVO postboardVO3 = new PostBoardVO();
//		postboardVO3.setPostId(113);
//		postboardVO3.setCategoryId(1);
//		postboardVO3.setMemberId(1);
//		postboardVO3.setPostTitle("test");
//		postboardVO3.setPostTime(timestamp);
//		postboardVO3.setReplyCount(1);
//		postboardVO3.setPic(null);
//		dao.findByPrimaryKey(1);
//		System.out.print(postboardVO3.getPostId() + ",");
//		System.out.print(postboardVO3.getCategoryId()+ ",");
//		System.out.print(postboardVO3.getMemberId()+ ",");
//		System.out.print(postboardVO3.getPostTitle()+ ",");
//		System.out.print(postboardVO3.getPostCont()+ ",");
//		System.out.print(postboardVO3.getPostTime()+ ",");
//		System.out.print(postboardVO3.getReplyCount()+ ",");
//		System.out.print(postboardVO3.getPic()+ ",");

//		// 查詢--ok
//		List<PostBoardVO> list = dao.getAll();
//		for (PostBoardVO pPost : list) {
//			System.out.print(pPost.getPostId() + ",");
//			System.out.print(pPost.getCategoryId() + ",");
//			System.out.print(pPost.getMemberId() + ",");
//			System.out.print(pPost.getPostTitle() + ",");
//			System.out.print(pPost.getPostCont() + ",");
//			System.out.print(pPost.getPostTime() + ",");
//			System.out.print(pPost.getReplyCount() + ",");
//			System.out.print(pPost.getPic()+ ",");
//			System.out.println();
//		}
	}

}
