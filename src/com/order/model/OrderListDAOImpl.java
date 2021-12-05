package com.order.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import org.apache.tomcat.dbcp.dbcp2.SQLExceptionList;

import util.Util;

public class OrderListDAOImpl implements OrderListDAO_interface {

	private static final String INSERT_STMT =
//			"INSERT INTO ORDER_LIST(PROD_ID, PROD_PRICE, EST_START, EST_END) VALUES (?, ?, ?, ?)";
			"INSERT INTO ORDER_LIST(PROD_ID, ORD_ID, PROD_PRICE, EST_START, EST_END) VALUES (? ,?, ?, ?, ?)";
	private static final String FIND_BY_PK = "SELECT * FROM ORDER_LIST WHERE LIST_ID = ?";
	private static final String GET_ALL = "SELECT * FROM ORDER_LIST";
	private static final String FIND_BY_STATUS = "SELECT * FROM ORDER_LIST WHERE ORD_STATUS = ?";
	private static final String UPDATE = "UPDATE ORDER_LIST SET ORD_STATUS = ? WHERE (LIST_ID = ?)";
	private static final String FIND_BY_ORD_ID = "SELECT * FROM ORDER_LIST WHERE ORD_ID = ?";
	private static final String UPDATE_LIST_STATUS = "UPDATE ORDER_LIST SET ORD_STATUS = ? WHERE LIST_ID = ? AND ORD_ID = ?";
	private static final String UPDATE_ORDER_STATUS = "UPDATR ORDER_MASTER SET ORD_STATUS =? WHERE ORD_ID = ?";
	
	static {
		try {
			Class.forName(Util.DRIVER);
		} catch (ClassNotFoundException ce) {
			ce.printStackTrace();
		}
	}

	@Override
	public List<OrderListVO> findOrderListByOrdID(Integer ordID) {

		List<OrderListVO> list = new ArrayList<OrderListVO>();
		OrderListVO orderListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_ORD_ID);

