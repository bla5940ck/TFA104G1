package com.booking.model;

import java.util.List;
import java.util.Map;

public interface BookingDAO_interface {
	public void add(BookingVO bk);
	public void update(BookingVO bk);
	public void delete(Integer bkID);
	public BookingVO  findBookingByPK(Integer bkID);
	public List<BookingVO> getAll();
	public List<BookingVO> findDateByProdID(Integer prodID);
	public Map<Integer, Integer> getSortByCount();
}
