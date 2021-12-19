package com.category.model;

public class ProdCategoryVO implements java.io.Serializable{
	private Integer categoryID;
	private String categoryName;
	
	public ProdCategoryVO() {
		super();
	
	}
	public ProdCategoryVO(Integer categoryID, String categoryName) {
		super();
		this.categoryID = categoryID;
		this.categoryName = categoryName;
	}
	public Integer getCategoryID() {
		return categoryID;
	}
	public void setCategoryID(Integer categoryID) {
		this.categoryID = categoryID;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	

}