			pstmt.setInt(1, ordID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderListVO = new OrderListVO();
				orderListVO.setListID(rs.getInt("LIST_ID"));
				orderListVO.setProdID(rs.getInt("PROD_ID"));
				orderListVO.setOrdID(rs.getInt("ORD_ID"));
				orderListVO.setProdPrice(rs.getInt("PROD_PRICE"));
				orderListVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				orderListVO.setEstStart(rs.getDate("EST_START"));
				orderListVO.setEstEnd(rs.getDate("EST_END"));

				list.add(orderListVO);
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
	public void insertOrder(OrderListVO olVO, Connection con) {
		// TODO Auto-generated method stub

		PreparedStatement pstmt = null;

		try {
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, olVO.getProdID());
			pstmt.setInt(2, olVO.getOrdID());
			pstmt.setInt(3, olVO.getProdPrice());
			pstmt.setDate(4, olVO.getEstStart());
			pstmt.setDate(5, olVO.getEstEnd());

			Statement stmt = con.createStatement();
			stmt.executeUpdate("set auto_increment_increment=1;");
			pstmt.executeUpdate();
		} catch (SQLException se) {
			if (con != null) {
				try {
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-orderList");
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
	public void addOrderList(OrderListVO orderList) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setInt(1, orderList.getProdID());
			pstmt.setInt(2, orderList.getOrdID());
			pstmt.setInt(3, orderList.getProdPrice());
			pstmt.setDate(4, orderList.getEstStart());
			pstmt.setDate(5, orderList.getEstEnd());

			pstmt.executeUpdate();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public OrderListVO findOrderListByPK(int listID) {
		OrderListVO orderListVO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_PK);

			pstmt.setInt(1, listID);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderListVO = new OrderListVO();
				orderListVO.setListID(rs.getInt("LIST_ID"));
				orderListVO.setProdID(rs.getInt("PROD_ID"));
				orderListVO.setOrdID(rs.getInt("ORD_ID"));
				orderListVO.setProdPrice(rs.getInt("PROD_PRICE"));
				orderListVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				orderListVO.setEstStart(rs.getDate("EST_START"));
				orderListVO.setEstEnd(rs.getDate("EST_END"));
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
		return orderListVO;
	}

	@Override
	public List<OrderListVO> getAllOrderList() {
		List<OrderListVO> list = new ArrayList<OrderListVO>();
		OrderListVO orderListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(GET_ALL);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderListVO = new OrderListVO();
				orderListVO.setListID(rs.getInt("LIST_ID"));
				orderListVO.setProdID(rs.getInt("PROD_ID"));
				orderListVO.setOrdID(rs.getInt("ORD_ID"));
				orderListVO.setProdPrice(rs.getInt("PROD_PRICE"));
				orderListVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				orderListVO.setEstStart(rs.getDate("EST_START"));
				orderListVO.setEstEnd(rs.getDate("EST_END"));

				list.add(orderListVO);

			}

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
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
	public List<OrderListVO> findOrderListByStatus(Integer ordStatus) {
		List<OrderListVO> list = new ArrayList<OrderListVO>();
		OrderListVO orderListVO = null;

		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(FIND_BY_STATUS);

			pstmt.setInt(1, ordStatus);
			rs = pstmt.executeQuery();

			while (rs.next()) {
				orderListVO = new OrderListVO();
				orderListVO.setListID(rs.getInt("LIST_ID"));
				orderListVO.setProdID(rs.getInt("PROD_ID"));
				orderListVO.setOrdID(rs.getInt("ORD_ID"));
				orderListVO.setProdPrice(rs.getInt("PROD_PRICE"));
				orderListVO.setOrdStatus(rs.getInt("ORD_STATUS"));
				orderListVO.setEstStart(rs.getDate("EST_START"));
				orderListVO.setEstEnd(rs.getDate("EST_END"));

				list.add(orderListVO);
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
	public void update(OrderListVO olVO) {

		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			pstmt = con.prepareStatement(UPDATE);

			pstmt.setInt(1, olVO.getOrdStatus());
			pstmt.setInt(2, olVO.getListID());

			pstmt.executeUpdate();

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
	};

	@Override
	public void update2(List<OrderListVO>list, OrderMasterVO omVO) {
		System.out.println("執行更新");

		Connection con = null;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;

		try {
			
			con = DriverManager.getConnection(Util.URL, Util.USER, Util.PASSWORD);
			con.setAutoCommit(false);
			
			String cols[] = { "ORD_ID" };
			pstmt = con.prepareStatement(UPDATE_LIST_STATUS, cols);
			System.out.println("這");
				
			OrderListDAOImpl oldao = new OrderListDAOImpl();
			for(OrderListVO upol : list) {
//				pstmt = con.prepareStatement(UPDATE_LIST_STATUS);
				System.out.println("明細更新");
				pstmt.setInt(1, upol.getOrdStatus());
				pstmt.setInt(2, upol.getListID());
				pstmt.setInt(3, upol.getOrdID());						
				list.add(upol);
				pstmt.executeUpdate();
			}
			
				String next_ordID = null;
				ResultSet rs = pstmt.getGeneratedKeys();
				while (rs.next()) {
					next_ordID = rs.getString(1);
					System.out.println("訂單編號 : " + next_ordID);
				}
				rs.close();
			
				
			pstmt2 = con.prepareStatement(UPDATE_LIST_STATUS);	
			omVO.setOrdID(new Integer(151));
			pstmt2.executeUpdate();
			System.out.println("訂單主檔執行更新");
			
			oldao.update2(list, omVO);

			con.commit();
			con.setAutoCommit(true);
			
		} catch (SQLException se) {
			if (con != null) {
				try {
					se.printStackTrace();
					System.err.print("Transaction is being ");
					System.err.println("rolled back-由-orderList");
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

	public static void main(String[] args) {
		OrderListDAO_interface oldao = new OrderListDAOImpl();

		// 更新交易控制
		List<OrderListVO> testList = new ArrayList<OrderListVO>();
		OrderListVO ola = new OrderListVO();
		System.out.println("第一筆明細更新");
		ola.setOrdStatus(3);
		ola.setListID(36);
		ola.setOrdID(151);
//		testList.add(ola);
		
		OrderListVO olb = new OrderListVO();
		System.out.println("第二筆明細更新");
		olb.setOrdStatus(3);
		olb.setListID(37);
		olb.setOrdID(151);
//		testList.add(olb);
				
		OrderMasterVO omVO = new OrderMasterVO();
		omVO.setOrdStatus(3);
		
		oldao.update2(testList, omVO);

		// 更新
//		OrderListVO ol1 = new OrderListVO();
//		ol1.setOrdStatus(9);
//		ol1.setListID(6);
//		oldao.update(ol1);

		// 新增
//		long datetime = System.currentTimeMillis();
//		Timestamp timeStamp = new Timestamp(datetime);
//		java.sql.Date date = new java.sql.Date(datetime);
//		OrderListVO ol1 = new OrderListVO();
//		ol1.setProdID(1);
//		ol1.setOrdID(1);
//		ol1.setEstStart(date);
//		ol1.setEstEnd(date);
//		ol1.setProdPrice(100);
//		
//		oldao.addOrderList(ol1);
//		System.out.println("新增成功");

		// 從pk找
		OrderListVO ol2 = oldao.findOrderListByPK(2);
//		System.out.println(ol2);
//		System.out.println(ol2.getListID() + ",");
//		System.out.println(ol2.getProdID() + ",");
//		System.out.println(ol2.getOrdID() + ",");
//		System.out.println(ol2.getPrice() + ",");
		System.out.println("==========================================");

		// 查全部
		List<OrderListVO> list = oldao.getAllOrderList();
//		for (OrderListVO ol3 : list) {
//			System.out.println(ol3);
//			System.out.println(ol3.getListID() + ",");
//			System.out.println(ol3.getProdID() + ",");
//			System.out.println(ol3.getOrdID() + ",");
//			System.out.println(ol3.getPrice() + ",");
		System.out.println("======================================");
//		}

		// 找狀態
		List<OrderListVO> list1 = oldao.findOrderListByStatus(1);
		for (OrderListVO ol4 : list1) {
//			ol4.setOrdStatus(1);
//			System.out.println(ol4);
		}
	}

}
