<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html  xmlns="http://www.w3.org/1999/xhtml">
<head>
<script>
	 /* function checkValue()
	{
		if(!document.joinform.userId.value){
			alert("ID를 입력하세요");
			return false;
		}
		if(!document.joinform.userPwd.value){
			alert("Password를 입력하세요");
			return false;
		}
		if(document.joinform.userPwd.value!=document.joinform.userRePwd.value){
			alert("Password가 서로 다릅니다.")
			return false;
		}
		
	} */
	
	function confirmId(){
		if(document.joinform.userId.value==""){
			alert("ID를 입력하세요");
			return;
		}
		
		url="confirmId.jsp?userId="+document.joinform.userId.value;
		open(url,"confirm","toolbar=no, location=no, status=no,menubar=no,scroolbars=no,resizable=no, width=500, height=200");
	}
	
	function confirmPwd() {
		if((document.joinform.userPwd.value == "") | (document.joinform.userRePwd.value == "")) {
			alert("비밀번호를 입력해주세요");
			document.joinform.userPwd.value = "";
			document.joinform.userRePwd.value = "";
			return;
		}
		
		if(document.joinform.userPwd.value == document.joinform.userRePwd.value) {
			alert("재입력한 비밀번호와 입력하신 비밀번호가 같습니다.");
			document.getElementById('register').disabled = false;
		} else if(document.joinform.userPwd.value != document.joinform.userRePwd.value) {
			alert("재입력한 비밀번호와 입력하신 비밀번호가 다릅니다.");
			document.getElementByName(userRePwd).focus();
			document.getElementById('register').disabled = true;
		} 
	}
</script>
<meta name="keywords" content="" />
	<meta name="description" content="" />
	<meta http-equiv="content-type" content="text/html; charset=utf-8" />
	<title></title>
	<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
	<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/join.css" rel="stylesheet" type="text/css" media="screen" />
<meta charset="UTF-8">
<style type="text/css"></style>
<title>회원가입</title>
</head>
<body>
	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	<div>
	<form name="joinform" action="insert.jsp" method="post" >
		<ul>
			<li><label id="lab">아이디<br>
				<input type="text" name="userId" required>				
				</label>
				<input id="check" type="button" value="중복확인" onClick="confirmId()"  style="width: 70px;">
			</li>
			
			<li><label>비밀번호<br>
				<input type="password" name="userPwd" required>				
				</label>
			</li>
			
			<li><label>비밀번호 재입력<br>
				<input type="password" name="userRePwd"  required>	
				</label>
				<input id="passwordCheck" type="button" value="중복확인" onClick="confirmPwd()" style="width: 70px;">			
			</li>
			
			<li><label>이름<br>
				<input type="text" name="userName" required>				
			</label></li>
			<li><label>이메일<br>
				<input type="email" name="userEmail" required>				
			</label></li>
			
			<li>
				<br><input id = "register" type="submit" value="가입하기" disabled ></input>
			</li>
		</ul>
	</form>
	</div>
	<div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
</div>
</body>
</html>