<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/10
  Time: 4:59 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>$Title$</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        $.ajax({
            url: "http://127.0.0.1:5000",
            type: "GET",
            success: function(response) {
                for (const prop in response) {
                    console.log(prop + ": " + response[prop]);
                    // const item = $("<li>").text(prop + ": " + response[prop]);
                    // $("ul").append(item);
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                console.log(textStatus, errorThrown);
            }
        });
    </script>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="sidebar.module.css">
<%--    <%@ include file="../index.jsp" %>--%>
</head>

<body>
<div class="menu">
    <ul>
        <li id="side-main"><a href="../index.jsp" class="item"><div class="link-content">Dashboard</div></a></li>
        <li id="side-acount"><a href="../Account.jsp" class="item"><div class="link-content">Accounts</div></a></li>
        <li id="side-human"><a href="../Human.jsp"class="item"><div class="link-content">HR</div></a></li>
        <li id="side-sales"><a href="../Sales.jsp" class="item"><div class="link-content">Sales</div></a></li>
<%--        <li><a href="#" class="item"><div>설정</div></a></li>--%>
    </ul>
</div>

<script>

    function handleDivClick(event) {
        event.preventDefault();

        const targetURL = event.target.closest("a").href;
        const convertedDate = localStorage.getItem("convertedDate");

        if (convertedDate) {
            const separator = targetURL.includes("?") ? "&" : "?";
            const updatedURL = targetURL.split("?")[0] + separator + "convertedDate=" + convertedDate;
            window.location.href = updatedURL;
        } else {
            window.location.href = targetURL;
        }
    }


    function handleLinkClick(event) {
        event.preventDefault();

        const targetURL = event.target.href;
        const convertedDate = localStorage.getItem("convertedDate");

        if (convertedDate) {
            const separator = targetURL.includes("?") ? "&" : "?";
            const updatedURL = targetURL.split("?")[0] + separator + "convertedDate=" + convertedDate;
            window.location.href = updatedURL;
        } else {
            window.location.href = targetURL;
        }
    }

    const links = document.querySelectorAll(".menu .item");
    links.forEach(function (link) {
        link.addEventListener("click", handleLinkClick);
    });

    const linkContents = document.querySelectorAll(".menu .item .link-content");
    linkContents.forEach(function (linkContent) {
        linkContent.addEventListener("click", handleDivClick);
    });
</script>
</body>
</html>
