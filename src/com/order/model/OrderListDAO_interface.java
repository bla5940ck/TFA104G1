package com.order.model;

import java.util.List;

public interface OrderListDAO_interface {

	void addOrderList(OrderListVO orderList);	//新增
	OrderListVO findOrderListByPK(int listID);	//從pk找
	List<OrderListVO> getAllOrderList();		//找全部
	List<OrderListVO> findOrderListByStatus(Integer ordStaus); //找狀態
	void update(OrderListVO orderList);
}
