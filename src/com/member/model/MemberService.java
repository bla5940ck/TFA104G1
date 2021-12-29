package com.member.model;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.List;

public class MemberService {
	
	private MemberDAO_interface dao;
	
	public MemberService() {
		dao = new MemberDAO();
	}
	
	public MemberVO addMem(String bankCode ,String email, String loginId ,
			String idcn ,String phoneNum ,String password ,Integer status ,String name ,
			String nickName , Date birthday ,String address ,String bankAccount ,String accountName,
			Double rentScore ,Double leaseScore, Timestamp creatDate, byte[] pic ,byte[] idcF ,byte[] idcB,Integer foul) {
		MemberVO memberVO = new MemberVO();
		memberVO.setBankCode(bankCode);
		memberVO.setEmail(email);
		memberVO.setLoginId(loginId);
		memberVO.setIdcn(idcn);
		memberVO.setPhoneNum(phoneNum);
		memberVO.setPassword(password);
		memberVO.setStatus(status);
		memberVO.setName(name);
		memberVO.setNickName(nickName);
		memberVO.setBirthday(birthday);
		memberVO.setAddress(address);
		memberVO.setBankAccount(bankAccount);
		memberVO.setAccountName(accountName);
		memberVO.setRentScore(rentScore);
		memberVO.setLeaseScore(leaseScore);
		memberVO.setCreatDate(creatDate);
		memberVO.setPic(pic);
		memberVO.setIdcF(idcF);
		memberVO.setIdcB(idcB);
		memberVO.setFoul(foul);
		dao.insert(memberVO);
		return memberVO;
	}
	
	public MemberVO updateMember(String bankCode ,String email, String loginId ,
			String idcn ,String phoneNum ,String password ,Integer status ,String name ,
			String nickName , Date birthday ,String address ,String bankAccount ,String accountName,
			Double rentScore ,Double leaseScore, Timestamp creatDate, byte[] pic ,byte[] idcF ,byte[] idcB,Integer foul) {
		MemberVO memberVO = new MemberVO();
//		memberVO.setMemberId(memberId);
		memberVO.setBankCode(bankCode);
		memberVO.setEmail(email);
		memberVO.setLoginId(loginId);
		memberVO.setIdcn(idcn);
		memberVO.setPhoneNum(phoneNum);
		memberVO.setPassword(password);
		memberVO.setStatus(status);
		memberVO.setName(name);
		memberVO.setNickName(nickName);
		memberVO.setBirthday(birthday);
		memberVO.setAddress(address);
		memberVO.setBankAccount(bankAccount);
		memberVO.setAccountName(accountName);
		memberVO.setRentScore(rentScore);
		memberVO.setLeaseScore(leaseScore);
		memberVO.setCreatDate(creatDate);
		memberVO.setPic(pic);
		memberVO.setIdcF(idcF);
		memberVO.setIdcB(idcB);
		memberVO.setFoul(foul);
		dao.update(memberVO);
		return memberVO;
	}
	//會員狀態審核
	public MemberVO updateStatus(Integer status ,Integer memberId
			) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberId(memberId);
		memberVO.setStatus(status);
		dao.updateStatus(memberVO);
		return memberVO;
	}
	
	//後台會員基本資料更改
		public MemberVO updateBackMember(Integer memberId,Integer foul ,Integer status ,Double rentScore,Double leaseScore
				) {
			MemberVO memberVO = new MemberVO();
			memberVO.setMemberId(memberId);
			memberVO.setFoul(foul);
			memberVO.setStatus(status);
//			memberVO.setBirthday(birthday);
			memberVO.setRentScore(rentScore);
			memberVO.setLeaseScore(leaseScore);
			dao.updateBackOneMember(memberVO);
			return memberVO;
		}
	//前台會員基本資料更改
	public MemberVO updateMemberBasicInformation(Integer memberId,String nickName,  String email , String phoneNum ,byte[] pic
			) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberId(memberId);
		memberVO.setNickName(nickName);
		memberVO.setEmail(email);
		memberVO.setPhoneNum(phoneNum);
		memberVO.setPic(pic);
		dao.updateMemberBasicInformation(memberVO);
		return memberVO;
	}
	//前台會員密碼變更
	public MemberVO updatePw(String password,String loginId
			) {
		MemberVO memberVO = new MemberVO();
		memberVO.setPassword(password);
		memberVO.setLoginId(loginId);
		dao.updatePw(memberVO);
		return memberVO;
	}
	//前台會員銀行變更
	public MemberVO updateAccount(Integer memberId,String bankCode,String bankAccount,String accountName
			) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberId(memberId);
		memberVO.setBankCode(bankCode);
		memberVO.setBankAccount(bankAccount);
		memberVO.setAccountName(accountName);

		dao.updateAccount(memberVO);
		return memberVO;
	}
	
	public MemberVO updateOneMember(Integer memberId,String name,
			String email, Timestamp creatDate,String loginId,String phoneNum,Integer status
			) {
		MemberVO memberVO = new MemberVO();
		memberVO.setMemberId(memberId);
		memberVO.setEmail(email);
		memberVO.setLoginId(loginId);
		memberVO.setPhoneNum(phoneNum);
		memberVO.setStatus(status);
		memberVO.setCreatDate(creatDate);
		memberVO.setName(name);
		dao.updateOneStatus(memberVO);
		return memberVO;
	}
	
	public MemberVO getOneMember(Integer memberId) {
		return dao.findByPrimaryKey(memberId);
	}
	
	public MemberVO 	getLoginMember(String loginId) {
		return dao.findLoginID(loginId);
	}
	
	public MemberVO 	login(String loginId,String password) {
		return dao.login(loginId,password);
	}

	public MemberVO 	findEmail(String email) {
		return dao.findEmail(email);
	}
	
	public List<MemberVO> getAll(){
		return dao.getAll();
	}
	public List<MemberVO> getPdrMember(){
		return dao.findPdrID();
	}
}
