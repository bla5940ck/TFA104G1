package com.booking.model;

import java.sql.Connection;
import java.sql.Date;
import java.util.List;

import com.product.model.ProdDAO;
import com.product.model.ProdDAO_Interface;

public class BookingService {
	
	public BookingDAO_interface dao;
	public ProdDAO_Interface dao2;
	public BookingService() {
		dao = new BookingDAO();
		dao2 = new ProdDAO();
	}
	
	
	public BookingVO addBk(Integer prodID,Integer status ,Date estStart ,Date estEnd ,Integer ordID) {
		BookingVO bk = new BookingVO();
		
		bk.setProdID(prodID);
		bk.setStatus(status);
		bk.setEstStart(estStart);
		bk.setEstEnd(estEnd);
		bk.setOrdID(ordID);
		
		dao.add(bk);
		
		return bk;
	}
	
	public BookingVO updateBk(Integer bkID,Integer prodID,Integer status ,Date estStart ,Date estEnd , Integer ordID) {
		BookingVO bk = new BookingVO();
		bk.setBkID(bkID);
		bk.setProdID(prodID);
		bk.setStatus(status);
		bk.setEstStart(estStart);
		bk.setEstEnd(estEnd);
		bk.setOrdID(ordID);
		
		dao.update(bk);
		return bk;
		
	}
	public void deleteBk(Integer bkID) {
		dao.delete(bkID);
	}
	public BookingVO findBkByPK(Integer bkID) {
		return dao.findBookingByPK(bkID);
	}
	public List<BookingVO> findDateByProdID(Integer bkID) {
		return dao.findDateByProdID(bkID);
	}
	public List<BookingVO> getAll() {
		return dao.getAll();
	}
	
	public BookingVO insertWithList(Integer prodID,Integer status ,Date estStart ,Date estEnd , Integer ordID,Connection con) {
		BookingVO bk = new BookingVO();
		
		bk.setProdID(prodID);
		bk.setStatus(status);
		bk.setEstStart(estStart);
		bk.setEstEnd(estEnd);
		bk.setOrdID(ordID);
			
		dao.add2(bk, con);
		
		return bk;
	}

}
