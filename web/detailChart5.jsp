<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
<title>Combination chart</title>

<script type="text/javascript">
    <%
             Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

             String jsonResult=null;
             try {
                 Connection conn = DriverManager.getConnection(
                    "server_address",
                    "user",
                    "password"
                 );

                 Statement stmt = conn.createStatement();
                 String convertedDate = request.getParameter("convertedDate");
                 ResultSet rs = stmt.executeQuery(String.format("EXEC SP_SAL_SaleOrder_Month_Query1 '%s', '%%', '%%', '1'",convertedDate));

                 JSONArray jsonArray = new JSONArray();

                int i=0;

                rs.next();
                 while (i<5) {
                     rs.next();
                     JSONObject jsonObject = new JSONObject();
                 jsonObject.put("금년 당월 실적", rs.getString("ResultAmt"));
                 jsonObject.put("전년도 실적", rs.getString("LastYearAmt"));
                 jsonObject.put("company", rs.getString(2));

                     jsonArray.add(jsonObject);
                     i++;
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
    <%--console.log(<%=jsonResult%>)--%>
    const saleOrderData = <%=jsonResult%>;

    console.log(saleOrderData)
    rMateChartH5.create("chart5", "body2-content1chart", "", "100%", "100%");

//스트링 형식으로 레이아웃 정의.
var layoutStr5 =
			'<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
				+'<Options>'
					+'<Caption text=""/>'
					+'<SubCaption text="" textAlign="center" />'
					+'<Legend defaultMouseOverAction="false" />'
				+'</Options>'
				+'<Column2DChart showDataTips="true" columnWidthRatio="0.33" selectionMode="single">'
					+'<horizontalAxis>'
						+'<CategoryAxis categoryField="company"/>'
					+'</horizontalAxis>'
					+'<verticalAxis>'
						+'<LinearAxis/>'
					+'</verticalAxis>'
					+'<series>'
						+'<Column2DSeries labelPosition="outside" yField="전년도 실적" displayName="전년도 실적" showValueLabels="[]">'
							+'<showDataEffect>'
							+'</showDataEffect>'
    +'<fill>'
    +'<SolidColor color="#233d4d"/>'
    +'</fill>'
    +'<SeriesInterpolate/>'
						+'</Column2DSeries>'
						+'<Column2DSeries labelPosition="outside" yField="금년 당월 실적" displayName="금년 당월 실적" showValueLabels="[]">'
							+'<showDataEffect>'
								+'<SeriesInterpolate/>'
							+'</showDataEffect>'
    +'<fill>'

    +'<SolidColor color="#cae9ff"/>'

    +'</fill>'
						+'</Column2DSeries>'
					+'</series>'
				+'</Column2DChart>'
			+'</rMateChart>';

//차트 데이터
var chartData5 = saleOrderData;

//rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
//
//argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
//argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
//
//아래 내용은 
//1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
//2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
rMateChartH5.calls("chart5", {
	"setLayout" : layoutStr5,
	"setData" : chartData5
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
	document.getElementById("chart5").setTheme(theme);
}

	// -----------------------차트 설정 끝 -----------------------
</script>
</head>
<body>
</body>
</html>