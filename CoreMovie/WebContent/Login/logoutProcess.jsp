<%@ page contentType="text/html; charset=utf-8" %>
<%
		session.removeAttribute("memLogin");
		session.removeAttribute("memErr");
		response.sendRedirect("../index.jsp");
%>
