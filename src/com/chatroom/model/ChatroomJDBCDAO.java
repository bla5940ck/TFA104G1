package com.chatroom.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;
import java.sql.Timestamp;

public class ChatroomJDBCDAO implements ChatroomDAOIpml {
	String driver = "com.mysql.cj.jdbc.Driver";
	String url = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	String userid = "root";
	String passwd = "password";
	
	private static final String INSERT_STMT = 
		"INSERT INTO chat_room (chat_room_No,rent_id,lease_id,chat_No,chat_text,chat_time) VALUES (?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT chat_room_No,rent_id,lease_id,chat_No,chat_text,chat_time FROM chat_room order by chat_room_No";
	private static final String GET_ONE_STMT = 
		"SELECT chat_room_No,rent_id,lease_id,chat_No,chat_text,chat_time FROM chat_room where chat_room_No = ?";
	private static final String DELETE = 
		"DELETE FROM chat_room where chat_room_No = ?";
	private static final String UPDATE = 
		"UPDATE chat_room set rent_id=?, lease_id=?, chat_No=?, chat_text=?, chat_time=? where chat_room_No = ?";
	
	@Override
	public void insert(ChatroomVO chatroomVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(INSERT_STMT);

				pstmt.setInt(1, chatroomVO.getChatroomNo());
				pstmt.setInt(2, chatroomVO.getRentId());
				pstmt.setInt(3, chatroomVO.getLeaseId());
				pstmt.setInt(4, chatroomVO.getChatNo());
				pstmt.setString(5, chatroomVO.getChatText());
				pstmt.setTimestamp(6, chatroomVO.getChatTime());

				pstmt.executeUpdate();
			
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
	public void update(ChatroomVO chatroomVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, chatroomVO.getRentId());
			pstmt.setInt(2, chatroomVO.getLeaseId());
			pstmt.setInt(3, chatroomVO.getChatNo());
			pstmt.setString(4, chatroomVO.getChatText());
			pstmt.setTimestamp(5, chatroomVO.getChatTime());

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
	public void delete(Integer chatroomNo) {
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(DELETE);

			pstmt.setInt(1, chatroomNo);

			pstmt.executeUpdate();
			//執行

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
	public ChatroomVO findByPrimaryKey(Integer chatroomNo) {
		ChatroomVO chatroomVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			Class.forName(driver);
			con = DriverManager.getConnection(url, userid, passwd);
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setInt(1, chatroomNo);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				chatroomVO = new ChatroomVO();
				chatroomVO.setChatroomNo(rs.getInt("chat_room_No"));
				chatroomVO.setRentId(rs.getInt("rent_id"));
				chatroomVO.setLeaseId(rs.getInt("lease_id"));
				chatroomVO.setChatNo(rs.getInt("chat_No"));
				chatroomVO.setChatText(rs.getString("chat_text"));
				chatroomVO.setChatTime(rs.getTimestamp("Chat_time"));
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
		return chatroomVO;
	}
	
	@Override
	public List<ChatroomVO> getAll() {
		List<ChatroomVO> list = new ArrayList<ChatroomVO>();
		ChatroomVO chatroomVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
				Class.forName(driver);
				con = DriverManager.getConnection(url, userid, passwd);
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

			while (rs.next()) {
				// empVO 也稱為 Domain objects
				chatroomVO = new ChatroomVO();
				chatroomVO.setChatroomNo(rs.getInt("chat_room_No"));
				chatroomVO.setRentId(rs.getInt("rent_id"));
				chatroomVO.setLeaseId(rs.getInt("lease_id"));
				chatroomVO.setChatNo(rs.getInt("chat_No"));
				chatroomVO.setChatText(rs.getString("chat_text"));
				chatroomVO.setChatTime(rs.getTimestamp("chat_time"));
				list.add(chatroomVO); 
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
		
		ChatroomJDBCDAO dao = new ChatroomJDBCDAO();

		long time = System.currentTimeMillis();
		Timestamp timestamp = new Timestamp(time);
		
		// 新增--ok
//		ChatroomVO chatVO1 = new ChatroomVO();
//		chatVO1.setChatroomNo(4);
//		chatVO1.setRentId(1);
//		chatVO1.setLeaseId(1);
//		chatVO1.setChatNo(4);
//		chatVO1.setChatText("test");
//		chatVO1.setChatTime(timestamp);
//		dao.insert(chatVO1);

//		// 修改--ok
//		ChatroomVO chatVO2 = new ChatroomVO();
//		chatVO2.setChatroomNo(5);
//		chatVO2.setRentId(1);
//		chatVO2.setLeaseId(1);
//		chatVO2.setChatNo(4);
//		chatVO2.setChatText("test2");
//		chatVO2.setChatTime(timestamp);
//		dao.insert(chatVO2);

//		// 刪除--ok
//		dao.delete(5);
//
////	// 查詢--ok
//		ChatroomVO chatVO4 = new ChatroomVO();
//		chatVO4.setChatroomNo(2);
//		chatVO4.setRentId(1);
//		chatVO4.setLeaseId(1);
//		chatVO4.setChatNo(2);
//		chatVO4.setChatText("test");
//		chatVO4.setChatTime(timestamp);
//		dao.findByPrimaryKey(2);
//		System.out.println(chatVO4.getChatroomNo());
//
//		// 查詢--ok
//		List<ChatroomVO> list = dao.getAll();
//		for (ChatroomVO cChat : list) {
//		System.out.print(cChat.getChatroomNo() + ",");
//		System.out.print(cChat.getRentId() + ",");
//		System.out.print(cChat.getLeaseId() + ",");
//		System.out.print(cChat.getChatNo() + ",");
//		System.out.print(cChat.getChatText() + ",");
//		System.out.print(cChat.getChatTime() + ",");
//		System.out.println();
//		}
	}
}

	
	
	


