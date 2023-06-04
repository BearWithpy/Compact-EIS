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
    stmt.executeQuery( "EXEC SP_FIN_BalRatio_Query1 '202112', 'X'" ); while
    (rs.next()) { out.println(rs.getString(4)); } } catch (SQLException e) {
    e.printStackTrace(); } %>
  </body>
</html>
