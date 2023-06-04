<%--
  Created by IntelliJ IDEA.
  User: junsu
  Date: 2023/05/10
  Time: 10:38 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>Account</title>
	<%@ include file="./include/base.jsp"%>
	<%@ include file="AccountChart1.jsp"%>
	<%@ include file="AccountChart3.jsp"%>
	<%@ include file="AccountChart4.jsp"%>
	<%@ include file="AccountChart5.jsp"%>
	<%@ include file="AccountChart6.jsp"%>
	<%@ include file="AccountChart7.jsp"%>
	<style>
		.menu ::before {
			margin-top:-5px;
		}
		/*body layout end*/
		<jsp:include page="sidebar/sidebar.module.css"/>
		<jsp:include page="headbar/headbar.module.css"/>
		button {
			float:right;
		}
	</style>
	<link rel="stylesheet" href="include/Account.css?after"/>
</head>
<body>

<div>
	<jsp:include page="headbar/headbar.jsp"/>
</div>
<div id="main">
	<aside>
		<jsp:include page="sidebar/sidebar.jsp"/>
	</aside>
	<style>
	#side-acount{
        background-color:#e9eef3;
        border-left: 5px solid #023e8a;
    }
    #side-acount>a{
        color:black;
    }
	</style>
	<section>
		<div class="nav-area" >
			<jsp:include page="navibar/navibar.jsp"/>
			<jsp:include page="calendar.jsp"/>
		</div>
		<div id="body">
			<div id="body-content3">
				<div id="body-content4title">당좌비율</div>
				<div id="AccountChart4"></div>
			</div>
			<div id="body-content4">
				<div id="body-content5title">유동비율</div>
				<div id="AccountChart5"></div>
			</div>
			<div id="body-content5">
				<div id="body-content3title">부채비율</div>
				<div id="AccountChart3"></div>
			</div>
			<div id="body-content1">
				<div id="body-content1title">손익현황
					<button type="button" id="xbutton1" style="border:none; font-size:13px; background-color:white; color:black;">X</button>
					<button type="button" id="minusbutton1" style="border:none; font-size:13px;background-color:white; color:black;">-</button>
				</div>
				<div id="AccountChart1"></div>
			</div>
		</div>
		<div id="body2">
			<div id="body2-content1">
				<div id="body2-content1title">재무상태표 요약</div>
				<div id="AccountChart7"></div>
			</div>
			<div id="body2-content2">
				<div id="body2-content2title">자산상세
					<button type="button" id="xbutton2" style="border:none; font-size:13px; background-color:white; color:black;">X</button>
					<button type="button" id="minusbutton2" style="border:none; font-size:13px;background-color:white; color:black;">-</button>
				</div>
				<div id="AccountChart6"></div>
			</div>
		</div>
		<div id="body3">
			<div id="body3-content1">
				<div id="body3-content1title">재무상태표
					<button type="button" id="xbutton3" style="border:none; font-size:13px; background-color:white; color:black;">X</button>
					<button type="button" id="minusbutton3" style="border:none; font-size:13px;background-color:white; color:black;">-</button>
				</div>
				<jsp:include page="AccountGrid1.jsp"/>
			</div>
		</div>
	</section>
</div>
<style>
	body {
		padding: 0px 0px 0px  0px;
	}
