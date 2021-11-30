package com.order.model;

import java.sql.Date;
import java.util.List;

public class OrderListService {
	
	private OrderListDAO_interface dao;

	public OrderListService() {
		dao = new OrderListDAOImpl();
	}
	
	public OrderListVO addOrderList(Integer prodID, Integer ordID, Integer prodPrice, Date estStart, Date estEnd) {
		
		OrderListVO olVO = new OrderListVO();
//		olVO.setListID(listID);
		olVO.setProdID(prodID);
		olVO.setOrdID(ordID);
		olVO.setProdPrice(prodPrice);
//		olVO.setStatus(status);
		olVO.setEstStart(estStart);
		olVO.setEstEnd(estEnd);
		return olVO;
	}

	public OrderListVO getOneOrderList(Integer listID) {
		return dao.findOrderListByPK(listID);
	}
	
	public List<OrderListVO> getAll(){
		return dao.getAllOrderList();
	}
	
	public List<OrderListVO> getStatus(Integer status){
		return dao.findOrderListByStatus(status);
	}
}
