package com.post_borad.model;

import java.sql.Timestamp;

public class PostBoradVO {
	
	private Integer postId;
	private Integer categoryId;
	private Integer memberId;
	private String postTitle;
	private String postCont;
	private Timestamp postTime;
	private Integer replyCount;
	private byte[] pic;
	
	public PostBoradVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public PostBoradVO(Integer postId, Integer categoryId, Integer memberId, String postTitle, String postCont,
			Timestamp postTime, Integer replyCount, byte[] pic) {
		super();
		this.postId = postId;
		this.categoryId = categoryId;
		this.memberId = memberId;
		this.postTitle = postTitle;
		this.postCont = postCont;
		this.postTime = postTime;
		this.replyCount = replyCount;
		this.pic = pic;
	}

	public Integer getPostId() {
		return postId;
	}

	public void setPostId(Integer postId) {
		this.postId = postId;
	}

	public Integer getCategoryId() {
		return categoryId;
	}

	public void setCategoryId(Integer categoryId) {
		this.categoryId = categoryId;
	}

	public Integer getMemberId() {
		return memberId;
	}

	public void setMemberId(Integer memberId) {
		this.memberId = memberId;
	}

	public String getPostTitle() {
		return postTitle;
	}

	public void setPostTitle(String postTitle) {
		this.postTitle = postTitle;
	}

	public String getPostCont() {
		return postCont;
	}

	public void setPostCont(String postCont) {
		this.postCont = postCont;
	}

	public Timestamp getPostTime() {
		return postTime;
	}

	public void setPostTime(Timestamp postTime) {
		this.postTime = postTime;
	}

	public Integer getReplyCount() {
		return replyCount;
	}

	public void setReplyCount(Integer replyCount) {
		this.replyCount = replyCount;
	}

	public byte[] getPic() {
		return pic;
	}

	public void setPic(byte[] pic) {
		this.pic = pic;
	}
	
	
	
	
	
}