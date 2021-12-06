package com.order.model;

import java.util.List;



public interface OrderMasterDAO_interface {
	void addOrderMaster(OrderMasterVO orderMaster);
	void updateOrderMaster(OrderMasterVO orderMaster);
	OrderMasterVO findOrderMasterByPK(Integer ordID);
	List<OrderMasterVO> getAllOrderMaster();
	void insertAllOrder(OrderMasterVO omVO, OrderListVO olVO); //交易控制一版_新增
	void inesetWithList(OrderMasterVO omVO, List<OrderListVO> list); //交易控制二版_新增
	void updateAllOrder(OrderMasterVO omVO, OrderListVO olVO); //交易控制一版_更新
	void updateWithListStatus(OrderMasterVO omVO, java.sql.Connection con); //交易控制_狀態更新
}
