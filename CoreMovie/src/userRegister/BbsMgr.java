package userRegister;

import java.sql.*;
import java.util.ArrayList;
import java.util.Vector;


public class BbsMgr { // 데이터베이스와 연동하는 생성자
	private final String JDBC_DRIVER="com.mysql.jdbc.Driver";
	private final String JDBC_URL="jdbc:mysql://localhost:3306/userdb?characterEncoding=utf-8";
	private final String USER="root";
	private final String PASS="YOUR_PASSWORD";
	
	private Connection conn;
	
	private ResultSet rs;
	
	public BbsMgr() {
		try{
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL,USER,PASS);
		}catch(Exception e) {
			System.out.println("Error : JDBC 드라이버 로딩 실패");
		}
	}
	
	public String getDate() { // 현재 시간을 가져오는 함수
		String SQL = "SELECT NOW()"; // 현재 시간을 가져오는 SQL문
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) { // 결과가 있는 경우
				return rs.getString(1); // 현재의 날짜 반환
			}
		} catch(Exception e) { // 오류 발생시
			e.printStackTrace();
		}
		return ""; // 데이터베이스 오류일 시 빈 문자 리턴
	}
	
	public int getNext() {
		String SQL = "SELECT bbsID FROM BBS ORDER BY bbsID DESC"; // 내림차순을 해서 가장 마지막에 쓴 글 번호를 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; // 그 다음 게시글 번호가 들어가게
			}
			return 1; // 현재가 첫 게시물일 때
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	/* getNext() 부연 설명 -> 만약 현재 게시글이 3라고 가정하면, SQL문의 결과물은 [3 - 2 - 1] 순으로 나옴.
	 * 그리고 그 결과물이 있으면, 마지막에 나온 3 (rs.getInt(1)) 에  1을 더하며, 4를 리턴하게 함. (즉, 4번째 게시글을 써야할 차례이니 4를 리턴한다는 의미)
	 * 결과물이 없으면, 첫 게시물이라는 의미이므로, 1을 리턴함. */ 
	
	public int write(String bbsTitle, String userID, String bbsContent) { // 게시글을 작성하는 함수
		String SQL = "INSERT INTO BBS VALUES(?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // 다음 번에 쓰여야 할 글 번호(위의 부연설명 참조) [bbsId]
			pstmt.setString(2, bbsTitle); // 제목
			pstmt.setString(3, userID); // 유저정보
			pstmt.setString(4, getDate()); // 날짜(getDate() 함수)
			pstmt.setString(5, bbsContent);
			pstmt.setInt(6, 1); // available 에는, 처음 글이 쓰여지는 것이니 당연히 보이게 1을 설정함. 밑의 주석 참조
			return pstmt.executeUpdate(); // 0 이상의 결과 반환
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	/* BbsAvailable -> 글이 삭제되었으면 (0), 글이 삭제되지 않았으면(1) 이렇게 설정하는 이유는 삭제되더라도 글의 정보를 남기기 위함.*/
	
	
	// 특정 리스트를 담아서 반환할 수 있게 함
	public ArrayList<BbsBean> getList(int pageNumber) { // 한 페이지(총 10개의 글)를 넘겨가면서 확인
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1 ORDER BY bbsID DESC LIMIT 10";
		// bbsID 가 pageNumber 보다 작고, bbsAvailable = 1(삭제가 되지 않은), bbsID를 내림차순 정렬로 위에서 10개까지만 가져오게 함.
		ArrayList<BbsBean> list = new ArrayList<BbsBean>();
		
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); // 5개의 글이 있다고 가정, 6 - (1-1) * 10(첫페이지)
			rs = pstmt.executeQuery();
			while (rs.next()) { // 결과가 나올 때마다
				BbsBean bbsBean = new BbsBean();
				bbsBean.setBbsID(rs.getInt(1));
				bbsBean.setBbsTitle(rs.getString(2));
				bbsBean.setUserID(rs.getString(3));
				bbsBean.setBbsDate(rs.getString(4));
				bbsBean.setBbsContent(rs.getString(5));
				bbsBean.setBbsAvailable(rs.getInt(6));
				list.add(bbsBean); // 모든 데이터를 담아 bbsBean 리스트에 담음
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; // 10개씩 뽑아온 리스트를 리턴
	}
	
	public boolean nextPage(int pageNumber) { // 게시글 10개 이하일 땐 다음페이지가 없어야 함. 10개 이상일 땐 다음 페이지가 있어야 함.
		String SQL = "SELECT * FROM BBS WHERE bbsID < ? AND bbsAvailable = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10); 
			rs = pstmt.executeQuery();
			if (rs.next()) { // 결과가 하나라도 존재한다면 다음페에지
				return true;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return false;
	}

	
	public BbsBean getBbs(int bbsID) { // 게시글에 해당되는 모든 정보를 리턴해주는 함수
		String SQL = "SELECT * FROM BBS WHERE bbsID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID); 
			rs = pstmt.executeQuery();
			if (rs.next()) {
				BbsBean bbs = new BbsBean();
				bbs.setBbsID(rs.getInt(1));
				bbs.setBbsTitle(rs.getString(2));
				bbs.setUserID(rs.getString(3));
				bbs.setBbsDate(rs.getString(4));
				bbs.setBbsContent(rs.getString(5));
				bbs.setBbsAvailable(rs.getInt(6));
				return bbs;
	
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int bbsID, String bbsTitle, String bbsContent) { // 게시글을 수정하는 함수
		String SQL = "UPDATE BBS SET bbsTitle = ?, bbsContent = ? WHERE bbsID = ?"; // 게시글에 해당되는 제목과 수정을 바꾸겠다는 SQL
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, bbsTitle);
			pstmt.setString(2, bbsContent);
			pstmt.setInt(3, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
	
	public int delete(int bbsID) {
		String SQL = "UPDATE BBS SET bbsAvailable = 0 WHERE bbsID = ?"; // 삭제하더라도 정보가 남게 bbsAvaliable을 0으로
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
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
	        BbsBean bean = new BbsBean();
	        bean.setBbsID(rs.getInt("bbsID"));
	        bean.setBbsTitle(rs.getString("bbsTitle"));
	        bean.setUserID(rs.getString("userID"));
	        bean.setBbsDate(rs.getString("bbsDate"));
	        bean.setBbsAvailable(rs.getInt("bbsAvailable"));
	        bbsList.add(bean);
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
