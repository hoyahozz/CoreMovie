<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="userRegister.*" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>회원 추가</title>
	<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
	<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/insertform.css" rel="stylesheet" type="text/css" media="screen" />
<jsp:useBean id="reg" scope="request" class="userRegister.RegisterBean" />
<jsp:useBean id="memMgr" class="userRegister.RegisterMgr" /> 
</head>
<body>
	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	<div>
	<form action="control.jsp?action=insert" method="post" >
	
	<ul>
			<li><label>아이디<br>
				<input type="text" name="userId" required>				
			</label></li>
			<li><label>비밀번호<br>
				<input type="password" name="userPwd" required>				
			</label></li>
			<li><label>이름<br>
				<input type="text" name="userName" required>				
			</label></li>
			<li><label>이메일<br>
				<input type="text" name="userEmail" required>				
			</label></li>
			
			<li>
				<br><input type="submit" value="추가하기"></input>
			</li>
	</ul>
	</form>
	</div>
	<div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
	</div>
</body>
</html>