<%--
  Created by IntelliJ IDEA.
  User: ihongcheol
  Date: 2023/05/11
  Time: 11:39 AM
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

    // 스트링 형식으로 레이아웃 정의.
    var layoutStr =
            '<rMateChart>'
            +'<Options>'
            +'<Caption text="Half Gauge Sample"/>'
            +'</Options>'
            +'<CurrencyFormatter id="cft" currencySymbol="%" precision="0" alignSymbol="right"/>'
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
            +'<Gauge height="380" formatter="{cft}" innerRatio="0.85" labelJsFunction="valueLabelFunc" foregroundColors="[#f6a44c]" backgroundColors="[#e8d7c9]" minimum="0" maximum="100" startAngle="-90" minimumAngle="0" maximumAngle="180" color="#333333" fontSize="53" verticalOriginRatio="0.7" valueChangeFunction="changeFunction" labelYOffset="-50" labelClickJsFunction="labelClickFunc">'
            +'<backgroundElements>'
            +'<CanvasElement>'
            +'<CanvasLabel fontSize="13" height="17" color="#888888" horizontalCenter="0" verticalCenter="65" text="HALF SIMPLE GAUGE"/>'
            +'</CanvasElement>'
            +'</backgroundElements>'
            +'</Gauge>'
            +'</rMateChart>';

    // 게이지 데이터
    var chartData = [100];

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

    // 라벨 클릭 함수
    function labelClickFunc(value){
      alert(value);
    }

    //게이지 값 랜덤 변경 함수
    function changeValue()
    {
      // 게이지의 값을 변경할려면 setData 함수를 사용하세요.
      document.getElementById("chart1").setData([parseInt(Math.random()*200)]);
    }

    // 게이지 값 보관.
    var gaugeValue;

    // 게이지 value change 이벤트 핸들러 함수.
    function changeFunction(value)
    {
      gaugeValue = value;
    }

    // 확인
    function commitValue()
    {
      alert(gaugeValue);
    }

    function valueLabelFunc(value){
      return value.toFixed(0) + "%";
    }

    function labelFunc(value)
    {
      return '<font size="30">' + value + "\n%</font>";
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
  <div id="chartHolder"></div>
</body>
</html>
