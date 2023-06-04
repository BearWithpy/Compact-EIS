<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.YearMonth" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head lang="en">
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
      <meta http-equiv="Content-Script-Type" content="text/javascript"/>
      <meta http-equiv="Content-Style-Type" content="text/css"/>
      <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
	<link rel="stylesheet" href="https://uicdn.toast.com/tui-grid/latest/tui-grid.css" />
	<script src="https://uicdn.toast.com/tui-grid/latest/tui-grid.js"></script>
</head>
<body>
	<div id="grid"></div>
	<script>
      <jsp:include page="include/base.jsp"/>
           <script type="text/javascript">

          <%
              Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
              String jsonResult =null;
              try {
                Connection conn = DriverManager.getConnection(
                  "server_address",
                    "user",
                    "password"
                );
 String dataValue2 = request.getParameter("convertedDate"); // 이동된 URL에서 데이터 값을 추출

                System.out.println("Data Value: " + dataValue2); // 데이터 값을 출력

               Statement stmt = conn.createStatement();
               Statement stmt2 = conn.createStatement();
                //현재 년, 월
               YearMonth currentYearMonth = YearMonth.now();
                       int year = currentYearMonth.getYear();
                       int month = currentYearMonth.getMonthValue();

                       System.out.println("Current Year: " + year);
                       System.out.println("Current Month: " + month);
                       //String yearmonth = year+month;
                      // System.out.println("yearmonth " + yearmonth);

                       String convertedDate_year = dataValue2.substring(0, 4); // 앞 4자리를 추출하여 저장
                       String convertedDate_month = dataValue2.substring(4);
                       int convertedDate_month2 = Integer.parseInt(convertedDate_month)-1;
                       String convertedDate_month3 ="";
                       if(convertedDate_month2<10){
                            convertedDate_month3 = "0"+String.valueOf(convertedDate_month2);
                       }
                        System.out.println("convertedDate_month3: " + convertedDate_month3);
                       System.out.println("convertedDate_month2: " + convertedDate_month2);
                        System.out.println("convertedDate_year: " + convertedDate_year);
                       System.out.println("convertedDate_month: " + convertedDate_month);
                       String convertedDate_yearmonth = convertedDate_year+"-"+convertedDate_month+"-01";
                        String convertedDate_yearmonth2 = convertedDate_year+"-"+convertedDate_month3+"-01";
                       System.out.println("convertedDate_yearmonth: " + convertedDate_yearmonth);
                       System.out.println("convertedDate_yearmonth2: " + convertedDate_yearmonth2);
                //현재 년,월 끝



                                ResultSet  rs = stmt.executeQuery("EXEC sp_hum_Organ_Query2 '" + convertedDate_yearmonth + "'");


                             if (dataValue2 != null && !dataValue2.isEmpty()) {
                               // dataValue2 변수가 존재하는 경우에 실행할 코드
                                System.out.println("dataValue2 변수가 존재하는 경우에 실행22 " ); // 데이터 값을 출력


                                    rs = stmt.executeQuery("EXEC sp_hum_Organ_Query2 '" + convertedDate_yearmonth + "'");
                             } else {
                              System.out.println("dataValue2 변수가 존재하지않는 경우에 실행 " ); // 데이터 값을 출력



                rs = stmt.executeQuery("EXEC sp_hum_Organ_Query2 '" + convertedDate_yearmonth + "'");
                             }
                                ResultSet  rs2 = stmt2.executeQuery("EXEC sp_hum_Organ_Query2 '" + convertedDate_yearmonth2 + "'");

                       List<Integer> values1 = new ArrayList<>();




                JSONArray jsonArray = new JSONArray();

                while (rs.next()) {
                  JSONObject jsonObject = new JSONObject();
                  jsonObject.put("division",  rs.getString(2));
                  jsonObject.put("personnel1", rs.getInt(3));
                  jsonObject.put("totalpayment1", rs.getInt(4));
                  jsonObject.put("average1", rs.getInt(5));

                  jsonArray.add(jsonObject);
                }
                jsonResult = jsonArray.toString();

              } catch (SQLException e) {
                e.printStackTrace();
              }
              %>
            var aj = eval('<%=jsonResult%>');
            console.log(aj)
        // GRID 를 생성한다.
        // 나이는 수정할 수 있도록 설정한다.
		var grid = new tui.Grid( {
			el: document.getElementById('grid'),
			header: {
                    height: 45,
                  },
                  columns: [
                    {
                      header: '구분',
                      name: 'division',
                      align: 'center'
                    },
                    {
                      header: '전년실적',
                      name: 'personnel1',
                      sortingType: 'asc',
                                sortable: true,
                                align: 'right'
                    },
                    {
                      header: '현재원',
                      name: 'totalpayment1',
                      sortingType: 'asc',
                                sortable: true,
                                 align: 'right'
                    },
                    {
                       header: '증감률',
                       name: 'average1',
                       sortingType: 'asc',
                                 sortable: true,
                                  align: 'right'

                    },


                  ],
			 columnOptions: {
                    resizable: true
                  }
		} );

        // GRID 에 데이터를 입력한다.
		var arrData = aj;
		/*[
			{
				division: '합계',
				personnel1: '123',
				totalpayment1: '111',
				average1: '12',
				personnel2: '',
                totalpayment2: '111',
                average2: '12',
				interval: '32',
				increase: '11'
			},
			{
            				division: '관리',
            				personnel1: '12',
            				totalpayment1: '111',
            				average1: '12',
            				personnel2: '',
                            totalpayment2: '111',
                            average2: '12',
            				interval: '32',
            				increase: '11'
            },
            {
            				division: '생산',
            				personnel1: '123',
            				totalpayment1: '111',
            				average1: '12',
            				personnel2: '',
                            totalpayment2: '111',
                            average2: '12',
            				interval: '32',
            				increase: '11'
            			}
		];*/

		grid.resetData( arrData );

	</script>
</body>
</html>
