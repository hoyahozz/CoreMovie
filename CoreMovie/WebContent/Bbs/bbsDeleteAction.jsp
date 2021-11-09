<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "userRegister.BbsMgr" %>
<%@ page import = "userRegister.BbsBean" %>
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
		
		BbsBean bbs = new BbsMgr().getBbs(bbsID);
		if (!userID.equals(bbs.getUserID())) { // 작성자와 삭제하려는 자가 동일하지 않을 경우
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다..')");
			script.println("location.href = 'bbsList.jsp'");
			script.println("</script>");
		} else {
				BbsMgr bbsMgr = new BbsMgr();
				int result = bbsMgr.delete(bbsID);
				if (result == -1) {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글 삭제에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>"); 
				}
				else {
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbsList.jsp'");
					script.println("</script>"); 
				}
			}
	
	%>

</body>
</html>