<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.naming.Context" %>
<%@ page import="javax.naming.InitialContext" %>
<%@ page import="javax.sql.DataSource" %><%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/18
  Time: 3:18 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<%
  Connection conn = null;
  Statement stmt = null;
  ResultSet rs = null;

  Context context = new InitialContext();
  DataSource ds = (DataSource) context.lookup("java:comp/env/jdbc/uni");

  conn = ds.getConnection();
  stmt = conn.createStatement();
  rs = stmt.executeQuery("SELECT CurrencyCode, BasicRate, BasicDt \n" +
          "FROM T_Fin_ExRate\n" +
          "ORDER BY BASICDT DESC\n" +
          "OFFSET 0 ROWS\n" +
          "FETCH NEXT 6 ROWS ONLY");

  while (rs.next()){
    out.print(rs.getString(1) + rs.getString(2));
  }

  out.print("Connection: " + conn.isClosed() + "<br>");
  conn.close();
  out.print("Connection: " + conn.isClosed() + "<br>");
%>

</body>
</html>
