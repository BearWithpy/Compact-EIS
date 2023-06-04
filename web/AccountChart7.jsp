<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Combination chart</title>

<script type="text/javascript">
rMateChartH5.create("Achart7", "AccountChart7", "", "100%", "100%");

//스트링 형식으로 레이아웃 정의.
var layoutStr7 =
				'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
					+'<Options>'
						+'<Caption text=""/>'
						+'<SubCaption text="" textAlign="right" />'
						+'<Legend defaultMouseOverAction="false" useVisibleCheck="true"/>'
					+'</Options>'
					+'<Bar2DChart showDataTips="true" barWidthRatio="0.48">'
						+'<horizontalAxis>'
							+'<LinearAxis/>'
						+'</horizontalAxis>'
						+'<verticalAxis>'
							+'<CategoryAxis categoryField="Month"/>'
						+'</verticalAxis>'
						+'<series>'
							/*
							type 속성을 stacked로 변경
							type속성으로는
							clustered : 일반적인 다중데이터(차트의 멀티시리즈)방식으로 데이터를 표현합니다.(Default)
							stacked : 데이터를 위에 쌓아 올린 방식으로 표현 합니다.
							overlaid : 수치 데이터 값을 겹쳐서 표현 합니다. 주로 목표 위치와 현재 위치를 나타낼 때 많이 쓰입니다.
							100% : 차트의 수치 데이터를 퍼센티지로 계산 후 값을 퍼센티지로 나타냅니다.
							*/
							+'<Bar2DSet type="stacked" showTotalLabel="true" totalLabelJsFunction="totalFunc" color="#666" labelYOffset="2" labelXOffset="5">'
								+'<series>'
								/* Bar2D Stacked 를 생성시에는 Bar2DSeries를 최소 2개 정의합니다 */
									+'<Bar2DSeries labelPosition="inside" showValueLabels="[5]" xField="부채" displayName="부채" color="#ffffff" insideLabelYOffset="2">'
										+'<fill>'
											+'<SolidColor color="#fe7f2d"/>'
										+'</fill>'
										+'<showDataEffect>'
											+'<SeriesInterpolate/>'
										+'</showDataEffect>'
									+'</Bar2DSeries>'
									+'<Bar2DSeries labelPosition="inside" showValueLabels="[5]" xField="자본" displayName="자본" color="#ffffff" insideLabelYOffset="2">'
										+'<fill>'
											+'<SolidColor color="#fcca46"/>'
										+'</fill>'
										+'<showDataEffect>'
											+'<SeriesInterpolate/>'
										+'</showDataEffect>'
									+'</Bar2DSeries>'
									+'<Bar2DSeries labelPosition="inside" showValueLabels="[5]" xField="자산" displayName="자산" color="#ffffff" insideLabelYOffset="2">'
										+'<fill>'
											+'<SolidColor color="#a1c181"/>'
										+'</fill>'
										+'<showDataEffect>'
											+'<SeriesInterpolate/>'
										+'</showDataEffect>'
									+'</Bar2DSeries>'
								+'</series>'
							+'</Bar2DSet>'
						+'</series>'
					+'</Bar2DChart>'
				+'</rMateChart>';

//차트 데이터
var chartData7 =
	[{"Month" : "자산","자산" : 0},
	 {"Month" : "부채+자본","부채" : 0,"자본" : 0}];

chartData7[0].자산 = data3[0].Amt02;
chartData7[1].부채 = data3[3].Amt02;
chartData7[1].자본 = data3[5].Amt02;
//rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
//
//argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
//argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
//
//아래 내용은 
//1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
//2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
rMateChartH5.calls("Achart7", {
	"setLayout" : layoutStr7,
	"setData" : chartData7
});

/*
//------------------------- 스택 타입의 토탈 필드 사용자 정의 함수 -----------------------------------------------------
//차트의 SeriesSet 에서 showTotalLabel 속성을 설정한 경우 토탈 필드를 사용자 정의하는 함수입니다.
//layout XML 에서 Series 속성을 넣을때 labelJsFunction 주고, 만든 javascript 함수명을 넣어줍니다
//
//예) <Bar2DSet showTotalLabel="true" totalLabelJsFunction="totalLabelFunc">
//
//파라메터 설명
//index : 해당 시리즈 아이템의 인덱스.
//data : 해당 item의 값을 표현하기 위해 입력된 data(입력된 데이타중 해당 row(레코드) 자료입니다)
//value : 총 합계 값.
*/
function totalFunc(index, data, value){
	if(index == 5)
		return insertComma(value);
	return "";
}

//숫자에 천단위 콤마 찍어 반환하는 함수.
function insertComma(n) {
	var reg = /(^[+-]?\d+)(\d{3})/; // 정규식
	n += "";
	while (reg.test(n))
	n = n.replace(reg, '$1' + "," + '$2');
	return n;
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
	document.getElementById("Achart7").setTheme(theme);
}

//-----------------------차트 설정 끝 -----------------------

</script>
</head>
<body>
</body>
</html>
