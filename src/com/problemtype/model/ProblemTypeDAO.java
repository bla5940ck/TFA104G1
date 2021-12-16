package com.problemtype.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProblemTypeDAO implements ProblemTypeDAO_interface {
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	public static final String URL = "jdbc:mysql://localhost:3306/JoyLease?serverTimezone=Asia/Taipei";
	public static final String USER = "root";
	public static final String PASSWORD = "password";
	
	private static final String INSERT_STMT = 
			"INSERT INTO problem_type (type_name) VALUES (?)";
	private static final String GET_ALL_STMT = 
			"SELECT type_id,type_name FROM problem_type order by type_id";
	private static final String GET_ONE_STMT = 
			"SELECT type_id,type_name FROM problem_type where (type_id = ?)";
	private static final String DELETE = 
			"DELETE FROM problem_type where type_id =? ";
	private static final String UPDATE = 
			"UPDATE problem_type set type_name=? where type_id=?";
	@Override
	public void insert(ProblemTypeVO problemTypeVO) {
		
		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL,USER,PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);
			
		
			pstmt.setString(1,problemTypeVO.getTypeName());
			
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
	public void update(ProblemTypeVO problemTypeVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		
		try {
			
			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL,USER,PASSWORD);
			pstmt = con.prepareStatement(UPDATE);
			
			pstmt.setString(1, problemTypeVO.getTypeName());
			pstmt.setInt(2,problemTypeVO.getTypeID());
			
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
	public void delete(Integer typeID) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {

			Class.forName(DRIVER);
			con = DriverManager.getConnection(URL, USER, PASSWORD);
			pstmt = con.prepareStatement(DELETE);
			
			pstmt.setInt(1, typeID);
			
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
	public ProblemTypeVO findByprimaryKey(Integer typeID) {
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		ProblemTypeVO ptvo = null;
		
		try {
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL,USER,PASSWORD);
			ps = con.prepareStatement(GET_ONE_STMT);
			
			ps.setInt(1, typeID);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				
				ptvo = new ProblemTypeVO();
				ptvo.setTypeID(rs.getInt("type_id"));
				ptvo.setTypeName(rs.getString("type_name"));
				
				
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
		return ptvo;
		
	}
	@Override
	public List<ProblemTypeVO> getAll() {
		List<ProblemTypeVO> li = new ArrayList<>();
		ProblemTypeVO ptvo = null;
		
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			
			Class.forName(DRIVER);
			con=DriverManager.getConnection(URL,USER,PASSWORD);
			ps=con.prepareStatement(GET_ALL_STMT);
			rs=ps.executeQuery();
			
			while(rs.next()) {
				ptvo = new ProblemTypeVO();
				ptvo.setTypeID(rs.getInt("type_id"));
				ptvo.setTypeName(rs.getString("type_name"));
				
				
				li.add(ptvo);
			}
			}catch (SQLException se) {
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
		
		ProblemTypeDAO dao = new ProblemTypeDAO();
		
		//新增
		ProblemTypeVO ptvo1 = new ProblemTypeVO();
		ptvo1.setTypeID(4);
		ptvo1.setTypeName("懶的處理");
//		dao.insert(ptvo1);

		
		
		
		//修改
		ProblemTypeVO ptvo2 = new ProblemTypeVO();
		ptvo2.setTypeID(1);
		ptvo2.setTypeName("123");
//		dao.update(ptvo2);
		
		
		//刪除
//		dao.delete(4);
		
		
		//查詢
		ProblemTypeVO ptvo3 = dao.findByprimaryKey(1);
		System.out.print(ptvo3.getTypeID() + ",");
		System.out.println(ptvo3.getTypeName() + ",");
		System.out.println("--------------------------");
		
		
		//全部查詢
		List<ProblemTypeVO> list = dao.getAll();
		for (ProblemTypeVO ptvo4 : list) {
		System.out.print(ptvo4.getTypeID() + ",");
		System.out.print(ptvo4.getTypeName() + ",");
		System.out.println();
		}
		
		
		
//		for(int i=0;i<list.size();i++) {
//			System.out.println(list.get(i));
//		}
	}
	
}
