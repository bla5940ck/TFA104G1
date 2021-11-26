package com.manager.model;

import java.util.List;

public class ManagerService {
private ManagerDAO_interface dao;

public ManagerService() {
	dao = new ManagerDAO();
}
public ManagerVO addManager(String managerUser,String managerName,String managerPassword,Integer status) {
	ManagerVO mvo = new ManagerVO();
	
	
	mvo.setManagerUser(managerUser);
	mvo.setManagerName(managerName);
	mvo.setManagerPassword(managerPassword);
	mvo.setStatus(status);
	return mvo;
	
}

public ManagerVO updateManager(Integer managerID,String managerUser,String managerName,String managerPassword,Integer status) {
	ManagerVO mvo = new ManagerVO();
	
	
	mvo.setManagerID(managerID);
	mvo.setManagerUser(managerUser);
	mvo.setManagerName(managerName);
	mvo.setManagerPassword(managerPassword);
	mvo.setStatus(status);
	dao.update(mvo);
	
	
	return mvo;
	
}
public void deleteManager(Integer managerID) {
	dao.delete(managerID);
}
public ManagerVO getOneManager(Integer managerID) {
	return dao.findByprimaryKey(managerID);
}

public List<ManagerVO> getAll(){
	return dao.getAll();
}
}
