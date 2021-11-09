<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <jsp:useBean id="RevMg" class="review.movie.ReviewMgr"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
	<link href="http://fonts.googleapis.com/css?family=Oxygen:400,700,300" rel="stylesheet" type="text/css" />
	<link href="../CSS/style.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/review.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/moviedata.css" rel="stylesheet" type="text/css" media="screen" />
	<link href="../CSS/star-rating-svg.css" rel="stylesheet" type="text/css" media="screen" />
	<script src="//code.jquery.com/jquery-2.1.4.min.js"></script>
	<script src="../js/jquery.star-rating-svg.js"></script>


<%
	
	String mvCode=request.getParameter("mvCode");
	movieRegister.Movie t1=new movieRegister.Movie();
	String data[]=t1.movieData(mvCode);
	String id2 = (String)session.getAttribute("memId");
	String logcheck = (String)session.getAttribute("memLogin");
	
	 int movieIndex = (Integer)request.getAttribute("mvCode");
		// 평가를 한 경우 중복 평가를 방지를 하기 위한 변수 선언 및 초기값 지정
	 	int duplicate = 0;
		// 중복이면 duplicate변수에 1을 대입
	 	if(RevMg.isDuplicate(id2, Integer.parseInt(mvCode))) {
	 		duplicate = 1;
	 	} else {
	 		duplicate = 0;
	 	} 
		// mvCode를 control로 보내기 위해 setAttribute 수행
	 	request.setAttribute("mvCode", mvCode);
		// 해당 mvCode에 해당하는 영화 점수를 저장하기 위한 변수
	 	double score = RevMg.getScore((Integer.parseInt(mvCode)));
	
	
%>
<script>
// 스크립트릿에서 선언한 점수를 JavaScript에서 사용하기 위해 score변수 선언
var score = "<%=score%>";
/* 평가 할 별점을 표시하는 jQuery 함수
 * 1. html로드 후 바로 jQuery를 사용하기 위해 $(document).ready(function()) 안에다가 수행할 함수 선언
 * 2. 태그들 중에 클래스가 starRev인 span태그를 누르면
 * 3. 그 span태그의 부모 즉 div태그 클래스 StarRev 안에 있는 자식들의 span 태그들의 중 on클래스를 모두 삭제
 * 4. 다 삭제 후, 클릭 한 이전 모든 span 태그에 클래스 on을 붙여서 별점을 표시
 * 5. jQuery 함수 수행 후 false를 return하여 정상 종료
 */
$( document ).ready( function() {
	$('.starRev span').click(function(){
	  $(this).parent().children('span').removeClass('on');
	  $(this).addClass('on').prevAll('span').addClass('on');
	  return false;
	});
} );
/* 화면에 점수 표시하는 JavaScript setInterval 함수 
 * 1 .starR1 과 starR2의 갯수를 더한 후 2를 나눠 별의 갯수를 선언
 * 2. 텍스트 박스에 별의 갯수를 표시
 */
review_score = setInterval(function(){
	var count = ($("span.starR1.on").length + $("span.starR2.on").length) / 2;
	$("input[type=text][name=movieScore]").val(count);	
}, 100);
/* 별점 평가 후 해당 영화에 들어온 경우 수정하게 만드는 함수
 * 1. 정상 사용을 위해 window.onload를 이용하여 안에다가 함수 작성
 * 2,3,4 id가 evaluate,edit인 값 저장, logcheck 변수에는 스크립트 릿에서 저장 로그인 상태를 저장
 * 비회원인 경우, 수정 및 평가 버튼들을 disabled 상태로 수정
 * 해당 회원이 평가 한 경우, 등록 대신 수정버튼 활성화
 * 평가하지 않은경우 수정버튼 대신 등록 버튼 활성화
*/
window.onload = function () {
   var evaluate = document.getElementById('evaluate');
   var edit = document.getElementById('edit');
   var logcheck = "<%= logcheck%>"
   /* 비회원들은 평가을 못하게 하는 함수 */
   if(logcheck != "null") {
      if(<%= duplicate%> ==  1) {
         evaluate.disabled = true;
         edit.disabled = false; 
      } else {
         evaluate.disabled = false;
         edit.disabled = true;
      }
   } else {
      evaluate.disabled = true;
      edit.disabled = true;
   }
}
</script>
</head>
<body>
<div id="wrapper">
	<div id="logo" class="container">
		<%@ include file="../Module/logo.jsp" %>
	</div>
	
	<div class="login_menu">
		<%@ include file="../Module/login_menu.jsp" %>
	</div>
	<div id="menu-wrapper">
		<%@ include file="../Module/menu.jsp" %>
	</div>

	<div id="mvContainer">
	
	<div id="mvData">	
		<div id="mvName"><%=data[0] %></div>
		<%=data[1] %><hr>
