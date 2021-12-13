package com.order.model;

import java.util.List;

public interface OrderListDAO_interface {

	void addOrderList(OrderListVO orderList);	//新增
	OrderListVO findOrderListByPK(int listID);	//從pk找
	List<OrderListVO> getAllOrderList();		//找全部
	List<OrderListVO> findOrderListByStatus(Integer ordStaus); //找狀態
	List<OrderListVO> findOrderListByOrdID(Integer ordID); //從編號找
	void update(OrderListVO olVO);
	void insertOrder(OrderListVO olVO, java.sql.Connection con);
	void update2(OrderListVO olVO, OrderMasterVO omVO);
	
}
