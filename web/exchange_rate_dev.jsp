<%--
Created by IntelliJ IDEA.
User: junsu
Date: 2023/05/19
Time: 11:34 AM
To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>

<html>
<head>
    <title>Title</title>
</head>
<body>
<div class="exchange-rate-box" id="head-content2"><h5 id="nation"></h5><br/>
    <h1 id="change"></h1></div>

<%

    Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");


    ArrayList<HashMap<String, String>> jsonarr = null;
    try {
        Connection conn = DriverManager.getConnection(
            "server_address",
            "user",
            "password"
        );

        Statement stmt = conn.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT CurrencyCode, BasicRate, BasicDt \n" +
                "FROM T_Fin_ExRate\n" +
                "ORDER BY BASICDT DESC\n" +
                "OFFSET 0 ROWS\n" +
                "FETCH NEXT 6 ROWS ONLY");

        HashMap<String, String> map = null;
        jsonarr = new ArrayList<>();

        while (rs.next()) {
            map = new HashMap<>();
            map.put(rs.getString("CurrencyCode"), rs.getString("BasicRate").substring(0, rs.getString("BasicRate").length() - 2));
            jsonarr.add(map);
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }


%>


<%--USD 1332.70--%>
<%--KRW 1.00--%>
<%--JPY 962.00--%>
<%--GBP 1654.35--%>
<%--EUR 1436.12--%>
<%--CNY 189.72--%>

<%--<%=jsonarr%>--%>

<%--<% for (HashMap<String, String> item : jsonarr) { %>--%>
<%--<% for (Map.Entry<String, String> entry : item.entrySet()) { %>--%>
<%--<p>--%>
<%--    <strong><%= entry.getKey()%>--%>
<%--    </strong><%= entry.getValue() %>--%>
<%--</p>--%>
<%--<% } %>--%>
<%--<% } %>--%>

<%
    StringBuilder jsonStr = new StringBuilder("[");
    for (HashMap<String, String> item : jsonarr) {
        for (Map.Entry<String, String> entry : item.entrySet()) {
            String key = entry.getKey();
            String value = entry.getValue();
            jsonStr.append("{\"").append(key).append("\":\"").append(value).append("\"},");
        }
    }
    if (jsonStr.length() > 1) {
        jsonStr.setLength(jsonStr.length() - 1);
    }
    jsonStr.append("]");
%>

<%= jsonStr.toString() %>


<script>
    const ts = ["미국\n", "일본(100)\n","영국\n",  "유로\n", "중국\n"];

    const obj = (<%= jsonStr.toString() %>)
    console.log(obj)

    const jsonS = JSON.stringify(<%= jsonStr.toString() %>)
    console.log(jsonS)

    // console.log(obj[0])



    const target = document.getElementById("change");
    target.innerText = obj[0]["USD"]

    // console.log(jsonObj)

    const idToDelete = "KRW"; // 삭제할 객체의 id
    const newExhangeRate = obj.filter(obj => Object.keys(obj)[0] !== "KRW")

    let idx = 0
    newExhangeRate.forEach(rate => {
        for (const key in rate) {
            console.log(key); // name, age, address
            console.log(rate[key])

            console.log(key + ": " + rate[key]);
            ts[idx] = ts[idx] +key+": " +   rate[key]
            idx++;
        }
    });

    function sleep(t) {
        return new Promise(resolve => setTimeout(resolve, t));
    }

    (async function () {
        let i = 0;
        while (true) {
            nation.innerText = ts[i % ts.length].split('\n')[0].slice(0, 1);
            await sleep(200);
            target.innerText = ts[i % ts.length].split('\n')[1].slice(0, 1);
            await sleep(200);
            for (let j = 1; j < ts[i % ts.length].length; j++) {
                nation.innerText = ts[i % ts.length].split('\n')[0].slice(0, j + 1);
                await sleep(30);
                target.innerText = ts[i % ts.length].split('\n')[1].slice(0, j + 1);
                await sleep(30);
            }
            await sleep(3000);
            for (let j = ts[i % ts.length].length - 1; j >= 0; j--) {
                nation.innerText = ts[i % ts.length].split('\n')[0].slice(0, j);
                await sleep(25);
                target.innerText = ts[i % ts.length].split('\n')[1].slice(0, j);
                await sleep(25);
            }
            await sleep(400);
            i++;
        }
    })();
</script>


</body>
</html>
