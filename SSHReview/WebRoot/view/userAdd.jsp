<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'userAdd.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

</head>

<body>
	<h2>添加用户</h2>
	<form style="width:300px;height: 300px;text-align:center;"
		action="/SSHReview/userNormal/addUser_user.do">
		<label for="name">用户名：</label>
		<input type="text" id="name" name="name">
		<br>
		<label for="name">密码：</label>
		<input type="password" id="password" name="password">
		<br>
		<label for="sex">性别：</label>
		<select id="sex" name="sex">
			<option value="0">男</option>
			<option value="1">女</option>
		</select>
		<br>
		<input type="submit" value="添加" />
	</form>
	<br>
</body>
</html>
