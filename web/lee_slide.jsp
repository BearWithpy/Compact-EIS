<%--
  Created by IntelliJ IDEA.
  User: ihongcheol
  Date: 2023/05/11
  Time: 1:41 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
  <script>
    // -----------------------차트 설정 시작-----------------------

    // rMateChart 를 생성합니다.
    // 파라메터 (순서대로)
    //  1. 차트의 id ( 임의로 지정하십시오. )
    //  2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
    //  3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
    //  4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
    //  5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
    rMateChartH5.create("chart1", "chartHolder", "", "100%", "100%");

    var layout1 = getCartesianLayout("Column2D","칼럼 차트로 표현",["Profit"]);
    var layout2 = getCartesianLayout("Line2D","라인 차트로 표현",["Profit"]);
    var layout3 = getCartesianLayout("Column3D","칼럼 3D 멀티 데이터 표현",["Profit","Cost"]);

    // 배열 데이터로 정의
    var chartData =
            [{"Month":"Jan","Profit":1100},
              {"Month":"Feb","Profit":1400},
              {"Month":"Mar","Profit":1450},
              {"Month":"Apr","Profit":2300},
              {"Month":"May","Profit":2100},
              {"Month":"Jun","Profit":1520},
              {"Month":"Jul","Profit":1360},
              {"Month":"Aug","Profit":1420},
              {"Month":"Sep","Profit":1150},
              {"Month":"Oct","Profit":1300},
              {"Month":"Nov","Profit":1300},
              {"Month":"Dec","Profit":1650}];

    // 배열 데이터로 정의
    var chartData2 =
            [{"Month":"Jan", "Profit":5000, "Cost":1700},
              {"Month":"Feb", "Profit":8000, "Cost":1600},
              {"Month":"Mar", "Profit":6000, "Cost":1200},
              {"Month":"Apr", "Profit":6000, "Cost":1400},
              {"Month":"May", "Profit":4800, "Cost":1700},
              {"Month":"Jun", "Profit":7000, "Cost":1400},
              {"Month":"Jul", "Profit":5200, "Cost":1600}];

    // XML 구조의 스트링으로 정의
    var chartData3 =
            "<items>"
            +"<item>"
            +"<Year>2014</Year>"
            +"<Profit>320</Profit>"
            +"<Cost>250</Cost>"
            +"</item>"
            +"<item>"
            +"<Year>2015</Year>"
            +"<Profit>250</Profit>"
            +"<Cost>150</Cost>"
            +"</item>"
            +"<item>"
            +"<Year>2016</Year>"
            +"<Profit>350</Profit>"
            +"<Cost>140</Cost>"
            +"</item>"
            +"<item>"
            +"<Year>2017</Year>"
            +"<Profit>250</Profit>"
            +"<Cost>130</Cost>"
            +"</item>"
            +"<item>"
            +"<Year>2018</Year>"
            +"<Profit>400</Profit>"
            +"<Cost>230</Cost>"
            +"</item>"
            +"<item>"
            +"<Year>2019</Year>"
            +"<Profit>350</Profit>"
            +"<Cost>140</Cost>"
            +"</item>"
            +"</items>";


    // 레이아웃을 반환하는 함수입니다.
    // 파라메터 설명
    // type : 차트 type
    // title : 차트 Caption
    // dataField : 시리즈가 표현할 실데이터의 필드명 배열
    function getCartesianLayout(type, title, dataField)
    {
      var layout="<rMateChart borderStyle='none'>"
              +"<Options><Caption text='" + title +"'/></Options>"
              +"<NumberFormatter id='numfmt' useThousandsSeparator='true'/>"
              +"<" + type + "Chart showDataTips='true'>"
              +"<series>";
      var interval = type == "Column3D" ? 1000 : 500;

      for(var i=0; i<dataField.length; ++i)
      {
        layout += "<" + type +"Series yField='" + dataField[i] + "' halfWidthOffset='2' displayName='" + dataField[i] + "'/>"
      }

      layout +="</series>"
              +"<horizontalAxis>"
              +   "<CategoryAxis categoryField='Month'/>"
              +"</horizontalAxis>"
              +"<verticalAxis>"
              +"<LinearAxis interval='" + interval + "' formatter='{numfmt}' />"
              +"</verticalAxis>"
              +"</" + type + "Chart>"
              +"</rMateChart>";
      return layout;
    }

    // 레이더 차트 레이아웃.
    var radarLayout =
            "<rMateChart borderStyle='none'>"
            +"<Options>"
            +"<Caption text='레이더 차트 표현'/>"
            +"</Options>"
            +"<RadarChart type='polygon' paddingTop='20' paddingBottom='20' showDataTips='true'>"
            +"<radialAxis>"
            +"<LinearAxis id='rAxis'/>"
            +"</radialAxis>"
            +"<radialAxisRenderers>"
            +"<Axis2DRenderer axis='{rAxis}' horizontal='true' tickPlacement='outside' tickLength='4'>"
            +'<axisStroke>'
            +'<Stroke color="#555555"/>'
            +'</axisStroke>'
            +'</Axis2DRenderer>'
            +"</radialAxisRenderers>"
            +"<angularAxis>"
            +"<CategoryAxis categoryField='Year' displayName='Year'/>"
            +"</angularAxis>"
            +"<series>"
            +"<RadarSeries field='Profit' displayName='Profit' fillLineArea='false'>"
            +'<lineStroke>'
            +'<Stroke color="#5587a2" weight="3"/>'
            +'</lineStroke>'
            +'</RadarSeries>'
            +"<RadarSeries field='Cost' displayName='Cost' fillLineArea='false'>"
            +'<lineStroke>'
            +'<Stroke color="#f6a44c" weight="3"/>'
            +'</lineStroke>'
            +'</RadarSeries>'
            +"</series>"
            +"</RadarChart>"
            +"</rMateChart>";

    // 슬라이드에 넣을 데이터와 레이아웃들.
    var layoutSet = [layout1, layout2, layout3, radarLayout];
    var dataSet = [chartData, chartData2, chartData2, chartData3];

    // rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
    //
    // argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
    // argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
    //
    // 아래 내용은
    // 1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
    // 2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
    rMateChartH5.calls("chart1", {
      "setSlideLayoutSet" : layoutSet,
      "setSlideDataSet" : dataSet
    });

    // -----------------------차트 설정 끝 -----------------------
  </script>
  <jsp:include page="include/base.jsp"/>
</head>
<body>
  <div id="content">
    <div id="chartHolder"></div>
  </div>
</body>
</html>
