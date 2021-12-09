package com.postboard.model;

import java.util.List;

public interface PostBoardDAOImpl {
	 public void insert(PostBoardVO postBoardVO);
     public void update(PostBoardVO postBoardVO);
     public void delete(Integer postId);
     public PostBoardVO findByPrimaryKey(Integer postId);
     public List<PostBoardVO> getAll();

}
