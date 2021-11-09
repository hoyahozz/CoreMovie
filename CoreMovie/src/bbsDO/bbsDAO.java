package bbsDO;

import java.sql.*;
import java.util.*;

public class bbsDAO {
	private final String JDBC_DRIVER="com.mysql.jdbc.Driver";
	private final String JDBC_URL="jdbc:mysql://localhost:3306/userdb?characterEncoding=utf-8";
	private final String USER="root";
	private final String PASS="YOUR_PASSWORD";
	//ㅅㅎㅎㅎㅎㅎㅎ
	public bbsDAO() {
		try{
			Class.forName(JDBC_DRIVER);
		}catch(Exception e) {
			System.out.println("Error : JDBC 드라이버 로딩 실패");
		}
	}
	// 게시물 목록 출력 함수
	public Vector getContentList(){   
		
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      Vector bbsList = new Vector();   
	      try{
	       conn = DriverManager.getConnection(JDBC_URL,USER,PASS);
	       String sql = "select * from bbs";
	       pstmt = conn.prepareStatement(sql);
	       rs = pstmt.executeQuery();
	       while(rs.next())
	       {
	          //while문을 통해 가지고 오는 값을 set메소드를 이용하여 저장
	        bbsDTO dto = new bbsDTO();
	        dto.setBbsID(rs.getInt("bbsID"));
	        dto.setBbsTitle(rs.getString("bbsTitle"));
	        dto.setUserID(rs.getString("userID"));
	        dto.setBbsDate(rs.getString("bbsDate"));
	        dto.setBbsAvailable(rs.getInt("bbsAvailable"));
	        bbsList.add(dto);
	       }
	      }catch(Exception ex){
	       System.out.println("Exception"+ex);
	      }finally{
	       if(rs != null)try{rs.close();}catch(SQLException e){}
	       if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
	       if(conn != null)try{conn.close();}catch(SQLException e){}
	      }
	      // 값을 저장 후 멤버 목록들을 벡터 자료형으로 반환
	      return bbsList;
	    }
	// 게시물 삭제
	public boolean adjustContent(int bbsID, int status) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			String sql = "update bbs set bbsAvailable = ? where bbsID = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,status);
			pstmt.setInt(2,bbsID);
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
	// 게시물 복구
	public boolean recoverContent(int bbsID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			String sql = "update bbs set bbsAvailable = 1 where bbsID = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,bbsID);
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
	
	// 게시물 상태 반환 함수
	public int getStatus(int bbsID) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			String sql = "select bbsAvailable from bbs where bbsID = ?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1,bbsID);
			rs = pstmt.executeQuery();
			rs.next();
			return rs.getInt("bbsAvailable");
		    }catch(Exception ex){
		       System.out.println("Exception"+ex);
		      }finally{
		       if(rs != null)try{rs.close();}catch(SQLException e){}
		       if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
		       if(conn != null)try{conn.close();}catch(SQLException e){}
		      }
		      // 값을 저장 후 멤버 목록들을 벡터 자료형으로 반환
		return 0;
	}
}
	

