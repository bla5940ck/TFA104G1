package com.manager.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ManagerDAO implements ManagerDAO_interface {
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	public static final String USER = "root";
	public static final String PASSWORD = "password";

	private static final String INSERT_STMT = 
			"INSERT INTO Manager (manager_user,manager_name,manager_password,status) VALUES (?, ?, ?, ?)";
	private static final String GET_ALL_STMT = 
			"SELECT manager_id,manager_user,manager_name,manager_password,status FROM Manager order by manager_id";
	private static final String GET_ONE_STMT = 
			"SELECT manager_id,manager_user,manager_name,manager_password,status FROM Manager where manager_id = ?  ";
	private static final String DELETE = 
			"DELETE FROM Manager where manager_id =? ";
	private static final String UPDATE = 
			"UPDATE Manager set manager_user=?,manager_name=?,manager_password=?,status=? where manager_id=?";

	@Override
	public void insert(ManagerVO managerVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, managerVO.getManagerUser());
			pstmt.setString(2, managerVO.getManagerName());
			pstmt.setString(3, managerVO.getManagerPassword());
			pstmt.setInt(4, managerVO.getStatus());

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
	public void update(ManagerVO managerVO) {
		// TODO Auto-generated method stub
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setString(1, managerVO.getManagerUser());
			pstmt.setString(2, managerVO.getManagerName());
			pstmt.setString(3, managerVO.getManagerPassword());
			pstmt.setInt(4, managerVO.getStatus());
			pstmt.setInt(5, managerVO.getManagerID());
			
			
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
	public void delete(Integer managerID) {
		
		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, managerID);
			
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
	public ManagerVO findByprimaryKey(Integer managerID) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ManagerVO vo = new ManagerVO();
		
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(GET_ONE_STMT);
			
			ps.setInt(1, managerID);
			
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				vo = new ManagerVO();
				vo.setManagerID(rs.getInt("manager_id"));
				vo.setManagerUser(rs.getString("manager_user"));
				vo.setManagerName(rs.getString("manager_name"));
				vo.setManagerPassword(rs.getString("manager_password"));
				vo.setStatus(rs.getInt("status"));

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
		return vo;
	}

	@Override
	public List<ManagerVO> getAll() {
		List<ManagerVO> li = new ArrayList<>();
		ManagerVO mvo = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			ps = con.prepareStatement(GET_ALL_STMT);
			rs = ps.executeQuery();
			
			while (rs.next()) {
				
				mvo = new ManagerVO();
				mvo.setManagerID(rs.getInt("manager_id"));
				mvo.setManagerUser(rs.getString("manager_user"));
				mvo.setManagerName(rs.getString("manager_name"));
				mvo.setManagerPassword(rs.getString("manager_password"));
				mvo.setStatus(rs.getInt("status"));

				li.add(mvo);
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

	public static void main(String[] args) {

		ManagerDAO dao = new ManagerDAO();

		//新增
		ManagerVO mvo1 = new ManagerVO();
		mvo1.setManagerUser("xxxxxxxxx");
		mvo1.setManagerName("hawer");
		mvo1.setManagerPassword("7654321");
		mvo1.setStatus(1);
		dao.insert(mvo1);
	

		//修改
		ManagerVO mvo2 = new ManagerVO();
//		mvo2.setManagerID(3);
//		mvo2.setManagerUser("loveme");
//		mvo2.setManagerName("David");
//		mvo2.setManagerPassword("1234567");
//		mvo2.setStatus(1);
		dao.update(mvo2);

		
		//刪除
		dao.delete(5);
		
		
		//查詢
		ManagerVO vo3 = dao.findByprimaryKey(3);
		System.out.print(vo3.getManagerID() + ",");
		System.out.print(vo3.getManagerUser() + ",");
		System.out.print(vo3.getManagerName() + ",");
		System.out.print(vo3.getManagerPassword() + ",");
		System.out.print(vo3.getStatus() + ",");
		System.out.println("----------------");
		
		//全部查詢		
		List<ManagerVO> list = dao.getAll();
		for (ManagerVO vo4 : list) {
		System.out.print(vo4.getManagerID() + ",");
		System.out.print(vo4.getManagerUser() + ",");
		System.out.print(vo4.getManagerName() + ",");
		System.out.print(vo4.getManagerPassword() + ",");
		System.out.print(vo4.getStatus() + ",");
			System.out.println();
		}
////		for(int i=0;i<list.size();i++) {
//			System.out.println(list.get(i));
//		}


	}

}
