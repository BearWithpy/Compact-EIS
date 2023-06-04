<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/16
  Time: 10:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="navibar.module.css">
</head>
<body>
 <%
                          String navi_area = "";
                          String url = request.getRequestURL().toString();
                          System.out.println("현재 페이지 URL: " + url);

                          String result = url.substring(url.indexOf("8080/") + 5);
                          System.out.println(result);

                          if (result.contains("Human")) {
                              navi_area="인사";
                          } else if (result.contains("Account")) {
                              navi_area="회계";
                          } else if (result.contains("Sales")) {
                               navi_area="영업";
                          } else if (result.contains("index")) {
                                navi_area="Dashboard";
                          }
                          else{
                              navi_area="Dashboard";
                          }
                           System.out.println("navi_area :" + navi_area);
                        %>

<h1  id="naviTitle"  class="navi-area">&nbsp;&nbsp;&nbsp;&nbsp;Naviarea</h1>
<script>
var navi_area_js = '<%= navi_area %>';
console.log(navi_area_js);
var naviTitleElement = document.getElementById("naviTitle");
  naviTitleElement.innerText = navi_area_js;

</script>
</body>
</html>
