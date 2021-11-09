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
	String email = request.getParameter("userEmail");
	String name = request.getParameter("userName");
	
	
	boolean check = regMgr.updateDB(reg);
	if (check == true) {
%>
		<script>
		alert("성공적으로 수정하였습니다");
		location.href="../index.jsp";
		</script>
<%
	}else{
%>
		<script>
		alert("수정도중 에러가 발생하였습니다.");
		history.back();
		</script>
<%
	  }
%>
