<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/10
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>

<head>
    <meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
    <style>
        table.ui-datepicker-calendar { display: none; }
        .ui-datepicker-trigger{
            border:none;
            background-color:white;
        }

        form {
            margin-right: 20px;
        }

    </style>
</head>
<body>



    <script>
        $(function () {
            //input을 datepicker로 선언
            var datepicker_default = {
                closeText: '닫기',
                prevText: '이전달',
                nextText: '다음달',
                currentText: '오늘',
                dateFormat: 'yy-mm' //Input Display Format 변경
                , showOtherMonths: true //빈 공간에 현재월의 앞뒤월의 날짜를 표시
                , showMonthAfterYear: true //년도 먼저 나오고, 뒤에 월 표시
                , changeYear: true //콤보박스에서 년 선택 가능
                , changeMonth: true //콤보박스에서 월 선택 가능
                , showOn: "both" //button:버튼을 표시하고,버튼을 눌러야만 달력 표시 ^ both:버튼을 표시하고,버튼을 누르거나 input을 클릭하면 달력 표시
                , buttonImage: "../../images/calendar.JPG" //버튼 이미지 경로

                , buttonText: "선택" //버튼에 마우스 갖다 댔을 때 표시되는 텍스트
                , yearSuffix: "년" //달력의 년도 부분 뒤에 붙는 텍스트
                , monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'] //달력의 월 부분 텍스트
                , monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'] //달력의 월 부분 Tooltip 텍스트
                , dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'] //달력의 요일 부분 텍스트
                , dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'] //달력의 요일 부분 Tooltip 텍스트
                , minDate: "-20Y" //최소 선택일자(-1D:하루전, -1M:한달전, -1Y:일년전)
                , maxDate: "+1D" //최대 선택일자(+1D:하루후, -1M:한달후, -1Y:일년후)
                , showButtonPanel: true
            };

            datepicker_default.closeText = "선택";
            datepicker_default.onClose = function (dateText, inst) {
                var month = $("#ui-datepicker-div .ui-datepicker-month :selected").val();
                var year = $("#ui-datepicker-div .ui-datepicker-year :selected").val();
                $(this).datepicker("option", "defaultDate", new Date(year, month, 1));
                $(this).datepicker('setDate', new Date(year, month, 1));
            }

            datepicker_default.beforeShow = function () {
                var selectDate = $("#sdate").val().split("-");
                var year = Number(selectDate[0]);
                var month = Number(selectDate[1]) - 1;
                $(this).datepicker("option", "defaultDate", new Date(year, month, 1));
            }
            $("#sdate").datepicker(datepicker_default);
        });
    </script>
  <form name="frmEX" style="border:2px solid black; width:110px; height:30px; border-radius: 7px 7px; 7px 7px; margin-right:10px;" >
        <input type="text" name="sdate" id="sdate" size="4.5" maxlength="4.5" value="2018-10"
        style="border:none; border-right-style: solid;border-right-width: 2px; border-right-color: black; margin-left:5px;"/>
    </form>

</body>
</html>
