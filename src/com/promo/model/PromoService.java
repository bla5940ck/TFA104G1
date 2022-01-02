package com.promo.model;

import java.util.List;

public class PromoService {
	
	private Promo_interface dao;
	public PromoService() {
		dao = new PromoDAO();
	}
	
	public void DateEnd(long time) {
//		java.sql.Date promo_end = new java.sql.Date(time);
		List<PromoVO> list = dao.getAll();
		Integer promo_id = null;
		
		System.out.println(time);
		System.out.println(list);
		
		for(PromoVO promoVO:list) {
			if(time > promoVO.getPromo_end().getTime()) {
				promoVO.setPromo_id(promo_id);
				dao.promoDateEnd(promo_id);
			}
		}
	};
	
	
	public PromoVO insert(String promo_name, java.sql.Date promo_start, java.sql.Date promo_end, String promo_text,
			Integer status) {
		PromoVO promoVO = new PromoVO();
		

		promoVO.setPromo_name(promo_name);
		promoVO.setPromo_start(promo_start);
		promoVO.setPromo_end(promo_end);
		promoVO.setPromo_text(promo_text);
		promoVO.setStatus(status);
		dao.insert(promoVO);
		
		return promoVO;
	}
	
	public PromoVO update(Integer promo_id, String promo_name, java.sql.Date promo_start, java.sql.Date promo_end, String promo_text,
			Integer status) {
		
		PromoVO promoVO = new PromoVO();
		
		promoVO.setPromo_id(promo_id);
		promoVO.setPromo_name(promo_name);
		promoVO.setPromo_start(promo_start);
		promoVO.setPromo_end(promo_end);
		promoVO.setPromo_text(promo_text);
		promoVO.setStatus(status);
		dao.update(promoVO);
		
		return promoVO;
	}
	public void delete(Integer promo_id) {
		dao.delete(promo_id);
	}
	public PromoVO findByPrimaryKey(Integer promo_id) {
		return dao.findByPrimaryKey(promo_id);
	}
	public List<PromoVO> getAll() {
		return dao.getAll();
	}
	
	
}
