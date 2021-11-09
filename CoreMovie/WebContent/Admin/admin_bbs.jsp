<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="userRegister.*,java.util.*"%>
    
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>관리자 페이지</title>
<meta name="keywords" content="" />
<meta name="description" content="" />
<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
<link href="../CSS/admin.css" rel="stylesheet" type="text/css" media="screen" />
</head>
<body>
<div align="center">
<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
</div>
<button class="button" type="button" onclick="location.href='insertform.jsp'">회원 추가</button>
<button class="button" type="button" onclick="location.href='../index.jsp'">메인페이지로 이동</button>
<button class="button" type="button" onclick="location.href='admin.jsp'">유저관리페이지로 이동</button>
<button class="button" type="button" onClick="location.href='../Login/logoutProcess.jsp'"> 로그아웃</button>
<hr>
<form method="get" action="bbsController.jsp">
<%-- 회원목록 출력 --%>
<table border="1" id="result_table">
 <tr class="admin_tr">
  <th class="admin_th">게 시 글 번 호</th>
  <th class="admin_th">제 목</th>
  <th class="admin_th">작 성 자</th>
  <th class="admin_th">작 성 일 자</th>
  <th class="admin_th">게 시 글 상 태</th>
  <th class="admin_th">게 시 글 삭 제 / 복 구</th>
 </tr>
 <jsp:useBean id="bbsMgr" class="userRegister.BbsMgr" />   
 <%/*게시글 정보 출력 삭제된 경우 체크박스 클릭 불가능 하게 수정해놨는데, 복구 기능 추가해서 변경 예정*/
 	String output = "";
 	String clickRole = "";
 	Vector memlist = bbsMgr.getContentList();        
      for(int i=0; i< memlist.size();i++)
      {
    	output = "Deleted";    	
     BbsBean contentInfo = (BbsBean)memlist.elementAt(i); 
   	if((contentInfo.getBbsAvailable()) == 1) {
   		output = "exist";
   	}
 %>
 <tr class="admin_tr">
  	<td class="admin_td"><a href="#"> <%=contentInfo.getBbsID() %></a></td>
  	<td class="admin_td"><%=contentInfo.getBbsTitle() %></td>
  	<td class="admin_td"><%=contentInfo.getUserID() %></td>
  	<td class="admin_td"><%=contentInfo.getBbsDate() %></td>
  	<td class="admin_td"><%= output %></td>
  	<td class="admin_td"> <input type="checkBox" name="contentID"  value=<%=contentInfo.getBbsID()%> > </td>
 </tr>
 <%
  }
 %>
 </table>
  <input type="submit" name="action" value="관리">
 </form>
 </div>
 <div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
</div>
</body>
</html>