<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
  <title>Combination chart</title>

  <script type="text/javascript">
    <%
                 Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

                 String json2Result=null;
                 try {
                     Connection conn2 = DriverManager.getConnection(
                      "server_address",
                    "user",
                    "password"
                     );

                     Statement stmt2 = conn2.createStatement();
                 String convertedDate = request.getParameter("convertedDate");
                  if(convertedDate == null){
            convertedDate = "202302";
        }
                     ResultSet rs2 = stmt2.executeQuery(String.format("EXEC SP_SAL_Sale_Month_Query1 '%s', '%%', '%%', '1'",convertedDate));

                     JSONArray jsonArray = new JSONArray();

                     rs2.next();
                     int i=0;
                     while (i<5) {
                         rs2.next();
                         JSONObject jsonObject = new JSONObject();
                     jsonObject.put("금년 당월 실적", rs2.getString("ResultAmt"));
                     jsonObject.put("전년도 실적", rs2.getString("LastYearAmt"));
                     jsonObject.put("company", rs2.getString(2));
                     i++;
                         jsonArray.add(jsonObject);
                     }


                     json2Result = jsonArray.toString();

         //        out.println(jsonResult);
         //        System.out.println(jsonResult);
         //        out.println("<script>");
         //        out.println("displayJSON('" + jsonResult + "');");
         //        out.println("</script>");
                 } catch (SQLException e) {
                     e.printStackTrace();
                 }
                 %>
    <%--const raw = (eval('<%=jsonResult%>'))--%>

    <%--const raw = JSON.parse(`<%=jsonResult%>`);--%>   <%--const array = Array.from(raw);--%>   <%--console.log(raw)--%>   <%--console.log(typeof array)--%>
    <%--console.log(<%=jsonResult%>)--%>
    const saleData = <%=json2Result%>;

    console.log(saleData)
    saleData2= saleData.splice(1,6);
    rMateChartH5.create("chart6", "body-content2-chart", "", "95%", "95%");

    //스트링 형식으로 레이아웃 정의.
    var layoutStr6 =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text=""/>'
            +'<SubCaption text="" textAlign="center" />'
            +'<Legend defaultMouseOverAction="false" />'
            +'</Options>'
            +'<NumberFormatter id="numfmt" useThousandsSeparator="true"/>'
            +'<Column2DChart showDataTips="true" columnWidthRatio="0.33" selectionMode="single">'
            +'<horizontalAxis>'
            +'<CategoryAxis categoryField="company"/>'
            +'</horizontalAxis>'
            +'<verticalAxis>'
            // +'<LinearAxis/>'
            +'<BrokenAxis id="vAxis" brokenMinimum="150000" brokenMaximum="300000" brokenRatio="0.8" interval="10000" formatter="{numfmt}" />'
            +'</verticalAxis>'
            +'<verticalAxisRenderers>'
            +'<BrokenAxis2DRenderer axis="{vAxis}"/>'
            /* BrokenAxis를 사용할 경우에는 BrokenAxis2DRenderer를 설정해야 합니다. */
            /* 이 외의 렌더러를 설정할 경우 올바르게 표현이 되지 않습니다. */
            +'</verticalAxisRenderers>'
            +'<series>'
            +'<Column2DSeries color = "#888888" labelPosition="outside" yField="전년도 실적" displayName="전년도 실적" showValueLabels="[]">'
            +'<showDataEffect>'
            +'<SeriesInterpolate/>'
            +'</showDataEffect>'
            +'<fill>'
            // +'<SolidColor color="#233d4d"/>'
            +'<SolidColor color="#a1c181"/>'
            +'</fill>'
            +'</Column2DSeries>'
            +'<Column2DSeries labelPosition="outside" yField="금년 당월 실적" displayName="금년 당월 실적" showValueLabels="[]">'
            +'<showDataEffect>'
            +'<SeriesInterpolate/>'
            +'</showDataEffect>'

            +'<fill>'
            // +'<SolidColor color="#cae9ff"/>'
            +'<SolidColor color="#fcca46"/>'
            +'</fill>'



            +'</Column2DSeries>'
            +'</series>'
            +'</Column2DChart>'
            +'</rMateChart>';

    //차트 데이터
    var chartData6 = saleData2;

    //rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
    //
    //argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
    //argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
    //
    //아래 내용은
    //1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
    //2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
    rMateChartH5.calls("chart6", {
      "setLayout" : layoutStr6,
      "setData" : chartData6
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
      document.getElementById("chart6").setTheme(theme);
    }

    // -----------------------차트 설정 끝 -----------------------
  </script>
</head>
<body>
<div id="body-content2" style=" position: relative; ">
  <div class="bt-group-chart1" >
    <div style="margin-top:-15px;">
      <p style="margin-top: 20px">매출 현황</p>
    </div>
    <hr style="margin: 12px; color:grey; margin-top:-20px;border-width:2px 0 0 0;">
    <div style="position:absolute; right:5px; top:0px;">
      <button type="button" id="minusbutton2" style="border:none; font-size:27px;background-color:white; color:grey;">-</button>
      <button type="button" id="xbutton2" style="border:none; font-size:20px; background-color:white; color:grey;">X</button>
    </div>
  </div>
  <div id="body-content2-chart" style="width:100%;height:300px; margin-bottom:10px;"></div>
</div>
</body>
<script>
  function chartItemClickHandler(seriesId, displayText, index, data, values){
    var chUrl = "http://www.localhost:8080/index_body_chart2.jsp?";
    window.open(chUrl, '_blank');
  }

  var count4 =0;
  document.getElementById("minusbutton2").addEventListener('click',minusbutton6);
  function minusbutton6(){
    console.log("축소버튼클릭!");
    if(count4%2==0){
      const element = document.getElementById('body-content2-chart');
      element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh;  opacity:0;';
      const button = document.getElementById('minusbutton2');
      button.innerText = '+';
      count4++;
    } else if(count4%2==1){
      const element = document.getElementById('body-content2-chart');
      element.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:310px;opacity:1;';
      const button = document.getElementById('minusbutton2');
      button.innerText = '-';
      count4++;
    }
  }

  document.getElementById("xbutton2").addEventListener('click',xbutton6);
  function xbutton6(){
    console.log("X버튼클릭!");
    const element = document.getElementById('body-content2');

    element.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
  }
</script>
</html>

</html>
