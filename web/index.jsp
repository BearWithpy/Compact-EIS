<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/10
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Compact EIS</title>
    <%@ include file="./include/base.jsp" %>
    <style>
        /*footer layout end*/
        <jsp:include page="sidebar/sidebar.module.css"/>
        <jsp:include page="headbar/headbar.module.css"/>

        .sample::before {
            font-size: 70px;
            line-height: 80px;
            width: 80px;
            height: 80px;
            display: block;
            font-family: 'Material Icons';
            /* font-size: 7rem; */
            background-color: #FF7000;
            color: white;
            text-align: center;
            content: '\e4fc';
        }

        .sample5::before {
            font-size: 70px;
            line-height: 80px;
            width: 80px;
            height: 80px;
            display: block;
            font-family: 'Material Icons';
            /* font-size: 7rem; */
            background-color: #619b8a;
            color: white;
            text-align: center;
            content: '\e8ca';
        }
    </style>
    <link rel="stylesheet" href="include/index.css"/>
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes" name="viewport">
</head>
<body>

<%
    String id = null;
    Cookie[] cs = request.getCookies();


    for (Cookie c : cs) {
        if (c.getName().equals("id")) {
            id = c.getValue();
        }
    }
    if (id == null) {//로그아웃후에 main페이지로 주소값을 입력해도 접속되지않게 방지 (로그인페이지호출)
        response.sendRedirect("loginFrm.jsp");
    }

    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

    Map<String, Object> map = new HashMap<String, Object>();
    Map<String, Object> map2 = new HashMap<String, Object>();
    String convertedDate = request.getParameter("convertedDate");
    int ratio = 0;
    int ratio2 = 0;
    try {
        Connection conn = DriverManager.getConnection(
            "server_address",
            "user",
            "password"
        );

        Statement stmt = conn.createStatement();

        if (convertedDate == null) {
            convertedDate = "202305";
        }
        ResultSet rs = stmt.executeQuery(String.format("Select SUM(YearPlanAmt), sum(SaleAmt) From T_SAL_Sale_Month tssm  \n" +
                "WHERE YyyyMm =%s", convertedDate));

        while (rs.next()) {
            map.put("목표", rs.getString(1));
            map.put("실적", rs.getString(2));
        }
        rs = stmt.executeQuery(String.format("SELECT ROUND((Sum(SaleAmt) /SUM(YearPlanAmt))  * 100,0 )\n" +
                "  FROM T_SAL_Sale_Month tssm\n" +
                " WHERE YyyyMm =%s", convertedDate));

        while (rs.next()) {
            ratio = rs.getInt(1);
        }
        rs = stmt.executeQuery(String.format("Select SUM(YearPlanAmt), sum(SaleOrderAmt) From T_SAL_SaleOrder_Month tssm  \n" +
                "WHERE YyyyMm =%s", convertedDate));

        while (rs.next()) {
            map2.put("목표", rs.getString(1));
            map2.put("실적", rs.getString(2));
        }
        rs = stmt.executeQuery(String.format("SELECT ROUND((Sum(SaleOrderAmt) /SUM(YearPlanAmt))  * 100,0 )\n" +
                "  FROM T_SAL_SaleOrder_Month tssm\n" +
                " WHERE YyyyMm =%s", convertedDate));

        while (rs.next()) {
            ratio2 = rs.getInt(1);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
%>
<div>
    <jsp:include page="headbar/headbar.jsp"/>
</div>
<div id="main">

    <aside>
        <jsp:include page="sidebar/sidebar.jsp"/>
    </aside>

<style>
#side-main{
    background-color:#e9eef3;
    border-left: 5px solid #023e8a;
}
#side-main>a{
    color:black;
}
@media (min-width:800px) {
    #footer_2{
        display:none;
    }
     #footer_1{
            display:flex;
        }

}
@media (max-width:800px) {
    #footer_1{
        display:none;
    }
}
</style>

    <section>
        <div class="nav-area">
            <jsp:include page="navibar/navibar.jsp"/>
            <%--            <jsp:include page="myeonghyeoncalendar4.jsp"/>--%>
            <jsp:include page="calendar.jsp"/>
        </div>
        <div id="head">
            <div id="head-content1">
                <div class="sample"></div>
                <div id="head-content1-center">
                    <ul>
                        <li style="height: 40px"><p style="text-align: left;font-size: 13px">매출실적(<%=convertedDate%>
                            )</p></li>
                        <li style="height: 40px"><p  id="record" style="text-align: left;font-size:13px">실적:<%=map.get("실적")%>
                        </p></li>
                        <li style="height: 40px"><p  id="goal" style="text-align: left;font-size:13px">목표:<%=map.get("목표")%>
                        </p></li>
                    </ul>
                </div>
                <div id="head-content1-right">
                    <h1 style="    font-size: 65px;
                                    width: 40%;
                                margin-top: -1%;
                                margin-right: 13%;"><font style="font-family: 'Wix Madefor Display', sans-serif;"><%=ratio%></font><strong style="font-size: 30px;color: #FF7000;">%</strong></h1>
                </div>
            </div>

            <div id="head-content2">
                <div class="sample5"></div>
                <div id="head-content2-center">
                    <ul>
                        <li style="height: 40px"><p style="text-align: left;font-size:13px">수주실적(<%=convertedDate%>)</p>
                        </li>
                        <li style="height: 40px"><p id="record2" style="text-align: left;font-size:13px">실적:<%=map2.get("실적")%>
                        </p></li>
                        <li style="height: 40px"><p id="goal2" style="text-align: left;font-size:13px">목표:<%=map2.get("목표")%>
                        </p></li>
                    </ul>
                </div>
                <div id="head-content2-right">
                    <h1 style="    font-size: 65px;
                                    width: 40%;
                                margin-top: -1%;
                                margin-right: 13%;"><font style="font-family: 'Wix Madefor Display', sans-serif;"><%=ratio2%></font><strong style="font-size: 30px;color: #619b8a;">%</strong></h1>
                </div>
            </div>
            <jsp:include page="exchange_rate_box.jsp"/>
        </div>

        <div id="body">

            <jsp:include page="index_body_chart2.jsp"/>
            <jsp:include page="index_body_chart1.jsp"/>
            <jsp:include page="index_body_chart3.jsp"/>

            <div id="footer_2" style="margin-right:30px;">
                <jsp:include page="index_body_chart4.jsp"/>
                <jsp:include page="index_body_chart5.jsp"/>
            </div>
        </div>
        <div id="footer_1">
                <jsp:include page="index_body_chart4_1.jsp"/>
                <jsp:include page="index_body_chart5_1.jsp"/>

        </div>
    </section>
</div>
</body>
<script>
    const n1 = Number(<%=map.get("목표")%>).toLocaleString()
    const n2 = Number(<%=map.get("실적")%>).toLocaleString()

    const n12 = Number(<%=map2.get("목표")%>).toLocaleString()
    const n22 = Number(<%=map2.get("실적")%>).toLocaleString()

    const goal = document.getElementById("goal");
    const record = document.getElementById("record");
    const goal2 = document.getElementById("goal2");
    const record2 = document.getElementById("record2");

    goal.innerText = `목표: `+ n1;
    record.innerText = `실적: `+ n2;
    goal2.innerText = `목표: `+ n12;
    record2.innerText = `실적: `+ n22;
</script>
</html>
