package com.postboard.model;

import java.sql.Timestamp;
import java.util.Arrays;

public class PostBoardVO implements java.io.Serializable {
	

	private Integer postId;
	private Integer categoryId;
	private Integer memberId;
	private String postTitle;
	private String postCont;
	private Timestamp postTime;
	private Integer replyCount;
	private byte[] pic;
	
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
	@Override
	public String toString() {
		return "PostBoardVO [postId=" + postId + ", categoryId=" + categoryId + ", memberId=" + memberId
				+ ", postTitle=" + postTitle + ", postCont=" + postCont + ", postTime=" + postTime + ", replyCount="
				+ replyCount + ", pic=" + Arrays.toString(pic) + "]";
	}
	
	
	
}