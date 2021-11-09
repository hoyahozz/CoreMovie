package userRegister;

import java.sql.*;
import java.util.ArrayList;

public class CommentMgr {
	
	private final String JDBC_DRIVER="com.mysql.jdbc.Driver";
	private final String JDBC_URL="jdbc:mysql://localhost:3306/userdb?characterEncoding=utf-8";
	private final String USER="root";
	private final String PASS="YOUR_PASSWORD";
	
	private Connection conn;
	private ResultSet rs;
	
	public CommentMgr() {
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
		String SQL = "SELECT COMMENTID FROM COMMENT ORDER BY COMMENTID DESC"; // 내림차순을 해서 가장 마지막에 쓴 댓글 번호를 가져옴
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; // 그 다음 댓글 번호가 들어가게
			}
			return 1; // 현재가 첫 댓글일 때는 1을 리턴함으로 첫번째 게시글이라는 의미를 담음.
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	
	public int write(int bbsID, String userID, String commentContent) { // 게시글을 작성하는 함수
		String SQL = "INSERT INTO COMMENT VALUES(?, ?, ?, ?, ?, ?)"; 
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext()); // 다음 번에 쓰여야 할 댓글 번호[commentId]
			pstmt.setInt(2, bbsID); // 댓글 번호
			pstmt.setString(3, userID); // 유저정보
			pstmt.setString(4, getDate()); // 날짜(getDate() 함수)
			pstmt.setString(5, commentContent); // 글 내용
			pstmt.setInt(6, 1); // available 에는, 처음 글이 쓰여지는 것이니 당연히 보이게 1을 설정함.
			return pstmt.executeUpdate(); // 0 이상의 결과 반환
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1; // 데이터베이스 오류
	}
	
	public ArrayList<CommentBean> getList(int bbsID) { // 댓글의 리스트를 뽑아내는 함수
		String SQL = "SELECT * FROM comment WHERE bbsID = ? and commentAvailable = 1 ORDER BY COMMENTID DESC";
		// 해당 게시글의 댓글을 뽑고(where bbsID = ?), 삭제되지 않은 것(coomentAvailable = 1)을 내림차순 (order by commentId DESC)
		ArrayList<CommentBean> list = new ArrayList<CommentBean>(); // 빈 클래스 형식의 리스트로 변환
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, bbsID);
			rs = pstmt.executeQuery();
			while (rs.next()) { // 해당 페이지의 댓글 결과가 나올 때마다
				CommentBean commentBean = new CommentBean();
				commentBean.setCommentID(rs.getInt(1));
				commentBean.setBbsID(rs.getInt(2));
				commentBean.setUserID(rs.getString(3));
				commentBean.setCommentDate(rs.getString(4));
				commentBean.setCommentContent(rs.getString(5));
				commentBean.setCommentAvailable(rs.getInt(6));
				list.add(commentBean); // 모든 데이터를 담아 CommentBean 리스트에 담음
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return list; // 뽑은 리스트를 리턴
	}
	
	public CommentBean getComment(int commentID) { // 게시글에 해당되는 모든 정보를 리턴해주는 함수
		String SQL = "SELECT * FROM comment WHERE commentID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentID); 
			rs = pstmt.executeQuery();
			if (rs.next()) {
				CommentBean comment = new CommentBean();
				comment.setCommentID(rs.getInt(1));
				comment.setBbsID(rs.getInt(2));
				comment.setUserID(rs.getString(3));
				comment.setCommentDate(rs.getString(4));
				comment.setCommentContent(rs.getString(5));
				comment.setCommentAvailable(rs.getInt(6));
				return comment;
	
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null; // 이 함수는 실제로 사용은 안하였으나, 필요시 언제든 사용할 수 있어 일단 남겨둠.
	}
	
	public int delete(int CommentID) { // 삭제하는 함수
		String SQL = "UPDATE COMMENT SET CommentAvailable = 0 WHERE CommentID = ?"; // 삭제하더라도 정보가 남게 bbsAvaliable을 0으로 설정
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, CommentID);
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return -1;	
	}
}
