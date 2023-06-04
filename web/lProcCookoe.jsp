<%@ page import="java.sql.*" %> <%@ page language="java" contentType="text/html;
charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
    <title>로그인 결과</title>
  </head>
  <body>
    <% String dbid = null;//DB에서 가져온 데이터 String dbpwd = null;//DB에서
    가져온 데이터 try { Connection conn = DriverManager.getConnection(
    "server_address", "user", "password" ); Statement stmt =
    conn.createStatement(); ResultSet rs = stmt.executeQuery("SELECT UserId,
    Password FROM t_Sys_User tsu \n" + "WHERE UserId = 910150");
    while(rs.next()){ dbid = rs.getString(1); dbpwd = rs.getString(2); } }catch
    (SQLException e) { e.printStackTrace(); } String id =
    request.getParameter("id"); String pwd = request.getParameter("pwd"); //회원
    아이디 : user1 //비밀번호 : 1234 if(dbid.equals(id)){ if(dbpwd.equals(pwd)){
    //로그인 성공. 이경우에 쿠키에 id 저장 Cookie user = new Cookie("id",id);
    response.addCookie(user); response.sendRedirect("index.jsp");//로그인 성공시
    main으로 }else{ //비밀번호 오류. response.sendRedirect("loginFrm.jsp"); }
    }else{ //아이디 없음. response.sendRedirect("loginFrm.jsp"); } %>
  </body>
</html>
