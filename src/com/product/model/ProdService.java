package com.product.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.stream.Collector;
import java.util.stream.Collectors;

import com.booking.model.BookingDAO;
import com.category.model.ProdCategoryDAO;
import com.category.model.ProdCategory_Interface;
import com.category.model.ProdCategory_Interface;



public class ProdService {
	private ProdDAO_Interface dao;
	private ProdCategory_Interface dao2;
	private BookingDAO dao3;

	public ProdService() {
		dao = new ProdDAO();
		dao2 = new ProdCategoryDAO();
		dao3 = new BookingDAO();
	}

	public Integer AddProd( Integer cate, String name, String cot, Integer rent,
			Integer price, String comt, byte[] pic1, byte[] pic2, byte[] pic3,Timestamp shelfDate,Integer memberID) {
		ProdVO prod = new ProdVO();
		
		prod.setCategoryID(cate);
		prod.setProdName(name);
		prod.setProdRent(rent);
		prod.setProdPrice(price);
		prod.setComt(comt);
		prod.setProdCot(cot);
		prod.setProdStatus(0);
		prod.setPic1(pic1);
		prod.setPic2(pic2);
		prod.setPic3(pic3);
		prod.setShelfDate(shelfDate);
		prod.setMemberID(memberID);
	
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
	public List<ProdVO> getAllByTimeDesc(){
		List<ProdVO> list = dao.getAll();
		return list.stream()
				.filter(p ->p.getShelfDate()!=null)	
					.sorted(Comparator.comparing(ProdVO::getShelfDate)
							.reversed())
								.collect(Collectors.toList());
	}
	public Map<Integer, Integer> getCountGroupbyProdID(){

		
		return  dao3.getSortByCount();
				
	}
	
}
