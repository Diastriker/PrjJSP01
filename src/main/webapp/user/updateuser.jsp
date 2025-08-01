<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

// 넘어온 정보를 변수에 받는다
request.setCharacterEncoding("utf-8"); // 넘어온 한글처리
String id     = request.getParameter("id");
String name   = request.getParameter("name");
String passwd = request.getParameter("passwd");
String email = request.getParameter("email");
System.out.println(name);

// db 연결 한다
String  driver  = "oracle.jdbc.OracleDriver";
String  url     = "jdbc:oracle:thin:@localhost:1521:xe";
String  dbuid   = "test";
String  dbpwd   = "1234";

// db 에 저장 한다
Class.forName(driver);
	Connection conn         = DriverManager.getConnection(url, dbuid, dbpwd);
	String sql = "";	
	sql += "UPDATE TUSER ";
	sql += " SET NAME = ?, PASSWD = ?, EMAIL = ? ";
	sql += " WHERE ID = ?";
	PreparedStatement pstmt = conn.prepareStatement(sql);
	pstmt.setString(1, name   );
	pstmt.setString(2, passwd );
	pstmt.setString(3, email );
	pstmt.setInt(4, Integer.parseInt(id) );
	
	pstmt.executeUpdate(); // insert, delete, update
	
	pstmt.close();
	conn.close();
	
// 돌아간다
String loc = "http://localhost:8080/PrjJSP01/user/userlist.jsp?name=all";
response.sendRedirect(loc);

%>
