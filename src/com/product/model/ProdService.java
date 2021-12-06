package com.product.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.category.model.ProdCategoryDAO;
import com.category.model.ProdCategoryDAOImpl;
import com.category.model.ProdCategoryImpl;



public class ProdService {
	private ProdDAOImpl dao;
	private ProdCategoryDAOImpl dao2;
	public ProdService() {
		dao = new ProdDAO();
		dao2 = new ProdCategoryDAO();
	}

	public Integer AddProd( Integer cate, String name, String cot, Integer rent,
			Integer price, String comt, byte[] pic1, byte[] pic2, byte[] pic3,Timestamp shelfDate) {
		ProdVO prod = new ProdVO();
		
		prod.setCategoryID(cate);
		prod.setProdName(name);
		prod.setProdRent(rent);
		prod.setProdPrice(price);
		prod.setComt(comt);
		prod.setProdCot(cot);
		prod.setProdStatus(0);// �ݤW�[�N�X
		prod.setPic1(pic1);
		prod.setPic2(pic2);
		prod.setPic3(pic3);
		prod.setShelfDate(shelfDate);
	
			Integer key =dao.add(prod);
 			
		return key;
	}
	public ProdVO updateProd(Integer prodID, Integer cate, String name, String cot, Integer rent,
			Integer price, String comt, byte[] pic1, byte[] pic2, byte[] pic3,Timestamp shelfDate,Integer status) {
		ProdVO prod = new ProdVO();
		prod.setProdID(prodID);
		prod.setCategoryID(cate);
		prod.setProdName(name);
		prod.setProdRent(rent);
		prod.setProdPrice(price);
		prod.setComt(comt);
		prod.setProdCot(cot);
		prod.setProdStatus(status);// !!!
		prod.setPic1(pic1);
		prod.setPic2(pic2);
		prod.setPic3(pic3);
		prod.setShelfDate(shelfDate);
		dao.update(prod);
		
		return prod;
	}
	public List<ProdVO> getAll() {
		return dao.getAll();
	}
	public ProdVO findProductByPK(Integer prodId) {
		return dao.findProductByPK(prodId);
	}
	public List<ProdVO> getSortAsc(){
		return dao.priceSortAsc();
	}
	public List<ProdVO> getSortDesc(){
		return dao.priceSortDesc();
	}
	public List<ProdVO> getAllByKeyword(String keyword){
		return dao.getAllByKeyword(keyword);
	}
//	public String getCateNameByProdID(Integer categoryID) {
//		
//		dao2.findCategoryByPK(categoryID);
//		
//	}
	
}
