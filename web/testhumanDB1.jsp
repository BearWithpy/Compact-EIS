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
    stmt.executeQuery( "EXEC sp_hum_Organ_Query2 '2021-05-19'" ); while
    (rs.next()) { out.println(rs.getRow()); out.println(rs.getString(1));
    out.println(rs.getString(2)); out.println(rs.getString(3));
    out.println(rs.getString(4)); out.println(rs.getString(5)+"<br />"); } }
    catch (SQLException e) { e.printStackTrace(); } %>

    <script></script>
  </body>
</html>
