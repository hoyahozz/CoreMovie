<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ page import="java.sql.*" %>
  
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean class="userRegister.RegisterBean" id="reg" scope="session"/>
<jsp:setProperty name="reg" property="*"/>
<jsp:useBean class="userRegister.RegisterMgr" id="regMgr" scope="session"/>

<%
	String id = request.getParameter("userId");
	String pw = request.getParameter("userPwd");
	
	boolean check = regMgr.deleteDB(id);
	if (check == true) {
%>
		<script>
		alert("탈퇴가 완료되었습니다.");
		location.href="../index.jsp";
		</script>
		<% session.removeAttribute("memLogin"); %>
<%
	}else{
%>
		<script>
		alert("탈퇴 도중 에러가 발생하였습니다.");
		history.back();
		</script>
<%
	  }
%>
