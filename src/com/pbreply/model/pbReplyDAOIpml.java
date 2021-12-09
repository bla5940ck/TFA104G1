package com.pbreply.model;

import java.util.*;


public interface pbReplyDAOIpml {
	
	public void insert(pbReplyVO pbreplyVO);
    public void update(pbReplyVO pbreplyVO);
    public void delete(Integer replyId);
    public pbReplyVO findByPrimaryKey(Integer pbreplyVO);
    public List<pbReplyVO> getAll();
    
}
