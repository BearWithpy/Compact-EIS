<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/15
  Time: 10:49 AM
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <title>Title</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Wix+Madefor+Display:wght@800&display=swap" rel="stylesheet">
    <link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css'>
    <link rel="stylesheet" href="exchange_rate_box.css">

    <style>
        .exchange-rate-box{
            display: inline-flex;
            height: 140px;
        }

        #nation {
            width : 50%;
            height: 20%;
            text-align: left;
            padding-top: 20px;
            margin-top: 0px;
            font-size: 30px;
            margin-left: 10px;
            font-family: 'Wix Madefor Display', sans-serif;
        }

        #change {
            text-align: right;
            width: 90%;
            height: 70%;
            /* text-align: left; */
            margin-top: 15px;
            font-size: 35px;
            font-family: 'Wix Madefor Display', sans-serif;
        }
        .bi-currency-exchange{
            margin-left: 15px;
            margin-top: -20px;
            box-shadow: 10px 5px 5px #e9eef3;
            padding-bottom: 20px;
            height: 80px;
        }
        @media (max-width:800px){
            .bi-currency-exchange{
                margin-left: 15px;
                margin-top: -20px;
                box-shadow: 0px 4px 4px rgba(0,0,0,0.1);
                padding-bottom: 20px;
                height: 80px;
            }
        }
    </style>
    <script>

    </script>
</head>
<body>

<div class="exchange-rate-box" id="head-content3">
    <i class='bi bi-currency-exchange sample2'></i>
    <div  style="width: 100%;">
        <div>
            <h5 id="nation"></h5><br/>
        </div>
        <div>
            <h1 id="change"></h1>
        </div>
        </div>
    </div>

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

<script>
    const ts = ["미국\n", "일본(100)\n","영국\n",  "유로\n", "중국\n"];

    const obj = (<%= jsonStr.toString() %>)
    const jsonS = JSON.stringify(<%= jsonStr.toString() %>)

    const target = document.getElementById("change");
    target.innerText = obj[0]["USD"]

    const idToDelete = "KRW"; // 삭제할 객체의 id
    const newExhangeRate = obj.filter(obj => Object.keys(obj)[0] !== "KRW")

    console.log(newExhangeRate)

    let idx = 0
    newExhangeRate.forEach(rate => {
        for (const key in rate) {
            ts[idx] = ts[idx] +key+": " + Number(rate[key]).toLocaleString(undefined, { minimumFractionDigits: 2, maximumFractionDigits: 2 });
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
