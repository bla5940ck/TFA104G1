package com.order.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.sql.Types;
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import com.booking.model.BookingDAO;
import com.booking.model.BookingVO;

import util.Util;

public class OrderMasterDAOImpl implements OrderMasterDAO_interface {

	private static final String INSERT_STMT = "INSERT INTO ORDER_MASTER" + "(RENT_ID, LEASE_ID, PAY_ID, COUPON_ID,"
			+ "ORD_DATE, STORE_CODE ,EST_START, EST_END, RENT_DAYS, PROD_PRICE, SHIP_FEE, ORD_PRICE)"
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	private static final String UPDATE = "UPDATE ORDER_MASTER SET "
			+ "SHIP_STATUS = ?, ORD_STATUS = ?, PAY_STATUS = ?, SHIP_CODE = ?, RETURN_CODE = ?, "
			+ "SHIP_DATE = ?, ARRIVAL_DATE = ?, RETURN_DATE = ?, RENT_RANK = ?, LEASE_RANK = ?, "
			+ "RENT_COMT = ?, LEASE_COMT = ?, RENT_COMTDATE = ?, LEASE_COMTDATE = ?, EST_TRF_DA = ?, TRF_STATUS = ?, PAY_DATE = ? WHERE (ORD_ID = ?) ORDER BY ORD_ID DESC";
	private static final String FIND_BY_PK = "SELECT * FROM ORDER_MASTER WHERE ORD_ID = ?";
	private static final String FIND_BY_STATUS = "SELECT * FROM ORDER_MASTER WHERE  ORD_STATUS = ? ORDER BY ORD_ID DESC";
	private static final String GET_ALL = "SELECT * FROM ORDER_MASTER ORDER BY ORD_ID DESC";

	private static final String INSERT_STMT_ORDERLIST = "INSERT INTO ORDER_LIST(PROD_ID, ORD_ID, PROD_PRICE, EST_START, EST_END) VALUES (? ,?, ?, ?, ?)";
	private static final String UPDATE_ORDERLIST = "UPDATE ORDER_LIST SET ORD_STATUS = ? WHERE LIST_ID = ? AND ORD_ID = ?";
	private static final String UPDATE2 = "UPDATE ORDER_MASTER SET ORD_STATUS = ? WHERE ORD_ID = ?";

	private static final String INSERT_RENT_COMMENT = "UPDATE ORDER_MASTER SET RENT_RANK = ?, RENT_COMT = ?, RENT_COMTDATE = ? WHERE (ORD_ID = ?)";
	private static final String INSERT_LEASE_COMMENT = "UPDATE ORDER_MASTER SET LEASE_RANK = ?, LEASE_COMT = ?, LEASE_COMTDATE = ? WHERE (ORD_ID = ?)";

