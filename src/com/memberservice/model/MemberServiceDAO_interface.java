package com.memberservice.model;

import java.util.List;

public interface MemberServiceDAO_interface {
	public void insert(MemberServiceVO manberServiceVO);
	public void update(MemberServiceVO manberServiceVO);
	public void delete(Integer msgID);
	public MemberServiceVO findByprimaryKey(Integer msgID);
	public List<MemberServiceVO> getAll();
}
