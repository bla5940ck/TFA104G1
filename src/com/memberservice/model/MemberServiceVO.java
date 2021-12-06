package com.memberservice.model;

import java.sql.Timestamp;
import java.util.Arrays;

public class MemberServiceVO {
	private Integer msgID;
	private Integer prodID;
	private Integer memberID;
	private Integer managerID;
	private Integer typeID;
	private Integer ordID;
	private Timestamp msgDate;
	private String problemMsg;
	private String msgRes;
	private byte[] pic1;
	private byte[] pic2;
	private byte[] pic3;
	private Integer problemStatus;

	public MemberServiceVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MemberServiceVO(Integer msgID, Integer prodID, Integer memberID, Integer managerID, Integer typeID,
			Integer ordID, Timestamp msgDate, String problemMsg, String msgRes, byte[] pic1, byte[] pic2, byte[] pic3,
			Integer problemStatus) {
		super();
		this.msgID = msgID;
		this.prodID = prodID;
		this.memberID = memberID;
		this.managerID = managerID;
		this.typeID = typeID;
		this.ordID = ordID;
		this.msgDate = msgDate;
		this.problemMsg = problemMsg;
		this.msgRes = msgRes;
		this.pic1 = pic1;
		this.pic2 = pic2;
		this.pic3 = pic3;
		this.problemStatus = problemStatus;
	}

	public Integer getMsgID() {
		return msgID;
	}

	public void setMsgID(Integer msgID) {
		this.msgID = msgID;
	}

	public Integer getProdID() {
		return prodID;
	}

	public void setProdID(Integer prodID) {
		this.prodID = prodID;
	}

	public Integer getMemberID() {
		return memberID;
	}

	public void setMemberID(Integer memberID) {
		this.memberID = memberID;
	}

	public Integer getManagerID() {
		return managerID;
	}

	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}

	public Integer getTypeID() {
		return typeID;
	}

	public void setTypeID(Integer typeID) {
		this.typeID = typeID;
	}

	public Integer getOrdID() {
		return ordID;
	}

	public void setOrdID(Integer ordID) {
		this.ordID = ordID;
	}

	public Timestamp getMsgDate() {
		return msgDate;
	}

	public void setMsgDate(Timestamp msgDate) {
		this.msgDate = msgDate;
	}

	public String getProblemMsg() {
		return problemMsg;
	}

	public void setProblemMsg(String problemMsg) {
		this.problemMsg = problemMsg;
	}

	public String getMsgRes() {
		return msgRes;
	}

	public void setMsgRes(String msgRes) {
		this.msgRes = msgRes;
	}

	public byte[] getPic1() {
		return pic1;
	}

	public void setPic1(byte[] pic1) {
		this.pic1 = pic1;
	}

	public byte[] getPic2() {
		return pic2;
	}

	public void setPic2(byte[] pic2) {
		this.pic2 = pic2;
	}

	public byte[] getPic3() {
		return pic3;
	}

	public void setPic3(byte[] pic3) {
		this.pic3 = pic3;
	}

	public Integer getProblemStatus() {
		return problemStatus;
	}

	public void setProblemStatus(Integer problemStatus) {
		this.problemStatus = problemStatus;
	}

	@Override
	public String toString() {
		return "ManberServiceVO [msgID=" + msgID + ", prodID=" + prodID + ", memberID=" + memberID + ", managerID="
				+ managerID + ", typeID=" + typeID + ", ordID=" + ordID + ", msgDate=" + msgDate + ", problemMsg="
				+ problemMsg + ", msgRes=" + msgRes + ", pic1=" + Arrays.toString(pic1) + ", pic2="
				+ Arrays.toString(pic2) + ", pic3=" + Arrays.toString(pic3) + ", problemStatus=" + problemStatus + "]";
	}

}
