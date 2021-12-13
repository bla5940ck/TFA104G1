package com.postboard.model;

import java.sql.Timestamp;
import java.util.List;
import java.util.Set;

import com.postboard.model.PostBoardVO;


public class PostBoardService {
	private PostBoardDAOImpl dao;
	
	public PostBoardService() {
		dao = new PostBoardDAO();
	}

	public PostBoardVO addarticle(Integer categoryId, Integer memberId, String postTitle, String postCont,Timestamp postTime, byte[] pic) {
		
		PostBoardVO pbVO = new PostBoardVO();
		
		pbVO.setCategoryId(categoryId);
		pbVO.setMemberId(memberId);
		pbVO.setPostTitle(postTitle);
		pbVO.setPostCont(postCont);
		pbVO.setPostTime(postTime);
		pbVO.setPic(pic);	
		dao.insert(pbVO);
		
		return pbVO;
		
	}
	
	
	public PostBoardVO updatearticle(Integer postId, Integer categoryId, Integer memberId, String postTitle, String postCont,
			Timestamp postTime, Integer replyCount, byte[] pic) {

		PostBoardVO pbVO = new PostBoardVO();

		pbVO.setPostId(postId);
		pbVO.setCategoryId(categoryId);
		pbVO.setMemberId(memberId);
		pbVO.setPostTitle(postTitle);
		pbVO.setPostCont(postCont);
		pbVO.setPostTime(postTime);
		pbVO.setReplyCount(replyCount);
		pbVO.setPic(pic);
		dao.update(pbVO);

		return dao.findByPrimaryKey(postId);
	}
	
	public void update(PostBoardVO pbVO) {
		dao.update(pbVO);
	}
	
	public void delet(Integer postId) {
		dao.delete(postId);
	}

	public PostBoardVO getOnePostBoard(Integer postId) {
		return dao.findByPrimaryKey(postId);
	}
	
	public PostBoardVO findByPrimaryKey(Integer postId) {
		return dao.findByPrimaryKey(postId);
	}

	public List<PostBoardVO> getAll() {
		return dao.getAll();
	}

	
	

	
	
	

}
