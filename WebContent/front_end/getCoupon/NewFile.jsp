<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>測試用領取折價券</title>
</head>
<body>

 <FORM METHOD="post" ACTION="getcoupon.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看可用折價券">
			     <input type="hidden" name="amount"  value="0">
			     <input type="hidden" name="action"	value="getAmount"></FORM>


 <FORM METHOD="post" ACTION="getmemid.do" style="margin-bottom: 0px;">
			     <input type="submit" value="查看會員的折價券">
			     <input type="TEXT" name="member_id"  size="1">
			     <input type="hidden" name="action"	value="getMemberid"></FORM>
			     
			


</body>
</html>