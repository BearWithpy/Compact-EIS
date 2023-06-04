<%@ page import="org.json.simple.JSONArray" %> <%@ page
import="org.json.simple.JSONObject" %> <%@ page import="java.sql.*" %> <%@ page
import="java.time.YearMonth" %> <%@ page contentType="text/html;charset=UTF-8"
language="java" %>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <meta http-equiv="Content-Script-Type" content="text/javascript" />
    <meta http-equiv="Content-Style-Type" content="text/css" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <title>Title</title>
    <jsp:include page="include/base.jsp" />
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
                             //String yearmonth = year+month;
                            // System.out.println("yearmonth " + yearmonth);

                             String convertedDate_year = dataValue2.substring(0, 4); // 앞 4자리를 추출하여 저장
                             String convertedDate_month = dataValue2.substring(4);
                              System.out.println("convertedDate_year: " + convertedDate_year);
                             System.out.println("convertedDate_month: " + convertedDate_month);
                             //String convertedDate_yearmonth = convertedDate_year++convertedDate_month;
                             //System.out.println("convertedDate_yearmonth: " + convertedDate_yearmonth);
                      //현재 년,월 끝
                                        ResultSet rs = stmt.executeQuery("EXEC sp_hum_Salary_Query2 '" + dataValue2 + "', 'M', '1'");

                                   if (dataValue2 != null && !dataValue2.isEmpty()) {
                                     // dataValue2 변수가 존재하는 경우에 실행할 코드
                                      System.out.println("dataValue2 변수가 존재하는 경우에 실행22 " ); // 데이터 값을 출력

                                          rs = stmt.executeQuery("EXEC sp_hum_Salary_Query2 '" + dataValue2 + "', 'M', '1'");
                                   } else {
                                    System.out.println("dataValue2 변수가 존재하지않는 경우에 실행 " ); // 데이터 값을 출력

                      rs = stmt.executeQuery("EXEC sp_hum_Salary_Query2 '" + dataValue2 + "', 'M', '1'");
                                   }

                  JSONArray jsonArray = new JSONArray();

                  while (rs.next()) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("Month", rs.getString(2));
                    jsonObject.put("phone", rs.getInt(3));
                    jsonObject.put("tv", rs.getInt(4));

                    jsonArray.add(jsonObject);
                  }
                  //뒤집기 시작
                  JSONArray reversedArray = new JSONArray();
                  for (int i = jsonArray.size() - 1; i >= 0; i--) {
                      reversedArray.add(jsonArray.get(i));
                  }
                  jsonArray = reversedArray;
                  //뒤집기 끝
                  jsonResult = jsonArray.toString();

                } catch (SQLException e) {
                  e.printStackTrace();
                }
                %>
              var aj = eval('<%=jsonResult%>');
              console.log(aj)

          rMateChartH5.create("chart5", "barchartHolder", "", "100%", "100%");

          // 스트링 형식으로 레이아웃 정의.
          var layoutStr =
                       '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                             +'<Options>'
                                +'<Caption text=""/>'
                                 +'<SubCaption text="(백만원 )" textAlign="right" />'
                               +'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
                              +'</Options>'
                           +'<Bar2DChart showDataTips="true" selectionMode="single" barWidthRatio="0.66">'
                                 +'<horizontalAxis>'
                                 +'<BrokenAxis id="hAxis" brokenMinimum="3000" brokenMaximum="150000"  brokenRatio="0.8" formatter="{}" />'
                                +'</horizontalAxis>'
                                 +'<horizontalAxisRenderers>'
                                          /* BrokenAxis를 사용할 경우에 BrokenAxis2DRenderer를 설정 합니다. */
                                         /* 이 외의 렌더러를 설정할 경우 올바르게 표현이 되지 않습니다. */
                                            +'<BrokenAxis2DRenderer axis="{hAxis}"/>'
                                     +'</horizontalAxisRenderers>'
                                +'<verticalAxis>'
                                   +'<CategoryAxis categoryField="Month"/>'
                                +'</verticalAxis>'
                                  +'<series>'
                                 /* Bar2D Multi-Sereis 를 생성시에는 Bar2DSeries 여러 개 정의합니다 */
                                   +'<Bar2DSeries labelPosition="inside" halfWidthOffset="1" showValueLabels="[]" xField="phone" displayName="전월" fill="#233d4d" insideLabelYOffset="-2">'
                                       +'<showDataEffect>'
                                             +'<SeriesInterpolate/>'
                                         +'</showDataEffect>'
                                    +'</Bar2DSeries>'
                                   +'<Bar2DSeries labelPosition="inside" halfWidthOffset="1" showValueLabels="[]" xField="tv" displayName="당월" fill="#fe7f2d" insideLabelYOffset="-2">'
                                          +'<showDataEffect>'
                                             +'<SeriesInterpolate/>'
                                         +'</showDataEffect>'
                                    +'</Bar2DSeries>'
                               +'</series>'
                            +'</Bar2DChart>'
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
          rMateChartH5.calls("chart5", {
           "setLayout" : layoutStr,
              "setData" : chartData
          });


          /**
           * rMateChartH5 3.0이후 버전에서 제공하고 있는 테마기능을 사용하시려면 아래 내용을 설정하여 주십시오.
           * 테마 기능을 사용하지 않으시려면 아래 내용은 삭제 혹은 주석처리 하셔도 됩니다.
           *
           * -- rMateChartH5.themes에 등록되어있는 테마 목록 --
           * - simple
           * - cyber
           * - modern
           * - lovely
           * - pastel
           * -------------------------------------------------
           *
           * rMateChartH5.themes 변수는 theme.js에서 정의하고 있습니다.
           */
          rMateChartH5.registerTheme(rMateChartH5.themes);

          /**
           * 샘플 내의 테마 버튼 클릭 시 호출되는 함수입니다.
           * 접근하는 차트 객체의 테마를 변경합니다.
           * 파라메터로 넘어오는 값
           * - simple
           * - cyber
           * - modern
           * - lovely
           * - pastel
           * - default
           *
           * default : 테마를 적용하기 전 기본 형태를 출력합니다.
           */
          function rMateChartH5ChangeTheme(theme){
              document.getElementById("chart1").setTheme(theme);
          }

          // -----------------------차트 설정 끝 -----------------------
    </script>
  </head>
  <body>
    <style>
      #chartHolder5 {
        width: 100%;
        height: 60vh;
        transition: all 0.3s;
      }
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
      #contant5 {
        margin-right: 5px;
        width: calc(100% / 3);
        margin-top: 13px;
        margin-bottom: 10px;
        position: relative;
        box-shadow: 0px 4px 4px rgba(0, 0, 0, 0.1);
        border-top: 8px solid #ff7000;
        background-color: white;
      }
    </style>
    <div id="contant5" style="position: relative; width: 100%">
      <div class="bt-group-chart1">
        <div style="margin-top: -15px">
          <p style="margin-top: 20px">
            전월대비실적<button
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
            id="minusbutton5"
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
            id="xbutton5"
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
        id="barchartHolder"
        style="width: 100%; height: 290px; padding: 3px"
      ></div>
    </div>
    <script>
      function chartItemClickHandler(
        seriesId,
        displayText,
        index,
        data,
        values
      ) {
        var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
        window.open(chUrl, "_blank");
      }

      var count5 = 0;
      document
        .getElementById("minusbutton5")
        .addEventListener("click", minusbutton5);
      function minusbutton5() {
        console.log("축소버튼클릭!");
        if (count5 % 2 == 0) {
          const element = document.getElementById("barchartHolder");
          element.style.cssText =
            "visibility:hidden; transition: all 0.3s;  height: 0vh; width:100%; opacity:0;";
          const button = document.getElementById("minusbutton5");
          button.innerText = "+";
          count5++;
        } else if (count5 % 2 == 1) {
          const element = document.getElementById("barchartHolder");
          element.style.cssText =
            "visibility:; transition: all 0.3s; width:100%  height:100%; opacity:1;";
          const button = document.getElementById("minusbutton5");
          button.innerText = "-";
          count5++;
        }
      }

      document.getElementById("xbutton5").addEventListener("click", xbutton5);
      function xbutton5() {
        console.log("X버튼클릭!");
        const element = document.getElementById("contant5");

        element.style.cssText =
          "visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;";
      }
      document
        .getElementById("detailbutton5")
        .addEventListener("click", detailbutton4);
      function detailbutton5() {
        var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
        window.open(chUrl, "_blank");
      }
    </script>
  </body>
</html>
