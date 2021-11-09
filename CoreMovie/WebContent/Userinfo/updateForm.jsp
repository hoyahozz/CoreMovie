<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="userRegister.*"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title></title>
	<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
	<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/join.css" rel="stylesheet" type="text/css" media="screen" />
</head>

<title>회원 수정</title>

<body>
	<jsp:useBean id="memMgr" class="userRegister.RegisterMgr" /> 
	<%
		
		String id = (String)session.getAttribute("memId");
		String pw = (String)session.getAttribute("memPw");
		RegisterBean User = (RegisterBean)memMgr.getDB(id);
	%>
	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	<div>
		<form action="update.jsp" method="post">
		<ul>
			<li><label>아이디<br>
				<input type="text" name="userId" value=<%=User.getUserId() %> readonly>				
			</label></li>
			<li><label>비밀번호<br>
				<input type="password" name="userPwd" value=<%=User.getUserPwd() %> required>				
			</label></li>
			<li><label>이름<br>
				<input type="text" name="userName" value=<%=User.getUserName() %> required>				
			</label></li>
			<li><label>이메일<br>
				<input type="text" name="userEmail" value=<%=User.getUserEmail() %> required>				
			</label></li>
			
			<li>
				<br><input type="submit" value="수정하기"></input>
			</li>
		</ul>
		</form>
	</div>
	<div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
	</div>
</body>
</html>

