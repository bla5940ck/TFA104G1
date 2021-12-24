package com.product.model;

import java.io.OutputStream;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import com.chatroom.jedis.JedisPoolUtil;
import com.order.model.OrderMasterDAOImpl;
import com.order.model.OrderMasterVO;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;
import util.Util;

public class ProdDAO implements ProdDAO_Interface {
	private static DataSource ds = null;
	static {
		try {
			Context ctx = new InitialContext();
			ds = (DataSource) ctx.lookup("java:comp/env/jdbc/JoyLease");
		} catch (NamingException e) {
			e.printStackTrace();
		}
	}

	private static final String SEARCH = "SELECT * FROM PRODUCT WHERE PROD_NAME LIKE \"%\"?\"%\" OR PROD_COT LIKE \"%\"?\"%\"";
	private static final String INSERT = "INSERT INTO PRODUCT(CATEGORY_ID,PROD_STATUS,PROD_NAME,PROD_COT,PROD_RENT,PROD_PRICE,COMT,PIC_1,PIC_2,PIC_3,SHELF_DATE,MEMBER_ID) VALUES (?,?,?,?,?,?, ?, ?, ?, ?, ?,?);";
	private static final String DESC = "SELECT * FROM PRODUCT GROUP BY PROD_ID ORDER BY PROD_RENT DESC;";
	private static final String ASC = "SELECT * FROM PRODUCT GROUP BY PROD_ID ORDER BY PROD_RENT;";
	private static final String ALL = "SELECT * FROM PRODUCT GROUP BY PROD_ID ORDER BY SHELF_DATE DESC";
	private static final String UPDATE = "UP"
			+ "DATE PRODUCT SET CATEGORY_ID=?, PROD_STATUS=?, PROD_NAME=? ,PROD_COT =? ,PROD_RENT=?,PROD_PRICE=? ,PIC_1=?,PIC_2=?,PIC_3=?,COMT=?,SHELF_DATE=? WHERE PROD_ID = ? ";
	private static final String FINDPRODUCTBYPK = "SELECT * FROM PRODUCT WHERE PROD_ID = ?";

	public Integer add(ProdVO prod) {

		String[] cols = { "prod_id" };
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Integer key = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT, cols);

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
			pstmt.setInt(12, prod.getMemberID());

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				key = rs.getInt(1); // 只支援欄位索引值取得自增主鍵值
				System.out.println("自增主鍵值 = " + key + "(剛新增成功的員工編號)");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
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
		return key;
	}

	public void update(ProdVO prod) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE);
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

	}

	@Override
	public void deleteProudct(ProdVO prod) {
		// TODO Auto-generated method stub

	}

	public ProdVO findProductByPK(Integer prodId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ProdVO prod = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FINDPRODUCTBYPK);
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

	public List<ProdVO> getAll() {
		List<ProdVO> prodList = new ArrayList<ProdVO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ALL);

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

	public List<ProdVO> priceSortAsc() {
		List<ProdVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ASC);
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

				list.add(prod);

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

		return list;
	}

	public List<ProdVO> priceSortDesc() {
		List<ProdVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(DESC);
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

				list.add(prod);

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

		return list;
	}

	public List<ProdVO> getAllByKeyword(String keyword) {

		List<ProdVO> list = new ArrayList();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(SEARCH);

			pstmt.setString(1, keyword);
			pstmt.setString(2, keyword);
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

				list.add(prod);

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

		return list;
	}

	public static void main(String[] args) {
//		ProdDAO dao = new ProdDAO();
//		
//		List<ProdVO> prodList = dao.getAll();
//		List<ProdVO> list1 = new ArrayList();
//		for(ProdVO p: list) {
//			if(p.getShelfDate()!=null) {
//				list1.add(p);
//			}
//		}
//		
//		List<ProdVO> list1 = prodList.stream()
//										.filter(p ->p.getShelfDate()!=null)	
//				.sorted(Comparator.comparing(ProdVO::getShelfDate).reversed()).collect(Collectors.toList());
//		
//		list1.forEach(p->System.out.println(p.getShelfDate()));
//		
//		for(ProdVO p :list1) {
//			System.out.println(p.getProdID());
//		}
////		
//		List<ProdVO> list = dao.priceSortAsc();
//		for(ProdVO p :list) {
//			System.out.println(p.getProdRent());
//		}
//		List<ProdVO> allByKeyword = dao.getAllByKeyword("試試看");
//		System.out.println(allByKeyword.size());
//		for(ProdVO p : allByKeyword) {
//			System.out.println();
//		}

//		ProdVO findProductByPK = dao.findProductByPK(1);
//		System.out.println(findProductByPK.getProdPrice());

//		ProdService prodSvc = new ProdService();
//		List<ProdVO> list = prodSvc.getAllByTimeDesc();
//		list.forEach(p->System.out.println(p.getProdID()));

//	JedisPool pool = JedisPoolUtil.getJedisPool();
//	Jedis jedis = pool.getResource();
////	
////	Boolean b = jedis.exists("prod124");
//////	jedis.lrem("prod124", Long.valueOf(jedis.llen("prod124")),"10" );
//	jedis.del("prod123");
//	jedis.rpush("prod123", "333q3");	

	}

}
