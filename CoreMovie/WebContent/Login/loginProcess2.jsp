<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*" %>
<jsp:useBean class="userRegister.RegisterMgr" id ="regMgr" scope="session" />
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	int check;
	check = regMgr.userCheck(id, pw);
	if (check == 2) {
			response.sendRedirect("../Admin/admin.jsp");	
		}
	else if (check == 1) {
		session.setAttribute("memLogin", "ok");
		if (request.getParameter("idSave") == null) {
			session.removeAttribute("memSave");
		}
		else {
			session.setAttribute("memSave","check");
		}
		session.setAttribute("memId", id);
		session.setAttribute("memPw", pw);
		response.sendRedirect("../index.jsp");
		}	 
	else {
		session.setAttribute("memErr", "error");
		session.removeAttribute("memSave");
		response.sendRedirect("login.jsp");
		}
%>