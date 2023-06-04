<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
  <head>
    <title>Combination chart</title>

    <script type="text/javascript">
          <%
                  Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

                  int ratio1 = 0;
                  try {
                      Connection conn = DriverManager.getConnection(
                        "server_address",
                          "user",
                          "password"
                      );

                      Statement stmt = conn.createStatement();
                  String convertedDate = request.getParameter("convertedDate");
                  ResultSet rs = stmt.executeQuery(String.format("SELECT ROUND((Sum(SaleOrderAmt) /SUM(YearPlanAmt))  * 100,0 )\n" +
                      "  FROM T_SAL_SaleOrder_Month tssm\n" +
                      " WHERE YyyyMm =%s",convertedDate));

              while (rs.next()){
                  ratio1=rs.getInt(1);
              }
                  } catch (SQLException e) {
                      e.printStackTrace();
                  }
                  %>
      rMateChartH5.create("chart1", "body-content1chart", "", "100%", "100%");

      //스트링 형식으로 레이아웃 정의.
      var layoutStr1 =
      '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
           +'<Options>'
             +'<Caption text="" paddingBottom="30"/>'
         +'</Options>'
        /**
         * showDataTip : 툴팁 출력 설정
           * minimum : 게이지 최소 값
           * maximum : 게이지 최대 값
           * startAngle : 시작 각도
           * minimumAngle : 게이지 최소 각도
         * maximumAngle : 게이지 최대 각도
         * gaugeWidth : 게이지 가로 크기
           * gaugeHeight : 게이지 세로 크기
          * innerRatio : 안쪽 영역 비율 값, 유효 값 0 ~ 1
          * outerRatio : 바깥쪽 영역 비율 값, 유효 값 0 ~ 1
         * circleOffset : 값이 여러개일 경우 원 형태 간의 여백을 설정합니다.
         * horizontalOriginRatio : 게이지 출력 수평위치를 설정합니다.
          * verticalOriginRatio : 게이지 출력 수직위치를 설정합니다.
            * valueChangeFunction : 데이터가 변경 될 경우 호출될 사용자 정의 함수를 설정합니다
          * fillJsFunction : 데이터의 값에 따른 색상 값을 설정하는 사용자 정의 함수를 설정합니다.
         * duration : 이펙트 출력시간을 설정합니다. default 800
          * bounceAnimating : 튕김 이펙트를 설정합니다. deafult true
            * showValueLabel : 수치 라벨을 출력할지 설정합니다. default true
         * valueField : 여러 데이터를 출력 할 경우 차트 데이터의 필드 명을 설정합니다.
            * nameField : 여러 데이터 출력 시 해당 데이터에 대한 이름을 출력할 필드 명을 설정합니다.
          * backgroundColors : 게이지가 출력되는 영역의 배경 색상을 설정합니다. default [#e2eaf3]
         * backgroundStrokes : 게이지가 출력되는 영역의 배경 테두리 색상을 설정합니다.
         * foregroundColors : 게이지가 출력되는 영역의 색상을 설정합니다. default [#51c0ee]
            * foregroundStrokes : 게이지가 출력되는 영역의 테두리 색상을 설정합니다.
         */
         +'<Gauge minimum="0" maximum="200" minimumAngle="0" maximumAngle="360" innerRatio="0.85" fontSize="25" startAngle="-180" labelJsFunction="valueFunc" dataTipJsFunction="dataTipFunc" valueChangeFunction="changeFunction" labelYOffset="0" foregroundColors="[#233d4d]" backgroundColors="[#f5f5dc]" color="#233d4d" labelClickJsFunction="labelClickFunc">'
         +'<backgroundElements>'
              +'<CanvasElement>'
                   +'<CanvasLabel fontWeight="bold" height="23" fontSize="13" horizontalCenter="0" verticalCenter="20" text="" color="#888888"/>'
               +'</CanvasElement>'
          +'</backgroundElements>'
      +'</Gauge>'
      +'</rMateChart>';

      //게이지 데이터
      var chartData1 = [<%=ratio1%>];

      //rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
      //
      //argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
      //argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
      //
      //아래 내용은
      //1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
      //2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
      rMateChartH5.calls("chart1", {
      "setLayout" : layoutStr1,
       "setData" : chartData1
      });

      //라벨 클릭 함수
      function labelClickFunc(value){
      alert(value);
      }

      //수치 라벨 사용자 정의 함수
      function valueFunc(value){
      return value.toFixed(0) + "%";
      }

      //데이터 팁 사용자 정의 함수
      function dataTipFunc(value){
      return value + "%";
      }

      //게이지 값 랜덤 변경 함수
      function changeValue()
      {
      // 게이지의 값을 변경할려면 setData 함수를 사용하세요.
      document.getElementById("chart1").setData([parseInt(Math.random()*100)]);
      }

      //게이지 값 보관.
      var gaugeValue;

      //게이지 value change 이벤트 핸들러 함수.
      function changeFunction(value)
      {
      gaugeValue = value;
      }

      //확인
      function commitValue()
      {
       alert(gaugeValue);
      }

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
  <body></body>
</html>
