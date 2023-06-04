<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>로그아웃 처리</title>
</head>
<body>
<%
  Cookie user = new Cookie("id", "");
  user.setMaxAge(0);
  response.addCookie(user);//쿠키에 초기화된 user정보를 보냄
  response.sendRedirect("loginFrm.jsp");//로그아웃 후 로그인페이지로 연결
%>
<!-- 로그아웃 처리 완료 -->
</body>
</html>