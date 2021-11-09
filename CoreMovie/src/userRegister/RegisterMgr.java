package userRegister;

import java.sql.*;
import java.util.*;

public class RegisterMgr {
	private final String JDBC_DRIVER="com.mysql.jdbc.Driver";
	private final String JDBC_URL="jdbc:mysql://localhost:3306/userdb?characterEncoding=utf-8";
	private final String USER="root";
	private final String PASS="YOUR_PASSWORD";
	
	public RegisterMgr() {
		try{
			Class.forName(JDBC_DRIVER);
		}catch(Exception e) {
			System.out.println("Error : JDBC 드라이버 로딩 실패");
		}
	}
	
	public Vector getMemberList(){   
		
	      Connection conn = null;
	      PreparedStatement pstmt = null;
	      ResultSet rs = null;
	      Vector vecList = new Vector();   
	      try{
	       conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
	       String sql = "select * from userinfo";
	       pstmt = conn.prepareStatement(sql);
	       rs = pstmt.executeQuery();
	       while(rs.next())
	       {
	          //while문을 통해 가지고 오는 값을 set메소드를 이용하여 저장
	        RegisterBean regBean = new RegisterBean();
	        regBean.setUserId(rs.getString("userId"));
	        regBean.setUserPwd(rs.getString("userPwd"));
	        regBean.setUserName(rs.getString("userName"));
	        regBean.setUserEmail(rs.getString("userEmail"));
	        vecList.add(regBean);
	       }
	      }catch(Exception ex){
	       System.out.println("Exception"+ex);
	      }finally{
	       if(rs != null)try{rs.close();}catch(SQLException e){}
	       if(pstmt != null)try{pstmt.close();}catch(SQLException e){}
	       if(conn != null)try{conn.close();}catch(SQLException e){}
	      }
	      // 값을 저장 후 멤버 목록들을 벡터 자료형으로 반환
	      return vecList;
	    }

	public boolean insertMember(RegisterBean mem) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			
			pstmt=conn.prepareStatement("insert into userinfo values(?, ?, ?, ?)");
			pstmt.setString(1,mem.getUserId());
			pstmt.setString(2,mem.getUserPwd());
			pstmt.setString(3,mem.getUserName());
			pstmt.setString(4,mem.getUserEmail());
			
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
	public int idCheck(String id) {
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs = null;
		String query = "select * from userinfo where userId = ?";
		try {
			conn = DriverManager.getConnection(JDBC_URL, USER,PASS);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return 0;
			}
		}catch (Exception e) {
				System.out.println(e.getMessage());
			}
			return 1;
	}
	
	public int userCheck(String id, String pw) { // 로그인시 아이디와 비밀번호 비교
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs = null;
		int check = -1;
		String query = "select * from userinfo where userId = ?"; // 유저가 입력한 id 와 동일한 레코드가 있는지 출력
		try {
			conn = DriverManager.getConnection(JDBC_URL, USER,PASS);
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()) {
			if(rs.getString("userId").equals("root") && rs.getString("userPwd").equals(pw)) { // 아이디가 관리자 계정이며, 비밀번호가 맞을 때
					check = 2;
				}	
			else if(!rs.getString("userId").equals("root") && rs.getString("userPwd").equals(pw)) { // 아이디가 일반 계정이며, 비밀번호가 맞을 때
					check = 1;
				} 	
			else { // 로그인 정보가 일치하지 않을 때
					check = 0;
				}
			}
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return check;
	}
	
	public RegisterBean getDB(String gb_id) {
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;

		String sql = "select * from userinfo where userId=?";
		RegisterBean reg = new RegisterBean();
		
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,gb_id);
			rs = pstmt.executeQuery();
			
			// 데이터가 하나만 있으므로 rs.next()를 한번만 실행 한다.
			rs.next();
			reg.setUserId(rs.getString("userId"));
			reg.setUserPwd(rs.getString("userPwd"));
			reg.setUserName(rs.getString("userName"));
			reg.setUserEmail(rs.getString("userEmail"));
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return reg;
	}
	
	public boolean deleteDB(String gb_id) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql ="delete from userinfo where userId=?";
		
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,gb_id);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return true;
	}
	
	public boolean updateDB(RegisterBean reg) {
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String sql ="update userinfo set userName=?, userEmail=?  where userId=?";		
		 
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1,reg.getUserName());
			pstmt.setString(2,reg.getUserEmail());
			pstmt.setString(3,reg.getUserId());
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		finally {
			if (rs != null) try{ rs.close(); } catch(SQLException ex){};
			if (pstmt != null) try{ pstmt.close(); } catch(SQLException ex){};
			if (conn != null) try{ conn.close(); } catch(SQLException ex){};
		}
		return true;
	}
	
	
	public ArrayList<RegisterBean> getDBList() {
		ArrayList<RegisterBean> datas = new ArrayList<RegisterBean>();
		Connection conn=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		String sql = "select * from userinfo order by userId desc";
		try {
			conn=DriverManager.getConnection(JDBC_URL,USER,PASS);
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				RegisterBean reg = new RegisterBean();
				
				reg.setUserId(rs.getString("userId"));
				reg.setUserPwd(rs.getString("userPwd"));
				reg.setUserName(rs.getString("userName"));
				reg.setUserEmail(rs.getString("userEmail"));
				datas.add(reg);
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
		return datas;
	}
}
/*
//닫기
public void close(Connection conn) {
	if (conn!=null) try {conn.close();} catch(SQLException e) {}
}
public void close(PreparedStatement pstmt) {
	if (pstmt!=null) try {pstmt.close();} catch(SQLException e) {}
}
public void close (ResultSet rs) {
	if (rs!=null) try {rs.close();} catch(SQLException e) {}
} */



