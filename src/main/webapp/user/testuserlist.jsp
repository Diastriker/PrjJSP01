<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%
   // 넘어오는 값 받기
   // http://localhost:8080/PrjJSP01/userlist.jsp?name=all
   String name = request.getParameter("q");
   if( name == null )
      name = "all";
   System.out.println(name);
   
   // 연결 문자열 
   // db Connection String
    String  driver  = "oracle.jdbc.OracleDriver";
    String  url     = "jdbc:oracle:thin:@localhost:1521:xe";
    String  dbuid   = "test";
    String  dbpwd   = "1234";
    
    String  tag     = "";
    
   //db 조회
   if( name.equals("all") ) {
      Class.forName(driver);
      Connection conn         = DriverManager.getConnection(url, dbuid, dbpwd);
      String sql = "";
      sql       += "SELECT * FROM TUSER ";
      sql       += " ORDER BY ID ASC";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet         rs    = pstmt.executeQuery();
      
       tag  = "<table id='t2'>";
      while( rs.next() ) {
         tag += "<tr>";
         tag += "<td>" + rs.getInt("id") + "</td>";
         tag += "<td>" + rs.getString("name") + "</td>";
         tag += "<td>" + rs.getString("userid") + "</td>";
         tag += "<td>" + rs.getString("passwd") + "</td>";
         tag += "<td>" + rs.getString("email") + "</td>";
         tag += "<td>" + rs.getString("regdate") + "</td>";
         tag += "</tr>";
      }
      tag += "</table>";
      
      rs.close();
      pstmt.close();
      conn.close();
   } else {
      Class.forName(driver);
      Connection conn         = DriverManager.getConnection(url, dbuid, dbpwd);
      String sql = "";
      sql       += "SELECT * FROM TUSER ";
      sql       += " WHERE NAME LIKE ? ";
      sql       += " ORDER BY ID ASC";
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setString(1, "%" + name + "%");
      ResultSet         rs    = pstmt.executeQuery();
      
       tag  = "<table id='t2'>";
      while( rs.next() ) {
         tag += "<tr>";
         tag += "<td>" + rs.getInt("id") + "</td>";
         tag += "<td>" + rs.getString("name") + "</td>";
         tag += "<td>" + rs.getString("userid") + "</td>";
         tag += "<td>" + rs.getString("passwd") + "</td>";
         tag += "<td>" + rs.getString("email") + "</td>";
         tag += "<td>" + rs.getString("regdate") + "</td>";
         tag += "</tr>";
      }
      tag += "</table>";
      
      rs.close();
      pstmt.close();
      conn.close();
   }
   // 출력할 html 만들기
%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style>
   table, th, td { 
      border : 1px solid black;
      border-collapse: collapse;   
    }
   table { width : 80%; margin : 0 auto; }
   
   td { padding : 10px; }
   
   h2 { text-align : center; }
</style>

<script src="https://code.jquery.com/jquery.min.js"></script>
<script>
   $( function() {
  //   console.log( $('tr') )
      $('#t2 tr').on( {
         mouseover : function() {
            $(this).css({
               background : 'cyan',
               color      : 'red'
            })
         },
         mouseout : function() {
            $(this).css({
               background : 'white',
               color      : 'black'
            })
         },
         dblclick : function() {
        	 console.dir(this)
        	 name = this.childNodes[1].innerHTML
        	 $('#t1 input[name="name"]').val(name) //input 생략 가능
        //	 alert(name);
         }
      } )
   })
</script>

</head>
<body>
   <h2>사용자 목록</h2>
   
   <form action="updateuser.jsp" method="GET">
   <table id="t1">
       <tr>
           <td><input type="text" name="id" readonly value="123"/></td>
           <td><input type="text" name="name"/></td>
           <td><input type="text" name="userid" readonly/></td>
           <td><input type="text" name="passwd"/></td>
           <td><input type="text" name="email"/></td>
           <td><input type="text" name="regedate" readonly/></td>
           <td><input type="submit" value="수정"/></td>
       </tr>
   </table>
   </form>
   
   <p><%=tag %></p>
   
   <a href="tuserlist.html">HOME</a>
</body>
</html>