	static {
		try {
			Class.forName(Util.DRIVER);
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	@Override
	public List<OrderMasterVO> findOrderMasterByStatus(Integer ordStatus) {
		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_STATUS);

			pstmt.setInt(1, ordStatus);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				OrderMasterVO omVO = new OrderMasterVO();
				omVO.setOrdID(rs.getInt("ORD_ID"));
				omVO.setRentID(rs.getInt("RENT_ID"));
				omVO.setLeaseID(rs.getInt("LEASE_ID"));
				omVO.setPayID(rs.getInt("PAY_ID"));
				omVO.setCouponID(rs.getInt("COUPON_ID"));
				omVO.setShipStatus(rs.getInt("SHIP_STATUS"));
				omVO.setPayStatus(rs.getInt("PAY_STATUS"));
				omVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				omVO.setOrdDate(rs.getTimestamp("ORD_DATE"));
				omVO.setShipCode(rs.getInt("SHIP_CODE"));
				omVO.setReturnCode(rs.getInt("RETURN_CODE"));
				omVO.setStoreCode(rs.getInt("STORE_CODE"));
				omVO.setEstStart(rs.getDate("EST_START"));
				omVO.setEstEnd(rs.getDate("EST_END"));
				omVO.setShipDate(rs.getTimestamp("SHIP_DATE"));
				omVO.setArrivalDate(rs.getTimestamp("ARRIVAL_DATE"));
				omVO.setReturnDate(rs.getTimestamp("RETURN_DATE"));
				omVO.setRentDays(rs.getInt("RENT_DAYS"));
				omVO.setRentRank(rs.getInt("RENT_RANK"));
				omVO.setLeaseRank(rs.getInt("LEASE_RANK"));
				omVO.setRentComt(rs.getString("RENT_COMT"));
				omVO.setLeaseComt(rs.getString("LEASE_COMT"));
				omVO.setRentComtdate(rs.getTimestamp("RENT_COMTDATE"));
				omVO.setLeaseComtdate(rs.getTimestamp("LEASE_COMTDATE"));
				omVO.setProdPrice(rs.getInt("PROD_PRICE"));
				omVO.setShipFee(rs.getInt("SHIP_FEE"));
				omVO.setOrdPrice(rs.getInt("ORD_PRICE"));
				omVO.setEstTrfDa(rs.getTimestamp("EST_TRF_DA"));
				omVO.setTrfStatus(rs.getInt("TRF_STATUS"));
				omVO.setPayDate(rs.getTimestamp("PAY_DATE"));
				

				list.add(omVO);
			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public void inesetWithList(OrderMasterVO omVO, List<OrderListVO> list) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);

			// 設定autoCommit false在pstmt.executeUpdate()之前
			con.setAutoCommit(false);

			// 先新增訂單
			String cols[] = { "ORD_ID" }; // 填入自增主鍵的欄位
			pstmt = con.prepareStatement(INSERT_STMT, cols);

			pstmt.setInt(1, omVO.getRentID());
			pstmt.setInt(2, omVO.getLeaseID());
			pstmt.setInt(3, omVO.getPayID());
			if (omVO.getCouponID() == null) {
				pstmt.setNull(4, Types.NULL);
			} else {
				pstmt.setInt(4, omVO.getCouponID());
			}
			pstmt.setTimestamp(5, omVO.getOrdDate());
			pstmt.setInt(6, omVO.getStoreCode());
			pstmt.setDate(7, omVO.getEstStart());
			pstmt.setDate(8, omVO.getEstEnd());
			pstmt.setInt(9, omVO.getRentDays());
			pstmt.setInt(10, omVO.getProdPrice());
			pstmt.setInt(11, omVO.getShipFee());
			pstmt.setInt(12, omVO.getOrdPrice());
			Statement stmt = con.createStatement();
			stmt.executeUpdate("set auto_increment_offset=1000;");
			stmt.executeUpdate("set auto_increment_increment=1;"); // 自增主鍵-遞增
			pstmt.executeUpdate();

			String next_ordID = null;
			ResultSet rs = pstmt.getGeneratedKeys();
			if (rs.next()) {
				next_ordID = rs.getString(1);
//				System.out.println("自增主鍵值 = " + next_ordID + "剛新增成功的訂單編號");
			} else {
//				System.out.println("未取得自增主鍵直");
			}
			rs.close();
			// 同時再新增訂單明細
			OrderListDAOImpl oldao = new OrderListDAOImpl();
//			System.out.println("新增前有 : " + list.size());
			for (OrderListVO olVO : list) {
				olVO.setOrdID(new Integer(next_ordID));
				oldao.insertOrder(olVO, con);

			}

			// 設定autoCommit(true)於pstmt.executeUpdate()之後
			con.commit();
			con.setAutoCommit(true);
//			System.out.println("新增後有 : " + list.size());
//			System.out.println("新增訂單編號" + next_ordID + "時,共有明細" + list.size() + "筆,同時被新增");

		} catch (SQLException se) {
			if (con != null) {
				try {
					se.printStackTrace();
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-orderMaster");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void addOrderMaster(OrderMasterVO orderMaster) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, orderMaster.getRentID());
			pstmt.setInt(2, orderMaster.getLeaseID());
			pstmt.setInt(3, orderMaster.getPayID());
			if (orderMaster.getCouponID() == null) {
//				pstmt.setObject(4, orderMaster.getCouponID());
				pstmt.setNull(4, Types.NULL);
			} else {
				pstmt.setInt(4, orderMaster.getCouponID());
			}
			pstmt.setTimestamp(5, orderMaster.getOrdDate());
			pstmt.setInt(6, orderMaster.getStoreCode());
			pstmt.setDate(7, orderMaster.getEstStart());
			pstmt.setDate(8, orderMaster.getEstEnd());
			pstmt.setInt(9, orderMaster.getRentDays());
			pstmt.setInt(10, orderMaster.getProdPrice());
			pstmt.setInt(11, orderMaster.getShipFee());
			pstmt.setInt(12, orderMaster.getOrdPrice());
			pstmt.executeUpdate();
		} catch (SQLException e) {

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
	}

	@Override
	public void updateOrderMaster(OrderMasterVO orderMaster) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, orderMaster.getShipStatus());
			pstmt.setInt(2, orderMaster.getOrdStatus());
			pstmt.setInt(3, orderMaster.getPayStatus());
			pstmt.setInt(4, orderMaster.getShipCode());
			pstmt.setInt(5, orderMaster.getReturnCode());
			pstmt.setTimestamp(6, orderMaster.getShipDate());
			pstmt.setTimestamp(7, orderMaster.getArrivalDate());
			pstmt.setTimestamp(8, orderMaster.getReturnDate());
			pstmt.setInt(9, orderMaster.getRentRank());
			pstmt.setInt(10, orderMaster.getLeaseRank());
			pstmt.setString(11, orderMaster.getRentComt());
			pstmt.setString(12, orderMaster.getLeaseComt());
			pstmt.setTimestamp(13, orderMaster.getRentComtdate());
			pstmt.setTimestamp(14, orderMaster.getLeaseComtdate());
			pstmt.setTimestamp(15, orderMaster.getEstTrfDa());
			pstmt.setInt(16, orderMaster.getTrfStatus());
			pstmt.setTimestamp(17, orderMaster.getPayDate());
			pstmt.setInt(18, orderMaster.getOrdID());
			pstmt.executeUpdate();

//			"UPDATE ORDER_MASTER SET "
//			+ "SHIP_STATUS = ?, ORD_STATUS = ?, PAY_STATUS = ?, SHIP_CODE = ?, RETURN_CODE = ?, "
//			+ "SHIP_DATE = ?, ARRIVAL_DATE = ?, RETURN_DATE = ?, RENT_RANK = ?, LEASE_RANK = ?, "
//			+ "RENT_COMT = ?, LEASE_COMT = ?, RENT_COMTDATE = ?, LEASE_COMTDATE = ?, EST_TRF_DA = ?, TRF_STATUS = ?, PAY_DATE = ? WHERE (ORD_ID = ?) ORDER BY ORD_ID DESC";
			
			
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
	}

