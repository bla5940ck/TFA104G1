package com.member.model;

import java.util.List;

public class DefAddressService {
	
	private DefAddressDAO_interface dao;
	
	public DefAddressService() {
		dao = new DefAddressJDBCDAO();
	}
	
	public DefAddressVO addDefaddress(Integer memberId, Integer code711, String name711, String add711
			, Integer status, String recipient,  String recptPhone) {
		
		DefAddressVO defAddressVO = new DefAddressVO();
		defAddressVO.setMemberId(memberId);
		defAddressVO.setCode711(code711);
		defAddressVO.setName711(name711);
		defAddressVO.setAdd711(add711);
		defAddressVO.setStatus(status);
		defAddressVO.setRecipient(recipient);
		defAddressVO.setRecptPhone(recptPhone);
		dao.insert(defAddressVO);
		
		return defAddressVO;
		
	}
	
	//�w�d�� Struts 2 �Ϊ�
	public void addDefaddress(DefAddressVO defAddressVO) {
		dao.insert(defAddressVO);
	}
	public void deleteDefaddress(Integer def711) {
		dao.delete(def711);
	}
	
	public DefAddressVO updateDefaddress(Integer def711, Integer memberId, Integer code711, String name711, String add711
			, Integer status, String recipient,  String recptPhone) {
		
		DefAddressVO defAddressVO = new DefAddressVO();
		defAddressVO.setDef711(def711);
		defAddressVO.setMemberId(memberId);
		defAddressVO.setCode711(code711);
		defAddressVO.setName711(name711);
		defAddressVO.setAdd711(add711);
		defAddressVO.setStatus(status);
		defAddressVO.setRecipient(recipient);
		defAddressVO.setRecptPhone(recptPhone);
		dao.update(defAddressVO);
		
		return dao.findByPrimaryKey(def711);
	}
	
	public  DefAddressVO getOneDefaddress(Integer def711) {
		return dao.findByPrimaryKey(def711);
	}
	
	public List<DefAddressVO> getAll(){
		return dao.getAll();
	}
	public List<DefAddressVO> getOneMemAll(Integer memberId){
		return dao.getOneMemAll(memberId);
	}
}
