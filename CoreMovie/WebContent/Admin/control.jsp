<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8" import="userRegister.*, java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<% request.setCharacterEncoding("utf-8"); %>

<jsp:useBean id="reg" class="userRegister.RegisterBean"/> 
<jsp:useBean id="regMgr" class="userRegister.RegisterMgr"/>
<jsp:setProperty name="reg" property="*"/> 
<% 
	// 컨트롤러 요청 파라미터
	String action = request.getParameter("action");

	// 파라미터에 따른 요청 처리
	// 회원 등록 요청인 경우
	if(action.equals("insert")) {		
		if(regMgr.insertMember(reg)) {
			response.sendRedirect("admin.jsp");
		}
		else
			throw new Exception("DB 입력오류");
	}
	// 회원 수정 페이지 요청인 경우
	else if(action.equals("edit")) {
		RegisterBean mem = regMgr.getDB(reg.getUserId());
		request.setAttribute("ab",mem);
		pageContext.forward("editform.jsp");
		
	}
	// 회원 수정 등록 요청인 경우
	else if(action.equals("update")) {
			if(regMgr.updateDB(reg)) {
				response.sendRedirect("admin.jsp");
			}
			else
				throw new Exception("DB 갱신오류");
	}
	// 회원 삭제 요청인 경우
	else if(action.equals("delete")) {
		if(regMgr.deleteDB(reg.getUserId())) {
			response.sendRedirect("admin.jsp");
		}
		else
			throw new Exception("DB 삭제 오류");
	}
	else {
		out.println("<script>alert('action 파라미터를 확인해 주세요!!!')</script>");
	}
%>