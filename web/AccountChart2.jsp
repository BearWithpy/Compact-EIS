<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Combination chart</title>

<script type="text/javascript">
rMateChartH5.create("Achart2", "AccountChart2", "", "100%", "100%");

//스트링 형식으로 레이아웃 정의.
var layoutStr2 =
				'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
						+'<Caption text="" />'
						+'<SubCaption text="" />'
					+'</Options>'
					+'<SeriesInterpolate id="ss"/>'
					+'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
						+'<horizontalAxis>'
							+'<CategoryAxis categoryField="Country"/>'
						+'</horizontalAxis>'
						+'<verticalAxis>'
							+'<LinearAxis maximum="100" interval="10"/>'
						+'</verticalAxis>'
						+'<series>'
							+'<Column2DSeries labelPosition="outside" yField="GDP" displayName="GDP Growth (In %)" showDataEffect="{ss}" showValueLabels="[4]" strokeJsFunction="strokeFunction"/>'
						+'</series>'
					+'</Column2DChart>'
				+'</rMateChart>';

//차트 데이터
var chartData2 = [{"Country":"1", "GDP":20},
				{"Country":"2", "GDP":30},
				{"Country":"3", "GDP":-51.2},
				{"Country":"4", "GDP":44.5}];

//rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
//
//argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
//argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
//
//아래 내용은 
//1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
//2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
rMateChartH5.calls("Achart2", {
	"setLayout" : layoutStr2,
	"setData" : chartData2
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
	document.getElementById("Achart2").setTheme(theme);
}

//-----------------------차트 설정 끝 -----------------------

</script>
</head>
<body>
</body>
</html>