<!-- 별 한개의 기준으로 왼쪽 반개별은 starR1, 오른쪽 반개별은 starR2 -->
	
	<div class="demo jq-stars"></div> <%=score %><br><hr>
		<span class="sub">개요</span>    <%=data[3]%> | <%=data[4] %> | <%=data[2] %>분<br>
		<span class="sub">감독</span>		<%=data[5] %> <br>
		<span class="sub">출연</span>		<%=data[6] %><%=data[7] %><br>
		<span class="sub">등급</span>		<%=data[8] %>		
	</div>
	
	<div id="mvImg"><img src="./img/<%=data[0]%>.jpg" width="200" height="350"  alt=""/></div>
	</div>
	
	
	<div id="starContainer">
	<div class="starRev">
  		<span class="starR1">별1_왼쪽</span>
  		<span class="starR2">별1_오른쪽</span>
  		<span class="starR1">별2_왼쪽</span>
  		<span class="starR2">별2_오른쪽</span>
  		<span class="starR1">별3_왼쪽</span>
  		<span class="starR2">별3_오른쪽</span>
  		<span class="starR1">별4_왼쪽</span>
  		<span class="starR2">별4_오른쪽</span>
  		<span class="starR1">별5_왼쪽</span>
  		<span class="starR2">별5_오른쪽</span>
	</div>
	<form action="review_control.jsp">
	<input type="text" name="movieScore" readonly>
	<!-- 영화별로 인덱스를 지정하여 버튼 입력이 해당 영화의 인덱스값과 평점을 DB에 저장 -->
	<input type="hidden" name="movieIndex" value="<%= mvCode%>">
	<input type="hidden" name="userId" value="<%= id%>"/>
	<!-- 평점 등록을 한 후 clearInterval함수를 이용하여 실시간 점수표시 중지 후 인덱스와 별점 데이터를 영화 디비에 전송 -->
	<input type="submit" id="evaluate" value="평점등록" onclick="clearInterval(review_score)">
	<input type="submit" id="edit" value="평점수정" onclick="clearInterval(review_score)" disabled>
	
	
	</form>
	</div>

<script>
// 
$(".demo").starRating({
	  totalStars: 5, // 별의 갯수 최대치
	  minRating: 0,
	  useFullStars:false,
	  initialRating: score, // 해당 영화의 점수를 초기값으로 지정
	  starShape:'straight',
	  emptyColor:'lightgray',
	  hoverColor:'orange',
	  activeColor:'gold',
	  ratedColor:'crimson',
	  useGradient:false,
	  readOnly:true, // 수정을 불가능하게 readonly설정
	  disableAfterRate:true,
	  baseUrl:false,
	  strokeWidth: 0,
	  strokeColor:'black',
	  starSize: 40,
	  forceRoundUp:true,
	  callback:function(currentRating){
	  }
	});
</script>
	
	<div id="footer">
	<%@ include file="../Module/bottom.jsp" %>
	</div>
</div>
</body>
</html>