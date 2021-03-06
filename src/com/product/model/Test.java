package com.product.model;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.json.JSONException;
import org.json.JSONObject;

import com.chatroom.jedis.JedisPoolUtil;

import redis.clients.jedis.Jedis;
import redis.clients.jedis.JedisPool;

public class Test {

	public static void main(String[] args) {
		JedisPool pool = JedisPoolUtil.getJedisPool();
		Jedis jedis = pool.getResource();
		Set<String> set = jedis.keys("prod*");
		Set<String> all_label = new HashSet();
		JSONObject jsonObj =new JSONObject();
		
		
		List<String> list = new ArrayList();
		int i=0;
		for(String prod :set) {
			List<String> prodAll = jedis.lrange(prod, 0, jedis.llen(prod));
			for(String label :prodAll) {
				all_label.add(label);
//				jsonObj.put(String.valueOf(i++), label);
			}
		}
		  
		try {
			jsonObj.put("all_label", all_label);
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		System.out.println(jsonObj);
		
		
	}

}
