<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean class="userRegister.RegisterBean" id="userBean" scope="session"/>
<jsp:setProperty name="userBean" property="*"/>
<jsp:useBean class="userRegister.RegisterMgr" id="userMgr" scope="session"/>

<html>
<head>
</head>
<body>
<%
	userMgr.insertMember(userBean);
	response.sendRedirect("../Login/login.jsp");
%>

</body>
</html>

