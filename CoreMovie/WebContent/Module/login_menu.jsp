<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

		<%
			String memLogin = (String)session.getAttribute("memLogin");
			String id = (String)session.getAttribute("memId");
			if(memLogin == null) { %>
					<form name="hidelogin" action="/CoreMovie/Login/login.jsp" method="post" id="login">
						<a href="#" onclick="javascript:document.hidelogin.submit();">로그인</a>
					</form>
					<a href="/CoreMovie/Userinfo/joinForm.jsp" id="signup">회원가입</a>
		<%
			}
			else { %>
						<a style="font-weight:bold;" id="userme"><%=id %>님 환영합니다!</a>
						<form name="hidelogout" action="/CoreMovie/Login/logoutProcess.jsp" method="POST"></form>
						<a href="#" onclick="javascript:document.hidelogout.submit();" id="logout">로그아웃</a>
						<a href="/CoreMovie/Userinfo/userinfoForm.jsp" id="info">내 정보</a>
			<%
			}
		%>