	@Override
	public OrderMasterVO findOrderMasterByPK(Integer ordID) {

		OrderMasterVO orderMasterVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK);

			pstmt.setInt(1, ordID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderMasterVO = new OrderMasterVO();
				orderMasterVO.setOrdID(rs.getInt("ORD_ID"));
				orderMasterVO.setRentID(rs.getInt("RENT_ID"));
				orderMasterVO.setLeaseID(rs.getInt("LEASE_ID"));
				orderMasterVO.setPayID(rs.getInt("PAY_ID"));
				orderMasterVO.setCouponID(rs.getInt("COUPON_ID"));
				orderMasterVO.setShipStatus(rs.getInt("SHIP_STATUS"));
				orderMasterVO.setPayStatus(rs.getInt("PAY_STATUS"));
				orderMasterVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				orderMasterVO.setOrdDate(rs.getTimestamp("ORD_DATE"));
				orderMasterVO.setShipCode(rs.getInt("SHIP_CODE"));
				orderMasterVO.setReturnCode(rs.getInt("RETURN_CODE"));
				orderMasterVO.setStoreCode(rs.getInt("STORE_CODE"));
				orderMasterVO.setEstStart(rs.getDate("EST_START"));
				orderMasterVO.setEstEnd(rs.getDate("EST_END"));
				orderMasterVO.setShipDate(rs.getTimestamp("SHIP_DATE"));
				orderMasterVO.setArrivalDate(rs.getTimestamp("ARRIVAL_DATE"));
				orderMasterVO.setReturnDate(rs.getTimestamp("RETURN_DATE"));
				orderMasterVO.setRentDays(rs.getInt("RENT_DAYS"));
				orderMasterVO.setRentRank(rs.getInt("RENT_RANK"));
				orderMasterVO.setLeaseRank(rs.getInt("LEASE_RANK"));
				orderMasterVO.setRentComt(rs.getString("RENT_COMT"));
				orderMasterVO.setLeaseComt(rs.getString("LEASE_COMT"));
				orderMasterVO.setRentComtdate(rs.getTimestamp("RENT_COMTDATE"));
				orderMasterVO.setLeaseComtdate(rs.getTimestamp("LEASE_COMTDATE"));
				orderMasterVO.setProdPrice(rs.getInt("PROD_PRICE"));
				orderMasterVO.setShipFee(rs.getInt("SHIP_FEE"));
				orderMasterVO.setOrdPrice(rs.getInt("ORD_PRICE"));
				orderMasterVO.setEstTrfDa(rs.getTimestamp("EST_TRF_DA"));
				orderMasterVO.setTrfStatus(rs.getInt("TRF_STATUS"));
				orderMasterVO.setPayDate(rs.getTimestamp("PAY_DATE"));
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
		return orderMasterVO;
	}

