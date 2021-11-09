<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="userRegister.*"%>
    
<jsp:useBean class="userRegister.RegisterBean" id="reg" scope="session"/>
<jsp:setProperty name="reg" property="*"/>
<jsp:useBean class="userRegister.RegisterMgr" id="regMgr" scope="session"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	String id=request.getParameter("userId");
	int check = regMgr.idCheck(id); 
	if(check==1){
%>
		<script>
			alert("가능합니다");
			window.close();
		</script>		
<% 	}else{
%>
		<script>
			alert("불가능합니다");
			window.close();
		</script>	
<% 	
	}

%>
</body>
</html>