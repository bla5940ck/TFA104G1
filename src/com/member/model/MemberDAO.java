package com.member.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class MemberDAO implements MemberDAO_interface {

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
			"INSERT INTO member (bank_code, email,login_id,idcn,phone_num,password,status,	name,	nickname,	"
			+ "birthday,	address,	bank_account,	account_name,	rent_score,	lease_score,	creat_date,	pic,	idc_f,	idc_b,	foul) "
			+ "VALUES (?, ?, ?, ?, ?, ?,?,?, ?, ?, ?, ?, ?,?,?, ?, ?, ?, ?, ?)";
		private static final String GET_ALL_STMT = 
			"SELECT member_id,bank_code, email,login_id,idcn,phone_num,password,status,	name,	nickname,"
			+"birthday,	address,	bank_account,	account_name,	rent_score,	lease_score,	creat_date,	pic,	idc_f,	idc_b,	foul "
			+ "FROM member";
		private static final String GET_ONE_STMT = 
			"SELECT member_id,bank_code, email,login_id,idcn,phone_num,password,status,	name,	nickname,"
			+ "birthday,	address,	bank_account,	account_name,	rent_score,	lease_score,	creat_date,	pic,	idc_f,	idc_b,	foul  "
			+ "FROM JoyLease.member where member_id = ?";
		private static final String GET_LOGIN_STMT = 
				"SELECT member_id,bank_code, email,login_id,idcn,phone_num,password,status,	name,	nickname,"
				+ "birthday,	address,	bank_account,	account_name,	rent_score,	lease_score,	creat_date,	pic,	idc_f,	idc_b,	foul  "
				+ "FROM member where login_id = ?";
		private static final String LOGIN = 
				"SELECT login_id,password FROM member where login_id = ? and password=? and status=1";
//		private static final String DELETE = 
//			"DELETE FROM member where member_id = ?";
		private static final String UPDATE = 
			"UPDATE member set bank_code=?,	email=?,  login_id=?,	idcn	=?,	phone_num=?,	password=?,status	=?,	name=?,	nickname=?,	birthday	=?,	address=?,	bank_account=?, account_name=?,rent_score=?,	lease_score=?,	creat_date=?,	pic=?,	idc_f=?,	idc_b=?,	foul	=? where (member_id = ?)";

		private static final String UPDATESTATUS = 
				"UPDATE member set status	=? where (member_id = ?)";
		
		private static final String UPDATEPW = 
				"UPDATE member set password	=? where (login_id = ?)";
		
		private static final String UPDATEACCOUNT = 
				"UPDATE member set bank_code =? ,bank_account =?  ,account_name=? where (member_id = ?)";
		
		
		private static final String UPDATEONEMEMBER = 
				"UPDATE member set member_id = ?"
				+ ",name=?, email=?,creat_date=?,login_id=?,phone_num=?, ,status	=?where (member_id = ?)";

		
		private static final String GET_PDR_ONE_STMT = 
				"SELECT member_id,bank_code, email,login_id,idcn,phone_num,password,status,	name,	nickname,"
				+ "birthday,	address,	bank_account,	account_name,	rent_score,	lease_score,	creat_date,	pic,	idc_f,	idc_b,	foul  "
				+ "FROM member where status = '0'";
	
	@Override
	public void insert(MemberVO memberVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, memberVO.getBankCode());
			pstmt.setString(2, memberVO.getEmail());
			pstmt.setString(3, memberVO.getLoginId());
			pstmt.setString(4, memberVO.getIdcn());
			pstmt.setString(5, memberVO.getPhoneNum());
			pstmt.setString(6, memberVO.getPassword());
			pstmt.setInt(7, memberVO.getStatus());
			pstmt.setString(8, memberVO.getName());
			pstmt.setString(9, memberVO.getNickName());
			pstmt.setDate(10, memberVO.getBirthday());
			pstmt.setString(11, memberVO.getAddress());
			pstmt.setString(12, memberVO.getBankAccount());
			pstmt.setString(13, memberVO.getAccountName());
			pstmt.setDouble(14, memberVO.getRentScore());
			pstmt.setDouble(15, memberVO.getLeaseScore());
			pstmt.setTimestamp(16, memberVO.getCreatDate());
			pstmt.setBytes(17, memberVO.getPic());
			pstmt.setBytes(18, memberVO.getIdcF());
			pstmt.setBytes(19, memberVO.getIdcB());
			pstmt.setInt(20, memberVO.getFoul());
			
			pstmt.executeUpdate();

			// Handle any driver errors
	
		} catch (SQLException se) {
			System.out.println("SQL EX:"+se.getErrorCode());
			if(se.getErrorCode()==1062) {
				throw new RuntimeException("此登入帳號、EMail或身分證號已有其他會員使用,請確認後重新註冊，謝謝");
			}else {
				
				throw new RuntimeException("這裡A database error occured. "
						+ se.getMessage());
			}
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
	public void update(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, memberVO.getBankCode());
			pstmt.setString(2, memberVO.getEmail());
			pstmt.setString(3, memberVO.getLoginId());
			pstmt.setString(4, memberVO.getIdcn());
			pstmt.setString(5, memberVO.getPhoneNum());
			pstmt.setString(6, memberVO.getPassword());
			pstmt.setInt(7, memberVO.getStatus());
			pstmt.setString(8, memberVO.getName());
			pstmt.setString(9, memberVO.getNickName());
			pstmt.setDate(10, memberVO.getBirthday());
			pstmt.setString(11, memberVO.getAddress());
			pstmt.setString(12, memberVO.getBankAccount());
			pstmt.setString(13, memberVO.getAccountName());
			pstmt.setDouble(14, memberVO.getRentScore());
			pstmt.setDouble(15, memberVO.getLeaseScore());
			pstmt.setTimestamp(16, memberVO.getCreatDate());
			pstmt.setBytes(17, memberVO.getPic());
			pstmt.setBytes(18, memberVO.getIdcF());
			pstmt.setBytes(19, memberVO.getIdcB());
			pstmt.setInt(20, memberVO.getFoul());
			pstmt.setInt(21, memberVO.getMemberId());

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
	public void updateStatus(MemberVO memberVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATESTATUS);
			pstmt.setInt(1, memberVO.getStatus());
			pstmt.setInt(2, memberVO.getMemberId());
			
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
	public void updateOneStatus(MemberVO memberVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
	
//		System.out.println(memberVO.getCreatDate().toString());
//		System.out.println(UPDATEONEMEMBER.toString());
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATEONEMEMBER);
			pstmt.setInt(1, memberVO.getMemberId());
			pstmt.setString(2, memberVO.getName());
			pstmt.setString(3, memberVO.getEmail());
			pstmt.setTimestamp(4, memberVO.getCreatDate());
			pstmt.setString(5, memberVO.getLoginId());
			pstmt.setString(6, memberVO.getPhoneNum());
			pstmt.setInt(7, memberVO.getStatus());
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
	public MemberVO findByPrimaryKey(Integer memberId) {
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);
			
//			System.out.println(GET_ONE_STMT .toString()+ memberId.toString());

			pstmt.setInt(1, memberId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMemberId(rs.getInt("member_id"));
				memberVO.setBankCode(rs.getString("bank_code"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setLoginId(rs.getString("login_id"));
				memberVO.setIdcn(rs.getString("idcn"));
				memberVO.setPhoneNum(rs.getString("phone_num"));
				memberVO.setPassword(rs.getString("password"));
				memberVO.setStatus(rs.getInt("status"));
				memberVO.setName(rs.getString("name"));
				memberVO.setNickName(rs.getString("nickname"));
				memberVO.setBirthday(rs.getDate("birthday"));
				memberVO.setAddress(rs.getString("address"));
				memberVO.setBankAccount(rs.getString("bank_account"));
				memberVO.setAccountName(rs.getString("account_name"));
				memberVO.setRentScore(rs.getDouble("rent_score"));
				memberVO.setLeaseScore(rs.getDouble("lease_score"));
				memberVO.setCreatDate(rs.getTimestamp("creat_date"));
				memberVO.setPic(rs.getBytes("pic"));
				memberVO.setIdcF(rs.getBytes("idc_f"));
				memberVO.setIdcB(rs.getBytes("idc_b"));
				memberVO.setFoul(rs.getInt("foul"));
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
		return memberVO;
	}
	@Override
	public List<MemberVO> findPdrID() {
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_PDR_ONE_STMT);
			rs = pstmt.executeQuery();
			
//			System.out.println(GET_PDR_ONE_STMT.toString());
			
			while (rs.next()) {
				
				memberVO = new MemberVO();
				memberVO.setMemberId(rs.getInt("member_id"));
				memberVO.setBankCode(rs.getString("bank_code"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setLoginId(rs.getString("login_id"));
				memberVO.setIdcn(rs.getString("idcn"));
				memberVO.setPhoneNum(rs.getString("phone_num"));
				memberVO.setPassword(rs.getString("password"));
				memberVO.setStatus(rs.getInt("status"));
				memberVO.setName(rs.getString("name"));
				memberVO.setNickName(rs.getString("nickname"));
				memberVO.setBirthday(rs.getDate("birthday"));
				memberVO.setAddress(rs.getString("address"));
				memberVO.setBankAccount(rs.getString("bank_account"));
				memberVO.setAccountName(rs.getString("account_name"));
				memberVO.setRentScore(rs.getDouble("rent_score"));
				memberVO.setLeaseScore(rs.getDouble("lease_score"));
				memberVO.setCreatDate(rs.getTimestamp("creat_date"));
				memberVO.setPic(rs.getBytes("pic"));
				memberVO.setIdcF(rs.getBytes("idc_f"));
				memberVO.setIdcB(rs.getBytes("idc_b"));
				memberVO.setFoul(rs.getInt("foul"));

				list.add(memberVO); // Store the row in the list
			}

			// Handle any driver errors
		
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
	@Override
	public List<MemberVO> getAll() {
		
		List<MemberVO> list = new ArrayList<MemberVO>();
		MemberVO memberVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				// memberVO �]�٬� Domain objects
				memberVO = new MemberVO();
				memberVO.setMemberId(rs.getInt("member_id"));
				memberVO.setBankCode(rs.getString("bank_code"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setLoginId(rs.getString("login_id"));
				memberVO.setIdcn(rs.getString("idcn"));
				memberVO.setPhoneNum(rs.getString("phone_num"));
				memberVO.setPassword(rs.getString("password"));
				memberVO.setStatus(rs.getInt("status"));
				memberVO.setName(rs.getString("name"));
				memberVO.setNickName(rs.getString("nickname"));
				memberVO.setBirthday(rs.getDate("birthday"));
				memberVO.setAddress(rs.getString("address"));
				memberVO.setBankAccount(rs.getString("bank_account"));
				memberVO.setAccountName(rs.getString("account_name"));
				memberVO.setRentScore(rs.getDouble("rent_score"));
				memberVO.setLeaseScore(rs.getDouble("lease_score"));
				memberVO.setCreatDate(rs.getTimestamp("creat_date"));
				memberVO.setPic(rs.getBytes("pic"));
				memberVO.setIdcF(rs.getBytes("idc_f"));
				memberVO.setIdcB(rs.getBytes("idc_b"));
				memberVO.setFoul(rs.getInt("foul"));

				list.add(memberVO); // Store the row in the list
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

		MemberDAO dao = new MemberDAO();
		Timestamp now = new Timestamp(System.currentTimeMillis());
		
		// 新增
//				MemberVO memberVO1 = new MemberVO();
//				memberVO1.setBankCode("700");
//				memberVO1.setEmail("abc@gmail.com");
//				memberVO1.setLoginId("tibame");
//				memberVO1.setIdcn("A123456789");
//				memberVO1.setPhoneNum("0988567123");
//				memberVO1.setPassword("123test");
//				memberVO1.setStatus(0);
//				memberVO1.setName("���j��");
//				memberVO1.setNickName("�Ѥ�");
//				memberVO1.setBirthday(java.sql.Date.valueOf("2002-01-01"));
//				memberVO1.setAddress("�x�_�����s�ϫ��k��1��");
//				memberVO1.setBankAccount("52525882");
//				memberVO1.setAccountName("���j��");
//				memberVO1.setRentScore(4.5);
//				memberVO1.setLeaseScore(4.8);
//				memberVO1.setCreatDate(now);
//				memberVO1.setPic(null);
//				memberVO1.setIdcF(null);
//				memberVO1.setIdcB(null);
//				memberVO1.setFoul(0);
//				dao.insert(memberVO1);
		
		// 修改
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setBankCode("822");
//		memberVO2.setEmail("updateabc@gmail.com");
//		memberVO2.setLoginId("tibame");
//		memberVO2.setIdcn("A123456789");
//		memberVO2.setPhoneNum("0988567123");
//		memberVO2.setPassword("123test");
//		memberVO2.setStatus(0);
//		memberVO2.setName("���j��");
//		memberVO2.setNickName("�Ѥ�");
//		memberVO2.setBirthday(java.sql.Date.valueOf("2002-01-01"));
//		memberVO2.setAddress("�x�_�����s�ϫ��k��1��");
//		memberVO2.setBankAccount("52525882");
//		memberVO2.setAccountName("���j��");
//		memberVO2.setRentScore(4.5);
//		memberVO2.setLeaseScore(4.8);
//		memberVO2.setCreatDate(now);
//		memberVO2.setPic(null);
//		memberVO2.setIdcF(null);
//		memberVO2.setIdcB(null);
//		memberVO2.setFoul(0);
//		memberVO2.setMemberId(8);
//		dao.update(memberVO2);
		
//		//前台會員資料修改
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setEmail("updateabc@gmail.com");
//		memberVO2.setPhoneNum("0988567123");
//		memberVO2.setNickName("xxx");
//		memberVO2.setPic(null);
//		memberVO2.setMemberId(3);
//		dao.updateMemberBasicInformation(memberVO2);
//		
//		//後台會員資料修改
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setFoul(10);
//		memberVO2.setRentScore(5.0);
//		memberVO2.setLeaseScore(5.0);
//		memberVO2.setStatus(9);
//		memberVO2.setMemberId(2);
//		dao.updateMemberBasicInformation(memberVO2);
			
		// 單一查詢
//		MemberVO memberVO3 = dao.findByPrimaryKey(1);
//		System.out.print(memberVO3.getMemberId() + ",");
//		System.out.print(memberVO3.getBankCode() + ",");
//		System.out.print(memberVO3.getEmail() + ",");
//		System.out.print(memberVO3.getLoginId() + ",");
//		System.out.print(memberVO3.getIdcn() + ",");
//		System.out.print(memberVO3.getPhoneNum() + ",");
//		System.out.print(memberVO3.getPassword() + ",");
//		System.out.print(memberVO3.getStatus() + ",");
//		System.out.print(memberVO3.getName() + ",");
//		System.out.print(memberVO3.getNickName() + ",");
//		System.out.print(memberVO3.getBirthday() + ",");
//		System.out.print(memberVO3.getAddress() + ",");
//		System.out.print(memberVO3.getBankAccount() + ",");
//		System.out.print(memberVO3.getAccountName() + ",");
//		System.out.print(memberVO3.getRentScore() + ",");
//		System.out.print(memberVO3.getLeaseScore() + ",");
//		System.out.print(memberVO3.getCreatDate() + ",");
//		System.out.print(memberVO3.getPic() + ",");
//		System.out.print(memberVO3.getIdcF() + ",");
//		System.out.print(memberVO3.getIdcB() + ",");
//		System.out.println(memberVO3.getFoul());
//		System.out.println("---------------------");
		

		// 單一查詢loginid
//		MemberVO memberVO3 = dao.findLoginID("zxcas4d");
//		System.out.print(memberVO3.getMemberId() + ",");
//		System.out.print(memberVO3.getBankCode() + ",");
//		System.out.print(memberVO3.getEmail() + ",");
//		System.out.print(memberVO3.getLoginId() + ",");
//		System.out.print(memberVO3.getIdcn() + ",");
//		System.out.print(memberVO3.getPhoneNum() + ",");
//		System.out.print(memberVO3.getPassword() + ",");
//		System.out.print(memberVO3.getStatus() + ",");
//		System.out.print(memberVO3.getName() + ",");
//		System.out.print(memberVO3.getNickName() + ",");
//		System.out.print(memberVO3.getBirthday() + ",");
//		System.out.print(memberVO3.getAddress() + ",");
//		System.out.print(memberVO3.getBankAccount() + ",");
//		System.out.print(memberVO3.getAccountName() + ",");
//		System.out.print(memberVO3.getRentScore() + ",");
//		System.out.print(memberVO3.getLeaseScore() + ",");
//		System.out.print(memberVO3.getCreatDate() + ",");
//		System.out.print(memberVO3.getPic() + ",");
//		System.out.print(memberVO3.getIdcF() + ",");
//		System.out.print(memberVO3.getIdcB() + ",");
//		System.out.println(memberVO3.getFoul());
//		System.out.println("---------------------");		
		
				// 全部查詢
//				List<MemberVO> list = dao.getAll();
//				for (MemberVO aMember : list) {
//					System.out.print(aMember.getMemberId() + ", ");
//					System.out.print(aMember.getBankCode() + ", ");
//					System.out.print(aMember.getEmail() + ", ");
//					System.out.print(aMember.getLoginId() + ", ");
//					System.out.print(aMember.getIdcn() + ", ");
//					System.out.print(aMember.getPhoneNum() + ", ");
//					System.out.print(aMember.getPassword()+ ", ");
//					System.out.print(aMember.getStatus() + ", ");
//					System.out.print(aMember.getName() + ", ");
//					System.out.print(aMember.getNickName() + ", ");
//					System.out.print(aMember.getBirthday() + ", ");
//					System.out.print(aMember.getAddress() + ", ");
//					System.out.print(aMember.getBankAccount()+ ", ");
//					System.out.print(aMember.getAccountName() + ", ");
//					System.out.print(aMember.getRentScore() + ", ");
//					System.out.print(aMember.getLeaseScore() + ", ");
//					System.out.print(aMember.getCreatDate() + ", ");
//					System.out.print(aMember.getPic() + ", ");
//					System.out.print(aMember.getIdcF() + ", ");
//					System.out.print(aMember.getIdcB() + ", ");
//					System.out.print(aMember.getFoul());
//					System.out.println();
//				}
		
		// 修改
//		MemberVO memberVO2 = new MemberVO();
//		memberVO2.setBankCode("822");
//		memberVO2.setBankAccount("52525882");
//		memberVO2.setAccountName("林大祥");
//		memberVO2.setMemberId(1);
//		dao.updateAccount(memberVO2);
	}

	@Override
	public MemberVO findLoginID(String loginId) {
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_LOGIN_STMT);

			pstmt.setString(1, loginId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				memberVO = new MemberVO();
				memberVO.setMemberId(rs.getInt("member_id"));
				memberVO.setBankCode(rs.getString("bank_code"));
				memberVO.setEmail(rs.getString("email"));
				memberVO.setLoginId(rs.getString("login_id"));
				memberVO.setIdcn(rs.getString("idcn"));
				memberVO.setPhoneNum(rs.getString("phone_num"));
				memberVO.setPassword(rs.getString("password"));
				memberVO.setStatus(rs.getInt("status"));
				memberVO.setName(rs.getString("name"));
				memberVO.setNickName(rs.getString("nickname"));
				memberVO.setBirthday(rs.getDate("birthday"));
				memberVO.setAddress(rs.getString("address"));
				memberVO.setBankAccount(rs.getString("bank_account"));
				memberVO.setAccountName(rs.getString("account_name"));
				memberVO.setRentScore(rs.getDouble("rent_score"));
				memberVO.setLeaseScore(rs.getDouble("lease_score"));
				memberVO.setCreatDate(rs.getTimestamp("creat_date"));
				memberVO.setPic(rs.getBytes("pic"));
				memberVO.setIdcF(rs.getBytes("idc_f"));
				memberVO.setIdcB(rs.getBytes("idc_b"));
				memberVO.setFoul(rs.getInt("foul"));
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
		return memberVO;
	}

	@Override
	public MemberVO login(String loginId,String password) {
		// TODO Auto-generated method stub
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(LOGIN);

			pstmt.setString(1, loginId);
			pstmt.setString(2, password);

			rs = pstmt.executeQuery();
			
			if (rs !=null) {
				while (rs.next()) {
					memberVO = new MemberVO();
					memberVO.setLoginId(rs.getString("login_id"));
					memberVO.setPassword(rs.getString("password"));
					break;
				}
			}
			// Handle any driver errors
	
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
		return memberVO;
	
	}
//	UPDATEPW = 			"UPDATE member set password	=? where (login_id = ?)";
	@Override
	public void updatePw(MemberVO memberVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATEPW);
			pstmt.setString(1, memberVO.getPassword());
			pstmt.setString(2, memberVO.getLoginId());
			
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
	public void updateAccount(MemberVO memberVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
//			SQL :"UPDATE member set bank_code =? ,bank_account =?  account_name=? where (member_id = ?)";
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATEACCOUNT);
			pstmt.setString(1, memberVO.getBankCode());
			pstmt.setString(2, memberVO.getBankAccount());
			pstmt.setString(3, memberVO.getAccountName());
			pstmt.setInt(4, memberVO.getMemberId());
			
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

	
	private static final String FIND_EMAIL = 
			"SELECT email ,login_id FROM member where email = ?  and status=1";

	@Override
	public MemberVO findEmail(String email) {
		// TODO Auto-generated method stub
		MemberVO memberVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_EMAIL);

			pstmt.setString(1, email);

			rs = pstmt.executeQuery();

				
			if (rs !=null) {
				while (rs.next()) {
					memberVO = new MemberVO();
					memberVO.setLoginId(rs.getString("login_id"));
					memberVO.setEmail(rs.getString("email"));
					break;
				}
			}
			// Handle any driver errors
		
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
		return memberVO;
	
	}

	private static final String UPDATE_ONE_MEM_INF = 
			"UPDATE member set nickName	=? ,email = ?, phone_num =? , pic = ? where (member_id = ?)";
	@Override
	public void updateMemberBasicInformation(MemberVO memberVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_ONE_MEM_INF);
			pstmt.setString(1, memberVO.getNickName());
			pstmt.setString(2, memberVO.getEmail());
			pstmt.setString(3, memberVO.getPhoneNum());
			pstmt.setBytes(4, memberVO.getPic());
			pstmt.setInt(5, memberVO.getMemberId());
			
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

	private static final String UPDATEMEMBER = 
			"UPDATE member set foul = ?,rent_score=?, lease_score=? ,status=? where (member_id = ?)";
	@Override
	public void updateBackOneMember(MemberVO memberVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;
		System.out.println("00000111111");
		try {
			System.out.println("0000000");
			con = ds.getConnection();
			System.out.println("99999");
			pstmt = con.prepareStatement(UPDATEMEMBER);
			System.out.println("88888");
			pstmt.setDouble(2, memberVO.getRentScore());
			System.out.println("2222222");
			
			pstmt.setDouble(3, memberVO.getLeaseScore());
			System.out.println("333333");
			pstmt.setInt(4, memberVO.getStatus());
			System.out.println("44444444");
			pstmt.setInt(5, memberVO.getMemberId());
			System.out.println("5555555");
			pstmt.setInt(1, memberVO.getFoul());
			System.out.println("111111");
			pstmt.executeUpdate();
			System.out.println("6666666");
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
