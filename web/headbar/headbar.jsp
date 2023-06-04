<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/12
  Time: 1:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:100,300,400,500,700,900&display=swap" rel="stylesheet">
    <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
    <link rel="stylesheet" href="headbar.module.css">
</head>
<body>
<script>

    $(window).resize(function() {
        if ($(window).width() > 800) {
            $("aside").css("display", "block")
            $("aside").css("float", "left")
            $("aside").css("width", '15%')
            $("aside").css("height", "100%")
            $("section").css("float", "right")
            $("section").css("width", "77%")
            $("main").removeAttr("margin-left")
        }
    });
    function is_checked() {

        const checkbox = document.getElementById('expand-menu');
        var is_checked = checkbox.checked;
        if(is_checked ==true ){
            // $("aside").hide();

            // aside{
            //     display: none;
            //     float: left;
            //     width: 100%;
            //     height: 20%;
            // }

            $("aside").css("display", "none")
            $("aside").css("float", "left")
            $("aside").css("width", '0%')
            $("aside").css("height", "20%")
            $("section").removeAttr("float")
            $("section").css("width","95%")
            if ($(window).width() > 800) {
                is_checked = checkbox.checked();
            }
        } else{
            // aside{
            //     float: left;
            //     width: 15%;
            //     height: 100%;
            // }

            // $("aside").show();

            $("aside").css("display", "block")
            $("aside").css("float", "left")
            $("aside").css("width", '15%')
            $("aside").css("height", "100%")
            $("section").css("float","right")
            $("section").css("width","77%")
            $("main").removeAttr("margin-left")
        }
        console.log(is_checked);

    }


</script>

<div class="header-menu">
    <label for="expand-menu"><div></div></label><input type="checkbox" id="expand-menu" name="expand-menu" onclick='is_checked()'>

<ul>
    <li><a href="#" class="item"><div></div></a></li>
    <li><a href="#" class="item"><div></div></a></li>
    <li><a href="../logout.jsp" class="item"><div></div></a></li>
</ul>

</div>



</div>

</body>
</html>
