package com.pb_reply.model;

import java.util.*;


public interface pb_replyDAO_interface {
	
	public void insert(pb_replyVO pb_replyVO);
    public void update(pb_replyVO pb_replyVO);
    public void delete(Integer reply_id);
    public pb_replyVO findByPrimaryKey(Integer pb_replyVO);
    public List<pb_replyVO> getAll();
    //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 

}
