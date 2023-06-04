<%--
  Created by IntelliJ IDEA.
  User: ihongcheol
  Date: 2023/05/11
  Time: 10:14 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  <meta http-equiv="Content-Script-Type" content="text/javascript"/>
  <meta http-equiv="Content-Style-Type" content="text/css"/>
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>Title</title>
  <jsp:include page="include/base.jsp"/>
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

    // 스트링 형식으로 레이아웃 정의.
    var layoutStr =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text="Annual Report"/>'
            +'<Legend useVisibleCheck="true"/>'
            +'</Options>'
            +'<Pie2DChart innerRadius="0.5" showDataTips="true" selectionMode="single">'
            /*
            Doughnut2D 차트 생성시에 필요한 Pie2DChart 정의합니다
           showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
              innerRadius : PieChart 가운데에 빈 공간을 만듭니다. 유효값 0.1 ~ 0.9 0은 PieChart 1은 차트 사라짐
           */
            +'<series>'
            +'<Pie2DSeries nameField="Month" field="Profit" startAngle="20" renderDirection="clockwise" labelPosition="inside" color="#ffffff">'
            +'<fills>'
            +'<SolidColor color="#20cbc2"/>'
            +'<SolidColor color="#074d81"/>'
            +'<SolidColor color="#40b2e6"/>'
            +'</fills>'
            /* Pie2DChart 정의 후 Pie2DSeries labelPosition="inside"정의합니다 */
            +'<showDataEffect>'
            /* 차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
            +'<SeriesZoom duration="1000"/>'
            /*
            SeriesZoom 효과는 시리즈 데이터가 데이터로 표시될 때 특정 지점에서 점점 확대되어지며 나타나는 효과를 적용합니다
           - 공통속성 -
              elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
            minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
                         이 값보다 짧은 시간에 effect가 실행되지 않습니다
           offset : effect개시의 지연시간을 설정합니다 default:0
              perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
             - SeriesZoom속성 -
              relativeTo : 이펙트의 기준을 어디로 잡을지에 대한 속성입니다. 유효값 : chart, series
              horizontalFocus : relativeTo를 기준으로 수평선 방향의 기준을 정합니다. 유효값 : left, center, right
            verticalFocus : relativeTo를 기준으로 수직선 방향의 기준을 정합니다. 유효값 : top, middle, bottom
              */
            +'</showDataEffect>'
            +'</Pie2DSeries>'
            +'</series>'
            +'<backgroundElements>'
            +'<CanvasElement>'
            +'<CanvasLabel text="2019" height="24" horizontalCenter="0" verticalCenter="-10" fontSize="19" color="#333333" backgroundAlpha="0"/>'
            +'<CanvasLabel text="Annual Report" height="24" horizontalCenter="0" verticalCenter="10" fontSize="14" color="#666666" backgroundAlpha="0"/>'
            +'</CanvasElement>'
            +'</backgroundElements>'
            +'</Pie2DChart>'
            +'</rMateChart>';

    // 차트 데이터
    var chartData = [{"Month":"Jan", "Profit":900},
      {"Month":"Feb", "Profit":2400},
      {"Month":"Mar", "Profit":1900}];

    // rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
    //
    // argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
    // argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
    //
    // 아래 내용은
    // 1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
    // 2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
    rMateChartH5.calls("chart1", {
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
  <div id="content">
    <div id="chartHolder"></div>
  </div>
</body>
</html>
