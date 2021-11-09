<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import = "userRegister.BbsBean" %>
<%@ page import = "userRegister.BbsMgr" %>
<%@ page import = "userRegister.CommentMgr" %>
<%@ page import = "userRegister.CommentBean" %>
 <%@ page import = "java.util.ArrayList" %>
    
<%-- 게시판의 글을 실제로 출력하는 페이지 --%>
    
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
		// 로그인 체크, logcheck 는 "logoutProcess.jsp" 에 있음.
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
		// <a href = bbsView.jsp?bbsID=<%= list.get(i).getBbsID() 이 부분에서 bbsID를 받아오는 것
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID")); // 오브젝트로 받아오니 형변환 필수
		}
		
		if (bbsID == 0) { // 받아온 bbsID가 없으면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("location.href = 'bbsList.jsp'");
			script.println("</script>");
		} 
		
		BbsBean bbs = new BbsMgr().getBbs(bbsID); // 해당 게시글의 빈즈를 받아옴
		
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
	<table class="table table-striped" style="text-align :center; border : 1px solid %dddddd">
		<thead>
		</thead>
		<tbody>
			<tr>
				<td style="width:20%;">글 제목</td>
				<td colspan="2"><%= bbs.getBbsTitle().replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">","&gt").replaceAll("\n","<br>")  %></td>
				<%-- HTML에서는 특수문자를 제대로 출력하지 못하기 때문에 replace 작업이 필요함. 또한 보안 체계에서도 매우 중요.--%>
			</tr>
			<tr>	
				<td>작성자</td>
				<td colspan="2"><%= bbs.getUserID()  %></td>
			</tr>
			<tr>
				<td>작성일자</td>
				<td colspan="2"><%= bbs.getBbsDate().substring(0, 11) + bbs.getBbsDate().substring(11, 13) + ":" + bbs.getBbsDate().substring(14, 16)%></td>
			</tr>
			<tr>
				<td>내용</td>
				<td colspan="2" style="min-height : 200px; text-align : LEFT;"><%= bbs.getBbsContent().replaceAll(" ", "&nbsp").replaceAll("<", "&lt").replaceAll(">","&gt").replaceAll("\n","<br>")  %></td>
				<%-- HTML에서는 특수문자를 제대로 출력하지 못하기 때문에 replace 작업이 필요함. 또한 보안 체계에서도 매우 중요. --%>
			</tr>
		</tbody>
	</table> 
	<div class="bbsbutton">
	<a href="bbsList.jsp">목록</a>
	<%
		if(userID != null && userID.equals(bbs.getUserID())) { // 해당 글의 작성자라면 수정 및 삭제를 할 수 있게 설정
	%>
		<a href="bbsUpdate.jsp?bbsID=<%= bbsID %>">수정</a>
		<a onclick="return confirm('정말로 삭제하시겠습니까?')" href="bbsDeleteAction.jsp?bbsID=<%= bbsID %>">삭제</a>
	</div>	
	<%			 
		}
	%>
</div>
	<div id = "commentlist"> <%-- 여기서부터 게시판의 댓글을 볼 수 있음 --%>
	<table class="table table-view" style="text-align :center; background : transparent; margin-top : 50px; margin-bottom : 0px;">
		<thead>
		</thead>
		<tbody>
				<%
					CommentMgr commentMgr = new CommentMgr(); // mgr 활성화
					ArrayList<CommentBean> list = commentMgr.getList(bbsID); // 현재의 페이지에서 가져온 댓글을 리스트로 뽑아낸 것
					for(int i =0; i < list.size(); i++) {
				%>
				<tr> <%-- 댓글의 목록을 보여주는 곳 --%>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getCommentContent() %></td>
						<td><%= list.get(i).getCommentDate().substring(0, 11) + list.get(i).getCommentDate().substring(11, 13) + ":" + list.get(i).getCommentDate().substring(14, 16)%></td>		
											<%-- substring 을 하는 이유 -> 데이터베이스의 (datetime)에서 필요한 부분만 뽑아내서 사용하기 위해 --%>
						<% 
							if (userID != null && userID.equals(list.get(i).getUserID())) {  // userID가 null 이 아니거나, userID가 해당 댓글의 작성자일 경우
						%>
						<td style="width: 50px;"></td> <%-- 유령 레코드 --%>
						<td style="width : 50px; color : black;"><a onclick="return confirm('정말로 삭제하시겠습니까?')" href="bbsCommentDeleteAction.jsp?commentID=<%= list.get(i).getCommentID() %>">삭제</a></td>
						<%-- 해당 사용자에게만 삭제 버튼이 보여지게 설정, 삭제할 수 있는 권한을 부여. 삭제를 누르면 bbsCommentDeleteAction으로 commentID를 담아 보내지게 됨.--%>
				<% 	
							} else { %>
								<td style="width : 50px;"></td>
								<td style="width : 50px;"></td>
									<%-- 정렬하기 위해 유령 레코드 생성 --%>
								</tr>
								<%
							}
						}
				%>
				
		</tbody>
	</table> 
	</div>
	
	<div>
		<%-- 글을 누르면 bbsID를 담아 bbsCommentAction으로 이동함 --%>
		<form method="post" action="bbsCommentAction.jsp?bbsID=<%= bbsID %>">
			<table class="table table-striped" style="text-align :center; background-color : transparent">
				<thead>
				</thead>
				<tbody>
					<tr>	
						<td><textarea class="form-control" placeholder="댓글 내용" name="commentContent" maxlength="1000" style="height:200"></textarea></td>
					</tr>
				</tbody>
			</table> 
			<input type="submit" class="bbsupdate" value="글쓰기">
		</form>
	</div>	


<div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
</div>

</body>
</html>
