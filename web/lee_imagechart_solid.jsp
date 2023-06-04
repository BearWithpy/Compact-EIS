<%--
  Created by IntelliJ IDEA.
  User: ihongcheol
  Date: 2023/05/11
  Time: 10:30 AM
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
        rMateChartH5.create("head-chart2", "head-content2", "", "100%", "100%");

        // 스트링 형식으로 레이아웃 정의.
        var layoutStr =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text="연도별 홈페이지 방문자 수"/>'
            +'</Options>'
            +'<NumberFormatter id="numFmt"/>'
            +'<ImageChart showDataTips="true" gutterLeft="20" gutterRight="20" showLabelVertically="true" columnWidthRatio="0.5">'
            /*
          Image 차트 생성시에 필요한 ImageChart 정의합니다
          showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다
         */
            +'<horizontalAxis>'
            +'<CategoryAxis id="hAxis" categoryField="Year" padding="1"/>'
            +'</horizontalAxis>'
            +'<verticalAxis>'
            +'<LinearAxis id="vAxis" maximum="2000"/>'
            +'</verticalAxis>'
            +'<series>'
            +'<ImageSeries yField="Data1" imageDisplayType="single" labelPosition="outside" formatter="{numFmt}" color="#5587a2">'
            /*
          ImageChart 정의 후 ImageSeries 정의합니다
           imageDisplayType ┬ single : 이미지 한개
                           ├ singleRepeat : 이미지 한개 반복
                          └ multiple : 다중 이미지
             */
            +'<imgSource>'
            +'<ImageSourceItem maintainAspectRatio="false" url="./chart/rMateChartH5/Assets/Images/man.png"/>'
            /*
          url : 이미지 파일의 주소입니다
         Value : 이미지가 갖을 고유의 value입니다(multiple에서만 해당합니다)
         maintainAspectRatio - true(정비율), false(차등비율) : 이미지의 고유 비율대로 표현할지 정의합니다
                  ├ imageDisplayType의 singleRepeat에서는 false(차등비율)은 존재하지 않습니다
                  └ imageDisplayType의 multiple에서는 true(정비율)는 존재하지 않습니다
            이 예제에서는 false(차등비율)를 정의 하였습니다
           */
            +'</imgSource>'
            +'<showDataEffect>'
            +'<SeriesSlide duration="1000" direction="up"/>'
            +'</showDataEffect>'
            +'</ImageSeries>'
            +'</series>'
            +'<verticalAxisRenderers>'
            +'<Axis2DRenderer axis="{vAxis}" visible="false"/>'
            +'</verticalAxisRenderers>'
            +'</ImageChart>'
            +'</rMateChart>';

        // 차트 데이터
        var chartData =
            [{"Year":2012,"Data1":700},
                {"Year":2013,"Data1":950},
                {"Year":2014,"Data1":1400},
                {"Year":2015,"Data1":1800},
                {"Year":2016,"Data1":1500},
                {"Year":2017,"Data1":1000},
                {"Year":2018,"Data1":1300},
                {"Year":2019,"Data1":600}];

        // rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
        //
        // argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
        // argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
        //
        // 아래 내용은
        // 1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
        // 2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
        rMateChartH5.calls("head-chart2", {
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
            document.getElementById("head-chart2").setTheme(theme);
        }

        // -----------------------차트 설정 끝 -----------------------
    </script>
<body>
        <div id="head-content2"></div>
</body>
</html>
