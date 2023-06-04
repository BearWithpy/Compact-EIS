<%@ page import="java.sql.*" %>
<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html>
<head>
    <title>Combination chart</title>

    <script type="text/javascript">
        function parseJSONFund(jsonResult) {
            const keys = ["부채", "자본", "당좌자산", "유동부채", "유동자산", "자산"];

            // var json = JSON.parse(jsonResult);
            // console.log(json);
            const newjson = jsonResult.filter(item => keys.includes(item.AcctName))
            return newjson;

        }

        <%
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");

            String jsonResult3=null;
            try {
                Connection conn = DriverManager.getConnection(
                    "server_address",
                    "user",
                    "password"
                );

                Statement stmt = conn.createStatement();

                String convertedDate = request.getParameter("convertedDate");
                ResultSet rs = stmt.executeQuery(String.format("EXEC SP_FIN_BalSheet_Query1  '%s', 'Y'", convertedDate));

                JSONArray jsonArray = new JSONArray();

                while (rs.next()) {
                    JSONObject jsonObject = new JSONObject();
                    jsonObject.put("AcctName", rs.getString(3));
        //          jsonObject.put("자산", rs.getString(4));
                    jsonObject.put("Amt02", rs.getInt(5));
        //          jsonObject.put("차이", rs.getString(6));


                    jsonArray.add(jsonObject);
                }


                jsonResult3 = jsonArray.toString();

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
        const raw3 = <%=jsonResult3%>;
        //console.log(raw2)

        const data3 = parseJSONFund(raw3)
        console.log(data3) // 부채 / 자본 * 100

        rMateChartH5.create("chart9", "AccountChart3", "", "100%", "100%");

        //스트링 형식으로 레이아웃 정의.
        /**
         * minimum : 최소 값
         * maximum : 최대 값
         * showDataTip : 툴팁의 출력 여부 default true
         * targetValue : 목표치 값
         * showTargetLine : 목표치의 출력 여부 default false
         * direction : 출력 방향 default vertical
         * duration : 이펙트 출력 시간 default 800
         * showValueLabel : 수치 라벨 출력 여부 default true
         * showAnimation : 이펙트 출력 여부 default true
         * valueChangeFunction : 데이터 변경될 시 호출될 콜백 함수
         * labelJsFunction : 수치 라벨 사용자 정의 함수
         * fillJsFunction : 색상 사용자 정의 함수
         * formatter : 포맷터 default NumberFormatter
         * bounceAnimating : 이펙트 튕김 효과 설정 여부 default true
         * backgroundColor : 배경 색상 default #ffffff
         * backgroundAlpha : 배경 색상 투명도 default 1
         * backgroundStroke : 배경 테두리 선
         * foregroundColor : 게이지 채워지는 영역 색상 default #33eeff
         * foreLineStroke : 게이지 채워지는 영역 테두리 선
         * horizontalRatio : 게이지 수평 출력 비율 default 0.6
         * verticalRatio : 게이지 수평 출력 비율 default 0.8
         * valueLabelHorizontalRatio : 수치 라벨 수평 위치 비율 default 0.5
         * valueLabelVerticalRatio : 수치 라벨 수직 위치 비율 default 0.5
         * leftTopBorderRadius : 위 왼쪽 보더 값 default 0
         * rightTopBorderRadius : 위 오른쪽 보더 값 default 0
         * leftBottomRadius : 아래 왼쪽 보더 값 default 0
         * rightBottomRadius : 아래 오른쪽 보더 값 default 0
         */

        var layoutStr1 =
            '<rMateChart backgroundColor="#FFFFFF" horizontalAlign="center" verticalAlign="middle" borderStyle="none">'
            +'<CurrencyFormatter id="cft" currencySymbol="%" alignSymbol="right"/>'
            +'<VCylinderGauge width="130" height="200" minimum="0" maximum="150" labels="[0,30,60,90,120,150]" tickInterval="20" '
            +'cylinderColor="[#6e6e6e,#5a5a5a,#233d4d]" cylinderAlpha="[1,1,1]" cylinderRatio="[0,100,255]" formatter="{cft}" '
            +'targetMark="10" snapInterval="1" labelJsFunction="labelFunc" valueLabelYOffset="120" valueLabelStyleName="valueLabel" valueChangeFunction="changeFunction3"/>'
            +'<Style>'
            +'.valueLabel{color:black;fontSize:15;}'
            +'</Style>'
            +'</rMateChart>';

        //게이지 데이터
        var chartData1 = [Math.floor(data3[3].Amt02 / data3[5].Amt02 * 100)];

        //rMateChartH5.calls 함수를 이용하여 차트의 준비가 끝나면 실행할 함수를 등록합니다.
        //
        //argument 1 - rMateChartH5.create시 설정한 차트 객체 아이디 값
        //argument 2 - 차트준비가 완료되면 실행할 함수 명(key)과 설정될 전달인자 값(value)
        //
        //아래 내용은
        //1. 차트 준비가 완료되면 첫 전달인자 값을 가진 차트 객체에 접근하여
        //2. 두 번째 전달인자 값의 key 명으로 정의된 함수에 value값을 전달인자로 설정하여 실행합니다.

        rMateChartH5.call("chart9", "setLayout", layoutStr1);
        rMateChartH5.call("chart9", "setData", chartData1);

        //게이지 값 랜덤 변경 함수
        function changeValue(){
            // 게이지의 값을 변경할려면 setData 함수를 사용하세요.
            document.getElementById("chart9").setData([parseInt(Math.random()*100)]);
        }

        //게이지 값 보관.
        var gaugeValue1, gaugeValue2, gaugeValue3;

        //게이지 value change 이벤트 핸들러 함수.
        function changeFunction1(value){
            gaugeValue1 = value;
        }

        function changeFunction2(value){
            gaugeValue2 = value;
        }

        function changeFunction3(value){
            gaugeValue3 = value;
        }

        //확인
        function commitValue(){
            alert("chart1 : " + gaugeValue1 + "\nchart2 : " + gaugeValue2 + "\nchart3 : " + gaugeValue3);
        }

        function labelFunc(value)
        {
            return value.toFixed(0)+"%";
        }

        function colorLabelFunc(value){
            var color = "#ffffff";
            if(value <= 55)
                color = "#5e4e3e";

            return "<font color='" + color + "'>" + Math.floor(value) + "</font>";
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
            document.getElementById("chart9").setTheme(theme);
        }

        //-----------------------차트 설정 끝 -----------------------

    </script>
</head>
<body>
</body>
</html>
