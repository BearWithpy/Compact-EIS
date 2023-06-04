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
                             String yearmonth = year+"0"+month;
                             System.out.println("yearmonth: " + yearmonth);
                      //현재 년,월 끝
                      ResultSet        rs = stmt.executeQuery("EXEC sp_hum_PerSon_Query1 '" + yearmonth + "', '1'");
                                   if (dataValue2 != null && !dataValue2.isEmpty()) {
                                     // dataValue2 변수가 존재하는 경우에 실행할 코드
                                      System.out.println("dataValue2 변수가 존재하는 경우에 실행 " ); // 데이터 값을 출력
                                     rs = stmt.executeQuery("EXEC sp_hum_PerSon_Query1 '" + dataValue2 + "', '1'");
                                   } else {
                                    System.out.println("dataValue2 변수가 존재하지않는 경우에 실행 " ); // 데이터 값을 출력
                                    rs = stmt.executeQuery("EXEC sp_hum_PerSon_Query1 '" + yearmonth + "', '1'");

                                   }



                     JSONArray jsonArray = new JSONArray();

                     while (rs.next()) {
                       JSONObject jsonObject = new JSONObject();
                       jsonObject.put("Month", rs.getString(2));

                       jsonObject.put("Rainfall", rs.getInt(4));

                       jsonArray.add(jsonObject);
                     }
                     jsonResult = jsonArray.toString();

                   } catch (SQLException e) {
                     e.printStackTrace();
                   }
                   %>
                 var aj = eval('<%=jsonResult%>');
                 console.log(aj)
      rMateChartH5.create("Achart6", "chartHolder", "", "100%", "100%");

      //스트링 형식으로 레이아웃 정의.
      var layoutStr6 =
                   '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
                      +'<Options>'
                         +'<Caption text="" />'
                          +'<SubCaption text="(  )" textAlign="right" />'
                    +'</Options>'
                    +'<Column3DChart showDataTips="true" cubeAngleRatio="1" columnWidthRatio="0.5">'
                      /*
                    Cylinder3D 차트 생성시에 필요한 Column3DChart 정의합니다
                     showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
                      */
                           +'<horizontalAxis>'
                              +'<CategoryAxis categoryField="Month"/>'
                         +'</horizontalAxis>'
                         +'<verticalAxis>'
                            +'<LinearAxis minimum="0" maximum="35" interval="5"/>'
                          +'</verticalAxis>'
                           +'<series>'
                              +'<Column3DSeries labelPosition="outside" yField="Rainfall" displayName="Rainfall" itemRenderer="CylinderItemRenderer" showValueLabels="[5]">'
                               /*
                             Column3DChart 정의 후 Column3DSeries 정의합니다
                            Cylinder3DChart는 Column3DSeries의 itemRenderer에 CylinderItemRenderer를 정의하여 생성합니다
                            */
                                 +'<showDataEffect>'
                                  /*  차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
                                      +'<SeriesInterpolate/>'
                                      /*
                                     SeriesInterpolate는 시리즈 데이터가 새로운 시리즈 데이터로 표시될 때 이동하는 효과를 적용합니다
                                      - 공통속성 -
                                       elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
                                     minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                                                  이 값보다 짧은 시간에 effect가 실행되지 않습니다
                                    offset : effect개시의 지연시간을 설정합니다 default:0
                                       perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
                                      */
                                 +'</showDataEffect>'
                                 +'<fill>'
      							+'<SolidColor color="#6E6ED7"/>'
      						+'</fill>'
                             +'</Column3DSeries>'
                         +'</series>'
                     +'</Column3DChart>'
                  +'</rMateChart>';

      //차트 데이터
      var chartData6 = aj;



      rMateChartH5.calls("Achart6", {
      "setLayout" : layoutStr6,
       "setData" : chartData6
      });

      function rMateChartH5ChangeTheme(theme){
       document.getElementById("Achart6").setTheme(theme);
      }

      //-----------------------차트 설정 끝 -----------------------
    </script>
  </head>
  <style>
    #chartHolder {
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
  </style>
  <body>
    <div
      id="contant4"
      style=" position: relative; width:100%; border: 2px solid black; border-radius: 10px 10px; 10px 10px; background-color:white; margin-right:10px;"
    >
      <div class="bt-group-chart1">
        <div style="margin-top: -15px">
          <p style="margin-top: 20px">
            인원 현황(부서별)<button
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
            type=""
            id="minusbutton4"
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
            type=""
            id="xbutton4"
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
        id="chartHolder"
        style="width: 100%; height: 300px; padding: 3px"
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

      var count3 = 0;
      document
        .getElementById("minusbutton4")
        .addEventListener("click", minusbutton4);
      function minusbutton4() {
        console.log("축소버튼클릭!");
        if (count3 % 2 == 0) {
          const element = document.getElementById("chartHolder");
          element.style.cssText =
            "visibility:hidden; transition: all 0.3s;  height: 0vh; width:100%; opacity:0;";
          const button = document.getElementById("minusbutton4");
          button.innerText = "+";
          count3++;
        } else if (count3 % 2 == 1) {
          const element = document.getElementById("chartHolder");
          element.style.cssText =
            "visibility:; transition: all 0.3s; width:100%;  height:300px; opacity:1;";
          const button = document.getElementById("minusbutton4");
          button.innerText = "-";
          count3++;
        }
      }

      document.getElementById("xbutton4").addEventListener("click", xbutton4);
      function xbutton4() {
        console.log("X버튼클릭!");
        const element = document.getElementById("contant4");

        element.style.cssText =
          "visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;";
      }
      document
        .getElementById("detailbutton4")
        .addEventListener("click", detailbutton4);
      function detailbutton4() {
        var chUrl = "http://www.localhost:8080/myeonghyeon2.jsp?";
        window.open(chUrl, "_blank");
      }
    </script>
  </body>
</html>
