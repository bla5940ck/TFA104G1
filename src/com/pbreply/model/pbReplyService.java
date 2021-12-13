package com.pbreply.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.pbreply.model.pbReplyVO;
import com.postboard.model.PostBoardVO;


public class pbReplyService {
	
	private pbReplyDAOIpml dao;
	
	public pbReplyService() {
		dao = new pbReplyDAO();
	}

	public pbReplyVO add(Integer postId, Integer memberId ,String replyCont, Timestamp replyTime ) {
		pbReplyVO pbrVO = new pbReplyVO();
		
		pbrVO.setPostId(postId);
		pbrVO.setMemberId(memberId);
		pbrVO.setReplyCont(replyCont);
		pbrVO.setReplyTime(replyTime);
		dao.insert(pbrVO);
		return pbrVO;
		
	}
	
	public pbReplyVO update(Integer replyId, Integer postId, Integer memberId, String replyCont, Timestamp replyTime){
		pbReplyVO pbrVO = new pbReplyVO();
		
		pbrVO.setReplyId(replyId);
		pbrVO.setPostId(postId);
		pbrVO.setMemberId(memberId);
		pbrVO.setReplyCont(replyCont);
		pbrVO.setReplyTime(replyTime);
		dao.update(pbrVO);
		return dao.findByPrimaryKey(replyId);
	
	} 
	
	public pbReplyVO getOnePostBoard(Integer replyId) {
		return dao.findByPrimaryKey(replyId);
	}
	
	public pbReplyVO findByPrimaryKey(Integer replyId) {
		return dao.findByPrimaryKey(replyId);
	}

	public List<pbReplyVO> getAll() {
		return dao.getAll();
	}

}
