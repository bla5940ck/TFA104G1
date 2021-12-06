package com.memberservice.model;

import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.Part;

import com.memberservice.model.MemberServiceVO;

public class MemberServiceService {

	private MemberServiceDAO_interface dao;

	public MemberServiceService() {

		dao = new MemberServiceDAO();

	}

	public MemberServiceVO addMemberService(Integer prodID, Integer memberID, Integer managerID, Integer typeID,
			Integer ordID, Timestamp msgDate, String problemMsg, String msgRes, byte[] pic1, byte[] pic2, byte[] pic3,
			Integer problemStatus) {

		MemberServiceVO msVO = new MemberServiceVO();

		msVO.setProdID(prodID);
		msVO.setMemberID(memberID);
		msVO.setManagerID(managerID);
		msVO.setTypeID(typeID);
		msVO.setOrdID(ordID);
		msVO.setMsgDate(msgDate);
		msVO.setProblemMsg(problemMsg);
		msVO.setMsgRes(msgRes);
		msVO.setPic1(pic1);
		msVO.setPic2(pic2);
		msVO.setPic3(pic3);
		msVO.setProblemStatus(problemStatus);
		msVO.setProdID(prodID);

		dao.insert(msVO);

		return msVO;
	}

	public MemberServiceVO updateMemberService(Integer msgID, Integer prodID, Integer memberID, Integer managerID,
			Integer typeID, Integer ordID, Timestamp msgDate, String problemMsg, String msgRes, byte[] pic1,
			byte[] pic2, byte[] pic3, Integer problemStatus) {

		MemberServiceVO msVO = new MemberServiceVO();

		msVO.setMsgID(msgID);
		msVO.setProdID(prodID);
		msVO.setMemberID(memberID);
		msVO.setManagerID(managerID);
		msVO.setTypeID(typeID);
		msVO.setOrdID(ordID);
		msVO.setMsgDate(msgDate);
		msVO.setProblemMsg(problemMsg);
		msVO.setMsgRes(msgRes);
		msVO.setPic1(pic1);
		msVO.setPic2(pic2);
		msVO.setPic3(pic3);
		msVO.setProblemStatus(problemStatus);
		msVO.setProdID(prodID);
		dao.update(msVO);

		return msVO;
	}

	public void deleteMemberService(Integer msgID) {
		dao.delete(msgID);
	}

	public MemberServiceVO getOneMemberService(Integer msgID) {
		return dao.findByprimaryKey(msgID);
	}

	public List<MemberServiceVO> getAll() {
		return dao.getAll();
	}

}
