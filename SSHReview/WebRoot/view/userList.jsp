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

<title>My JSP 'userList.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="style/jquery-3.2.1.js"></script>
<style type="text/css">
.canPress {
	background: lightblue;
}

th {
	width: 400px;
}

td {
	text-align: center;
	width: 400px;
}
</style>
</head>

<body style="text-align: center;">
	<label for="searchName">用户名：</label>
	<input type="text" id="searchName">
	<button onclick="getUserListByName()">查询</button>
	<button onclick="addUser()">添加</button>
	<button onclick="batchInsert()">批量添加</button>
	<hr>
	<table id="userTable">
		<tr>
			<th>用户</th>
			<th>性别</th>
			<th>操作</th>
		</tr>
	</table>
	<hr>
	<span id="showPage"></span>
	<label for="pageSize">每页条数</label>
	<select id="pageSize" onchange="getUserListByName()">
		<option value="5" selected="selected">5条</option>
		<option value="10">10条</option>
		<option value="20">20条</option>
	</select>
	<button id="leftButton" onclick="toLeft()" disabled="disabled">《</button>
	<button id="rightButton" onclick="toRight()" disabled="disabled">》</button>
</body>

<script type="text/javascript">
	let curPage = 1;
	let pageSize = 5;
	let leftBtnOk = false;
	let rightBtnOk = false;

	let userTable;
	window.onload = function() {
		userTable = $("#userTable");
		getUserListByName();
	}

	function batchInsert() {
		window.location.href = "/SSHReview/userNormal/batchInsert_user.do";
	}

	function getUserListByName() {
		$.get("/SSHReview/userJson/getUserListByName_ajax.do",
			{
				searchName : $("#searchName").val(),
				curPage : curPage,
				pageSize : $("#pageSize").val(),
			},
			function(data) {
				let resultJSONData = JSON.parse(data);
				if (resultJSONData.status === 200) {
					clearTable();
					let htmlStr = listToTable(resultJSONData.data);
					userTable.append(htmlStr);
					controlButton(resultJSONData.hasPrePage, resultJSONData.hasNextPage);
					$("#showPage").text("共" + resultJSONData.count + "条，共" + resultJSONData.totalPage + "页，当前页数：" + resultJSONData.curPage);
				} else if (resultJSONData.status === 204) {
					clearTable();
				} else {
					alert(resultJSONData.msg);
				}
			});

	}

	function clearTable() {
		userTable.html("<tr><th>用户</th><th>性别</th><th>操作</th></tr>");
	}

	function listToTable(list) {
		let htmlStr = "";
		for (let i = 0; i < list.length; i++) {
			htmlStr = htmlStr + "<tr><td>" + list[i].name + "</td><td>" + getSex(list[i].sex) + "</td><td>" +
				"<a href='javascript:void(0)' onclick='deleteUser(\"" + list[i].id + "\")'>删</a>" +
				" | " +
				"<a href='javascript:void(0)' onclick='updateUser(\"" + list[i].id + "\")'>改</a>" +
				"</td></tr>";
		}
		return htmlStr;
	}
	function addUser() {
		window.location.href = "view/userAdd.jsp";
	}
	function deleteUser(id) {
		$.get("/SSHReview/userJson/deleteUser_ajax.do",
			{
				id : id
			},
			function(data) {
				let resultJSONData = JSON.parse(data);
				alert(resultJSONData.msg);
				getUserListByName();
			});

	}
	function updateUser(id) {
		window.location.href = "/SSHReview/userNormal/getUserInfoById_user.do?id=" + id;
	}
	function toLeft() {
		if (leftBtnOk) {
			curPage--;
			getUserListByName();
		}
	}
	function toRight() {
		if (rightBtnOk) {
			curPage++;
			getUserListByName();
		}
	}
	function getSex(sex) {
		return sex === "1" ? "女" : "男";
	}
	function controlButton(canLeft, canRight) {
		leftBtnOk = canLeft;
		rightBtnOk = canRight;
		let leftButton = $("#leftButton");
		let rightButton = $("#rightButton");
		if (canLeft) {
			leftButton.attr("disabled", false);
			leftButton.addClass("canPress");
		} else {
			leftButton.attr("disabled", true);
			leftButton.removeClass("canPress");
		}
		if (canRight) {
			rightButton.attr("disabled", false);
			rightButton.addClass("canPress");
		} else {
			rightButton.attr("disabled", true);
			rightButton.removeClass("canPress");
		}
	}
</script>
</html>
