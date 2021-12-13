package com.chatroom.model;

import java.util.*;

public interface ChatroomDAOImpl {
	
	public void insert(ChatroomVO chatroomVO);
    public void update(ChatroomVO chatroomVO);
    public void delete(Integer chatroomNo);
    public ChatroomVO findByPrimaryKey(Integer chatroomVO);
    public List<ChatroomVO> getAll();
    //萬用複合查詢(傳入參數型態Map)(回傳 List)
//  public List<EmpVO> getAll(Map<String, String[]> map); 

}
