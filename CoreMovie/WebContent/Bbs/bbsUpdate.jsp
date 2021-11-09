<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.io.PrintWriter" %>
<%@ page import = "userRegister.BbsBean" %>
<%@ page import = "userRegister.BbsMgr" %>
<!DOCTYPE html>
<html>
<head>
<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../CSS/bbs.css" rel="stylesheet" type="text/css" media="screen" />
<meta charset="UTF-8">
<title>게시판</title>
</head>
<body>

	<%
		String logcheck = (String) session.getAttribute("memLogin");
		if(logcheck == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../Login/login.jsp'");
			script.println("</script>");
		}
		String userID = null;
		if (session.getAttribute("memId") != null) {
			userID = (String) session.getAttribute("memId");
		}
		int bbsID = 0;
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if (bbsID == 0) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbsList.jsp'");
			script.println("</script>");
		}
		
		BbsBean bbs = new BbsMgr().getBbs(bbsID); // 수정하려는 게시글의 빈즈를 가져옴
		if (!userID.equals(bbs.getUserID())) { // 작성자와 수정하려는 자가 동일하지 않을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다..')");
			script.println("location.href = 'bbsList.jsp'");
			script.println("</script>");
		}
	%>

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
	<form method="post" action="bbsUpdateAction.jsp?bbsID=<%= bbsID %>">
	<%-- bbsID를 updateAction으로 보내줌 --%>
		<table class="table table-striped" style="text-align :center; border : 1px solid %dddddd">
			<thead>
				<tr>
					<th colspan="2" style= "text-align : center;">글 수정 양식</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%= bbs.getBbsTitle() %>"></td>
				</tr>
				<tr>	
					<td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height:350"><%= bbs.getBbsContent() %></textarea></td>
					<%-- 수정자에게 기존의 제목 및 내용을 보게끔 설정 --%>
				</tr>
			</tbody>
		</table> 
		<input type="submit" class="bbsupdate" value="글수정">
	</form>
</div>

<div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
</div>

</body>
</html>