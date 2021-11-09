<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="movieRegister.Movie" %>

		<%
			movieRegister.Movie t1=new movieRegister.Movie();

			for(int temp=0;temp<6;temp++){
				int num=(temp+1)%3;
		%>
		
		<div class="tbox<%=num%>">
			<div class="box-style box-style0<%=temp+1 %>">
				<div class="content">
					<div id="rank"><%=temp+1%></div>
						<div class="image"><a href="Movie/moviedata.jsp?mvCode=<%=t1.getCode(temp)%>" ><img src="./img/<%=t1.movieRank(temp)%>.jpg" width="300" height="450" alt="" /></a></div>	
				</div>
			</div>
		</div>
		<%} %>
	