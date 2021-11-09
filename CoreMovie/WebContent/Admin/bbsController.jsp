<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<jsp:useBean id="Bean" class="userRegister.BbsBean"/> 
<jsp:useBean id="Mgr" class="userRegister.BbsMgr"/>
<jsp:setProperty name="Mgr" property="*"/> 
<% String[] bbsID = request.getParameterValues("contentID");
	for(int i =0; i < bbsID.length; i++) {
		int contentIndex = Integer.parseInt(bbsID[i]);
		int temp = Mgr.getStatus(contentIndex);
		// 게시글이 존재할 경우 삭제
		if(temp == 1) {
			if(Mgr.adjustContent(contentIndex, temp-1)) {} else throw new Exception("adjust Fail!!");
		} else { // 게시글이 삭제되어진 상태인 경우 복구
			if(Mgr.adjustContent(contentIndex, temp+1)) {} else throw new Exception("adjust Fail!!");
		}
	}

%>
<% response.sendRedirect("admin_bbs.jsp"); %>