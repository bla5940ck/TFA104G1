package com.order.model;

import java.io.Serializable;
import java.sql.Date;
import java.sql.Timestamp;

public class OrderMasterVO implements Serializable{
	private Integer ordID;
	private Integer rentID; // 承租者
	private Integer leaseID; // 出租者
	private Integer payID; // 付款方式
	private Integer couponID;
	private Integer shipStatus;
	private Integer payStatus;
	private Integer ordStatus;
	private Timestamp ordDate;
	private Integer shipCode;
	private Integer returnCode;
	private Integer storeCode;
	private Date estStart; // 預計開始
	private Date estEnd; // 預計結束
	private Timestamp shipDate; // 實際出貨日期
	private Timestamp arrivalDate;
	private Timestamp returnDate;
	private Integer rentDays;
	private Integer rentRank; // 承租評價
	private Integer leaseRank;
	private String rentComt; // 承租評價日期
	private String leaseComt;
	private Timestamp rentComtdate;
	private Timestamp leaseComtdate;
	private Integer prodPrice; // 商品小計
	private Integer shipFee;
	private Integer ordPrice;
	private Timestamp estTrfDa; // 預計轉帳日期
	private Integer trfStatus; // 轉帳狀態
	private Timestamp payDate; //付款日期
	
	public OrderMasterVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Integer getOrdID() {
		return ordID;
	}

	public void setOrdID(Integer ordID) {
		this.ordID = ordID;
	}

	public Integer getRentID() {
		return rentID;
	}

	public void setRentID(Integer rentID) {
		this.rentID = rentID;
	}

	public Integer getLeaseID() {
		return leaseID;
	}

	public void setLeaseID(Integer leaseID) {
		this.leaseID = leaseID;
	}

	public Integer getPayID() {
		return payID;
	}

	public void setPayID(Integer payID) {
		this.payID = payID;
	}

	public Integer getCouponID() {
		return couponID;
	}

	public void setCouponID(Integer couponID) {
		this.couponID = couponID;
	}

	public Integer getShipStatus() {
		return shipStatus;
	}

	public void setShipStatus(Integer shipStatus) {
		this.shipStatus = shipStatus;
	}

	public Integer getPayStatus() {
		return payStatus;
	}

	public void setPayStatus(Integer payStatus) {
		this.payStatus = payStatus;
	}

	public Integer getOrdStatus() {
		return ordStatus;
	}

	public void setOrdStatus(Integer ordStatus) {
		this.ordStatus = ordStatus;
	}

	public Timestamp getOrdDate() {
		return ordDate;
	}

	public void setOrdDate(Timestamp ordDate) {
		this.ordDate = ordDate;
	}

	public Integer getShipCode() {
		return shipCode;
	}

	public void setShipCode(Integer shipCode) {
		this.shipCode = shipCode;
	}

	public Integer getReturnCode() {
		return returnCode;
	}

	public void setReturnCode(Integer returnCode) {
		this.returnCode = returnCode;
	}

	public Integer getStoreCode() {
		return storeCode;
	}

	public void setStoreCode(Integer storeCode) {
		this.storeCode = storeCode;
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

	public Timestamp getShipDate() {
		return shipDate;
	}

	public void setShipDate(Timestamp shipDate) {
		this.shipDate = shipDate;
	}

	public Timestamp getArrivalDate() {
		return arrivalDate;
	}

	public void setArrivalDate(Timestamp arrivalDate) {
		this.arrivalDate = arrivalDate;
	}

	public Timestamp getReturnDate() {
		return returnDate;
	}

	public void setReturnDate(Timestamp returnDate) {
		this.returnDate = returnDate;
	}

	public Integer getRentDays() {
		return rentDays;
	}

	public void setRentDays(Integer rentDays) {
		this.rentDays = rentDays;
	}

	public Integer getRentRank() {
		return rentRank;
	}

	public void setRentRank(Integer rentRank) {
		this.rentRank = rentRank;
	}

	public Integer getLeaseRank() {
		return leaseRank;
	}

	public void setLeaseRank(Integer leaseRank) {
		this.leaseRank = leaseRank;
	}

	public String getRentComt() {
		return rentComt;
	}

	public void setRentComt(String rentComt) {
		this.rentComt = rentComt;
	}

	public String getLeaseComt() {
		return leaseComt;
	}

	public void setLeaseComt(String leaseComt) {
		this.leaseComt = leaseComt;
	}

	public Timestamp getRentComtdate() {
		return rentComtdate;
	}

	public void setRentComtdate(Timestamp rentComtdate) {
		this.rentComtdate = rentComtdate;
	}

	public Timestamp getLeaseComtdate() {
		return leaseComtdate;
	}

	public void setLeaseComtdate(Timestamp leaseComtdate) {
		this.leaseComtdate = leaseComtdate;
	}

	public Integer getProdPrice() {
		return prodPrice;
	}

	public void setProdPrice(Integer prodPrice) {
		this.prodPrice = prodPrice;
	}

	public Integer getShipFee() {
		return shipFee;
	}

	public void setShipFee(Integer shipFee) {
		this.shipFee = shipFee;
	}

	public Integer getOrdPrice() {
		return ordPrice;
	}

	public void setOrdPrice(Integer ordPrice) {
		this.ordPrice = ordPrice;
	}

	public Timestamp getEstTrfDa() {
		return estTrfDa;
	}

	public void setEstTrfDa(Timestamp estTrfDa) {
		this.estTrfDa = estTrfDa;
	}

	public Integer getTrfStatus() {
		return trfStatus;
	}

	public void setTrfStatus(Integer trfStatus) {
		this.trfStatus = trfStatus;
	}

	public Timestamp getPayDate() {
		return payDate;
	}

	public void setPayDate(Timestamp payDate) {
		this.payDate = payDate;
	}

	@Override
	public String toString() {
		return "OrderMasterVO [ordID=" + ordID + ", rentID=" + rentID + ", leaseID=" + leaseID + ", payID=" + payID
				+ ", couponID=" + couponID + ", shipStatus=" + shipStatus + ", payStatus=" + payStatus + ", ordStatus="
				+ ordStatus + ", ordDate=" + ordDate + ", shipCode=" + shipCode + ", returnCode=" + returnCode
				+ ", storeCode=" + storeCode + ", estStart=" + estStart + ", estEnd=" + estEnd + ", shipDate="
				+ shipDate + ", arrivalDate=" + arrivalDate + ", returnDate=" + returnDate + ", rentDays=" + rentDays
				+ ", rentRank=" + rentRank + ", leaseRank=" + leaseRank + ", rentComt=" + rentComt + ", leaseComt="
				+ leaseComt + ", rentComtdate=" + rentComtdate + ", leaseComtdate=" + leaseComtdate + ", prodPrice="
				+ prodPrice + ", shipFee=" + shipFee + ", ordPrice=" + ordPrice + ", estTrfDa=" + estTrfDa
				+ ", trfStatus=" + trfStatus + ", payDate=" + payDate + "]";
	}
	
	

}
