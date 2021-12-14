package com.member.model;

import java.util.List;
import java.util.Set;



public class BankService {
	private BankDAO_interface dao;

	public BankService() {
		dao = new BankJDBCDAO();
	}

	public BankVO addBank(String code,String chineseName) {

		BankVO bankVO= new BankVO();
		bankVO.setCode(code);
		bankVO.setChineseName(chineseName);
		
		dao.insert(bankVO);

		return bankVO;

	}

	public void addBank(BankVO bankVO) {
		dao.insert(bankVO);
	}

//	public void deleteBank(String code) {
//		dao.delete(code);
//	}

	public BankVO updateBank(String code,String chineseName) {

		BankVO bankVO= new BankVO();
		bankVO.setCode(code);
		bankVO.setChineseName(chineseName);
		
		dao.update(bankVO);

		return dao.findByPrimaryKey(code);
	}

	public  BankVO getOneBank(String code) {
		return dao.findByPrimaryKey(code);
	}

	public List<BankVO> getAll() {
		return dao.getAll();
	}
	
	public Set<MemberVO> getEmpsByDeptno(String bankCode) {
		return dao.getMemberByBankCode(bankCode);
	}
}
