package util;


public class Util {
	
	public static final String DRIVER = "com.mysql.cj.jdbc.Driver";
	
	
	public static final String URL = 
			"jdbc:mysql://localhost:3306/JoyLease?"
//			+ "useSSL=false&"                  
			+ "rewriteBatchedStatements=true&" 
			+ "serverTimezone=Asia/Taipei";     
//			+ "allowPublicKeyRetrieval=true&"   
//			+ "useUnicode=true&"                
//			+ "characterEncoding=utf-8";        
	
	public static final String USER = "root";
	
	public static final String PASSWORD = "password";
}
