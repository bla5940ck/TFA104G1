package com.ProblemType.model;

import java.util.List;

import com.ProblemType.model.ProblemTypeDAO;
import com.ProblemType.model.ProblemTypeDAO_interface;
import com.ProblemType.model.ProblemTypeVO;

public class ProblemTypeService {
	private ProblemTypeDAO_interface dao;

	public ProblemTypeService() {
		dao = new ProblemTypeDAO();
	}
	public ProblemTypeVO addManager(String typeName) {
		ProblemTypeVO ptvo = new ProblemTypeVO();
		
		
	
		ptvo.setTypeName(typeName);
		
		return ptvo;
		
	}

	public ProblemTypeVO updateProblemType(Integer typeID,String typeName) {
		ProblemTypeVO ptvo = new ProblemTypeVO();		
		
		ptvo.setTypeID(typeID);
		ptvo.setTypeName(typeName);
		
		dao.update(ptvo);
		
		
		return ptvo;
		
	}
	public void deleteProblemType(Integer typeID) {
		dao.delete(typeID);
	}
	public ProblemTypeVO getOneProblemType(Integer typeID) {
		return dao.findByprimaryKey(typeID);
	}

	public List<ProblemTypeVO> getAll(){
		return dao.getAll();
	}
}
