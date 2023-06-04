<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/10
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <meta http-equiv="Content-Script-Type" content="text/javascript"/>
    <meta http-equiv="Content-Style-Type" content="text/css"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>$Title$</title>
    <!-- rMateChartH5 에서 사용하는 스타일 -->
    <!-- rMateChartH5 에서 사용하는 스타일 -->

    <script type="text/javascript">

        // -----------------------차트 설정 시작-----------------------

        // rMateChart 를 생성합니다.
        // 파라메터 (순서대로)
        //  1. 차트의 id ( 임의로 지정하십시오. )
        //  2. 차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
        //  3. 차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
        //  4. 차트의 가로 사이즈 (생략 가능, 생략 시 100%)
        //  5. 차트의 세로 사이즈 (생략 가능, 생략 시 100%)
        rMateChartH5.create("head-chart1", "head-content1", "", "100%", "100%");

        // 스트링 형식으로 레이아웃 정의.
        var layoutStr =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Legend useVisibleCheck="true"/>'
            +'</Options>'
            +'<NumberFormatter id="numFmt1" useThousandsSeparator="true"/>'
            +'<CurrencyFormatter id="numFmt2" precision="0" currencySymbol="%" alignSymbol="right"/>'
            +'<Combination2DChart showDataTips="true" dataTipJsFunction="dataTipJsFunc">'
            /*
             Combination2D 차트 생성시에 필요한 Combination2DChart 정의합니다
             showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
             */
            +'<horizontalAxis>'
            +'<CategoryAxis categoryField="Month" padding="0.5"/>'
            +'</horizontalAxis>'
            +'<verticalAxis>'
            +'<LinearAxis id="vAxis1" formatter="{numFmt1}"/>'
            +'</verticalAxis>'
            +'<series>'
            +'<Column2DSet type="clustered">'
            /*
           Combination 차트에서는 Column차트와 Bar차트를 사용할때 Column2DSet(Colum2DSet),Bar2DSet(Bar2DSet)을 사용합니다
             예제로 Column2DSeries를 사용하려 할 때는 Column2DSet을 정의 후 +'<series>'와+'<Column2DSet>'을 정의합니다
           Column2DSet(Colum2DSet),Bar2DSet(Bar2DSet)의 Type은 일반 Type과 동일 합니다
             그러나 기본 Type은 overlaid입니다
                */
            +'<series>'
            +'<Column2DSeries yField="sales" displayName="Sales" labelPosition="outside" showValueLabels="[2]">'
            +'<fill>'
            +'<SolidColor color="#41b2e6"/>'
            +'</fill>'
            +'<showDataEffect>'
            +'<SeriesInterpolate/>'
            +'</showDataEffect>'
            +'</Column2DSeries>'
            +'<Column2DSeries yField="cost" displayName="Cost" labelPosition="outside" showValueLabels="[2]">'
            +'<fill>'
            +'<SolidColor color="#4452a8"/>'
            +'</fill>'
            +'<showDataEffect>'
            +'<SeriesInterpolate/>'
            +'</showDataEffect>'
            +'</Column2DSeries>'
            +'<Column2DSeries yField="profit" displayName="Profit" labelPosition="outside" showValueLabels="[2]">'
            +'<fill>'
            +'<SolidColor color="#fabc05"/>'
            +'</fill>'
            +'<showDataEffect>'
            +'<SeriesInterpolate/>'
            +'</showDataEffect>'
            +'</Column2DSeries>'
            +'</series>'
            +'</Column2DSet>'
            +'<Line2DSeries selectable="true" yField="목표치" displayName="목표치" radius="4.5" form="curve" itemRenderer="CircleItemRenderer">'
            +'<stroke>'
            +'<Stroke color="#5587a2" weight="3"/>'
            +'</stroke>'
            +'<lineStroke>'
            +'<Stroke color="#5587a2" weight="3"/>'
            +'</lineStroke>'
            +'<verticalAxis>'
            +'<LinearAxis id="vAxis2" formatter="{numFmt2}"/>'
            +'</verticalAxis>'
            +'<showDataEffect>'
            +'<SeriesInterpolate/>'
            +'</showDataEffect>'
            +'</Line2DSeries>'
            +'</series>'
            +'<verticalAxisRenderers>'
            +'<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
            +'<Axis2DRenderer axis="{vAxis2}" showLine="false"/>'
            +'</verticalAxisRenderers>'
            +'</Combination2DChart>'
            +'</rMateChart>';

        // 차트 데이터
        var chartData =
            [{"Month":"Jan","sales":1000, "cost":1300, "profit":700, "목표치":3000},
                {"Month":"Feb","sales":2000, "cost":1800, "profit":1200, "목표치":3000},
                {"Month":"Mar","sales":3000, "cost":2500, "profit":1700, "목표치":3000},
                {"Month":"Apr","sales":4000, "cost":3500, "profit":2000, "목표치":3000},
                {"Month":"May","sales":5000, "cost":4000, "profit":2200, "목표치":3000},
                {"Month":"May","sales":5000, "cost":4000, "profit":2200, "목표치":3000},
                {"Month":"May","sales":5000, "cost":4000, "profit":2200, "목표치":3000},
                {"Month":"May","sales":5000, "cost":4000, "profit":2200, "목표치":3000},
                {"Month":"May","sales":5000, "cost":4000, "profit":2200, "목표치":3000},
                {"Month":"May","sales":5000, "cost":4000, "profit":2200, "목표치":3000},
                {"Month":"Jun","sales":6000, "cost":4500, "profit":2700, "목표치":3000}];

        // rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
        //
        // argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
        // argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
        //
        // 아래 내용은
        // 1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
        // 2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
        rMateChartH5.calls("head-chart1", {
            "setLayout" : layoutStr,
            "setData" : chartData
        });

        function dataTipJsFunc (seriesId, seriesName, index, xName, yName, data, values) {
            if (seriesName == "목표치")
                return data['Month'] + "" + seriesName + " : <b>" + values['1'] + "</b>";
        else
            return data['Month'] + "" + seriesName + " : <b>$" + values['1'] + "M</b>";
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
            document.getElementById("head-chart1").setTheme(theme);
        }

        // -----------------------차트 설정 끝 -----------------------
    </script>
</head>
<body>
    <div id="head-content1"></div>
</body>
</html>
