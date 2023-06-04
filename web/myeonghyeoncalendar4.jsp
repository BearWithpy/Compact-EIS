<html>
  <head>

    <!-- font-awesome -->
    <link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">

    <!-- bootstrap -->
    <link type="text/css" rel="stylesheet" href="calendar/css/bootstrap.min.css" />
    <!-- datepicker styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker3.min.css">

  </head>
  <body>
    <style>
    .fa{
        font-size:30px;
    }

    </style>
    <div class="container">


      <form>

        <!-- Date Picker -->
        <div class="form-group mb-4" style="width:142px; float:right;  margin-top:30px;" >
          <div class="datepicker date input-group">
            <div class="input-group-append" style="display:flex; ">
                        <span class="input-group-text" style="margin-right:5px;"><i class="fa fa-calendar"></i></span>
                        <input type="text" placeholder="Choose Date" class="form-control" id="fecha1" onchange="convertDate()" >
                        </div>


          </div>
        </div>
        <!-- // Date Picker -->
      </form>
    </div>


    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>

    <!-- Datepicker -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>

<%--    <script>--%>
<%--      const dateInput = document.getElementById('fecha1');--%>
<%--      dateInput.addEventListener('change', () => {--%>
<%--        const selectedDate = dateInput.value;--%>
<%--        console.log(selectedDate);--%>
<%--      });--%>
<%--    </script>--%>
    <script>


      function convertDate() {

        const dateInput = document.getElementById('fecha1');
        const selectedDate = dateInput.value;

        const parts = selectedDate.split('/');
        const month = parts[0];
        const year = parts[1];

        console.log(year + month);

        var dataValue = year + month; // 전달할 데이터 값
        var url = location.href; // 현재 URL
        var questionMarkIndex = url.indexOf("?"); // ?의 인덱스 찾기

        if (questionMarkIndex !== -1) { // ?가 존재하는 경우
          result = url.substring(0, questionMarkIndex); // ? 이전 부분만 저장
          console.log(result); // 결과 출력
          url = result;
        } else {
          console.log(url); // ?가 존재하지 않는 경우 그대로 출력
        }
        // URL에 데이터 값을 추가하여 새로운 URL 생성
        var newUrl = url + '?data=' + encodeURIComponent(dataValue);

        // 새로운 URL로 이동
        location.href = newUrl;

      }
    </script>

  <script>
  $(function () {
    $('.datepicker').datepicker({
      language: "ko",
      minViewMode: 1,
      autoclose: true,

      format: "mm/yyyy"
    });
  });

  </script>
  </body>
<html>