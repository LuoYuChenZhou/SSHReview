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

<title>My JSP 'index.jsp' starting page</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="style/jquery-3.2.1.js"></script>
</head>

<body>
	<div style="width:300px;height: 300px;">
		<label for="name">用户名：</label>
		<input type="text" id="name"> <br>
		<label for="name">密码：</label>
		<input type="password" id="password"> <br>
		<button onclick="login()">登录</button>
	</div>
</body>
<script type="text/javascript">
	function login() {
		$.post("/SSHReview/userJson/login_ajax.do",
			{
				name : $("#name").val(),
				password : $("#password").val()
			},
			function(data) {
				let resultJSONData = JSON.parse(data);
				if (resultJSONData.status === 200) {
					window.location.href = "view/userList.jsp";
				} else {
					alert(resultJSONData.msg);
				}
			});

	}

</script>
</html>