	@Override
	public List<OrderMasterVO> getAllOrderMaster() {
		List<OrderMasterVO> list = new ArrayList<OrderMasterVO>();
		OrderMasterVO orderMasterVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderMasterVO = new OrderMasterVO();
				orderMasterVO.setOrdID(rs.getInt("ORD_ID"));
				orderMasterVO.setRentID(rs.getInt("RENT_ID"));
				orderMasterVO.setLeaseID(rs.getInt("LEASE_ID"));
				orderMasterVO.setPayID(rs.getInt("PAY_ID"));
				orderMasterVO.setCouponID(rs.getInt("COUPON_ID"));
				orderMasterVO.setShipStatus(rs.getInt("SHIP_STATUS"));
				orderMasterVO.setPayStatus(rs.getInt("PAY_STATUS"));
				orderMasterVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				orderMasterVO.setOrdDate(rs.getTimestamp("ORD_DATE"));
				orderMasterVO.setShipCode(rs.getInt("SHIP_CODE"));
				orderMasterVO.setReturnCode(rs.getInt("RETURN_CODE"));
				orderMasterVO.setStoreCode(rs.getInt("STORE_CODE"));
				orderMasterVO.setEstStart(rs.getDate("EST_START"));
				orderMasterVO.setEstEnd(rs.getDate("EST_END"));
				orderMasterVO.setShipDate(rs.getTimestamp("SHIP_DATE"));
				orderMasterVO.setArrivalDate(rs.getTimestamp("ARRIVAL_DATE"));
				orderMasterVO.setReturnDate(rs.getTimestamp("RETURN_DATE"));
				orderMasterVO.setRentDays(rs.getInt("RENT_DAYS"));
				orderMasterVO.setRentRank(rs.getInt("RENT_RANK"));
				orderMasterVO.setLeaseRank(rs.getInt("LEASE_RANK"));
				orderMasterVO.setRentComt(rs.getString("RENT_COMT"));
				orderMasterVO.setLeaseComt(rs.getString("LEASE_COMT"));
				orderMasterVO.setRentComtdate(rs.getTimestamp("RENT_COMTDATE"));
				orderMasterVO.setLeaseComtdate(rs.getTimestamp("LEASE_COMTDATE"));
				orderMasterVO.setProdPrice(rs.getInt("PROD_PRICE"));
				orderMasterVO.setShipFee(rs.getInt("SHIP_FEE"));
				orderMasterVO.setOrdPrice(rs.getInt("ORD_PRICE"));
				orderMasterVO.setEstTrfDa(rs.getTimestamp("EST_TRF_DA"));
				orderMasterVO.setTrfStatus(rs.getInt("TRF_STATUS"));
				orderMasterVO.setPayDate(rs.getTimestamp("PAY_DATE"));
				list.add(orderMasterVO);
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
		return list;
	}

