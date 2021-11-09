<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="review.movie.*"%>
 <jsp:useBean id="RevList" scope="request" class="review.movie.ReviewList"/>
 <jsp:useBean id="RevMg" class="review.movie.ReviewMgr"/>
 <jsp:setProperty name="RevList" property = "*"/>
<%	
	// isEval 함수를 이용하여 사용자가 해당 영화를 평가한 경우 edit, 평가하지 않는 경우 insertScore 함수 수행
 	if(RevMg.isEval(RevList)) {
 		if(RevMg.editScore(RevList)) {
 			// 성공한 경우 해당 영화 사이트로 Redirect하기위해서 해당 영화값과 주소값 지정
 			int code = RevList.getMovieIndex();
 			String temp = "moviedata.jsp?mvCode=";
 	 		response.sendRedirect(temp + code);
 		} 
 	} else {
 		if(RevMg.insertScore(RevList)) {
 		// 성공한 경우 해당 영화 사이트로 Redirect하기위해서 해당 영화값과 주소값 지정
 			int code = RevList.getMovieIndex();
 			String temp = "moviedata.jsp?mvCode=";
 	 		response.sendRedirect(temp + code);
 	 	}
 	}
%>