</style>
<script>
	var count1=0;
	var count2=0;
	var count3=0;
	document.getElementById("minusbutton1").addEventListener('click',minusbutton1click);
	function minusbutton1click(){
		console.log("축소버튼클릭!");
		if(count1%2==0){
			const body = document.getElementById('body');
			body.style.cssText = 'height: 10%; transition: 0.3s';

			const bodyContentTitle1 = document.getElementById('body-content1title');
			bodyContentTitle1.style.cssText = 'height: 100%';
			const bodyContentTitle3 = document.getElementById('body-content3title');
			bodyContentTitle3.style.cssText = 'height: 100%';
			const bodyContentTitle4 = document.getElementById('body-content4title');
			bodyContentTitle4.style.cssText = 'height: 100%';
			const bodyContentTitle5 = document.getElementById('body-content5title');
			bodyContentTitle5.style.cssText = 'height: 100%';
			const bodyContentChart1 = document.getElementById('AccountChart1');
			bodyContentChart1.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const bodyContentChart3 = document.getElementById('AccountChart3');
			bodyContentChart3.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const bodyContentChart4 = document.getElementById('AccountChart4');
			bodyContentChart4.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const bodyContentChart5 = document.getElementById('AccountChart5');
			bodyContentChart5.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const minusButton1 = document.getElementById('minusbutton1');
			minusButton1.innerText = '+';
			count1++;
		} else if(count1%2==1){
			const body = document.getElementById('body');
			body.style.cssText = 'height: 43%; transition: 0.3s';

			const bodyContentTitle1 = document.getElementById('body-content1title');
			bodyContentTitle1.style.cssText = 'height: 10%';
			const bodyContentTitle3 = document.getElementById('body-content3title');
			bodyContentTitle3.style.cssText = 'height: 10%';
			const bodyContentTitle4 = document.getElementById('body-content4title');
			bodyContentTitle4.style.cssText = 'height: 10%';
			const bodyContentTitle5 = document.getElementById('body-content5title');
			bodyContentTitle5.style.cssText = 'height: 10%';
			const bodyContentChart1 = document.getElementById('AccountChart1');
			bodyContentChart1.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			const bodyContentChart3 = document.getElementById('AccountChart3');
			bodyContentChart3.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			const bodyContentChart4 = document.getElementById('AccountChart4');
			bodyContentChart4.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			const bodyContentChart5 = document.getElementById('AccountChart5');
			bodyContentChart5.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			const minusButton1 = document.getElementById('minusbutton1');
			minusButton1.innerText = '-';
			count1++;
		}
	}

	document.getElementById("minusbutton2").addEventListener('click',minusbutton2click);
	function minusbutton2click(){
		console.log("축소버튼클릭!");
		if(count2%2==0){
			const body = document.getElementById('body2');
			body.style.cssText = 'height: 10%; transition: 0.3s';


			const bodyContentTitle1 = document.getElementById('body2-content1title');
			bodyContentTitle1.style.cssText = 'height: 100%';
			const bodyContentTitle2 = document.getElementById('body2-content2title');
			bodyContentTitle2.style.cssText = 'height: 100%';
			const bodyContentChart1 = document.getElementById('AccountChart7');
			bodyContentChart1.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const bodyContentChart2 = document.getElementById('AccountChart6');
			bodyContentChart2.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const minusButton2 = document.getElementById('minusbutton2');
			minusButton2.innerText = '+';
			count2++;
		} else if(count2%2==1){
			const body = document.getElementById('body2');
			body.style.cssText = 'height: 43%; transition: 0.3s';
			const bodyContentTitle1 = document.getElementById('body2-content1title');
			bodyContentTitle1.style.cssText = 'height: 10%';
			const bodyContentTitle2 = document.getElementById('body2-content2title');
			bodyContentTitle2.style.cssText = 'height: 10%';
			const bodyContentChart1 = document.getElementById('AccountChart7');
			bodyContentChart1.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			const bodyContentChart2 = document.getElementById('AccountChart6');
			bodyContentChart2.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			const minusButton1 = document.getElementById('minusbutton2');
			minusButton1.innerText = '-';
			count2++;
		}
	}
	
	document.getElementById("minusbutton3").addEventListener('click',minusbutton3click);
	function minusbutton3click(){
		console.log("축소버튼클릭!");
		if(count3%2==0){
			const body3 = document.getElementById('body3');
			body3.style.cssText = 'height: 10%; transition: 0.3s';

			const bodyContentTitle1 = document.getElementById('body3-content1title');
			bodyContentTitle1.style.cssText = 'height: 100%';
			const bodyContentChart1 = document.getElementById('AccountGrid');
			bodyContentChart1.style.cssText  = 'visibility:hidden; transition: all 0.3s; width: 0%; height: 0%;  opacity:0;';
			const minusButton3 = document.getElementById('minusbutton3');
			minusButton3.innerText = '+';
			count3++;
		} else if(count3%2==1){
			const body3 = document.getElementById('body3');
			body3.style.cssText = 'height: 60%; transition: 0.3s';

			const bodyContentTitle1 = document.getElementById('body3-content1title');
			bodyContentTitle1.style.cssText = 'height: 10%';
			const bodyContentChart1 = document.getElementById('AccountGrid');
			bodyContentChart1.style.cssText  = 'visibility:; transition: all 0.3s; width:100%;  height:90%;opacity:1;';
			
			const minusButton3 = document.getElementById('minusbutton3');
			minusButton3.innerText = '-';
			count3++;
		}
	}

	document.getElementById("xbutton1").addEventListener('click',xbutton1click);
	function xbutton1click(){
		console.log("X버튼클릭!");
		const body = document.getElementById('body');

		body.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
	}

	document.getElementById("xbutton2").addEventListener('click',xbutton2click);
	function xbutton2click(){
		console.log("X버튼클릭!");
		const body2 = document.getElementById('body2');

		body2.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
	}

	document.getElementById("xbutton3").addEventListener('click',xbutton3click);
	function xbutton3click(){
		console.log("X버튼클릭!");
		const body3 = document.getElementById('body3');

		body3.style.cssText  = 'visibility:hidden; transition: all 0.3s;  height: 0vh; opacity:0;';
	}
</script>
</body>
</html>