	@Override
	public void insertAllOrder(OrderMasterVO omVO, OrderListVO olVO) {

		Connection con = null;
//		Connection con1 = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);

			// 1. 設定於pstmt.executeUpdate()之前
			con.setAutoCommit(false);
			// 先新增訂單
//			int cols[] = {1}; // 或 int cols[] = {1};
			String cols[] = { "ORD_ID" };

			pstmt = con.prepareStatement(INSERT_STMT, cols);
			pstmt2 = con.prepareStatement(INSERT_STMT_ORDERLIST);

			pstmt.setInt(1, omVO.getRentID());
			pstmt.setInt(2, omVO.getLeaseID());
			pstmt.setInt(3, omVO.getPayID());
			if (omVO.getCouponID() == null) {
				pstmt.setNull(4, Types.NULL);
			} else {
				pstmt.setInt(4, omVO.getCouponID());
			}
			pstmt.setTimestamp(5, omVO.getOrdDate());
			pstmt.setInt(6, omVO.getStoreCode());
			pstmt.setDate(7, omVO.getEstStart());
			pstmt.setDate(8, omVO.getEstEnd());
			pstmt.setInt(9, omVO.getRentDays());
			pstmt.setInt(10, omVO.getProdPrice());
			pstmt.setInt(11, omVO.getShipFee());
			pstmt.setInt(12, omVO.getOrdPrice());

			Statement stmt = con.createStatement();
			stmt.executeUpdate("set auto_increment_offset=1000");
			stmt.executeUpdate("set auto_increment_increment=1");

			pstmt.executeUpdate();

			// 取得對應的字增主鍵值
			int key = 0;
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				key = rs.getInt(1);
				System.out.println(key);
			}
			rs.close();
			// 同時再新增訂單明細內容
			pstmt2.setInt(1, olVO.getProdID());
			pstmt2.setInt(2, key);
			pstmt2.setInt(3, olVO.getProdPrice());
			pstmt2.setDate(4, olVO.getEstStart());
			pstmt2.setDate(5, olVO.getEstEnd());

			stmt = con.createStatement();
			stmt.executeUpdate("set auto_increment_offset=1001");
			stmt.executeUpdate("set auto_increment_increment=1");

			pstmt2.executeUpdate();

