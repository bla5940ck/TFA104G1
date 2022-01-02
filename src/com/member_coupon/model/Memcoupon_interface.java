package com.member_coupon.model;

import java.util.List;

	public interface Memcoupon_interface {
		public void insert(MemcouponVO memcouponVO);
		public void update(MemcouponVO memcouponVO);
		public void delete(Integer mem_coupon_id);
		public void findByPrimaryKey(Integer mem_coupon_id);
		public List<MemcouponVO> getAll();
		public List<MemcouponVO> getMemberid(Integer member_id);
		public MemcouponVO check(boolean memcouponVO2);
		public MemcouponVO check(MemcouponVO memcouponVO2);
		public void orderSelect(Integer mem_coupon_id);
		
	}


