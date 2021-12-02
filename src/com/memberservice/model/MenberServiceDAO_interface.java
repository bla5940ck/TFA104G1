package com.memberservice.model;

import java.util.List;

public interface MenberServiceDAO_interface {
	public void insert(MenberServiceVO manberServiceVO);
	public void update(MenberServiceVO manberServiceVO);
	public void delete(Integer msgID);
	public MenberServiceVO findByprimaryKey(Integer msgID);
	public List<MenberServiceVO> getAll();
}
