<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<%@ include file="./include/gridBase.jsp" %>
	<!-- rMateGridH5 CSS -->

<%--	<script>--%>
<%--		window.onload = function() {--%>
<%--			const convertedDate = localStorage.getItem('convertedDate');--%>
<%--			location.href = 'Account.jsp?convertedDate=' + convertedDate;--%>
<%--		};--%>
<%--	</script>--%>

	<script type="text/javascript">



		<%
             Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

			 String convertedDate = request.getParameter("convertedDate");
			 System.out.println(convertedDate);

             String jsonResult=null;
             try {
                 Connection conn = DriverManager.getConnection(
                    "server_address",
                    "user",
                    "password"
                 );

                 Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery(String.format("EXEC SP_FIN_BalSheet_Query1  '%s', 'Y'", convertedDate) );

                 JSONArray jsonArray = new JSONArray();

                 while (rs.next()) {
                     JSONObject jsonObject = new JSONObject();
                 jsonObject.put("AcctLevelCode", rs.getString(1));
                 jsonObject.put("구분", rs.getString(3));
                 jsonObject.put("지난 연도", rs.getString(4));
                 jsonObject.put("현 연도", rs.getString(5));
                 jsonObject.put("차이", rs.getString(6));
                 jsonObject.put("증감률", rs.getString(7));

                     jsonArray.add(jsonObject);
                 }


                 jsonResult = jsonArray.toString();

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
		<%--console.log(<%=jsonResult%>)--%>   const raw2 = <%=jsonResult%>;

		console.log(raw2)

		function convertToHierarchy(levelFieldName, childrenAttributeName, arr) {
			var fldNm = levelFieldName;
			var childrenAttrNm = childrenAttributeName;
			var src = arr;
			var treeArr = [];
			var lookup = {};
			var key = 0, currentArr, lastRow;

			for (var i = 0; i < arr.length; i++) {
				var row = src[i];
				var k = row[fldNm];
				if (k == key) {
					currentArr.push(row);
				} else if (k == 1) {
					treeArr.push(row);
					currentArr = treeArr;
					lookup[k] = {parent : currentArr};
				} else if (k > key) {
					if (!lastRow[childrenAttrNm])
						lastRow[childrenAttrNm] = [];
					lastRow[childrenAttrNm].push(row);
					currentArr = lastRow[childrenAttrNm];
					lookup[k] = {parent : currentArr};
				} else {
					currentArr = lookup[k].parent;
					currentArr.push(row);
				}
				lastRow = row;
				key = k;
			}

			return treeArr;
		}

		var gridDataConvert = convertToHierarchy("AcctLevelCode", "children", raw2);
		console.log(gridDataConvert)



		// rMateGridH5에서 그리드 생성 준비가 완료될 경우 호출할 함수를 지정합니다.
var jsVars = "rMateOnLoadCallFunction=gridReadyHandler";
rMateGridH5.setAssetsPath("./Grid/rMateGridH5/Assets/")

// rMateDataGrid 를 생성합니다.
// 파라메터 (순서대로)
//  1. 그리드의 id ( 임의로 지정하십시오. )
//  2. 그리드가 위치할 div 의 id (즉, 그리드의 부모 div 의 id 입니다.)
//  3. 그리드 생성 시 필요한 환경 변수들의 묶음인 jsVars
//  4. 그리드의 가로 사이즈 (생략 가능, 생략 시 100%)
//  5. 그리드의 세로 사이즈 (생략 가능, 생략 시 100%)
rMateGridH5.create("grid1", "AccountGrid", jsVars, "100%", "100%");

// 그리드의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
// rMate 그리드의 준비가 완료된 경우 이 함수가 호출됩니다.
// 이 함수를 통해 그리드에 레이아웃과 데이터를 삽입합니다.
// 파라메터 : id - rMateGridH5.create() 사용 시 사용자가 지정한 id 입니다.
function gridReadyHandler(id) {
	// rMateGrid 관련 객체
	gridApp = document.getElementById(id);	// 그리드를 포함하는 div 객체
	gridRoot = gridApp.getRoot();	// 데이터와 그리드를 포함하는 객체

	gridApp.setLayout(layoutStr);
	gridApp.setData(gridData);

	var layoutCompleteHandler = function(event) {
		dataGrid = gridRoot.getDataGrid();	// 그리드 객체
	}
	gridRoot.addEventListener("layoutComplete", layoutCompleteHandler);
}

var gridApp, gridRoot, dataGrid;

// 접힌 행을 깊이로 열기
// depth : 깊이, 0은 최상위
function expandLevel(depth) {
	dataGrid.expandLevel(depth);
}

// 접힌 행 모두 열기
function expandAll() {
	dataGrid.expandAll();
}

// 접힌 행 모두 닫기
function collapseAll() {
	dataGrid.setDisplayItemsExpanded(false);
	dataGrid.collapseAll();
}



//----------------------- 그리드 설정 끝 -----------------------

var layoutStr =
'<rMateGrid>\
	<NumberFormatter id="numfmt" useThousandsSeparator="true"/>\
	<PercentFormatter id="percfmt" useThousandsSeparator="true"/>\
<!--\n\
displayItemsExpanded 계층형 자료를 모두 펼친후에 보여줄지 여부 조정 (true,false중 택일, 기본 false)\n\
treeColumn 계층형 트리가 표현될 컬럼을 지정합니다. (기본은 첫번째 컬럼)\n\
-->\n\
	<DataGrid id="dg1" sortableColumns="true" sortExpertMode="true" displayItemsExpanded="true" treeColumn="{dg1col1}" horizontalScrollPolicy="auto" verticalAlign="middle" headerPaddingTop="5" headerPaddingBottom="6">\
		<groupedColumns>\
<!--\n\
allowChildrenSelection 계층형 자료에서 선택 변경시 하위 자식 노드도 같이 변경하도록 조정 (true,false중 택일, 기본 false)\n\
-->\n\
			<DataGridColumn id="dg1col1" dataField="구분" width="230" sortable="false"/>\
			<DataGridColumn id="dg1col2" dataField="지난 연도" textAlign="center" sortCompareFunction="numericSort" formatter="{numfmt}"/>\
			<DataGridColumn id="dg1col20" dataField="현 연도" textAlign="center" sortCompareFunction="numericSort" formatter="{numfmt}"/>\
			<DataGridColumn id="dg1col21" dataField="차이" textAlign="center" sortCompareFunction="numericSort" formatter="{numfmt}"/>\
			<DataGridColumn id="dg1col22" dataField="증감률" textAlign="center" sortCompareFunction="numericSort" formatter="{percfmt}"/>\
		</groupedColumns>\
		<dataProvider>\
			<!-- 그리드의 자료를 일반 dataProvider가 아닌 별도의 컴포넌트에 입력해야 할 경우 아래와 같이 source에 $gridData를 넣어줍니다 -->\
			<!-- HierarchicalData 컴포넌트를 사용하여 계층형 데이터를 표현합니다 -->\
			<HierarchicalData source="{$gridData}"/>\
		</dataProvider>\
	</DataGrid>\
</rMateGrid>\
';
		var gridData = gridDataConvert

// var gridData = [
// 	{
// 		"구분": "자산",
// 		"2022": 56,
// 		"2023": 83,
//         "차이": 24,
//         "증감율": 16,
// 		"children": [
// 			{
// 				"구분": "유동자산",
// 				"2022": 46,
// 		        "2023": 92,
//                 "차이": 13,
//                 "증감율": 26,
// 				"children": [
// 					{
//                         "구분": "당좌자산",
// 						"2022": 55,
// 		                "2023": 13,
//                         "차이": 59,
//                         "증감율": 11,
//                         "children": [
//                             {
//                                 "구분": "단기금융상품",
//                                 "2022": 55,
//                                 "2023": 66,
//                                 "차이": 19,
//                                 "증감율": 31,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "미수금",
//                                 "2022": 32,
//                                 "2023": 36,
//                                 "차이": 66,
//                                 "증감율": -4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "받을어음",
//                                 "2022": 13,
//                                 "2023": 25,
//                                 "차이": 66,
//                                 "증감율": -9,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "현금및현금성자산",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "외상매출금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "기타당좌자산",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "선급금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "보통예금(국가보조금)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "단기매매증권",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "대손충당금(외상매출)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "매도가능증권",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "선급비용",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "가지급금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "부가세대급금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             }
//                         ]
// 					},
// 					{
//                         "구분": "재고자산",
//                         "2022": 19,
//                         "2023": 36,
//                         "차이": 78,
//                         "증감율": 91,
//                         "children": [
//                             {
//                                 "구분": "미착품",
//                                 "2022": 35,
//                                 "2023": 29,
//                                 "차이": 56,
//                                 "증감율": 46,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "제품",
//                                 "2022": 13,
//                                 "2023": 28,
//                                 "차이": 65,
//                                 "증감율": 46,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "제품평가충당금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "재공품",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "원재료",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                         ]
// 					}
// 				]
// 			},
// 			{
// 				"구분": "비유동자산",
//                 "2022": 93,
//                 "2023": 13,
//                 "차이": 46,
//                 "증감율": 65,
// 				"children": [
// 					{
//                         "구분": "투자자산",
//                         "2022": 67,
//                         "2023": 69,
//                         "차이": 16,
//                         "증감율": 20,
//                         "children": [
//                             {
//                                 "구분": "장기금융상품",
//                                 "2022": 13,
//                                 "2023": 65,
//                                 "차이": 76,
//                                 "증감율": 77,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "매도가능증권",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             }
//                         ]
// 					},
// 					{
//                         "구분": "무형자산",
//                         "2022": 38,
//                         "2023": 72,
//                         "차이": 76,
//                         "증감율": -21,
//                         "children": [
//                             {
//                                 "구분": "개발비",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             }
//                         ]
// 					},
// 					{
//                         "구분": "기타비유동자산",
//                         "2022": 16,
//                         "2023": 77,
//                         "차이": 46,
//                         "증감율": 59,
//                         "children": [
//                             {
//                                 "구분": "기타보증금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "장기선급비용",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "임차보증금",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             }
//                         ]
// 					},
//                     {
//                         "구분": "유형자산",
//                         "2022": 32,
//                         "2023": 36,
//                         "차이": 85,
//                         "증감율": 70,
//                         "children": [
//                             {
//                                 "구분": "토지",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "건물",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(건물)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "구축물",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(구축물)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "기계장치",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(기계장치)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "차량운반구",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(차량운반구)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "공구와기구",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(공구와기구)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "비품",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(비품)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "국고보조금(비품)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "시설장치",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "감가상각누계액(시설장치)",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             },
//                             {
//                                 "구분": "건설중인자산",
//                                 "2022": 1,
//                                 "2023": 2,
//                                 "차이": 3,
//                                 "증감율": 4,
//                                 "children": [
//                                 ]
//                             }
//                         ]
// 					}
// 				]
// 			}
// 		]
// 	},
// ];

</script>
</head>
<body>
		<!-- 그리드가 삽입될 DIV -->
	<div id="AccountGrid"></div>
</body>
</html>