package com.order.model;

import java.sql.Connection;
import java.util.List;



public interface OrderMasterDAO_interface {
	void addOrderMaster(OrderMasterVO orderMaster);
	void updateOrderMaster(OrderMasterVO orderMaster);
	OrderMasterVO findOrderMasterByPK(Integer ordID);
	List<OrderMasterVO> getAllOrderMaster();
	void insertAllOrder(OrderMasterVO omVO, OrderListVO olVO);
	void updateAllOrder(OrderMasterVO omVO, OrderListVO olVO);
}
