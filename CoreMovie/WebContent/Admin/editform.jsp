<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="userRegister.*"%>
<!DOCTYPE HTML>
<html>
<head>
<link rel="stylesheet" href="../CSS/style.css" type="text/css" media="screen" />

<script type="text/javascript">
	function delcheck() {
		result = confirm("정말로 삭제하시겠습니까 ?");
	
		if(result == true){
			document.form1.action.value="delete";
			document.form1.submit();
		}
		else
			return;
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>주소록:수정화면</title>
</head>

<jsp:useBean id="reg" scope="request" class="userRegister.RegisterBean" />
<jsp:setProperty name="reg" property="*"/>

<body>
<div align="center">
<H2>주소록:수정화면 </H2>
<HR>
[<a href=admin.jsp>주소록 목록으로</a>] <p>

<jsp:useBean id="memMgr" class="userRegister.RegisterMgr" /> 
<%
	RegisterBean User = (RegisterBean)memMgr.getDB(reg.getUserId());
%>
<form name=form1 method=post action=control.jsp>
<input type=hidden name="userId" value="<%=User.getUserId() %>">
<input type=hidden name="action" value="update">

<table border="1">
  <tr>
    <th>이 름</th>
    <td><input type="text" name="userName" value="<%=User.getUserName() %>"></td>
  </tr>
  <tr>
    <th>email</th>
    <td><input type="text" name="userEmail" value="<%=User.getUserEmail() %>"></td>
  </tr>
   
  <tr>
    <td colspan=2 align=center><input type=submit value="저장"><input type=reset value="취소"><input type="button" value="삭제" onClick="delcheck()"></td>
</tr>
</table>
</form>

</div>
</body>
</html>