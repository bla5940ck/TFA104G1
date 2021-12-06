package com.problemtype.model;

public class ProblemTypeVO {
	private Integer typeID;
	private String typeName;
	
	

	public ProblemTypeVO() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	

	public ProblemTypeVO(Integer typeID, String typeName) {
		super();
		this.typeID = typeID;
		this.typeName = typeName;
	}



	public Integer getTypeID() {
		return typeID;
	}

	public void setTypeID(Integer typeID) {
		this.typeID = typeID;
	}

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
	}

	@Override
	public String toString() {
		return "ProblemTypeVO [typeID=" + typeID + ", typeName=" + typeName + "]";
	}

	

}
