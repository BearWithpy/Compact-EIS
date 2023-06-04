<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>Combination chart</title>

    <script type="text/javascript">
        function parseJSONFund(jsonResult) {
            const keys = ["Ⅰ. 매출", "Ⅲ. 매출총이익", "Ⅴ. 영업이익", "Ⅹ. 당기순이익"];

            // var json = JSON.parse(jsonResult);
            // console.log(json);
            const newjson = jsonResult.filter(item => keys.includes(item.AcctName))
            return newjson;

        }

        <%
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            String jsonResult0=null;
            try {
                Connection conn = DriverManager.getConnection(
                    "server_address",
                    "user",
                    "password"
                );

                Statement stmt = conn.createStatement();
                String convertedDate = request.getParameter("convertedDate");
                ResultSet rs = stmt.executeQuery(String.format("EXEC sp_Fin_PlStatement_Query1 '%s'", convertedDate));

                JSONArray jsonArray = new JSONArray();

                while (rs.next()) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("AcctName", rs.getString(2));
        //          jsonObject.put("자산", rs.getString(4));
                    jsonObject.put("MonthAmt", rs.getInt(7));
                    jsonObject.put("YearAmt", rs.getInt(13));
        //          jsonObject.put("차이", rs.getString(6));


                    jsonArray.add(jsonObject);
                }


                jsonResult0 = jsonArray.toString();

        //out.println(jsonResult);
        //System.out.println(jsonResult);
        //out.println("<script>");
        //out.println("displayJSON('" + jsonResult + "');");
        //out.println("</script>");
            } catch (SQLException e) {
                e.printStackTrace();
            }
            %>
        <%--const raw = (eval('<%=jsonResult%>'))--%>

        <%--const raw = JSON.parse(`<%=jsonResult%>`);--%>
        <%--const array = Array.from(raw);--%>
        <%--console.log(raw)--%>
        <%--console.log(typeof array)--%>

        <%--console.log(<%=jsonResult%>)--%>
        const raw0 = <%=jsonResult0%>;
        //console.log(raw2)

        const data0 = parseJSONFund(raw0)
        console.log(data0) // 부채 / 자본 * 100

        rMateChartH5.create("Achart1", "AccountChart1", "", "100%", "100%");

        //스트링 형식으로 레이아웃 정의.
        var layoutStr1 =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text="월계" />'
            +'<SubCaption text="" />'
            +'</Options>'
            +'<SeriesInterpolate id="ss"/>'
            +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
            +'<horizontalAxis>'
            +'<CategoryAxis categoryField="Country"/>'
            +'</horizontalAxis>'
            +'<series>'
            +'<Column2DSeries labelPosition="outside" yField="실적" displayName="실적" fill="#233d4d" showDataEffect="{ss}" showValueLabels="[4]" strokeJsFunction="strokeFunction"/>' 
            +'</series>'
            +'</Column2DChart>'
            +'</rMateChart>';

        var layoutStr2 =
            '<rMateChart backgroundColor="#FFFFFF" borderStyle="none">'
            +'<Options>'
            +'<Caption text="누계" />'
            +'<SubCaption text="" />'
            +'</Options>'
            +'<SeriesInterpolate id="ss"/>'
            +'<Column2DChart showDataTips="true" selectionMode="multiple" columnWidthRatio="0.48">'
            +'<horizontalAxis>'
            +'<CategoryAxis categoryField="Country"/>'
            +'</horizontalAxis>'
            +'<series>'
            +'<Column2DSeries labelPosition="outside" yField="실적" displayName="실적" fill="#233d4d" showDataEffect="{ss}" showValueLabels="[4]" strokeJsFunction="strokeFunction"/>'
            +'</series>'
            +'</Column2DChart>'
            +'</rMateChart>';

        //차트 데이터
        var chartData1 = [{"Country":"1", "실적":20},
            {"Country":"2", "실적":30},
            {"Country":"3", "실적":-51.2},
            {"Country":"4", "실적":44.5}];

        var chartData2 = [{"Country":"1", "실적":20},
            {"Country":"2", "실적":30},
            {"Country":"3", "실적":-51.2},
            {"Country":"4", "실적":44.5}];
        console.log(data0[0].AcctName);
        for (let i = 0; i < 4; i++) {
            chartData1[i].Country = data0[i].AcctName;
            chartData1[i].실적 = data0[i].MonthAmt;
        }

        for (let i = 0; i < 4; i++) {
            chartData2[i].Country = data0[i].AcctName;
            chartData2[i].실적 = data0[i].YearAmt;
        }

        var layoutSet = [layoutStr1, layoutStr2];
        var dataSet = [chartData1, chartData2];
        //rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
        //
        //argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
        //argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
        //
        //아래 내용은
        //1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
        //2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.
        rMateChartH5.calls("Achart1", {
            "setSlideLayoutSet" : layoutSet,
            "setSlideDataSet" : dataSet
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
            document.getElementById("Achart1").setTheme(theme);
        }

        //-----------------------차트 설정 끝 -----------------------

    </script>
</head>
<body>
</body>
</html>
