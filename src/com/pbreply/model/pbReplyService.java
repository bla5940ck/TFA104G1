package com.pbreply.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.pbreply.model.pbReplyVO;
import com.postboard.model.PostBoardDAO;
import com.postboard.model.PostBoardVO;


public class pbReplyService {
	
	private pbReplyDAOIpml dao;
	private PostBoardDAO dao2;
	public pbReplyService() {
		dao = new pbReplyDAO();
		dao2 = new PostBoardDAO();
	}

	public pbReplyVO add(Integer postId, Integer memberId ,String replyCont, Timestamp replyTime ) {
		pbReplyVO pbrVO = new pbReplyVO();
		
		pbrVO.setPostId(postId);
		pbrVO.setMemberId(memberId);
		pbrVO.setReplyCont(replyCont);
		pbrVO.setReplyTime(replyTime);
		dao.insert(pbrVO);
		
		List<pbReplyVO> list = dao.getAll();
		System.out.println(list.size());
		int count = 0;
		for(pbReplyVO pbrVO2 :list) {
			System.out.println("postId : " +postId);
			System.out.println("pbrVO2.getPostId(): " + pbrVO2.getPostId());
			if(postId.equals(pbrVO2.getPostId())) {
				count++;
			}
		}
		PostBoardVO pbVO  = dao2.findByPrimaryKey(postId);
		pbVO.setReplyCount(count);
		
		dao2.update(pbVO);
		
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
