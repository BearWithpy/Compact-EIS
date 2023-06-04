<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes" name="viewport">
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta http-equiv="Content-Script-Type" content="text/javascript"/>
  <meta http-equiv="Content-Style-Type" content="text/css"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta charset="UTF-8">



    <style>
p {
  display: inline-block;
  vertical-align: middle;
  padding:10px;
  font-size:20px;
}
button {
  display: inline-block;
  vertical-align: middle;
}


        table {
            border-collapse: collapse;
            width: 100%;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        tr:nth-child(even) {
            background-color: #f9f9f9;
        }

        tr:hover {
            background-color: #e9e9e9;
        }
#contant6{
        margin-right: 5px;

        margin-bottom: 10px;
        position: relative;
        box-shadow: 0px 4px 4px rgba(0,0,0,0.1);
        border-top: 8px solid #233d4d;
        background-color:white;
}
    </style>
</head>
<body>




<div id="contant6" style=" position: relative; width:100%; " >
          <div class="bt-group-chart1">
                                       <div style="margin-top:-15px;">
                                            <p style="margin-top: 20px">인원현황<button type="button" id="detailbutton1" style="visibility: hidden;border: 3px solid white; border-radius: 7px 7px 7px 7px;  font-size:15px; background-color:black; color:white; ;margin-bottom: 10px;">+</button></p>
                                       </div>
                                       <hr style="margin: 12px; color:gry; margin-top:-20px;border-width:2px 0 0 0;">

                                       <div style="position:absolute; right:5px; top:0px;">
                                       <button type="button" id="minusbutton6" style="border:none; font-size:27px;background-color:white; color:grey;">-</button>
                                       <button type="button" id="xbutton6" style="border:none; font-size:20px; background-color:white; color:grey;">X</button>
                                       </div>
                                   </div>

		<div style="padding:10px;"id="body3-content2chart">
			 <jsp:include page="myeonghyeonGrid1.jsp"/>
		</div>
	</div>
<script>
function chartItemClickHandler(seriesId, displayText, index, data, values){
	var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
	window.open(chUrl, '_blank');
}

var count4 =0;
document.getElementById("minusbutton6").addEventListener('click',minusbutton6);
function minusbutton6(){
  console.log("축소버튼클릭!");
  if(count4%2==0){
    const element = document.getElementById('body3-content2chart');
    element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh;  opacity:0;';
    const button = document.getElementById('minusbutton6');
    button.innerText = '+';
    count4++;
  } else if(count4%2==1){
                const element = document.getElementById('body3-content2chart');
                element.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:200px;opacity:1; padding:10px;';
                const button = document.getElementById('minusbutton6');
                button.innerText = '-';
                count4++;
       }
}

document.getElementById("xbutton6").addEventListener('click',xbutton6);
function xbutton6(){
     console.log("X버튼클릭!");
     const element = document.getElementById('contant6');

     element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
}
document.getElementById("detailbutton6").addEventListener('click',detailbutton6);
function detailbutton6(){
     var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
     window.open(chUrl, '_blank');
}
</script>

</body>
</html>
