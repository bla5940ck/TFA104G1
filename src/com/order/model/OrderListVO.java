package com.order.model;

import java.io.Serializable;
import java.sql.Date;

public class OrderListVO implements Serializable {
	private Integer listID;
	private Integer prodID;
	private Integer ordID;
	private Integer prodPrice;	//商品小計
	private Integer ordStatus;
	private Date estStart;
	private Date estEnd;

	public OrderListVO(Integer listID, Integer prodID, Integer ordID, Integer prodPrice, Integer ordStatus, Date estStart, Date estEnd) {
		super();
		this.listID = listID;
		this.prodID = prodID;
		this.ordID = ordID;
		this.prodPrice = prodPrice;
		this.ordStatus = ordStatus;
		this.estStart = estStart;
		this.estEnd = estEnd;
	}
	public OrderListVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Integer getListID() {
		return listID;
	}
	public void setListID(Integer listID) {
		this.listID = listID;
	}
	public Integer getProdID() {
		return prodID;
	}
	public void setProdID(Integer prodID) {
		this.prodID = prodID;
	}
	public Integer getOrdID() {
		return ordID;
	}
	public void setOrdID(Integer ordID) {
		this.ordID = ordID;
	}
	public Integer getProdPrice() {
		return prodPrice;
	}
	public void setProdPrice(Integer prodPrice) {
		this.prodPrice = prodPrice;
	}
	
	public Integer getOrdStatus() {
		return ordStatus;
	}
	public void setOrdStatus(Integer ordStatus) {
		this.ordStatus = ordStatus;
	}
	public Date getEstStart() {
		return estStart;
	}
	public void setEstStart(Date estStart) {
		this.estStart = estStart;
	}
	public Date getEstEnd() {
		return estEnd;
	}
	public void setEstEnd(Date estEnd) {
		this.estEnd = estEnd;
	}
	@Override
	public String toString() {
		return "OrderListVO [listID=" + listID + ", prodID=" + prodID + ", ordID=" + ordID + ", prodPrice=" + prodPrice
				+ ", ordStatus=" + ordStatus + ", estStart=" + estStart + ", estEnd=" + estEnd + "]";
	}
}
