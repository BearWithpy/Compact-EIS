<%@ page import="java.sql.*" %><%-- Created by IntelliJ IDEA. User: junsu Date:
2023/05/19 Time: 10:27 AM To change this template use File | Settings | File
Templates. --%> <%@ page contentType="text/html;charset=UTF-8" language="java"
%>
<html>
  <head>
    <title>Title</title>
  </head>
  <body>
    <% Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); try {
    Connection conn = DriverManager.getConnection( "server_address", "user",
    "password" ); Statement stmt = conn.createStatement(); ResultSet rs =
    stmt.executeQuery( "EXEC sp_hum_Salary_Query2 '202203', 'M', '1'" ); while
    (rs.next()) { out.println(rs.getString(2)); out.println(rs.getString(3));
    out.println(rs.getString(4)); out.println(rs.getString(5));
    out.println(rs.getString(7)); out.println(rs.getString(8));
    out.println(rs.getString(9)); out.println(rs.getString(10));
    out.println(rs.getString(11)+"<br />"); } } catch (SQLException e) {
    e.printStackTrace(); } %>
  </body>
</html>
