package com.member.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import java.sql.*;
import com.member.model.MemberVO;

public class BankDAO implements BankDAO_interface {
	
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/Bank");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}
	
	private static final String INSERT_STMT = 
		"INSERT INTO bank (code,chinese_name) VALUES (?, ?)";
	private static final String GET_ALL_STMT = 
		"SELECT code,chinese_name FROM bank order by code";
	private static final String GET_ONE_STMT = 
		"SELECT code,chinese_name FROM bank where code = ?";
	private static final String GET_Mem_ByBankcode_STMT = 
			"SELECT member_id,bank_code, email,login_id,idcn,phone_num,password,status,	name,	nickname,"
					+ "birthday,	address,	bank_account,	account_name,	rent_score,	lease_score,	creat_date,	pic,	idc_f,	idc_b,	foul  "
					+ "FROM JoyLease.member where bank_code = ? order by member_id";
//			"SELECT empno,ename,job,hiredate,sal,comm,deptno FROM emp2 where deptno = ? order by empno";
	
	private static final String UPDATE = 
		"UPDATE bank set code=?, chinese_name=? where code = ?";

	@Override
	public void insert(BankVO bankVO) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, bankVO.getCode());
			pstmt.setString(2, bankVO.getChineseName());
			pstmt.executeUpdate();

			// Handle any driver errors
		
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
	public void update(BankVO bankVO) {

			Connection con = null;
			PreparedStatement pstmt = null;

			try {

				con = ds.getConnection();
				pstmt = con.prepareStatement(UPDATE);

				pstmt.setString(1, bankVO.getCode());
				pstmt.setString(2, bankVO.getChineseName());
				pstmt.setString(3, bankVO.getCode());


				pstmt.executeUpdate();

				// Handle any driver errors
			
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
	public BankVO findByPrimaryKey(String code) {
		BankVO bankVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {

			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ONE_STMT);

			pstmt.setString(1, code);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				bankVO = new BankVO();
				bankVO.setCode(rs.getString("code"));
				bankVO.setChineseName(rs.getString("chinese_name"));
		
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
		return bankVO;
	}

	@Override
	public List<BankVO> getAll() {
		List<BankVO> list = new ArrayList<BankVO>();
		BankVO bankVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_ALL_STMT);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				bankVO = new BankVO();
				bankVO.setCode(rs.getString("code"));
				bankVO.setChineseName(rs.getString("chinese_name"));

				list.add(bankVO); // Store the row in the list
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
	public static void main(String[] args) {

		BankDAO dao = new BankDAO();

		// 新增
//		BankVO bankVO1 = new BankVO();
//		bankVO1.setCode("822");
//		bankVO1.setChineseName("���H");
//
//		dao.insert(bankVO1);

		// �ק�
		BankVO bankVO2 = new BankVO();
		bankVO2.setCode("822");
		bankVO2.setChineseName("����H�U");
		bankVO2.setCode("822");
		dao.update(bankVO2);
		
		// 刪除
//		dao.delete(7014);

		// 單一查詢
//		BankVO bankVO3 = dao.findByPrimaryKey("822");
//		System.out.print(bankVO3.getCode() + ",");
//		System.out.print(bankVO3.getChineseName() );
//
//		System.out.println("---------------------");

//		 全部查詢
//		List<BankVO> list = dao.getAll();
//		for (BankVO aBank : list) {
//			System.out.print(aBank.getCode() + ",");
//			System.out.print(aBank.getChineseName() );
//
//			System.out.println();
//		}
	}



	@Override
	public Set<MemberVO> getMemberByBankCode(String bankCode) {
		
		Set<MemberVO> set = new LinkedHashSet<MemberVO>();
		MemberVO memberVO = null;
	
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
	
		try {
	
			con = ds.getConnection();
			pstmt = con.prepareStatement(GET_Mem_ByBankcode_STMT);
			pstmt.setString(1, bankCode);
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
				memberVO.setRentScore(rs.getDouble("rent_score"));
				memberVO.setLeaseScore(rs.getDouble("lease_score"));
				memberVO.setCreatDate(rs.getTimestamp("creat_date"));
				memberVO.setPic(rs.getBytes("pic"));
				memberVO.setIdcF(rs.getBytes("idc_f"));
				memberVO.setIdcB(rs.getBytes("idc_b"));
				memberVO.setFoul(rs.getInt("foul"));
				set.add(memberVO); // Store the row in the vector
			}
	
			// Handle any driver errors
		
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. "
					+ se.getMessage());
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
		return set;
	}
	
}
