package com.post_borad.model;

import java.util.List;

public interface post_boradDAO_interface {
	 public void insert(post_boradVO post_boradVO);
     public void update(post_boradVO post_boradVO);
     public void delete(Integer post_id);
     public post_boradVO findByPrimaryKey(Integer post_id);
     public List<post_boradVO> getAll();
     //�U�νƦX�d��(�ǤJ�Ѽƫ��AMap)(�^�� List)
//   public List<EmpVO> getAll(Map<String, String[]> map); 

}
