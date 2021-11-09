<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../CSS/login.css" rel="stylesheet" type="text/css" media="screen"/>
<meta charset="UTF-8">

    
<%
	String memLogin = (String)session.getAttribute("memLogin");
	String id = (String)session.getAttribute("memId");
	String pw = (String)session.getAttribute("memPw");
	String check = (String)session.getAttribute("memSave");
	String errMsg = (String)session.getAttribute("memErr");
	String idStr=null, pwStr=null, checkStr=null;
	
	

	if(errMsg != null) {
		out.println("<script>alert('회원 정보가 올바르지 않습니다.'); history.back();</script>");
		session.removeAttribute("memErr");
	}
	else {
		errMsg="로그인 정보가 일치하지 않습니다.";
	}
	
	if(check==null) {
		idStr = ""; pwStr =""; checkStr="";
	}
	else {
		idStr = id; pwStr = pw; checkStr="checked";
	}
%>
	<%-- TOP --%>
	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	<%--  --%>
	<form method="post" action="loginProcess2.jsp" >
	<section class="Login1-section-wrap">
		<div class="Login1">
			<div class="Login1-id">
				<input type="text" name="id" placeholder="아이디" value=<%=idStr %>>
				<br>
		
			</div>
			<div class="Login1-password"> 
				<input type="password" name="pw" placeholder="비밀번호" value=<%=pwStr %>><br>
			</div>
			<div class="Login1-button">
				<input type="submit" value="로그인">
			</div>
			<div class="Login1-stay">
				<input type="checkbox" name="idSave" value="c1" <%=checkStr %>>
				<label>로그인 정보 저장</label>
			</div>
		</div>
	</section>
	</form>
	<div id="Login1-join">
		<a href="../Userinfo/joinForm.jsp">회원가입</a>
	</div>
	
	
	
	<%-- FOOTER --%>
	<div id="footer">
		<%@ include file="../Module/bottom.jsp" %>
	</div>
</html>