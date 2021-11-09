<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title></title>
	<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
	<link href="./CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>

<div id="wrapper">
	<div id="logo" class="container">
		<%@ include file="Module/logo.jsp" %>
	</div>
	
	<div class="login_menu">
		<%@ include file="Module/login_menu.jsp" %>
	</div>
	<div id="menu-wrapper">
		<%@ include file="Module/menu.jsp" %>
	</div>
	
	<div id="three-column" class="container">
		<%@ include file="Module/main.jsp" %>
	</div>
</div>
<div id="footer">
	<%@ include file="Module/bottom.jsp" %>
</div>

</body>
</html>