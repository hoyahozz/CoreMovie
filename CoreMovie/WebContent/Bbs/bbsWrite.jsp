<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../CSS/bbs.css" rel="stylesheet" type="text/css" media="screen" />
<meta charset="UTF-8">
<title>게시판</title>
<%-- 게시판 작성 공간 --%>

<%
	//로그인 체크, logcheck 는 "logoutProcess.jsp" 에 있음.
	String logcheck = (String) session.getAttribute("memLogin");
	if(logcheck == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = '../Login/login.jsp'");
		script.println("</script>");
	}
%>


</head>
<body>
<div id="wrapper">
	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	
	<div class="login_menu">
		<%@ include file="../Module/login_menu.jsp" %>
	</div>
	
	<div id="menu-wrapper">
		<%@ include file="../Module/menu.jsp" %>
	</div>
</div>



	<div class="row">
		<form method="post" action="bbsWriteAction.jsp">
			<table class="table table-striped" style="text-align :center; border : 1px solid %dddddd">
				<thead>
					<tr>
						<th colspan="2" style= "text-align : center;">게시판 글쓰기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
					</tr>
					<tr>	
						<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:500"></textarea></td>
					</tr>
				</tbody>
			</table> 
			<div id="bbsupdate">
			<input type="submit" class="bbsupdate" value="글쓰기">
			</div>
		</form>
	</div>

	<div id="footer">
		<%@ include file="../Module/bottom.jsp" %>
	</div>

</body>
</html>