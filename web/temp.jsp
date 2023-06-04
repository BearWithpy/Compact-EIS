<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/19
  Time: 2:52 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html>
<head>
  <title>Title</title>
  <script>
    function displayJSON(jsonResult) {
      var json = JSON.parse(jsonResult);
      console.log(json);
    }
  </script>
</head>
<body>
<%
  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

  try {
    Connection conn = DriverManager.getConnection(
      "server_address",
      "user",
      "password"
    );

    Statement stmt = conn.createStatement();
    ResultSet rs = stmt.executeQuery("EXEC sp_Fin_PlStatement_Query1 '202303'");

    JSONArray jsonArray = new JSONArray();

    while (rs.next()) {
      JSONObject jsonObject = new JSONObject();
      jsonObject.put("column2", rs.getString(2));
      jsonObject.put("column7", rs.getString(7));

      jsonArray.add(jsonObject);
    }

    String jsonResult = jsonArray.toString();

    out.println(jsonResult);
    System.out.println(jsonResult);
    out.println("<script>");
    out.println("displayJSON('" + jsonResult + "');");
    out.println("</script>");
  } catch (SQLException e) {
    e.printStackTrace();
  }
%>
</body>
</html>
