<%@ page import="java.sql.*" %> <%@ page import="org.json.simple.*" %> <%@ page
language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
  <head>
    <title>Combination chart</title>

    <script>
      function displayJSON(jsonResult) {
        const keys = [
          "당좌자산",
          "재고자산",
          "투자자산",
          "유형자산",
          "무형자산",
          "기타비유동자산",
        ];

        var json = JSON.parse(jsonResult);
        console.log(json);

        const newjson = json.filter((item) => keys.includes(item.AcctName));
        console.log(newjson);
      }
    </script>

    <script type="text/javascript">
      rMateChartH5.create("Achart6", "AccountChart6", "", "100%", "100%");

      //스트링 형식으로 레이아웃 정의.
      var layoutStr6 =
        '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">' +
        "<Options>" +
        '<Caption text="" />' +
        '<SubCaption text="( mm )" textAlign="right" />' +
        "</Options>" +
        '<Column3DChart showDataTips="true" cubeAngleRatio="1" columnWidthRatio="0.5">' +
        /*
          Cylinder3D 차트 생성시에 필요한 Column3DChart 정의합니다
           showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
            */
        "<horizontalAxis>" +
        '<CategoryAxis categoryField="Month"/>' +
        "</horizontalAxis>" +
        "<verticalAxis>" +
        '<LinearAxis minimum="0" maximum="100" interval="5"/>' +
        "</verticalAxis>" +
        "<series>" +
        '<Column3DSeries labelPosition="outside" yField="Rainfall" displayName="Rainfall" itemRenderer="CylinderItemRenderer" showValueLabels="[5]">' +
        /*
          Column3DChart 정의 후 Column3DSeries 정의합니다
         Cylinder3DChart는 Column3DSeries의 itemRenderer에 CylinderItemRenderer를 정의하여 생성합니다
         */
        "<showDataEffect>" +
        /*  차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
        "<SeriesInterpolate/>" +
        /*
           SeriesInterpolate는 시리즈 데이터가 새로운 시리즈 데이터로 표시될 때 이동하는 효과를 적용합니다
            - 공통속성 -
             elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
           minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                        이 값보다 짧은 시간에 effect가 실행되지 않습니다
          offset : effect개시의 지연시간을 설정합니다 default:0
             perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
            */
        "</showDataEffect>" +
        "<fill>" +
        '<SolidColor color="#6E6ED7"/>' +
        "</fill>" +
        "</Column3DSeries>" +
        "</series>" +
        "</Column3DChart>" +
        "</rMateChart>";

      //차트 데이터
      var chartData6 = [
        { Month: "당좌자산", Rainfall: 25 },
        { Month: "재고자산", Rainfall: 35 },
        { Month: "투자자산", Rainfall: 54 },
        { Month: "유형자산", Rainfall: 42 },
        { Month: "무형자산", Rainfall: 67 },
        { Month: "기타자산", Rainfall: 87 },
      ];

      //rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
      //
      //argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
      //argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
      //
      //아래 내용은
      //1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
      //2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
      rMateChartH5.calls("Achart6", {
        setLayout: layoutStr6,
        setData: chartData6,
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
      function rMateChartH5ChangeTheme(theme) {
        document.getElementById("Achart6").setTheme(theme);
      }

      //-----------------------차트 설정 끝 -----------------------

      //-----------------------차트 설정 끝 -----------------------
    </script>
  </head>
  <body>
    <% Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver"); try {
    Connection conn = DriverManager.getConnection( "server_address", "user",
    "password" ); Statement stmt = conn.createStatement(); ResultSet rs =
    stmt.executeQuery("EXEC SP_FIN_BalSheet_Query1 '202212', 'Y'"); JSONArray
    jsonArray = new JSONArray(); while (rs.next()) { JSONObject jsonObject = new
    JSONObject(); jsonObject.put("AcctName", rs.getString(3));
    jsonObject.put("자산", rs.getString(4)); jsonObject.put("자산2",
    rs.getString(5)); jsonObject.put("차이", rs.getString(6));
    jsonArray.add(jsonObject); } String jsonResult = jsonArray.toString(); //
    out.println(jsonResult); System.out.println(jsonResult); out.println("
    <script>
      ");
              out.println("displayJSON('" + jsonResult + "');");
              out.println("
    </script>
    "); } catch (SQLException e) { e.printStackTrace(); } %>
    <h1>newjson</h1>
  </body>
</html>
