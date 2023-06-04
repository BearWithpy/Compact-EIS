<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=yes" name="viewport">
<html>
<head>


  <title>Human Resource</title>
    <style>
        /*footer layout end*/
        <jsp:include page="sidebar/sidebar.module.css"/>
             <jsp:include page="headbar/headbar.module.css"/>
     @media (min-width: 1200px) {
      	#test5 {
      		display:flex;
      	}
       #test1{
            margin-left:10px;
       }
       #test2{
            margin-left:10px;
             margin-right:10px;
       }
       #table3{
       margin-right:10px;
       margin-left:10px;
       }
       #test3{
              margin-left:10px;
              margin-right:10px;
              display:flex;
       }
       #test4{
              margin-left:10px;
              margin-right:10px;
              margin-top:-30px;
       }
       #test6{
             margin-right:10px;
             margin-left:10px;
       }
      }
       @media (max-width: 1200px) {
        #test1{
                   margin-bottom:10px;
                   width:100%;
              }
        .test {
              		float:;
              		display:;
              	}
               #test2{
                    width:100%;
               }
               #test3{
                    margin-top:-10px;
               }

               #gongbox{
                    display:;
                    margin-top:-20px;
               }

       }

    </style>
    <link rel="stylesheet" href="include/index.css"/>
</head>
<body>
 <jsp:include page="headbar/headbar.jsp"/>
<style>
#side-human{
    background-color:#e9eef3;
    border-left: 5px solid #023e8a;
}
#side-human>a{
    color:black;
}
</style>
 <script>

 </script>
<div id="main">
        <aside>
            <jsp:include page="sidebar/sidebar.jsp"/>
        </aside>

       <section>
                        <div class="nav-area">
                                   <jsp:include page="navibar/navibar.jsp"/>
                                   <jsp:include page="calendar.jsp"/>
                        </div>


                   <div class="test" id="test5" style="overflow:hidden; margin-bottom:10px;display: ">
                         <div class="test" id="test1" style="float:; flex-basis: 40%">
                               <jsp:include page="myeonghyeonbar2.jsp"/>
                         </div>

                        <div class="test" id="test2" style="float:; flex-basis: 60%">
                            <jsp:include page="myeonghyeon.jsp"/>
                            <p style="margin-bottom:-10px;" id="pbox2"></p>
                            <jsp:include page="myeonghyeontables.jsp"/>
                        </div>
                    </div>


                   <div class="test" style="overflow:hidden;  display:;">
                                           <div class="test"  style="float:;  flex-basis: 70%;" >
                                               <div style="margin-bottom:10px; " id="test3">
                                               <jsp:include page="myeonghyeon2.jsp"/>
                                               </div>
                                               <p id="gongbox" style="display:hidden;"></p>
                                               <div style="margin-bottom:10px;" id="test4">
                                               <jsp:include page="myeonghyeontables2.jsp"/>
                                               </div>
                                           </div>
                                             <div class="test"  id="test6" style="float:; flex-basis: 30%;">
                                              <jsp:include page="myeonghyeonbar.jsp"/>
                                             </div>
                   </div>
               </section>
</div>

<script>

/*var currentDate = new Date();
var year = currentDate.getFullYear();
var month = currentDate.getMonth() + 1;

console.log("날짜:"+year + '0' + month);
     var inputElement = document.getElementById('fecha1'); // ID를 사용하여 input 요소 가져오기
     if (month.toString().length === 1) {
       // month의 길이가 1인 경우에 대한 조건문 처리
       console.log("한자리 월 선택");
        inputElement.value = '0' + month+'/'+ year ;
     } else {
       // month의 길이가 1이 아닌 경우에 대한 처리
       console.log("두자리 월 선택");
        inputElement.value = month+'/'+ year;
     }
var queryString = window.location.search;

// 쿼리 문자열을 파싱하여 객체로 변환합니다.
var params = new URLSearchParams(queryString);

// "data" 매개변수의 값을 가져옵니다.
var dataValue = params.get('data');
console.log("data는 :"+dataValue);
var data_year = dataValue.substring(0, 4); // 년도 저장
var data_month = dataValue.substring(4);   // 월 저장

if (typeof dataValue !== 'undefined' && dataValue !== null) {
console.log("dataValue의 값이 존재합니다.");
  var inputElement = document.getElementById('fecha1'); // ID를 사용하여 input 요소 가져오기
  inputElement.value = data_month+'/'+ data_year; // value 값을 1로 지정하기
}


// 가져온 데이터 값을 출력하거나 원하는 대로 사용합니다.
console.log("dataValue:"+dataValue);
*/

</script>

</body>
</html>
