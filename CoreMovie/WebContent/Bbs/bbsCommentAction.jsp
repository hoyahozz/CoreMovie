<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "userRegister.CommentMgr" %>
<%@ page import= "java.io.PrintWriter" %> 

<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="comment" class="userRegister.CommentBean" scope="page" />
<jsp:setProperty name="comment" property="commentContent"/>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>게시판</title>
</head>
<body>


	<%
		
		int bbsID = 0;
		// <a href = bbsView.jsp?bbsID=<%= list.get(i).getBbsID() 이 부분에서 bbsID를 받아오는 것
		if (request.getParameter("bbsID") != null) {
			bbsID = Integer.parseInt(request.getParameter("bbsID")); // 오브젝트로 받아오니 형변환 필수
		}
		
		if (bbsID == 0) { // 받아온 bbsID가 없으면
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	
		String userID = null;
		if (session.getAttribute("memId") != null) {
			userID = (String) session.getAttribute("memId");
		}
		// 로그인 체크, logcheck 는 "logoutProcess.jsp" 에 있음.
		String logcheck = (String) session.getAttribute("memLogin");
		if(logcheck == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			script.println("location.href = '../Login/login.jsp'");
			script.println("</script>");
		}
		else {
			if (comment.getCommentContent() == null) { // 댓글 내용을 작성하지 않았을 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력 사항을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>"); 
			} else { // 작성하였을 경우 데이터베이스에 입력하는 작업
				CommentMgr commentMgr = new CommentMgr(); // mgr 객체 생성
				int result = commentMgr.write(bbsID, userID, comment.getCommentContent()); // 글쓰기 작업 실시
				if (result == -1) { // write 작업이 실패했을 시
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('댓글 작성에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>"); 
				}
				else { // 성공시 이전페이지로 이동
					response.sendRedirect("bbsView.jsp?bbsID=" + bbsID);
				}
			}
		}
		%>


</body>
</html>