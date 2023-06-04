<%@ page import="org.json.simple.JSONArray" %>
<%@ page import="org.json.simple.JSONObject" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.time.YearMonth" %>
<%@ page import="java.text.NumberFormat" %>
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
	<div id="grid2"></div>
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
                        System.out.println("convertedDate_year: " + convertedDate_year);
                       System.out.println("convertedDate_month: " + convertedDate_month);
                     //  String convertedDate_yearmonth = convertedDate_year+convertedDate_month;
                      // System.out.println("convertedDate_yearmonth: " + convertedDate_yearmonth);
                //현재 년,월 끝

                            ResultSet rs = stmt.executeQuery("EXEC sp_hum_Salary_Query1 '" + dataValue2 + "', '1', 'M'");
                             if (dataValue2 != null && !dataValue2.isEmpty()) {
                               // dataValue2 변수가 존재하는 경우에 실행할 코드
                                System.out.println("dataValue2 변수가 존재하는 경우에 실행 " ); // 데이터 값을 출력

                         rs = stmt.executeQuery("EXEC sp_hum_Salary_Query1 '" + dataValue2 + "', '1', 'M'");
                             } else {
                              System.out.println("dataValue2 변수가 존재하지않는 경우에 실행 " ); // 데이터 값을 출력


                             rs = stmt.executeQuery("EXEC sp_hum_Salary_Query1 '" + dataValue2 + "', '1', 'M'");

                             }


                JSONArray jsonArray = new JSONArray();

                while (rs.next()) {
                  JSONObject jsonObject = new JSONObject();
                  jsonObject.put("division",  rs.getString(3));

                  int value4 = rs.getInt(4); // 숫자를 가져옴
                  int value5 = rs.getInt(5); // 숫자를 가져옴
                  int value6 = rs.getInt(6); // 숫자를 가져옴
                  int value7 = rs.getInt(7); // 숫자를 가져옴
                  int value8 = rs.getInt(8); // 숫자를 가져옴
                  int value9 = rs.getInt(9); // 숫자를 가져옴
                  int value10 = rs.getInt(10); // 숫자를 가져옴
                  int value11 = rs.getInt(11); // 숫자를 가져옴

                  // NumberFormat 객체 생성
                  NumberFormat numberFormat = NumberFormat.getNumberInstance();
                  // 3자리마다 쉼표를 추가하도록 설정
                  numberFormat.setGroupingUsed(true);
                  // 포맷팅된 숫자 문자열 얻기
                  String formattedValue4 = numberFormat.format(value4);
                  String formattedValue5 = numberFormat.format(value5);
                  String formattedValue6 = numberFormat.format(value6);
                  String formattedValue7 = numberFormat.format(value7);
                  String formattedValue8 = numberFormat.format(value8);
                  String formattedValue9 = numberFormat.format(value9);
                  String formattedValue10 = numberFormat.format(value10);
                  String formattedValue11 = numberFormat.format(value11);


                  jsonObject.put("personnel1", formattedValue4);
                  jsonObject.put("totalpayment1", formattedValue5);
                  jsonObject.put("average1", formattedValue6);
                  jsonObject.put("personnel2", formattedValue7);
                  jsonObject.put("totalpayment2", formattedValue8);
                  jsonObject.put("average2", formattedValue9);
                  jsonObject.put("interval", formattedValue10);
                  jsonObject.put("increase", formattedValue11);
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
		var grid2 = new tui.Grid( {
			el: document.getElementById('grid2'),
			header: {
                    height: 80,
                    complexColumns: [
                      {
                        header: '전년실적',
                        name: 'mergeColumn1',
                        childNames: ['personnel1', 'totalpayment1','average1']
                      },
                      {
                        header: '실적',
                        name: 'mergeColumn2',
                        childNames: ['personnel2', 'totalpayment2', 'average2']
                      }

                    ]
                  },
                  columns: [
                    {
                      header: '구분',
                      name: 'division',
                       align: "center"

                    },
                    {
                      header: '인원',
                      name: 'personnel1',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    },
                    {
                      header: '총지급액',
                      name: 'totalpayment1',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    },
                    {
                       header: '평균',
                       name: 'average1',
                       sortingType: 'asc',
                                 sortable: true,
                                 align: "right",
                    },
                    {
                      header: '인원',
                      name: 'personnel2',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    },
                    {
                      header: '총지급액',
                      name: 'totalpayment2',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    },
                    {
                      header: '평균',
                      name: 'average2',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    },
                    {
                      header: '차이',
                      name: 'interval',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    },
                    {
                      header: '증감률',
                      name: 'increase',
                      sortingType: 'asc',
                                sortable: true,
                                align: "right",
                    }
                  ],
			 columnOptions: {
                    resizable: true
                  }
		} );

        // GRID 에 데이터를 입력한다.
		var arrData2 = aj;

		grid2.resetData( arrData2);

	</script>
</body>
</html>
