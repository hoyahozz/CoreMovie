<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "userRegister.CommentMgr" %>
<%@ page import = "userRegister.CommentBean" %>
<%@ page import= "java.io.PrintWriter" %> 

<% request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
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
	
		String url = request.getHeader("Referer"); // ★이 코드가 이전페이지를 알아내는 코드★
		String userID = null;
		if (session.getAttribute("memId") != null) {
			userID = (String) session.getAttribute("memId");
		}
		int commentID = 0; // 댓글 번호를 이전 페이지에서 받아옴
		if (request.getParameter("commentID") != null) {
			commentID = Integer.parseInt(request.getParameter("commentID")); // 마찬가지로 오브젝트 형식으로 받기 때문에, 형변환 필수
		}
		
		if (commentID == 0) { // 댓글 번호가 없으면 유효하지 않은 글
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 댓글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		
		CommentBean comment = new CommentMgr().getComment(commentID);
		if (!userID.equals(comment.getUserID())) { // 작성자와 댓글을 삭제하려는 자가 동일하지 않을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다..')");
			script.println("location.href = 'bbsList.jsp'");
			script.println("</script>");
		} else {
				CommentMgr commentMgr = new CommentMgr();
				int result = commentMgr.delete(commentID); // delete 실행
				if (result == -1) { // delete에서 오류가 발생시
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>"); 
				}
				else { // 오류가 발생하지 않으면 이전 페이지로 이동
					response.sendRedirect(url);
				}
		}
				
	%>		}
</body>
</html>