package com.category.model;

import java.util.List;


public class ProdCategoryService {
	private ProdCategoryDAOImpl dao;
	
	public ProdCategoryService() {
		dao = new ProdCategoryDAO();
	}
	
	
	public List<ProdCategoryVO> getAllCategory() {
		return dao.getAllCategory();
	}
	
	
	public ProdCategoryVO findCategoryByPK(Integer id) {
		
		ProdCategoryVO cateVO = new ProdCategoryVO();
		
		return dao.findCategoryByPK(id);
		
		
	}
}
