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
	<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/userinfo.css" rel="stylesheet" type="text/css" media="screen"/>
</head>
<title>내 정보</title>

	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	<div class="infoform">
		<div><a href="updateForm.jsp" id="a1">정보 수정하기</a></div>
		<div><a href="deleteForm.jsp" id="a2">계정 탈퇴하기</a></div>
	</div>
	<div id="footer">
		<%@ include file="../Module/bottom.jsp" %>
	</div>

</body>
</html>

