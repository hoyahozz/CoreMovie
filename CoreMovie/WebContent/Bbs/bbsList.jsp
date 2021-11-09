<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page import = "java.io.PrintWriter" %>
 <%@ page import = "userRegister.BbsBean" %>
 <%@ page import = "userRegister.BbsMgr" %>
 <%@ page import = "java.util.ArrayList" %>


<%-- 게시판 메인화면 --%>

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
<div id="wrapper">
	<div id="logo" class="container">
		<%@ include file="/Module/logo.jsp" %>
	</div>
	
	<div class="login_menu">
		<%@ include file="/Module/login_menu.jsp" %>
	</div>
	
	<div id="menu-wrapper">
		<%@ include file="/Module/menu.jsp" %>
	</div>
</div>

	<%
		String userID = (String)session.getAttribute("memId");
	
		int pageNumber = 1; // 기본 페이지를 의미
		if (request.getParameter("pageNumber") != null) { // 밑의 href에서 다시 pageNumber 를 받아오는 것(오브젝트 타입으로 넘어오기 때문에 형변환 필수)
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
		BbsMgr bbsMgr = new BbsMgr();
		ArrayList<BbsBean> list = bbsMgr.getList(pageNumber);
	%>

<div class = "bbsbutton">
	<%
		if(pageNumber != 1) { // 1페이지가 아니라면 기본페이지가 아니라는 의미이므로, 이전 버튼을 생성
	%> 
		<a style="margin-left : 10px;" href="bbsList.jsp?pageNumber=<%=pageNumber - 1 %>">이전</a>
	<%
		} if(bbsMgr.nextPage(pageNumber + 1)) { // 다음 페이지가 있으면 다음 버튼을 생성
	%>
			<a href="bbsList.jsp?pageNumber=<%=pageNumber + 1 %>">다음</a>
	<%	
		}
	%>
	<a class="write" href="bbsWrite.jsp">글쓰기</a>
	 </div>
<div class="row"> <%-- 테이블 시작 --%> 
	<table class="table table-striped" style="text-align :center; border : 1px solid %dddddd">
		<thead>
			<tr>
				<th style="text-align : center;">번호</th>
				<th style="text-align : center;">제목</th>
				<th style="text-align : center;">작성자</th>
				<th style="text-align : center;">작성일</th>
			</tr>
		</thead>
		<tbody>
			
				<%
					 // 현재의 페이지에서 가져온 게시글 목록
					for(int i =0; i < list.size(); i++) {
				%>
				<tr> <%-- 글의 목록을 보여주는 곳 --%>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href = bbsView.jsp?bbsID=<%= list.get(i).getBbsID() %>><%=list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" + list.get(i).getBbsDate().substring(14, 16) + "분" %></td>		
				</tr>
				<% 	
					} // 제목을 눌렀을 때는 해당 게시글로 이동할 수 있게 href 설정
				%>
				
		</tbody>
	</table> 
	
</div>
	
	

<div id="footer">
	<%@ include file="/Module/bottom.jsp" %>
</div>

</body>
</html>