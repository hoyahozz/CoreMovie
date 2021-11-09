package review.movie;

import java.sql.*;

public class ReviewMgr {
	private final String JDBC_DRIVER="com.mysql.jdbc.Driver";
	private final String JDBC_URL="jdbc:mysql://localhost:3306/userdb?useSSL=false&characterEncoding=utf-8";
	private final String USER="root";
	private final String PASS="YOUR_PASSWORD";
	
	public ReviewMgr() {
		try{
			Class.forName(JDBC_DRIVER);
		}catch(Exception e) {
			System.out.println("Error : JDBC 드라이버 로딩 실패");
		}
	}
	/* 점수입력 함수 */
	public boolean insertScore(ReviewList rev) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt=conn.prepareStatement("insert into review(userId, movieIndex, movieScore) values(?, ?, ?)");
			pstmt.setString(1, rev.getUserId());
			pstmt.setInt(2,rev.getMovieIndex());
			pstmt.setDouble(3,rev.getMovieScore());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			System.out.println("Exception"+ex);
			return false;
		}finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return true;
	}
	/*점수 수정 함수*/
	public boolean editScore(ReviewList rev) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt=conn.prepareStatement("update review set movieScore = ? where userId=? and movieIndex=?");
			pstmt.setDouble(1,rev.getMovieScore());
			pstmt.setString(2, rev.getUserId());
			pstmt.setInt(3,rev.getMovieIndex());
			pstmt.executeUpdate();
		}catch(Exception ex) {
			System.out.println("Exception"+ex);
			return false;
		}finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return true;
	}
	/*점수 출력 함수 */
	public double getScore(int movieIndex) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		double totalScore = 0.0;
		String sql = "select round(avg(movieScore),2) as total from review where movieIndex=?";
		
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1,movieIndex);
			rs = pstmt.executeQuery();
			rs.next();
			totalScore = rs.getDouble("total");
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return totalScore;
}
	
	/* 점수 중복 체크 함수*/
	public boolean isEval(ReviewList rlist) {
		boolean evalFlag = false;
		int evalTemp = 0;
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql = "select count(userId) as Eval from review where userId=? and movieIndex=?";
		
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, rlist.getUserId());
			pstmt.setInt(2, rlist.getMovieIndex());
			rs = pstmt.executeQuery();
			rs.next();
			evalTemp = rs.getInt("Eval");
			if(evalTemp == 1) {
				evalFlag = true;
			} else {
				evalFlag = false;
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return evalFlag;
}	
 /* 점수 중복 입력 방지 함수 */
public boolean isDuplicate(String userId, int movieIndex) {
	boolean DuplicateResult = false;
	Connection conn=null;
	PreparedStatement pstmt=null;
	ResultSet rs=null;
	String sql = "select count(userId) as duplicate from review where userId=? and movieIndex=?";
	
	try {
		conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1,userId);
		pstmt.setInt(2, movieIndex);
		rs = pstmt.executeQuery();
		rs.next();
		if(rs.getInt("duplicate") == 1) DuplicateResult = true;
		else DuplicateResult = false;
		rs.close();
		
	} catch (SQLException e) {
		e.printStackTrace();
	}
	finally {
		if (rs != null) try{ rs.close(); } catch(SQLException ex){};
		if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
		if (conn != null) try{ conn.close(); } catch(SQLException ex){};
	}
	return DuplicateResult;
	}
}
