package com.manager.model;

public class ManagerVO {
	private Integer managerID;
	private String managerUser;
	private String managerName;
	private String managerPassword;
	private Integer status;

	public ManagerVO() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManagerVO(Integer managerID, String managerUser, String managerName, String managerPassword,
			Integer status) {
		super();
		this.managerID = managerID;
		this.managerUser = managerUser;
		this.managerName = managerName;
		this.managerPassword = managerPassword;
		this.status = status;
	}

	public Integer getManagerID() {
		return managerID;
	}

	public void setManagerID(Integer managerID) {
		this.managerID = managerID;
	}

	public String getManagerUser() {
		return managerUser;
	}

	public void setManagerUser(String managerUser) {
		this.managerUser = managerUser;
	}

	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getManagerPassword() {
		return managerPassword;
	}

	public void setManagerPassword(String managerPassword) {
		this.managerPassword = managerPassword;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "ManagerVO [managerID=" + managerID + ", managerUser=" + managerUser + ", managerName=" + managerName
				+ ", managerPassword=" + managerPassword + ", status=" + status + "]";
	}

	

}