			con.commit();
			con.setAutoCommit(true);
		} catch (SQLException e) {
			try {
				// 發生例外進行rollback動作
				con.rollback();
			} catch (SQLException se) {
				se.printStackTrace();
			}
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
	}

	public void updateAllOrder(OrderMasterVO omVO, OrderListVO olVO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);

			// 1. 設定於pstmt.executeUpdate()之前
			con.setAutoCommit(false);
			// 先更新訂單
			int cols[] = { 1 }; // 或 int cols[] = {1};

			pstmt = con.prepareStatement(UPDATE, cols);

			pstmt.setInt(1, omVO.getShipStatus());
			pstmt.setInt(2, omVO.getOrdStatus());
			pstmt.setInt(3, omVO.getPayStatus());
			pstmt.setInt(4, omVO.getShipCode());
			pstmt.setInt(5, omVO.getReturnCode());
			pstmt.setTimestamp(6, omVO.getShipDate());
			pstmt.setTimestamp(7, omVO.getArrivalDate());
			pstmt.setTimestamp(8, omVO.getReturnDate());
			pstmt.setInt(9, omVO.getRentRank());
			pstmt.setInt(10, omVO.getLeaseRank());
			pstmt.setString(11, omVO.getRentComt());
			pstmt.setString(12, omVO.getLeaseComt());
			pstmt.setTimestamp(13, omVO.getRentComtdate());
			pstmt.setTimestamp(14, omVO.getLeaseComtdate());
			pstmt.setTimestamp(15, omVO.getEstTrfDa());
			pstmt.setInt(16, omVO.getTrfStatus());
			pstmt.setTimestamp(17, omVO.getPayDate());
			pstmt.setInt(18, omVO.getOrdID());
			pstmt.executeUpdate();

			int key = 0;
			rs = pstmt.getGeneratedKeys();
			while (rs.next()) {
				key = rs.getInt(1);
				System.out.println(key);
			}
			rs.close();
			// 同時再更新訂單明細內容 UPDATE ORDER_LIST SET ORD_STATUS = ? WHERE LIST_ID = ? AND ORD_ID
			// =?
			pstmt2 = con.prepareStatement(UPDATE_ORDERLIST);
			pstmt2.setInt(1, olVO.getOrdStatus());
			pstmt2.setInt(2, olVO.getListID());
			pstmt2.setInt(3, olVO.getOrdID());

			pstmt2.executeUpdate();
			con.commit();
			con.setAutoCommit(true);

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			try {
				// 發生例外進行rollback動作
				con.rollback();
			} catch (SQLException se) {
				se.printStackTrace();
			}
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
	}

	@Override
	public void updateWithListStatus(OrderMasterVO omVO, OrderListVO olVO) {

		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			con.setAutoCommit(false);

			pstmt = con.prepareStatement(UPDATE2);
//			UPDATE ORDER_MASTER SET ORD_STATUS = ? WHERE ORD_ID = ?
			// 先更新訂單主檔
			pstmt.setInt(1, omVO.getOrdStatus());
			pstmt.setInt(2, omVO.getOrdID());
			pstmt.executeUpdate();

			// 在更新訂單明細
			OrderListDAOImpl oldao = new OrderListDAOImpl();
			olVO.setOrdID(omVO.getOrdID());
			olVO.setOrdStatus(omVO.getOrdStatus());

			oldao.updateWithOrder(olVO, con);

			con.commit();
			con.setAutoCommit(true);

		} catch (SQLException se) {
			if (con != null) {
				try {
					se.printStackTrace();
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-orderMaster");
					con.rollback();
				} catch (SQLException excep) {
					throw new RuntimeException("rollback error occured. " + excep.getMessage());
				}
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void addLeaseComment(OrderMasterVO orderMaster) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(INSERT_LEASE_COMMENT);
//			"UPDATE ORDER_MASTER SET LEASE_RANK = ?, LEASE_COMT = ?, LEASE_COMTDATE = ? WHERE (ORD_ID = ?)";
			pstmt.setInt(1, orderMaster.getLeaseRank());
			pstmt.setString(2, orderMaster.getLeaseComt());
			pstmt.setTimestamp(3, orderMaster.getLeaseComtdate());
			pstmt.setInt(4, orderMaster.getOrdID());
			pstmt.executeUpdate();

		} catch (SQLException e) {
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
	}

	@Override
	public void addRentComment(OrderMasterVO orderMaster) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(INSERT_RENT_COMMENT);
//			"UPDATE ORDER_MASTER SET RENT_RANK = ?, RENT_COMT = ?, RENT_COMTDATE = ? WHERE (ORD_ID = ?)";
			pstmt.setInt(1, orderMaster.getRentRank());
			pstmt.setString(2, orderMaster.getRentComt());
			pstmt.setTimestamp(3, orderMaster.getRentComtdate());
			pstmt.setInt(4, orderMaster.getOrdID());
			pstmt.executeUpdate();

		} catch (SQLException e) {
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
	}

	public static void main(String[] args) {
		OrderMasterDAOImpl omdao = new OrderMasterDAOImpl();

		long datetime = System.currentTimeMillis();
		Timestamp timeStamp = new Timestamp(datetime);
		java.sql.Date date = new java.sql.Date(datetime);
		System.out.println(timeStamp);
		
		// 查詢某期間成功的訂單		
		
		// 新增rent承租者評論
//		OrderMasterVO rent = new OrderMasterVO();
//		rent.setRentRank(4);
//		rent.setRentComt("DAO測試");
//		rent.setRentComtdate(timeStamp);
//		rent.setOrdID(171);
//		omdao.addRentComment(rent);

		// 新增lease出租者評論
//		OrderMasterVO lease = new OrderMasterVO();
//		lease.setLeaseRank(3);
//		lease.setLeaseComt("DAO測試");
//		lease.setLeaseComtdate(timeStamp);
//		lease.setOrdID(171);
//		omdao.addLeaseComment(lease);

		// 新增訂單主檔+明細(交易控制2版)
//		OrderMasterVO omVO = new OrderMasterVO();
//		omVO.setRentID(2);
//		omVO.setLeaseID(1);
//		omVO.setPayID(2);
//		omVO.setCouponID(null);
//		omVO.setOrdDate(timeStamp);
//		omVO.setStoreCode(19374);
//		omVO.setEstStart(date);
//		omVO.setEstEnd(date);
//		omVO.setRentDays(1);
//		omVO.setProdPrice(1000);
//		omVO.setShipFee(60);
//		omVO.setOrdPrice(1120);
//		
//		List<OrderListVO> testList = new ArrayList<OrderListVO>();
//		OrderListVO ola = new OrderListVO(); // 第一筆明細a
//		ola.setProdID(6);
//		ola.setProdPrice(400);
//		ola.setEstStart(date);
//		ola.setEstEnd(date);
//		
//		OrderListVO olb = new OrderListVO(); // 第二筆明細b
//		olb.setProdID(7);
//		olb.setProdPrice(60);
//		olb.setEstStart(date);
//		olb.setEstEnd(date);
//		
//		testList.add(ola);
//		testList.add(olb);
//		omdao.inesetWithList(omVO, testList);

		// 更新訂單主檔+明細
//		OrderMasterVO om2 = new OrderMasterVO();
//		om2.setShipStatus(9);
//		om2.setOrdStatus(1);
//		om2.setPayStatus(3);
//		om2.setShipCode(11111);
//		om2.setReturnCode(222222);
//		om2.setShipDate(timeStamp);
//		om2.setArrivalDate(timeStamp);
//		om2.setReturnDate(timeStamp);
//		om2.setRentRank(3);
//		om2.setLeaseRank(3);
//		om2.setRentComt("1234567");
//		om2.setLeaseComt("gg");
//		om2.setRentComtdate(timeStamp);
//		om2.setLeaseComtdate(timeStamp);
//		om2.setOrdID(190);
//
//		OrderListVO olVO = new OrderListVO();
//		olVO.setListID(6);
//		olVO.setOrdID(190);
//		olVO.setOrdStatus(1);
//
//		OrderListDAOImpl oldao = new OrderListDAOImpl();
//
//		olVO = oldao.findOrderListByPK(6);
//		System.out.println("更新前" + olVO.getOrdStatus());		
//		omdao.updateAllOrder(om2, olVO);
//		System.out.println("更新後" + olVO.getOrdStatus());		

		// 新增訂單主檔 + 明細
//		OrderMasterVO omVO = new OrderMasterVO();
//		OrderListVO olVO = new OrderListVO();
//		omVO.setRentID(1);
//		omVO.setLeaseID(5);
//		omVO.setPayID(2);
//		omVO.setCouponID(null);
//		omVO.setOrdDate(timeStamp);
//		omVO.setStoreCode(19374);
//		omVO.setEstStart(date);
//		omVO.setEstEnd(date);
//		omVO.setRentDays(2);
//		omVO.setProdPrice(1000);
//		omVO.setShipFee(120);
//		omVO.setOrdPrice(1120);
//
//		Integer prodID = 2;
////		Integer ordID = omVO.getOrdID();
//		Integer prodPrice = 3600;
//		java.sql.Date estStart = new java.sql.Date(datetime);
//		java.sql.Date estEnd = new java.sql.Date(datetime);
//
//		olVO.setProdID(prodID);
////		olVO.setOrdID(ordID);
//		olVO.setProdPrice(prodPrice);
//		olVO.setEstStart(estStart);
//		olVO.setEstEnd(estEnd);
//
//		omdao.insertAllOrder(omVO, olVO);
//
//		System.out.println(omVO);

		// 新增
//		OrderMasterVO om1 = new OrderMasterVO();
//		om1.setRentID(3);
//		om1.setLeaseID(4);
//		om1.setPayID(1);
//		om1.setCouponID(null);
//		om1.setOrdDate(timeStamp);
//		om1.setStoreCode("19374");
//		om1.setEstStart(date);
//		om1.setEstEnd(date);
//		om1.setRentDays(1);
//		om1.setProdPrice(600);
//		om1.setShipFee(120);
//		om1.setOrdPrice(720);
//		omdao.addOrderMaster(om1);

		// 更新
//		OrderMasterVO om2 = new OrderMasterVO();
//		om2.setShipStatus(9);
//		om2.setOrdStatus(2);
//		om2.setPayStatus(3);
//		om2.setShipCode("11111");
//		om2.setReturnCode("222222");
//		om2.setShipDate(timeStamp);
//		om2.setArrivalDate(timeStamp);
//		om2.setReturnDate(timeStamp);
//		om2.setRentRank(3);
//		om2.setLeaseRank(3);
//		om2.setRentComt("1234567");
//		om2.setLeaseComt("gg");
//		om2.setRentComtdate(timeStamp);
//		om2.setLeaseComtdate(timeStamp);
//		om2.setOrdID(22);
//		omdao.updateOrderMaster(om2);
//		
		// 從PK找
		OrderMasterVO om3 = omdao.findOrderMasterByPK(170);
//		System.out.println(om3);
//		System.out.println(om3.getPayID() + ",");
//		System.out.println(om3.getRentID() + ",");
//		System.out.println(om3.getLeaseID() + ",");
//		System.out.println(om3.getPayID() + ",");
//		System.out.println(om3.getCouponID() + ",");
//		System.out.println(om3.getShipStatus() + ",");
//		System.out.println(om3.getPayStatus() + ",");
//		System.out.println(om3.getOrdStatus() + ",");
//		System.out.println(om3.getOrdDate() + ",");
//		System.out.println(om3.getShipCode() + ",");
//		System.out.println(om3.getReturnCode() + ",");
//		System.out.println(om3.getStoreCode() + ",");
//		System.out.println(om3.getEstStart() + ",");
//		System.out.println(om3.getEstEnd() + ",");
//		System.out.println(om3.getShipDate() + ",");
//		System.out.println(om3.getArrivalDate() + ",");
//		System.out.println(om3.getReturnDate() + ",");
//		System.out.println(om3.getRentDays() + ",");
//		System.out.println(om3.getRentRank() + ",");
//		System.out.println(om3.getLeaseRank() + ",");
//		System.out.println(om3.getRentComt() + ",");
//		System.out.println(om3.getLeaseComt() + ",");
//		System.out.println(om3.getRentComtdate() + ",");
//		System.out.println(om3.getLeaseComtdate() + ",");
//		System.out.println(om3.getProdPrice() + ",");
//		System.out.println(om3.getShipFee() + ",");
//		System.out.println(om3.getOrdPrice() + ",");
//		System.out.println("=========================");

		// 找全部
//		String dateTimeStr2 = "2021-12-29 00:00:00";
//		java.sql.Timestamp ts = java.sql.Timestamp.valueOf(dateTimeStr2);
//		if (timeStamp.before(ts)) {
//			System.out.println(true);
//		}
//		
//		Integer month = ts.getMonth();
//		System.out.println(month);
//
//		List<OrderMasterVO> list = omdao.getAllOrderMaster();
//		for (OrderMasterVO om4 : list) {
//			System.out.println(om4.getReturnDate());
//			java.sql.Timestamp rd = om4.getReturnDate();
//
//			if (om4.getOrdStatus() == 2 && om4.getReturnDate() != null && om4.getReturnDate().before(ts)) {
//				System.out.println(om4.getOrdID());
//				System.out.println(om4.getReturnDate());
//				System.out.println("=======================");
//			}
//			System.out.println(om4.getOrdDate().before(ts));

//			System.out.println(om4);
//			System.out.println(om4.getPayID() + ",");
//			System.out.println(om4.getRentID() + ",");
//			System.out.println(om4.getLeaseID() + ",");
//			System.out.println(om4.getPayID() + ",");
//			System.out.println(om4.getCouponID() + ",");
//			System.out.println(om4.getShipStatus() + ",");
//			System.out.println(om4.getPayStatus() + ",");
//			System.out.println(om4.getOrdStatus() + ",");
//			System.out.println(om4.getOrdDate() + ",");
//			System.out.println(om4.getShipCode() + ",");
//			System.out.println(om4.getReturnCode() + ",");
//			System.out.println(om4.getStoreCode() + ",");
//			System.out.println(om4.getEstStart() + ",");
//			System.out.println(om4.getEstEnd() + ",");
//			System.out.println(om4.getShipDate() + ",");
//			System.out.println(om4.getArrivalDate() + ",");
//			System.out.println(om4.getReturnDate() + ",");
//			System.out.println(om4.getRentDays() + ",");
//			System.out.println(om4.getRentRank() + ",");
//			System.out.println(om4.getLeaseRank() + ",");
//			System.out.println(om4.getRentComt() + ",");
//			System.out.println(om4.getLeaseComt() + ",");
//			System.out.println(om4.getRentComtdate() + ",");
//			System.out.println(om4.getLeaseComtdate() + ",");
//			System.out.println(om4.getProdPrice() + ",");
//			System.out.println(om4.getShipFee() + ",");
//			System.out.println(om4.getOrdPrice() + ",");
//			System.out.println("=========================");
//		}
	}
}
