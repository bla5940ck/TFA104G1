package com.manager.model;

import java.util.List;

public interface ManagerDAO_interface {
	public void insert(ManagerVO managerVO);
	public void update(ManagerVO managerVO);
	public void delete(Integer manager_id);
	public ManagerVO findByprimaryKey(Integer manager_id);
	public List<ManagerVO> getAll();
	public ManagerVO login(String manager_user,String manager_password);
}

