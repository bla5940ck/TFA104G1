package com.member.model;

import java.util.*;

public interface MemberDAO_interface {
	public void insert(MemberVO memberVO);
    public void update(MemberVO memberVO);
    public void updateStatus(MemberVO memberVO);
    public void updatePw(MemberVO memberVO);
    public void updateAccount(MemberVO memberVO);
    public void updateOneStatus(MemberVO memberVO);
    public void updateMemberBasicInformation(MemberVO memberVO);
    public void updateBackOneMember(MemberVO memberVO);
    
//    public void delete( Integer memberId);
    public MemberVO findByPrimaryKey(Integer memberId);
    public MemberVO findLoginID(String loginId);
    public MemberVO login(String loginId ,String password);
    public MemberVO findEmail(String email);
 
    
    public List<MemberVO> findPdrID();
    public List<MemberVO> getAll();
    // //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<MemberVO> getAll(Map<String, String[]> map); 
}
