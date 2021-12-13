package com.chatroom.model;

import java.util.*;
import java.sql.*;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class ChatroomDAO implements ChatroomDAOImpl {
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
			"INSERT INTO chat_room (chat_room_No,rent_id,lease_id,chat_No,chat_text,chat_time) VALUES (?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT chat_room_No,rent_id,lease_id,chat_No,chat_text,chat_time FROM chat_room order by chat_room_No";
		private static final String GET_ONE_STMT = 
			"SELECT chat_room_No,rent_id,lease_id,chat_No,chat_text,chat_time FROM chat_room where chat_room_No = ?";
		private static final String DELETE = 
			"DELETE FROM chat_room where chat_room_No = ?";
		private static final String UPDATE = 
			"UPDATE chat_room set chat_room_No=?, rent_id=?, lease_id=?, chat_No=?, chat_text=?, chat_time=? where chat_room_No = ?";

		
		public void insert(ChatroomVO chatroomVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(INSERT_STMT);

				pstmt.setInt(1, chatroomVO.getChatNo());
				pstmt.setInt(2, chatroomVO.getRentId());
				pstmt.setInt(3, chatroomVO.getLeaseId());
				pstmt.setInt(4, chatroomVO.getChatNo());
				pstmt.setString(5, chatroomVO.getChatText());
				pstmt.setTimestamp(6, chatroomVO.getChatTime());

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
		public void update(ChatroomVO chatroomVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setInt(1, chatroomVO.getChatroomNo());
				pstmt.setInt(2, chatroomVO.getRentId());
				pstmt.setInt(3, chatroomVO.getLeaseId());
				pstmt.setInt(4, chatroomVO.getChatNo());
				pstmt.setString(5, chatroomVO.getChatText());
				pstmt.setTimestamp(6, chatroomVO.getChatTime());

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
		public void delete(Integer chatRoomNo) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(DELETE);

				pstmt.setInt(1, chatRoomNo);

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
		public ChatroomVO findByPrimaryKey(Integer leaseId) {
			ChatroomVO chatroomVO = null;
			Connection con = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ONE_STMT);

				pstmt.setInt(1, leaseId);

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

				con = ds.getConnection();
				pstmt = con.prepareStatement(GET_ALL_STMT);
				rs = pstmt.executeQuery();

				while (rs.next()) {
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
