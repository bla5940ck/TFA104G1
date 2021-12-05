package com.chat_room.model;

import java.sql.Timestamp;

public class ChatroomVO implements java.io.Serializable {
	
	private Integer chatroomNo;
	private Integer rentId;
	private Integer leaseId;
	private Integer chatNo;
	private String chatText;
	private Timestamp chatTime;
	
	public ChatroomVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ChatroomVO(Integer chatroomNo, Integer rentId, Integer leaseId, Integer chatNo, String chatText,
			Timestamp chatTime) {
		super();
		this.chatroomNo = chatroomNo;
		this.rentId = rentId;
		this.leaseId = leaseId;
		this.chatNo = chatNo;
		this.chatText = chatText;
		this.chatTime = chatTime;
	}

	public Integer getChatroomNo() {
		return chatroomNo;
	}

	public void setChatroomNo(Integer chatroomNo) {
		this.chatroomNo = chatroomNo;
	}

	public Integer getRentId() {
		return rentId;
	}

	public void setRentId(Integer rentId) {
		this.rentId = rentId;
	}

	public Integer getLeaseId() {
		return leaseId;
	}

	public void setLeaseId(Integer leaseId) {
		this.leaseId = leaseId;
	}

	public Integer getChatNo() {
		return chatNo;
	}

	public void setChatNo(Integer chatNo) {
		this.chatNo = chatNo;
	}

	public String getChatText() {
		return chatText;
	}

	public void setChatText(String chatText) {
		this.chatText = chatText;
	}

	public Timestamp getChatTime() {
		return chatTime;
	}

	public void setChatTime(Timestamp chatTime) {
		this.chatTime = chatTime;
	}
	
	
	
	
	

}

	