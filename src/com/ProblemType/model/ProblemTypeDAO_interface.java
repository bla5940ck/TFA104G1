package com.ProblemType.model;

import java.util.List;

public interface ProblemTypeDAO_interface {
	public void insert(ProblemTypeVO problemTypeVO);
	public void update(ProblemTypeVO problemTypeVO);
	public void delete(Integer typeID);
	public ProblemTypeVO findByprimaryKey(Integer typeID);
	public List<ProblemTypeVO> getAll();
}
