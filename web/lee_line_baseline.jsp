<%--
  Created by IntelliJ IDEA.
  User: ihongcheol
  Date: 2023/05/11
  Time: 11:45 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
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

    // 기준 값
    var baseValue = 50;

    // 스트링 형식으로 레이아웃 정의.
    var layoutStr =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text="2013 Monthly Price of Soybean ($ Per Metric Ton)"/>'
            +'</Options>'
            +'<CurrencyFormatter id="cft" currencySymbol="$" alignSymbol="left"/>'
            +'<Line2DChart showDataTips="true" gutterTop="6">'
            +'<horizontalAxis>'
            +'<CategoryAxis categoryField="Month" padding="0.85"/>'
            +'</horizontalAxis>'
            +'<verticalAxis>'
            +'<LinearAxis id="vAxis" formatter="{cft}" interval="50" minimum="400" maximum="650"/>'
            +'</verticalAxis>'
            +'<series>'
            +'<Line2DSeries yField="Price" baseValue="524" showMaxValueLabel="true" showMinValueLabel="true" upLabelJsFunction="upFunc" downLabelJsFunction="downFunc" fontSize="12">'
            +'<lineStroke>'
            +'<Stroke color="#02a8f2" weight="3"/>'
            +'</lineStroke>'
            +'<lineDeclineStroke>'
            +'<Stroke color="#b0f0fa" weight="3"/>'
            +'</lineDeclineStroke>'
            +'<showDataEffect>'
            +'<SeriesInterpolate/> '
            +'</showDataEffect>'
            +'</Line2DSeries>'
            +'</series>'
            +'<verticalAxisRenderers>'
            +'<Axis2DRenderer axis="{vAxis}"/>'
            +'</verticalAxisRenderers>'
            +'<annotationElements>'
            +'<AxisMarker>'
            +'<lines>'
            +'<AxisLine value="524" lineStyle="dashLine" dashLinePattern="3" label="The Annual Average Price of 2012" labelAlign="left" color="#999999" labelYOffset="-5" fontSize="12">'
            +'  <stroke>'
            +'<Stroke color="#888888" weight="1"/>'
            +'</stroke>'
            +'</AxisLine>'
            +'</lines>'
            +'</AxisMarker>'
            +'</annotationElements>'
            +'</Line2DChart>'
            +'</rMateChart>'

    // 차트 데이터
    var chartData = [{"Month":"Jan","Price":500},
      {"Month":"Feb","Price":563},
      {"Month":"Mar","Price":550},
      {"Month":"Apr","Price":600},
      {"Month":"May","Price":465},
      {"Month":"Jun","Price":450},
      {"Month":"Jul","Price":548},
      {"Month":"Aug","Price":500},
      {"Month":"Sep","Price":510},
      {"Month":"Oct","Price":585},
      {"Month":"Nov","Price":572},
      {"Month":"Dec","Price":500}];

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

    /*
    // ------------------------- 수치 필드 사용자 정의 함수 -----------------------------------------------------
    // 챠트의 시리즈에서 labelPosition 속성을 설정한 경우 수치 필드를 사용자 정의하는 함수입니다.
    // layout XML 에서 Series 속성을 넣을때 라벨펑션을 설정하고 속성 값으로 javascript 함수명을 넣어줍니다
    //
    // 예) <Column2DSeries yField="Profit" labelPosition="outside" outsideLabelJsFunction="seriesLabelFunc">
    //
    // 파라메터 설명
    // seriesID : 해당 시리즈의 ID.
    // index : 해당 시리즈 아이템의 인덱스.
    // data : 해당 item의 값을 표현하기 위해 입력된 data(입력된 데이타중 해당 row(레코드) 자료입니다)
    // values : 해당 item의 값 (배열로 전달되며, 챠트 종류에 따라 아래와 같이 들어옵니다.)Pie2DSeries,Pie3DSeries           0:값 1:퍼센트값
              Bubble3DSeries,Matrix2DSeries   0:x축값 1:y축값 2:z값
                Candlestick2DSeries             0:x축값 1:open값 2:close값 3:high값 4:low값Pie,Bubble시리즈를 제외한 모든 시리즈   0:x축값 1:y축값 2:min값
             * min값은 type을 '100%' 또는 'stacked' 인 경우만 유효합니다. 쌓아올릴 경우 해당 데이터의 시작값을 의미합니다.
    //
    */
    function upFunc(seriesId, index, data, values){
      return '<font color="#03a9f5">Highest Price : $' + values[1] + '</font>';
    }

    /*
    // ------------------------- 수치 필드 사용자 정의 함수 -----------------------------------------------------
    // 챠트의 시리즈에서 labelPosition 속성을 설정한 경우 수치 필드를 사용자 정의하는 함수입니다.
    // layout XML 에서 Series 속성을 넣을때 라벨펑션을 설정하고 속성 값으로 javascript 함수명을 넣어줍니다
    //
    // 예) <Column2DSeries yField="Profit" labelPosition="outside" outsideLabelJsFunction="seriesLabelFunc">
    //
    // 파라메터 설명
    // seriesID : 해당 시리즈의 ID.
    // index : 해당 시리즈 아이템의 인덱스.
    // data : 해당 item의 값을 표현하기 위해 입력된 data(입력된 데이타중 해당 row(레코드) 자료입니다)
    // values : 해당 item의 값 (배열로 전달되며, 챠트 종류에 따라 아래와 같이 들어옵니다.)Pie2DSeries,Pie3DSeries         0:값 1:퍼센트값
              Bubble3DSeries,Matrix2DSeries   0:x축값 1:y축값 2:z값
                Candlestick2DSeries             0:x축값 1:open값 2:close값 3:high값 4:low값Pie,Bubble시리즈를 제외한 모든 시리즈   0:x축값 1:y축값 2:min값
             * min값은 type을 '100%' 또는 'stacked' 인 경우만 유효합니다. 쌓아올릴 경우 해당 데이터의 시작값을 의미합니다.
    //
    */
    function downFunc(seriesId, index, data, values){
      return '<font color="#33bbd3">Lowest Price : $' + values[1] + '</font>';
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
<body>
  <div id="chartHolder"/>
</body>
</html>
