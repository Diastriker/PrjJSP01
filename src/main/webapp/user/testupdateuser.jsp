<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
   String name = request.getParameter("name");
//   String userid = request.getParameter("userid");
//   String passwd = request.getParameter("passwd");
   String email = request.getParameter("email");
   System.out.println(name);
   
   String  driver  = "oracle.jdbc.OracleDriver";
    String  url     = "jdbc:oracle:thin:@localhost:1521:xe";
    String  dbuid   = "test";
    String  dbpwd   = "1234";
    
    Class.forName(driver);
   Connection conn         = DriverManager.getConnection(url, dbuid, dbpwd);
   String sql = "";
   sql += "UPDATE TUSER ";
   sql += " SET EMAIL = ? ";
   sql += " WHERE NAME = ? ";

   PreparedStatement pstmt = conn.prepareStatement(sql);
   pstmt.setString( 1, email );
   pstmt.setString( 2, name );
   
   pstmt.executeUpdate(); // insert, delete, update
   
   pstmt.close();
   conn.close();
   
   /*
   String loc = "http://localhost:8080/PrjJSP01/user/userlist.jsp?name=all";
   response.sendRedirect(loc);
   */
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
   <script>
      alert('회원 수정 성공')
      location.href = "http://localhost:8080/PrjJSP01/user/userlist.jsp?name=all"
   </script>
</body>
</html>