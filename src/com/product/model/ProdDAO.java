package com.product.model;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import util.Util;

public class ProdDAO implements ProdDAOImpl {

	static {
		try {
			Class.forName(Util.DRIVER);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Integer add(ProdVO prod) {
		
		String sql = "INSERT INTO product(category_id,prod_status,prod_name,prod_cot,prod_rent,prod_price,comt,pic_1,pic_2,pic_3,shelf_date) VALUES (?,?,?,?,?, ?, ?, ?, ?, ?,?);";
		int[] cols = {1};
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs =null;
		Integer key = null;
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql,pstmt.RETURN_GENERATED_KEYS);

			pstmt.setInt(1, prod.getCategoryID());
			pstmt.setInt(2, prod.getProdStatus());
			pstmt.setString(3, prod.getProdName());
			pstmt.setString(4, prod.getProdCot());
			pstmt.setInt(5, prod.getProdRent());
			pstmt.setInt(6, prod.getProdPrice());
			pstmt.setString(7, prod.getComt());
			pstmt.setBytes(8, prod.getPic1());
			pstmt.setBytes(9, prod.getPic2());
			pstmt.setBytes(10, prod.getPic3());
			pstmt.setTimestamp(11, prod.getShelfDate());
			
			
			
			pstmt.executeUpdate();
			
			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				key = rs.getInt(1); // 只支援欄位索引值取得自增主鍵值
				System.out.println("自增主鍵值 = " + key + "(剛新增成功的員工編號)");
			}
			
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
		return key;
	}

