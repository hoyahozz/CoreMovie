<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="userRegister.*,java.util.*"%>
<html>
<head>
	<!--  <link href="./CSS/admin.css" rel="stylesheet" type="text/css" media="screen" />-->
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
<button class="button" type="button" onclick="location.href='admin_bbs.jsp'">게시물관리페이지로 이동</button>
<button class="button" type="button" onClick="location.href='../Login/logoutProcess.jsp'"> 로그아웃</button>
<hr>
<form>
<%-- 회원목록 출력 --%>
<table border="1" id="result_table">
 <tr class="admin_tr">
  <th class="admin_th">userID</th>
  <th class="admin_th">password</th>
  <th class="admin_th">name</th>
  <th class="admin_th">email</th>
 </tr>
 <jsp:useBean id="memMgr" class="userRegister.RegisterMgr" />  
 <%
 	// 빈즈에서 받아온 멤버리스트를 벡터로 받아옴
 	Vector memlist = memMgr.getMemberList();        
      for(int i=0; i< memlist.size();i++)
      {
   	// elementAt()메소드를 이용하여 멤버리스트에 접근 후 값을 반환
     RegisterBean regBean = (RegisterBean)memlist.elementAt(i); 
 %>
 <tr class="admin_tr">
  	<td class="admin_td"><a href="editform.jsp?userId=<%=regBean.getUserId() %>"> <%=regBean.getUserId() %></a></td>
  	<td class="admin_td"><%=regBean.getUserPwd() %></td>
  	<td class="admin_td"><%=regBean.getUserName() %></td>
  	<td class="admin_td"><%=regBean.getUserEmail() %></td>
 </tr>
 <%
  }
 %>
 </table>
 </form>
 </div>
 <div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
</div>
</body>
</html>