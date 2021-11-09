<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "userRegister.BbsMgr" %>
<%@ page import= "java.io.PrintWriter" %> 

<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="bbs" class="userRegister.BbsBean" scope="page" />
<jsp:setProperty name="bbs" property="bbsTitle"/>
<jsp:setProperty name="bbs" property="bbsContent"/>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html" charset="UTF-8">
<title>게시판</title>
</head>
<body>


	<%
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
			if (bbs.getBbsTitle() == null || bbs.getBbsContent() == null) { // 글 내용이나 제목을 작성하지 않았을 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('입력 사항을 입력해주세요.')");
				script.println("history.back()");
				script.println("</script>"); 
			} else { // 작성하였을 경우 데이터베이스에 입력하는 작업
				BbsMgr bbsMgr = new BbsMgr(); // 행동 객체 생성
				int result = bbsMgr.write(bbs.getBbsTitle(), userID, bbs.getBbsContent()); // 글쓰기 작업 실시
				if (result == -1) { // write 작업이 실패했을 시
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글쓰기에 실패했습니다.')");
					script.println("history.back()");
					script.println("</script>"); 
				}
				else { // 성공시 bbsList(게시판 메인)으로 이동
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href = 'bbsList.jsp'");
					script.println("</script>"); 
				}
			}
		}
	
	%>

</body>
</html>