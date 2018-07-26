<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">

<title>My JSP 'userEdit.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="style/jquery-3.2.1.js"></script>
</head>

<body style="text-align: center;">
	<h2>用户信息修改</h2>
	<h3>当前用户：${userInfo.name}</h3>
	<form style="width:300px;height: 300px;text-align: center;"
		action="/SSHReview/userNormal/updateUser_user.do">
		<input type="hidden" name="id" value="${userInfo.id} ">
		<label for="name">用户名：</label>
		<input type="text" id="name" name="name" value="${userInfo.name}">
		<br>
		<label for="name">密码：</label>
		<input type="password" id="password" name="password"
			value="${userInfo.password}">
		<br>
		<label for="sex">性别：</label>
		<select id="sex" name="sex">
			<option value="0">男</option>
			<option value="1">女</option>
		</select>
		<br>
		<input type="submit" value="修改" />
	</form>
	<br>
</body>
<script type="text/javascript">
	window.onload = function(){
		$("#sex").val(""+${userInfo.sex});
	}
</script>
</html>
