package com.order.model;

import java.util.List;

public interface OrderListDAO_interface {

	void addOrderList(OrderListVO orderList);	//�s�W�q�����
	OrderListVO findOrderListByPK(int listID);	//��pk�d��
	List<OrderListVO> getAllOrderList();		//�����
	List<OrderListVO> findOrderListByStatus(Integer staus); // �Ϊ��A�d��
}
