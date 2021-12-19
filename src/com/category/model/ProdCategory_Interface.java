package com.category.model;

import java.util.List;

public interface ProdCategory_Interface {
	public ProdCategoryVO findCategoryByPK(int id);
	public List<ProdCategoryVO> getAllCategory();
	public void addCategory(ProdCategoryVO prodCategory);

}
