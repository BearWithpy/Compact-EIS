<%@ page import="org.json.simple.JSONArray" %> <%@ page
import="org.json.simple.JSONObject" %> <%@ page import="java.sql.*" %> <%@ page
import="java.time.YearMonth" %> <%@ page contentType="text/html;charset=UTF-8"
language="java" %>
<html>
  <head>
    <title>$Title$</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <%@ include file="include/base.jsp" %>
  </head>
  <style>
    <jsp:include page="/sidebar/sidebar.module.css" > </jsp:include > p {
      display: inline-block;
      vertical-align: middle;
      padding: 10px;
      font-size: 20px;
    }
    button {
      display: inline-block;
      vertical-align: middle;
    }
    @media (max-width: 800px) {
      #contant6 {
        margin-left: 20px;
      }
    }
  </style>
  <body>
    <div
      id="contant6"
      style="
        position: relative;
        width: 100%;
        height: 100%;
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.1);
        border-top: 8px solid #233d4d;
        background-color: white;
      "
    >
      <div class="bt-group-chart1">
        <div style="margin-top: -15px">
          <p style="margin-top: 20px">
            인원 현황<button
              type="button"
              id="detailbutton1"
              style="
                visibility: hidden;
                border: 3px solid white;
                border-radius: 7px 7px 7px 7px;
                font-size: 15px;
                background-color: black;
                color: white;
                margin-bottom: 10px;
              "
            >
              +
            </button>
          </p>
        </div>
        <hr
          style="
            margin: 12px;
            color: gry;
            margin-top: -20px;
            border-width: 2px 0 0 0;
          "
        />
        <div style="position: absolute; right: 5px; top: 0px">
          <button
            type="button"
            id="minusbutton6"
            style="
              border: none;
              font-size: 27px;
              background-color: white;
              color: grey;
            "
          >
            -
          </button>
          <button
            type="button"
            id="xbutton6"
            style="
              border: none;
              font-size: 20px;
              background-color: white;
              color: grey;
            "
          >
            X
          </button>
        </div>
      </div>

      <div
        id="footer-content6"
        style="width: 100%; height: 290px; margin-bottom: 10px"
      ></div>
    </div>
    <script>
           <jsp:include page="include/base.jsp"/>
                <script type="text/javascript">

               <%
                   Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
                   String jsonResult =null;
                   try {
                     Connection conn = DriverManager.getConnection(
                      "server_address",
                          "user",
                          "password"
                     );
       String dataValue2 = request.getParameter("convertedDate"); // 이동된 URL에서 데이터 값을 추출

                       if(dataValue2 == null){
                           dataValue2 = "202302";
                       }
                      System.out.println("Data Value: " + dataValue2); // 데이터 값을 출력

                     Statement stmt = conn.createStatement();
                      //현재 년, 월
                     YearMonth currentYearMonth = YearMonth.now();
                             int year = currentYearMonth.getYear();
                             int month = currentYearMonth.getMonthValue();

                             System.out.println("Current Year: " + year);
                             System.out.println("Current Month: " + month);
                             String yearmonth = year+"-0"+month+"-01";
                             System.out.println("yearmonth " + yearmonth);

                             String convertedDate_year = dataValue2.substring(0, 4); // 앞 4자리를 추출하여 저장
                             String convertedDate_month = dataValue2.substring(4);
                              System.out.println("convertedDate_year: " + convertedDate_year);
                             System.out.println("convertedDate_month: " + convertedDate_month);
                             String convertedDate_yearmonth = convertedDate_year+"-"+convertedDate_month+"-01";
                             System.out.println("convertedDate_yearmonth: " + convertedDate_yearmonth);
                      //현재 년,월 끝
                                  ResultSet rs = stmt.executeQuery("EXEC sp_hum_Organ_Query2 '" + yearmonth + "'");
                                   if (dataValue2 != null && !dataValue2.isEmpty()) {
                                     // dataValue2 변수가 존재하는 경우에 실행할 코드
                                      System.out.println("dataValue2 변수가 존재하는 경우에 실행 " ); // 데이터 값을 출력

                               rs = stmt.executeQuery("EXEC sp_hum_Organ_Query2 '" + convertedDate_yearmonth + "'");
                                   } else {
                                    System.out.println("dataValue2 변수가 존재하지않는 경우에 실행 " ); // 데이터 값을 출력

                                   rs = stmt.executeQuery("EXEC sp_hum_Organ_Query2 '" + yearmonth + "'");


                                   }
                     JSONArray jsonArray = new JSONArray();




                     while (rs.next()) {
                       JSONObject jsonObject = new JSONObject();
                       jsonObject.put("Year", rs.getString(2));
                       jsonObject.put("Data1", rs.getInt(3));
                      jsonObject.put("Data2", rs.getInt(4));
                       jsonArray.add(jsonObject);
                     }
                     jsonResult = jsonArray.toString();

                   } catch (SQLException e) {
                     e.printStackTrace();
                   }
                   %>
                 var aj = eval('<%=jsonResult%>');
                 console.log(aj)
         rMateChartH5.create("fChart6", "footer-content6", "", "100%", "100%");

         // 스트링 형식으로 레이아웃 정의.
         var layoutStr =
                      '<rMateChart backgroundColor="#FFFFFF">'
                           +'<Options>'
                               +'<Caption text=""/>'
                                 +'<Legend position="bottom" hAlign="center" useVisibleCheck="false" labelPlacement="bottom" defaultMouseOverAction="true"/>>'
                           +'</Options>'
                          +'<NumberFormatter id="numFmt"/>'
                          +'<ImageChart showDataTips="true" showLabelVertically="true" itemClickJsFunction="chartItemClickHandler">'
                                 +'<horizontalAxis>'
                                    +'<CategoryAxis id="hAxis" categoryField="Year" padding="0.7"/>'
                               +'</horizontalAxis>'
                               +'<verticalAxis>'
                                  +'<LinearAxis id="vAxis"  />'

                                +'</verticalAxis>'
                                 +'<series>'
                        /*
                       Image Multi-Sereis 를 생성시에는 ImageSeries 여러 개 정의합니다
                        이 예제는 한개의 categoryField에 여러개의 imageSeries를 적용하는 예제입니다
                        */
                                   +'<ImageSeries labelPosition="outside" yField="Data1" imageDisplayType="single" styleName="seriesStyle" displayName="전년실적" formatter="{numFmt}" fill="#233d4d" halfWidthOffset="5">'
                        /*
                       ImageChart 정의 후 ImageSeries 정의합니다
                        imageDisplayType ┬ single : 이미지 한개
                                ├ singleRepeat : 이미지 한개 반복
                               └ multiple : 다중 이미지
                          */
                                      +'<imgSource>'
                                             +'<ImageSourceItem maintainAspectRatio="true" url="../chart/rMateChartH5/Assets/Images/person_1_1.png"/>'
                      /*
                       url : 이미지 파일의 주소입니다
                      Value : 이미지가 갖을 고유의 value입니다(multiple에서만 해당합니다)
                      maintainAspectRatio - true(정비율), false(차등비율) : 이미지의 고유 비율대로 표현할지 정의합니다
                               ├ imageDisplayType의 singleRepeat에서는 false(차등비율)은 존재하지 않습니다
                               └ imageDisplayType의 multiple에서는 true(정비율)는 존재하지 않습니다
                         이 예제에서는 true(정비율)를 정의 하였습니다
                      */
                                       +'</imgSource>'
                                        +'<showDataEffect>'
                                            +'<SeriesSlide duration="1000" direction="up"/>'
                                       +'</showDataEffect>'

                                   +'</ImageSeries>'
                                  +'<ImageSeries labelPosition="outside" yField="Data2" imageDisplayType="single" styleName="seriesStyle2" displayName="현재원" formatter="{numFmt}" fill="#cae9ff" halfWidthOffset="5" >'
                                         +'<imgSource>'
                                                 +'<ImageSourceItem maintainAspectRatio="true" url="../chart/rMateChartH5/Assets/Images/person_2_1.png"/>'
                                        +'</imgSource>'
                                        +'<showDataEffect>'
                                            +'<SeriesSlide duration="1000" direction="up"/>'
                                       +'</showDataEffect>'

                                   +'</ImageSeries>'

                              +'</series>'
                                +'<verticalAxisRenderers>'
                                     +'<Axis2DRenderer axis="{vAxis}" />'
                                +'</verticalAxisRenderers>'
                            +'</ImageChart>'
                           +'<Style>'
                                 +'.seriesStyle{labelPosition:outside;}'
                              +'.seriesStyle2{labelPosition:outside;}'
                             +'</Style>'
                        +'</rMateChart>';

         // 차트 데이터
         var chartData =
          aj;

         // rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
         //
         // argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
         // argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
         //
         // 아래 내용은
         // 1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
         // 2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
         rMateChartH5.calls("fChart6", {
          "setLayout" : layoutStr,
             "setData" : chartData
         });


      function chartItemClickHandler(seriesId, displayText, index, data, values){
      	var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
      	window.open(chUrl, '_blank');
      }

      var count6 =0;
      document.getElementById("minusbutton6").addEventListener('click',minusbutton6);
      function minusbutton6(){
        console.log("축소버튼클릭!");
        if(count6%2==0){
          const element = document.getElementById('footer-content6');
          element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  width:100%; height: 0vh; opacity:0;';
          const button = document.getElementById('minusbutton6');
          button.innerText = '+';
          count6++;
        } else if(count6%2==1){
                      const element = document.getElementById('footer-content6');
                      element.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:300px;opacity:1;';
                      const button = document.getElementById('minusbutton6');
                      button.innerText = '-';
                      count6++;
             }
      }

      document.getElementById("xbutton6").addEventListener('click',xbutton6);
      function xbutton6(){
           console.log("X버튼클릭!");
           const element = document.getElementById('contant6');
           element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
      }
      document.getElementById("detailbutton").addEventListener('click',detailbutton);
      function detailbutton(){
           var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
           window.open(chUrl, '_blank');
      }
    </script>
  </body>
</html>
