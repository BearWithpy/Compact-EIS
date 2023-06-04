<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/10
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes" name="viewport">
<html>
<head>
  <title>$Title$</title>
    <style>
        /*footer layout end*/
        <jsp:include page="headbar/headbar.module.css"/>
        <jsp:include page="sidebar/sidebar.module.css"/>

     @media (min-width: 1200px) {
            #test3{
                 margin-left:5px;
                 margin-right:10px;
                 display:flex;
            }
            #test4{
                 margin-left:5px;
                 margin-right:10px;
            }
     }


            #test_btn1{
                 border-top-left-radius: 7px;
                 border-bottom-left-radius: 7px;
                 margin-right:-1px;
             }
             #test_btn2{
                 border-top-right-radius: 7px;
                 border-bottom-right-radius: 7px;
                 margin-left:-5px;
             }
             #btn_group button{
                 border: 2px solid black;
                 background-color: rgba(0,0,0,0);
                 color: black;
                 padding: 5px;
                 height:33.7px;
             }
             #btn_group button:hover{
                 color:white;
                 background-color: black;
             }

    </style>
    <link rel="stylesheet" href="include/index.css"/>
</head>
<body>
  <jsp:include page="headbar/headbar.jsp"/>
<div id="main">
        <aside>
            <jsp:include page="sidebar/sidebar.jsp"/>
        </aside>
       <section>

                           <div class="nav-area">
                               <jsp:include page="navibar/navibar.jsp"/>
                               <div style="display:flex;">
                                   <div id="btn_group" style="margin-right:3px;" >
                                          <button id="test_btn1">월계</button>
                                          <button id="test_btn2">누계</button>
                                   </div>
                                   <jsp:include page="myeonghyeoncalendar.jsp"/>
                               </div>
                           </div>


                        <div class="test" id="test3" style="overflow:hidden;  display:;">
                        <div class="test"  style="float:;  flex-basis: 70%;" >
                            <div style="margin-bottom:10px;" id="test3">
                            <jsp:include page="myeonghyeon2.jsp"/>
                            </div>
                            <div style="margin-bottom:10px;" id="test4">
                            <jsp:include page="myeonghyeontables2.jsp"/>
                            </div>
                        </div>
                          <div class="test"  style="float:; flex-basis: 30%;">
                           <jsp:include page="myeonghyeonbar.jsp"/>
                          </div>
                        </div>
               </section>
</div>

<script>
</script>

</body>
</html>
