package com.product.model;

import java.util.List;

public interface ProdDAO_Interface {
	public Integer add(ProdVO prod);
	public void update(ProdVO prod);
	public void deleteProudct(ProdVO prod);
	public ProdVO findProductByPK(Integer prodId);
	public List<ProdVO> getAll();
	public List<ProdVO> priceSortAsc();	
	public List<ProdVO> priceSortDesc();	
	public List<ProdVO> getAllByKeyword(String keyword);
	
}
