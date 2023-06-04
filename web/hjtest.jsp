<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Combination chart</title>
<%@ include file="../include/base.jsp"%>

<!-- rMateChartH5 테마 js -->
<script type="text/javascript" src="../rMateChartH5/Assets/Theme/theme.js"></script>

<script type="text/javascript">
	rMateChartH5.create("chart1", "chartHolder", "", "70%", "70%");

	var layoutStr = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
			+ '<Options>'
			+ '<Caption text="매출 현황(메인 페이지)"/>'
			+ '<Legend useVisibleCheck="true"/>'
			+ '</Options>'
			+ '<NumberFormatter id="numFmt1" useThousandsSeparator="true"/>'
			+ '<CurrencyFormatter id="numFmt2" precision="0" currencySymbol="%" alignSymbol="right"/>'
			+ '<Combination2DChart showDataTips="true" dataTipJsFunction="dataTipJsFunc">'
			+ '<horizontalAxis>'
			+ '<CategoryAxis categoryField="Month" padding="0.5"/>'
			+ '</horizontalAxis>'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis1" formatter="{numFmt1}"/>'
			+ '</verticalAxis>'
			+ '<series>'
			+ '<Column2DSeries labelPosition="outside" yField="실적" displayName="실적" showValueLabels="[5]">'
			+ '<fill>'
			+ '<SolidColor color="#41b2e6"/>'
			+ '</fill>'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '</Column2DSeries>'
			+ '<Line2DSeries radius="6" yField="누계" displayName="누계" itemRenderer="CircleItemRenderer">'
			+ '<verticalAxis>'
			+ '<LinearAxis id="vAxis2" formatter="{numFmt2}"/>'
			+ '</verticalAxis>' + '<showDataEffect>' + '<SeriesInterpolate/>'
			+ '</showDataEffect>' + '<lineStroke>'
			+ '<Stroke color="#f9bd03" weight="4"/>' + '</lineStroke>'
			+ '<stroke>' + '<Stroke color="#f9bd03" weight="3"/>' + '</stroke>'
			+ '</Line2DSeries>' + '</series>' + '<verticalAxisRenderers>'
			+ '<Axis2DRenderer axis="{vAxis1}" showLine="false"/>'
			+ '<Axis2DRenderer axis="{vAxis2}" showLine="false"/>'
			+ '</verticalAxisRenderers>' + '</Combination2DChart>'
			+ '</rMateChart>';
	// 차트 데이터
	var chartData = [ {
		"Month" : "Jan",
		"실적" : 200,
		"누계" : 61
	}, {
		"Month" : "Feb",
		"실적" : 300,
		"누계" : 35
	}, {
		"Month" : "Mar",
		"실적" : 420,
		"누계" : 30
	}, {
		"Month" : "Apr",
		"실적" : 550,
		"누계" : 32
	}, {
		"Month" : "May",
		"실적" : 620,
		"누계" : 29
	}, {
		"Month" : "Jun",
		"실적" : 720,
		"누계" : 22
	}, {
		"Month" : "Jul",
		"실적" : 880,
		"누계" : 20
	}, {
		"Month" : "Aug",
		"실적" : 990,
		"누계" : 25
	}, {
		"Month" : "Sep",
		"실적" : 1000,
		"누계" : 19
	}, {
		"Month" : "Oct",
		"실적" : 1100,
		"누계" : 18
	}, {
		"Month" : "Nov",
		"실적" : 1220,
		"누계" : 16
	}, {
		"Month" : "Dec",
		"실적" : 1840,
		"누계" : 15
	} ];

	rMateChartH5.calls("chart1", {
		"setLayout" : layoutStr,
		"setData" : chartData
	});

	function dataTipJsFunc(seriesId, seriesName, index, xName, yName, data,
			values) {
		if (seriesName == "누계")
			return data['Month'] + "<br>누계 : " + "<b>" + data['누계'] + "%</b>";
		else
			return data['Month'] + "<br>실적 : " + "<b>$" + data['실적'] + "M</b>";
	}

	rMateChartH5.registerTheme(rMateChartH5.themes);

	function rMateChartH5ChangeTheme(theme) {
		document.getElementById("chart1").setTheme(theme);
	}

	rMateChartH5.create("chart2", "chartHolder", "", "70%", "70%");

	// 스트링 형식으로 레이아웃 정의.
	var layoutStr2 = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
			+ '<Options>'
			+ '<Caption text="실적 기준 (영업 페이지)" />'
			+ '</Options>'
			+ '<Combination2DChart showDataTips="true">'
			/*
			Target_2D 차트 생성시에 필요한 Combination2DChart 정의합니다
			showDataTips : 데이터에 마우스를 가져갔을 때 나오는 Tip을 보이기/안보이기 속성입니다.
			 */
			+ '<horizontalAxis>'
			+ '<CategoryAxis categoryField="Month" padding="1"/>'
			+ '</horizontalAxis>'
			+ '<verticalAxis>'
			+ '<LinearAxis maximum="100" interval="10"/>'
			+ '</verticalAxis>'
			+ '<series>'
			/* 목표비실적Chart의 지켜야 할 점은 실적에 해당되는 시리즈를 먼저 정의 후에 목표 시리즈를 정의 해야 합니다 */
			/* 실적에 해당 필히 순서 준수*/
			+ '<VTarget2DResultSeries labelPosition="inside" yField="실적" displayName="실적" showValueLabels="[]" color="#ffffff" columnWidthRatio="0.54">'
			/* Combination2DChart 정의 후 Target2DResultSeries 정의합니다 */
			+ '<showDataEffect>'
			/*  차트 생성시에 Effect를 주고 싶을 때 shoDataEffect정의합니다 */
			+ '<SeriesInterpolate/>'
			/*
			SeriesInterpolate는 시리즈 데이터가 새로운 시리즈 데이터로 표시될 때 이동하는 효과를 적용합니다
			- 공통속성 -
			 elementOffset : effect를 지연시키는 시간을 지정합니다 default:20
			minimumElementDuration : 각 엘리먼트의 최소 지속 시간을 설정합니다 default:0
			            이 값보다 짧은 시간에 effect가 실행되지 않습니다
			offset : effect개시의 지연시간을 설정합니다 default:0
			 perElementOffset : 각 엘리먼트의 개시 지연시간을 설정합니다
			 */
			+ '</showDataEffect>'
			+ '</VTarget2DResultSeries>'
			/* 목표에 해당 */
			+ '<VTarget2DGoalSeries labelPosition="outside" yField="사업계획" displayName="사업계획" color="#f7921e" showValueLabels="[]" columnWidthRatio="0.54">'
			+ '<showDataEffect>'
			+ '<SeriesInterpolate/>'
			+ '</showDataEffect>'
			+ '<fill>'
			+ '<SolidColor color="#f7921e"/>'
			+ '</fill>'
			+ '</VTarget2DGoalSeries>'
			+ '</series>'
			+ '</Combination2DChart>'
			+ '</rMateChart>';

	// 차트 데이터
	var chartData2 = [ {
		"Month" : "Jan",
		"사업계획" : 45,
		"실적" : 43
	}, {
		"Month" : "Feb",
		"사업계획" : 65.8,
		"실적" : 62.1
	}, {
		"Month" : "Mar",
		"사업계획" : 30,
		"실적" : 40
	}, {
		"Month" : "Apr",
		"사업계획" : 33,
		"실적" : 30
	}, {
		"Month" : "May",
		"사업계획" : 60.8,
		"실적" : 53.4
	}, {
		"Month" : "Jun",
		"사업계획" : 45.8,
		"실적" : 40.4
	}, {
		"Month" : "Jul",
		"사업계획" : 26,
		"실적" : 18
	}, {
		"Month" : "Aug",
		"사업계획" : 35,
		"실적" : 28
	}, {
		"Month" : "Sep",
		"사업계획" : 75,
		"실적" : 62
	}, {
		"Month" : "Oct",
		"사업계획" : 60,
		"실적" : 55
	} ];

	rMateChartH5.calls("chart2", {
		"setLayout" : layoutStr2,
		"setData" : chartData2
	});

	rMateChartH5.registerTheme(rMateChartH5.themes);

	function rMateChartH5ChangeTheme(theme) {
		document.getElementById("chart2").setTheme(theme);
	}

	rMateChartH5.create("chart3", "chartHolder", "", "70%", "70%");

	var layoutStr3 = '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
			+ '<Options>'
			+ '<Caption text="실적 기준2 (영업 페이지)"/>'
			+ '<Legend useVisibleCheck="true"/>'
			+ '</Options>'
			+ '<Pie2DChart innerRadius="0.5" showDataTips="true" selectionMode="single">'
			+ '<series>'
			+ '<Pie2DSeries nameField="Month" field="실적" startAngle="20" renderDirection="clockwise" labelPosition="inside" color="#ffffff">'
			+ '<fills>'
			+ '<SolidColor color="#20cbc2"/>'
			+ '<SolidColor color="#074d81"/>'
			+ '<SolidColor color="#40b2e6"/>'
			+ '</fills>'
			+ '<showDataEffect>'
			+ '<SeriesZoom duration="1000"/>'
			+ '</showDataEffect>'
			+ '</Pie2DSeries>'
			+ '</series>'
			+ '<backgroundElements>'
			+ '<CanvasElement>'
			+ '<CanvasLabel text="2023" height="24" horizontalCenter="0" verticalCenter="-10" fontSize="19" color="#333333" backgroundAlpha="0"/>'
			+ '<CanvasLabel text="실적" height="24" horizontalCenter="0" verticalCenter="10" fontSize="14" color="#666666" backgroundAlpha="0"/>'
			+ '</CanvasElement>'
			+ '</backgroundElements>'
			+ '</Pie2DChart>'
			+ '</rMateChart>';

	// 차트 데이터
	var chartData3 = [ {
		"Month" : "Jan",
		"실적" : 900
	}, {
		"Month" : "Feb",
		"실적" : 2400
	}, {
		"Month" : "Mar",
		"실적" : 1900
	}, {
		"Month" : "Apr",
		"실적" : 1000
	}, {
		"Month" : "May",
		"실적" : 1500
	} ];

	rMateChartH5.calls("chart3", {
		"setLayout" : layoutStr3,
		"setData" : chartData3
	});

	rMateChartH5.registerTheme(rMateChartH5.themes);

	// -----------------------차트 설정 끝 -----------------------
</script>


<!-- 샘플 작동을 위한 css와 js -->
<script type="text/javascript" src="../chart/Web/JS/common.js"></script>
<script type="text/javascript" src="../chart/Web/JS/sample_util.js"></script>
<link rel="stylesheet" type="text/css" href="../chart/Web/sample.css" />

<!-- SyntaxHighlighter -->
<script type="text/javascript" src="../chart/Web/syntax/shCore.js"></script>
<script type="text/javascript" src="../chart/Web/syntax/shBrushJScript.js"></script>
<link type="text/css" rel="stylesheet" href="../chart/Web/syntax/shCoreDefault.css" />
</head>
<body>
	<div class="wrapper">
		<div class="header">
			<div class="headerTitle"></div>
		</div>
		<div id="content">
			<!-- 차트가 삽입될 DIV -->
			<div id="chartHolder"></div>
		</div>
	</div>
</body>
</html>