	@Override
	public void update(ProdVO prod) {
		String sql = "update product set category_id=?, prod_status=?, prod_name=? ,prod_cot =? ,prod_rent=?,prod_price=? ,pic_1=?,pic_2=?,pic_3=?,comt=?,shelf_date=? where prod_id = ? ";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, prod.getCategoryID());
			pstmt.setInt(2, prod.getProdStatus());
			pstmt.setString(3, prod.getProdName());
			pstmt.setString(4, prod.getProdCot());
			pstmt.setInt(5, prod.getProdRent());
			pstmt.setInt(6, prod.getProdPrice());
			pstmt.setBytes(7, prod.getPic1());
			pstmt.setBytes(8, prod.getPic2());
			pstmt.setBytes(9, prod.getPic3());
			pstmt.setString(10, prod.getComt());
			pstmt.setTimestamp(11, prod.getShelfDate());
			pstmt.setInt(12, prod.getProdID());
			
			
			pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
		
	}

	@Override
	public void deleteProudct(ProdVO prod) {
		// TODO Auto-generated method stub

	}

	@Override
	public ProdVO findProductByPK(Integer prodId) {
		String sql = "select * from product where prod_id = ?";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProdVO prod = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, prodId);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				prod = new ProdVO();
				prod.setProdID(rs.getInt("prod_id"));
				prod.setCategoryID(rs.getInt("category_id"));
				prod.setMemberID(rs.getInt("member_id"));
				prod.setProdStatus(rs.getInt("prod_status"));
				prod.setProdName(rs.getString("prod_name"));
				prod.setProdCot(rs.getString("prod_cot"));
				prod.setShelfDate(rs.getTimestamp("shelf_date"));
				prod.setCreationDate(rs.getTimestamp("creation_date"));
				prod.setProdRent(rs.getInt("prod_rent"));
				prod.setProdPrice(rs.getInt("prod_price"));
				prod.setPic1(rs.getBytes("pic_1"));
				prod.setPic2(rs.getBytes("pic_2"));
				prod.setPic3(rs.getBytes("pic_3"));
				prod.setComt(rs.getString("comt"));

			}
		} catch (SQLException e) {
		
			e.printStackTrace();
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

		return prod;
	}

	@Override
	public List<ProdVO> getAll() {
		List<ProdVO> prodList = new ArrayList<ProdVO>();
		String sql = "select * from product group by prod_id order by shelf_date desc";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				ProdVO prod = new ProdVO();
				prod.setProdID(rs.getInt("prod_id"));
				prod.setCategoryID(rs.getInt("category_id"));
				prod.setMemberID(rs.getInt("member_id"));
				prod.setProdStatus(rs.getInt("prod_status"));
				prod.setProdName(rs.getString("prod_name"));
				prod.setProdCot(rs.getString("prod_cot"));
				prod.setShelfDate(rs.getTimestamp("shelf_date"));
				prod.setCreationDate(rs.getTimestamp("creation_date"));
				prod.setProdRent(rs.getInt("prod_rent"));
				prod.setProdPrice(rs.getInt("prod_price"));
				prod.setPic1(rs.getBytes("pic_1"));
				prod.setPic2(rs.getBytes("pic_2"));
				prod.setPic3(rs.getBytes("pic_3"));
				prod.setComt(rs.getString("comt"));

				prodList.add(prod);

			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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

		return prodList;
	}
	
	
	
	public List<ProdVO> priceSortAsc(){
		List<ProdVO> list = new ArrayList();
		String sql = "select * from product group by prod_id order by prod_rent;";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProdVO prod = new ProdVO();
				prod.setProdID(rs.getInt("prod_id"));
				prod.setCategoryID(rs.getInt("category_id"));
				prod.setMemberID(rs.getInt("member_id"));
				prod.setProdStatus(rs.getInt("prod_status"));
				prod.setProdName(rs.getString("prod_name"));
				prod.setProdCot(rs.getString("prod_cot"));
				prod.setShelfDate(rs.getTimestamp("shelf_date"));
				prod.setCreationDate(rs.getTimestamp("creation_date"));
				prod.setProdRent(rs.getInt("prod_rent"));
				prod.setProdPrice(rs.getInt("prod_price"));
				prod.setPic1(rs.getBytes("pic_1"));
				prod.setPic2(rs.getBytes("pic_2"));
				prod.setPic3(rs.getBytes("pic_3"));
				prod.setComt(rs.getString("comt"));

				list.add(prod);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
	
	
	
	public List<ProdVO> priceSortDesc(){
		List<ProdVO> list = new ArrayList();
		String sql = "select * from product group by prod_id order by prod_rent desc;";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProdVO prod = new ProdVO();
				prod.setProdID(rs.getInt("prod_id"));
				prod.setCategoryID(rs.getInt("category_id"));
				prod.setMemberID(rs.getInt("member_id"));
				prod.setProdStatus(rs.getInt("prod_status"));
				prod.setProdName(rs.getString("prod_name"));
				prod.setProdCot(rs.getString("prod_cot"));
				prod.setShelfDate(rs.getTimestamp("shelf_date"));
				prod.setCreationDate(rs.getTimestamp("creation_date"));
				prod.setProdRent(rs.getInt("prod_rent"));
				prod.setProdPrice(rs.getInt("prod_price"));
				prod.setPic1(rs.getBytes("pic_1"));
				prod.setPic2(rs.getBytes("pic_2"));
				prod.setPic3(rs.getBytes("pic_3"));
				prod.setComt(rs.getString("comt"));

				list.add(prod);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
	public List<ProdVO> getAllByKeyword(String keyword){
		
		List<ProdVO> list = new ArrayList();
		String sql = "SELECT * FROM product where prod_name like \"%\"?\"%\" or prod_cot like \"%\"?\"%\"";
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, keyword);
			pstmt.setString(2, keyword);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProdVO prod = new ProdVO();
				prod.setProdID(rs.getInt("prod_id"));
				prod.setCategoryID(rs.getInt("category_id"));
				prod.setMemberID(rs.getInt("member_id"));
				prod.setProdStatus(rs.getInt("prod_status"));
				prod.setProdName(rs.getString("prod_name"));
				prod.setProdCot(rs.getString("prod_cot"));
				prod.setShelfDate(rs.getTimestamp("shelf_date"));
				prod.setCreationDate(rs.getTimestamp("creation_date"));
				prod.setProdRent(rs.getInt("prod_rent"));
				prod.setProdPrice(rs.getInt("prod_price"));
				prod.setPic1(rs.getBytes("pic_1"));
				prod.setPic2(rs.getBytes("pic_2"));
				prod.setPic3(rs.getBytes("pic_3"));
				prod.setComt(rs.getString("comt"));

				list.add(prod);
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
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
		ProdDAO dao = new ProdDAO();
//		List<ProdVO> list = dao.priceSortAsc();
//		for(ProdVO p :list) {
//			System.out.println(p.getProdRent());
//		}
		List<ProdVO> allByKeyword = dao.getAllByKeyword("試試看");
		System.out.println(allByKeyword.size());
		for(ProdVO p : allByKeyword) {
			System.out.println();
		}
		
//		ProdVO findProductByPK = dao.findProductByPK(1);
//		System.out.println(findProductByPK.getProdPrice());
	}

}
