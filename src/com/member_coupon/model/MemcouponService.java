package com.member_coupon.model;

import java.util.List;

public class MemcouponService {
	
	private Memcoupon_interface dao;
	public MemcouponService() {
		dao = new MemcouponDAO();
	}
	
	public boolean insert(Integer member_id, Integer category_id, Integer coupon_id, Double discount, String coupon_name, 
			Integer status, java.sql.Date start_date, java.sql.Date end_date) {
				
		List<MemcouponVO> list = dao.getAll();
		boolean flag = false;
		//假如是false 代表沒有重複
		//true 代表重複
		for(MemcouponVO memcouponVO:list) {
			if(memcouponVO.getMember_id()==1) {
				
				flag = flag || (coupon_id.equals(memcouponVO.getCoupon_id()));
			}
		}
		if (flag) {
				return false;			
		}else {
			
		MemcouponVO memcouponVO = new MemcouponVO();
		
		memcouponVO.setMember_id(member_id);
		memcouponVO.setCategory_id(category_id);
		memcouponVO.setCoupon_id(coupon_id);
		memcouponVO.setDiscount(discount);
		memcouponVO.setCoupon_name(coupon_name);
		memcouponVO.setStatus(status);
		memcouponVO.setStart_date(start_date);
		memcouponVO.setEnd_date(end_date);
		dao.insert(memcouponVO);
		}
		return true;
	}
	
//	public MemcouponVO insert2(Integer member_id, Integer category_id, Integer coupon_id, Double discount, String coupon_name, 
//			Integer status, java.sql.Date start_date, java.sql.Date end_date) {
//		MemcouponVO memcouponVO = new MemcouponVO();
//		memcouponVO.setMember_id(member_id);
//		memcouponVO.setCategory_id(category_id);
//		memcouponVO.setCoupon_id(coupon_id);
//		memcouponVO.setDiscount(discount);
//		memcouponVO.setCoupon_name(coupon_name);
//		memcouponVO.setStatus(status);
//		memcouponVO.setStart_date(start_date);
//		memcouponVO.setEnd_date(end_date);
//		dao.insert(memcouponVO);
//		
//		return memcouponVO;
//	}
	
	
	public MemcouponVO update(Integer mem_coupon_id, Integer member_id, Integer category_id, Integer coupon_id, Double discount, String coupon_name, 
			Integer status, java.sql.Date start_date, java.sql.Date end_date) {
		MemcouponVO memcouponVO = new MemcouponVO();
		
		memcouponVO.setMem_coupon_id(mem_coupon_id);
		memcouponVO.setMember_id(member_id);
		memcouponVO.setCategory_id(category_id);
		memcouponVO.setCoupon_id(coupon_id);
		memcouponVO.setDiscount(discount); 
		memcouponVO.setCoupon_name(coupon_name);
		memcouponVO.setStatus(status);
		memcouponVO.setStart_date(start_date);
		memcouponVO.setEnd_date(end_date);
		dao.update(memcouponVO);
		
		return memcouponVO;
	}
	public void delete(Integer mem_coupon_id) {
		dao.delete(mem_coupon_id);
	}
//	public MemcouponVO findByPrimaryKey(Integer mem_coupon_id) {
//		return dao.findByPrimaryKey(mem_coupon_id);
//	}
	public void findByPrimaryKey(Integer mem_coupon_id) {
		dao.findByPrimaryKey(mem_coupon_id);
	}
	public List<MemcouponVO> getAll() {
		return dao.getAll();
	}
	public List<MemcouponVO> getMemberid(Integer member_id) {
		return dao.getMemberid(member_id);
	}

}
