package com.pb_reply.model;

import java.sql.Timestamp;

public class pbReplyVO {
	
	private Integer replyId;
	private Integer postId;
	private Integer memberId;
	private String replyCont;
	private Timestamp replyTime;
	
	public pbReplyVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public pbReplyVO(Integer replyId, Integer postId, Integer memberId, String replyCont, Timestamp replyTime) {
		super();
		this.replyId = replyId;
		this.postId = postId;
		this.memberId = memberId;
		this.replyCont = replyCont;
		this.replyTime = replyTime;
	}

	public Integer getReplyId() {
		return replyId;
	}

	public void setReplyId(Integer replyId) {
		this.replyId = replyId;
	}

	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getReplyCont() {
		return replyCont;
	}

	public void setReplyCont(String replyCont) {
		this.replyCont = replyCont;
	}

	public Timestamp getReplyTime() {
		return replyTime;
	}

	public void setReplyTime(Timestamp replyTime) {
		this.replyTime = replyTime;
	}
	
	
	
	
	
	
	

}
