package com.order.model;

import java.sql.Timestamp;
import java.util.List;



public interface OrderMasterDAO_interface {
	void addLeaseComment(OrderMasterVO orderMaster);
	void addRentComment(OrderMasterVO orderMaster);
	
	OrderMasterVO findOrderMasterByPK(Integer ordID);
	
	List<OrderMasterVO> findOrderMasterByStatus(Integer ordStatus);
	List<OrderMasterVO> getAllOrderMaster();
	
	void inesetWithList(OrderMasterVO omVO, List<OrderListVO> list); //交易控制二版_新增
	void updateAllOrder(OrderMasterVO omVO, OrderListVO olVO); //交易控制一版_更新
	void updateWithListStatus(OrderMasterVO omVO, OrderListVO olVO); //交易控制_狀態更新
	
	
	
	void addOrderMaster(OrderMasterVO orderMaster);
	void insertAllOrder(OrderMasterVO omVO, OrderListVO olVO); //交易控制一版_新增
	void updateOrderMaster(OrderMasterVO orderMaster);
}
