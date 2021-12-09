package com.post_borad.model;

import java.util.List;

public interface PostBoradDAOInterface {
	 public void insert(PostBoradVO postBoradVO);
     public void update(PostBoradVO postBoradVO);
     public void delete(Integer postId);
     public PostBoradVO findByPrimaryKey(Integer postId);
     public List<PostBoradVO> getAll();

}
