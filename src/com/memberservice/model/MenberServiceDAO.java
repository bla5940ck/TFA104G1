package com.memberservice.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class MenberServiceDAO implements MenberServiceDAO_interface {
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	public static final String USER = "root";
	public static final String PASSWORD = "password";

	private static final String INSERT_STMT = 
			"INSERT INTO member_service (prod_id,member_id,manager_id,type_id,ord_id,msg_date,problem_msg,msg_res,pic_1,pic_2,pic_3,problem_status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT msg_id,prod_id,member_id,manager_id,type_id,ord_id,msg_date,problem_msg,msg_res,pic_1,pic_2,pic_3,problem_status FROM member_service order by msg_id";
	private static final String GET_ONE_STMT = 
			"SELECT msg_id,prod_id,member_id,manager_id,type_id,ord_id,msg_date,problem_msg,msg_res,pic_1,pic_2,pic_3,problem_status FROM member_service where msg_id = ?  ";
	private static final String DELETE = 
			"DELETE FROM member_service where msg_id =? ";
	private static final String UPDATE = 
			"UPDATE member_service set prod_id=?,member_id=?,manager_id=?,type_id=?,ord_id=?,msg_date=?,problem_msg=?,msg_res=?,pic_1=?,pic_2=?,pic_3=?,problem_status=? where msg_id=?";

	@Override
	public void insert(MenberServiceVO manberServiceVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
//			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, manberServiceVO.getProdID());
			pstmt.setInt(2, manberServiceVO.getMemberID());
			pstmt.setInt(3, manberServiceVO.getManagerID());
			pstmt.setInt(4, manberServiceVO.getTypeID());
			pstmt.setInt(5, manberServiceVO.getOrdID());
			pstmt.setTimestamp(6, manberServiceVO.getMsgDate());
			pstmt.setString(7, manberServiceVO.getProblemMsg());
			pstmt.setString(8, manberServiceVO.getMsgRes());
			pstmt.setBytes(9, manberServiceVO.getPic1());
			pstmt.setBytes(10, manberServiceVO.getPic2());
			pstmt.setBytes(11, manberServiceVO.getPic3());
			pstmt.setInt(12, manberServiceVO.getProblemStatus());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();

				} catch (Exception se) {
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
	public void update(MenberServiceVO manberServiceVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, manberServiceVO.getProdID());
			pstmt.setInt(2, manberServiceVO.getMemberID());
			pstmt.setInt(3, manberServiceVO.getManagerID());
			pstmt.setInt(4, manberServiceVO.getTypeID());
			pstmt.setInt(5, manberServiceVO.getOrdID());
			pstmt.setTimestamp(6, manberServiceVO.getMsgDate());
			pstmt.setString(7, manberServiceVO.getProblemMsg());
			pstmt.setString(8, manberServiceVO.getMsgRes());
			pstmt.setBytes(9, manberServiceVO.getPic1());
			pstmt.setBytes(10, manberServiceVO.getPic2());
			pstmt.setBytes(11, manberServiceVO.getPic3());
			pstmt.setInt(12, manberServiceVO.getProblemStatus());
			pstmt.setInt(13, manberServiceVO.getMsgID());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();

				} catch (Exception se) {
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
	public void delete(Integer msgID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
		
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE);
			pstmt.setInt(1, msgID);
			int executeUpdate = pstmt.executeUpdate();
			System.out.println(executeUpdate);
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();

				} catch (Exception se) {
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
	public MenberServiceVO findByprimaryKey(Integer msgID) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		MenberServiceVO msvo = null;
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(GET_ONE_STMT);
			
			ps.setInt(1, msgID);
			
			rs = ps.executeQuery();
			
			if (rs.next()) {
				
				msvo = new MenberServiceVO();
				msvo.setMsgID(rs.getInt("msg_id"));
				msvo.setProdID(rs.getInt("prod_id"));
				msvo.setMemberID(rs.getInt("member_id"));
				msvo.setManagerID(rs.getInt("manager_id"));
				msvo.setTypeID(rs.getInt("type_id"));
				msvo.setOrdID(rs.getInt("ord_id"));
				msvo.setMsgDate(rs.getTimestamp("msg_date"));
				msvo.setProblemMsg(rs.getString("problem_msg"));
				msvo.setMsgRes(rs.getString("msg_res"));
				msvo.setPic1(rs.getBytes("pic_1"));
				msvo.setPic2(rs.getBytes("pic_2"));
				msvo.setPic3(rs.getBytes("pic_3"));
				msvo.setProblemStatus(rs.getInt("problem_status"));

			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception se) {
					se.printStackTrace(System.err);
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (Exception se) {
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
		return msvo;
	}

	@Override
	public List<MenberServiceVO> getAll() {
		List<MenberServiceVO> li = new ArrayList<>();
		MenberServiceVO msvo = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(GET_ALL_STMT);

			rs = ps.executeQuery();
			while (rs.next()) {
				msvo = new MenberServiceVO();
				msvo.setMsgID(rs.getInt("msg_id"));
				msvo.setProdID(rs.getInt("prod_ID"));
				msvo.setMemberID(rs.getInt("member_ID"));
				msvo.setManagerID(rs.getInt("manager_ID"));
				msvo.setTypeID(rs.getInt("type_ID"));
				msvo.setOrdID(rs.getInt("ord_ID"));
				msvo.setMsgDate(rs.getTimestamp("msg_Date"));
				msvo.setProblemMsg(rs.getString("problem_Msg"));
				msvo.setMsgRes(rs.getString("msg_Res"));
//				msvo.setPic1(rs.getBytes("pic_1"));
				msvo.setPic2(rs.getBytes("pic_2"));
				msvo.setPic3(rs.getBytes("pic_3"));
				msvo.setProblemStatus(rs.getInt("problem_Status"));
				li.add(msvo);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} catch (Exception se) {
			throw new RuntimeException("A database error occured." + se.getMessage());
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (Exception se) {
					se.printStackTrace(System.err);
				}
			}

			if (ps != null) {
				try {
					ps.close();
				} catch (Exception se) {
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

		return li;
	}

	public static void main(String[] args) throws Exception {

		MenberServiceDAO dao = new MenberServiceDAO();

		// 新增
		MenberServiceVO msvo1 = new MenberServiceVO();

		long datetime = System.currentTimeMillis();
		Timestamp timestamp = new Timestamp(datetime);
//		System.out.println(timestamp);
		
		msvo1.setMsgID(2);
		msvo1.setProdID(2);
		msvo1.setMemberID(1);
		msvo1.setManagerID(1);
		msvo1.setTypeID(3);
		msvo1.setOrdID(2);
		msvo1.setMsgDate(timestamp);
		msvo1.setProblemMsg("123");
		msvo1.setMsgRes("321");
		msvo1.setPic1(null);
		msvo1.setPic2(null);
		msvo1.setPic3(null);
		msvo1.setProblemStatus(2);
//		dao.insert(msvo1);
		
		
		
		
		// 修改
		MenberServiceVO msvo2 = new MenberServiceVO();
		msvo2.setProdID(2);
		msvo2.setMemberID(1);
		msvo2.setManagerID(1);
		msvo2.setTypeID(3);
		msvo2.setOrdID(2);
		msvo2.setMsgDate(timestamp);
		msvo2.setProblemMsg("123");
		msvo2.setMsgRes("321");
		msvo2.setPic1(null);
		msvo2.setPic2(null);
		msvo2.setPic3(null);
		msvo2.setProblemStatus(2);
//		dao.update(msvo2);
		
		
		// 刪除
//		dao.delete(7017);


		// 單筆查詢
//		MenberServiceVO msvo3 = dao.findByprimaryKey(5);
//		System.out.println(msvo3);
//		System.out.print(msvo3.getMsgID() + ",");
//		System.out.print(msvo3.getProdID() + ",");
//		System.out.print(msvo3.getMemberID() + ",");
//		System.out.print(msvo3.getTypeID() + ",");
//		System.out.print(msvo3.getOrdID() + ",");
//		System.out.print(msvo3.getMsgDate() + ",");
//		System.out.print(msvo3.getProblemMsg());
//		System.out.print(msvo3.getMsgRes());
//		System.out.print(msvo3.getPic1());
//		System.out.print(msvo3.getPic2());
//		System.out.print(msvo3.getPic3());
//		System.out.print(msvo3.getProblemStatus());
//		System.out.println("---------------------");
	
		// 全部查詢
		List<MenberServiceVO> list = dao.getAll();
		for(MenberServiceVO msvo4:list) {
			System.out.print(msvo4.getMsgID() + ",");
			System.out.print(msvo4.getProdID() + ",");
			System.out.print(msvo4.getMemberID() + ",");
			System.out.print(msvo4.getTypeID() + ",");
			System.out.print(msvo4.getOrdID() + ",");
			System.out.print(msvo4.getMsgDate() + ",");
			System.out.print(msvo4.getProblemMsg());
			System.out.print(msvo4.getMsgRes());
			System.out.print(msvo4.getPic1());
			System.out.print(msvo4.getPic2());
			System.out.print(msvo4.getPic3());
			System.out.print(msvo4.getProblemStatus());
			System.out.println();
		}

//		for(int i=0;i<list.size();i++) {
//			System.out.println(list.get(i));
//		}
	}

}
