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
    p {
      display: inline-block;
      vertical-align: middle;
      padding: 10px;
      font-size: 20px;
    }
    button {
      display: inline-block;
      vertical-align: middle;
    }
    #contant2 {
      margin-right: 5px;
      position: relative;
      box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.1);
      border-top: 8px solid #619b8a;
      background-color: white;
    }
  </style>
  <body>
    <div
      id="contant2"
      class="col col-lg-6 col-xs-12"
      style="position: relative; width: 100%; padding: 0px"
    >
      <div class="bt-group-chart1">
        <div style="margin-top: -15px">
          <p style="margin-top: 20px">
            급여 현황<button
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
            id="minusbutton2"
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
            id="xbutton2"
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
        id="chartHolder2"
        style="width: 100%; height: 300px; margin-bottom: 10px"
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

                      System.out.println("Data Value: " + dataValue2); // 데이터 값을 출력

                     Statement stmt = conn.createStatement();
                      //현재 년, 월
                     YearMonth currentYearMonth = YearMonth.now();
                             int year = currentYearMonth.getYear();
                             int month = currentYearMonth.getMonthValue();

                             System.out.println("Current Year: " + year);
                             System.out.println("Current Month: " + month);
                             String yearmonth = year+"0"+month;
                             System.out.println("yearmonth: " + yearmonth);
                      //현재 년,월 끝
                      ResultSet   rs = stmt.executeQuery("EXEC sp_hum_Salary_Query1 '" + yearmonth + "', '1', 'M'");
                                   if (dataValue2 != null && !dataValue2.isEmpty()) {
                                     // dataValue2 변수가 존재하는 경우에 실행할 코드
                                      System.out.println("dataValue2 변수가 존재하는 경우에 실행 " ); // 데이터 값을 출력
                                     rs = stmt.executeQuery("EXEC sp_hum_Salary_Query1 '" + dataValue2 + "', '1', 'M'");
                                   } else {
                                    System.out.println("dataValue2 변수가 존재하지않는 경우에 실행 " ); // 데이터 값을 출력
                                     rs = stmt.executeQuery("EXEC sp_hum_Salary_Query1 '" + yearmonth + "', '1', 'M'");
                                   }
                     JSONArray jsonArray = new JSONArray();

                     while (rs.next()) {
                       JSONObject jsonObject = new JSONObject();
                       jsonObject.put("Month", rs.getString(3));
                      jsonObject.put("2011", rs.getInt(5));
                       jsonObject.put("2012", rs.getInt(8));

                       jsonArray.add(jsonObject);
                     }
                     jsonResult = jsonArray.toString();

                   } catch (SQLException e) {
                     e.printStackTrace();
                   }
                   %>
                 var aj = eval('<%=jsonResult%>');
                 console.log(aj)
      rMateChartH5.create("chart2", "chartHolder2", "", "100%", "100%");

      // 스트링 형식으로 레이아웃 정의.
      var layoutStr =
                  '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                     +'<Options>'
                        +'<Caption text=""/>'
                          +'<SubCaption text="(백만원)" textAlign="right" />'
                      +'<Legend position="bottom" hAlign="center" useVisibleCheck="false" labelPlacement="bottom" defaultMouseOverAction="true"/>>'
                    +'</Options>'
                   +'<Column2DChart showDataTips="true" columnWidthRatio="0.55" selectionMode="single" >'
                       +'<horizontalAxis>'
                             +'<CategoryAxis categoryField="Month"/>'
                        +'</horizontalAxis>'
                        +'<verticalAxis>'
                           +'<LinearAxis />'
                       +'</verticalAxis>'
                          +'<series>'
                             +'<Column2DSeries labelPosition="outside" yField="2011" displayName="전년실적"  fill="#a1c181" showValueLabels="[]" >'
                                  +'<showDataEffect>'
                                     +'<SeriesInterpolate/>'
                                 +'</showDataEffect>'
                            +'</Column2DSeries>'
                            +'<Column2DSeries labelPosition="outside" yField="2012" displayName="실적"  fill="#fcca46" showValueLabels="[]">'
                                  +'<showDataEffect>'
                                     +'<SeriesInterpolate/>'
                                 +'</showDataEffect>'
                            +'</Column2DSeries>'

                        +'</series>'
                    +'</Column2DChart>'
                 +'</rMateChart>';

      // 차트 데이터
      var chartData = aj;


      // rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
      //
      // argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
      // argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
      //
      // 아래 내용은
      // 1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
      // 2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
      rMateChartH5.calls("chart2", {
          "setLayout" : layoutStr,
          "setData" : chartData
      });


      rMateChartH5.registerTheme(rMateChartH5.themes);


      function rMateChartH5ChangeTheme(theme){
          document.getElementById("chart2").setTheme(theme);
      }

      // -----------------------차트 설정 끝 -----------------------

      function chartItemClickHandler(seriesId, displayText, index, data, values){
      	var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
      	window.open(chUrl, '_blank');
      }

      var count2 =0;
      document.getElementById("minusbutton2").addEventListener('click',minusbutton2);
      function minusbutton2(){
        console.log("축소버튼클릭!");
        if(count2%2==0){
          const element = document.getElementById('chartHolder2');
          element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
          const button = document.getElementById('minusbutton2');
          button.innerText = '+';
          count2++;
        } else if(count2%2==1){
                      const element = document.getElementById('chartHolder2');
                      element.style.cssText  = 'visibility:; transition: all 0.3s;  height:310px; opacity:1;';
                      const button = document.getElementById('minusbutton2');
                      button.innerText = '-';
                      count2++;
             }
      }

      document.getElementById("xbutton2").addEventListener('click',xbutton2);
      function xbutton2(){
           console.log("X버튼클릭!");
           const element = document.getElementById('contant2');
           element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
      }
      document.getElementById("detailbutton2").addEventListener('click',detailbutton2);
      function detailbutton2(){
           var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
           window.open(chUrl, '_blank');
      }
    </script>
  </body>
</html>
