<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>

<script>
$(()=>{ 
	logInConfrim();
	hideTip();
});
function logInConfrim(){
	if(`${userId}`){ //로그인 했을경우
		if(`${userId}` === 'admin'){ //관리자가 로그인 했을경우
			afterAdminLogin();
		}else{ //관리자가 아닌 사용자가 로그인 했을경우
			afterUserLogin();
		}
	}else{ //로그인이 안된 상태일 때
	}
}
function hideTip(){
	if(`${userId}`){
		$('#tip').hide();
	}
}


function afterUserLogin(){
	$('#headBtn').empty();
	$('#headBtn').append("<li><a href='<c:url value='/user/mypage'/>'>마이페이지</a></li>");
	$('#headBtn').append("<li><a href='<c:url value='/user/logout'/>'>로그아웃</a></li>");
	
	$('#mLoginBtn').empty();
	$('#mLoginBtn').append("<a href='<c:url value='/user/mypage'/>'>마이페이지</a>");
	$('#mJoinBtn').empty();
	$('#mJoinBtn').append("<a href='<c:url value='/user/logout'/>'>로그아웃</a>");
}

function afterAdminLogin(){
	$('#headBtn').empty();
	$('#headBtn').append("<li><a href='<c:url value='/admin'/>'>관리자페이지</a></li>");
	$('#headBtn').append("<li><a href='<c:url value='/user/mypage'/>'>마이페이지 &nbsp;&nbsp;</a></li>");
	$('#headBtn').append("<li><a href='<c:url value='/user/logout'/>' id='logoutBtn'>로그아웃</a></li>");
	
	$('#mLoginBtn').empty();
	$('#mLoginBtn').append('<a href="<c:url value="/admin"/>">관리자페이지</a>');
	$('#mJoinBtn').empty();
	$('#mJoinBtn').append('<a href="<c:url value="/user/mypage"/>">마이페이지</a>');
	$('#mUl').append('<li><a href="<c:url value="/user/logout"/>">로그아웃</a></li>');
	
}


//모바일 메뉴
$(document).ready(function(){
 mobile_menu();
});

function mobile_menu(){
 /* 변수 선언 */
 var $menu = null;
 var $left_gnb = null; // 영역 전체
 var $depth1_wrap = null;
 var $depth1 = null;
 var $depth1_btn = null;
 
 /* 시작 함수 */
 function start(){
     init();
     init_event();
 }
 /* 변수 초기화 함수 */
 function init(){
     $menu = $('.menu');
     $left_gnb = $('.left_gnbWrap'); // 영역 전체
     $depth1_wrap = $('.left_gnb>li');
     $depth1 = $depth1_wrap.children('ul');
     //$depth1_btn = $depth1_wrap.children('a');
 }
 /* 이벤트 함수 */
 function init_event(){
     
     /* 모바일 메뉴 버튼 클릭했을때 모바일 메뉴영역 나오게 하기 */
     $menu.click(function(event){
         event.preventDefault();
         $left_gnb.addClass('on');
     });
     
     /* x버튼 눌렀을때 모바일 메뉴 닫기 */
     $('.close').click(function(event){
         event.preventDefault();

         $left_gnb.removeClass('on');
         
         // x버튼 누르면 시간차 약간두고 소메뉴 닫히게 하기
         setTimeout(function(){
             $depth1_btn.removeClass('on');
             $depth1.slideUp();
         },300)
     });
     
     /* depth1의 각메뉴 클릭시 depth2 나오게 하기 */
     $depth1_btn.click(function(event){
         event.preventDefault();
         var $this = $(this);
         var $this_ul = $this.siblings('ul');

         var check = $this.hasClass('on');
         if(check){
             $this.removeClass('on');
             $this_ul.stop(true,true).slideUp();
         }else{
             $depth1_btn.removeClass('on');
             $depth1.stop().slideUp();
             $this.addClass('on');
             $this_ul.stop(true,true).slideDown();
         }
     });
     
     /* 디바이스 크기 변경시 모바일 메뉴영역 숨기기 */
     $(window).resize(function(){
         $left_gnb.removeClass('on');
     });
 }
 
 start(); // 시작 호출
}
</script>

<style>
/* 초기화 */
html {
	overflow-y: scroll;
	font: 'nanum' !important;
}

body {
	margin: 0 auto;
	padding: 0;
	max-width: 100%;
	font-family: "맑은 고딕";
}

html, h1, h2, h3, h4, h5, h6, form, fieldset, img {
	margin: 0;
	padding: 0;
	border: 0
}

article, aside, details, figcaption, figure, footer, header, hgroup,
	menu, nav, section {
	display: block
}

ul {
	list-style: none;
	margin: 0;
	padding: 0
}

a {
	text-decoration: none;
	color: inherit;
	display: block
}

a:hover {
	text-decoration: none;
}

/* container */
.container {
	width: 100%;
}

/* header */
.header header {
	width: 80%;
	margin: 0 auto;
}

.header header .headA {
	padding-top: 20px;
	overflow: hidden;
	color: #fff;
}

.header header .headA ul {
	float: right;
	color: #fff;
	overflow: hidden;
}

.header header .headA ul li {
	text-align: right;
	font-size: 12px;
	float: left;
}

.header header .headA ul li:nth-child(2) {
	margin-left: 10px;
}

.header header .headB {
	overflow: hidden;
}

.header header .headB .logo a {
	width: 100px;
	height: 100px;
	float: left;
	color: #fff;
}

.header header .headB .logo a img {
	width: 100%
}

.header header .headB ul {
	float: right;
	margin-top: 25px;
	color: #fff;
	font-weight: bold;
}

.header header .headB ul li:hover {
	color: #f5bf25;
	transition-duration: .5s;
}

.header header .headB ul li {
	float: left;
	margin-left: 31px;
}

/* footer */
footer {
	width: 100%;
	height: 95px;
	background-color: #333;
	color: #666
}

footer .fot {
	width: 80%;
	margin: 0 auto;
	overflow: hidden;
}

footer .fot div {
	float: left;
}

footer .fot div:nth-child(1) {
	font-size: 18px;
	margin: 35px 0 0 0;
}

footer .fot div:nth-child(2) {
	margin: 24px 0 0 50px;
	font-size: 12px;
}

/* 모바일 메뉴 */
.mobileHead {
	overflow: hidden;
	display: none;
}

.gnbWrap {
	padding-top: 10px;
	padding-bottom: 8px;
	width: 890px;
	margin: 0 auto;
}

.gnbWrap>img {
	width: 250px;
	height: 42px;
}

/* 모바일 메뉴 버튼 */
.menu {
	position: absolute;
	top: 10%;
	right: 5%;
	transform: translateY(-50%);
}

.menu>a {
	width: 100%;
	height: 100%;
	display: block;
}

.fa-bars {
	color: #fff;
}

.fa-bars:hover {
	color: #f5bf25;
	transition-duration: .5s;
}

.fas {
	width: 40px;
	height: 40px;
}

a.close {
	position: absolute;
	right: 0;
	top: 5px;
	color: #fff;
	line-height: 50px;
	text-align: center;
}

.left_gnbWrap {
	height: 100%;
	width: 40%;
	position: fixed;
	right: -40%;
	top: 0;
	background-color: #f5bf25;
	padding-top: 50px;
	z-index: 999;
	transition: all 0.3s;
}

.left_gnbWrap.on {
	right: 0;
}

.left_gnb>li {
	width: 100%;
}

.left_gnb>li>a {
	display: block;
	text-align: center;
	line-height: 50px;
	width: 100%;
	height: 50px;
	color: #333;
	font-weight: bold;
}

.left_gnb>li>a.on {
	color: #fff;
}

.left_gnb>li>ul {
	display: none;
}

.left_gnb>li>ul>li>a {
	display: block;
	text-align: center;
	line-height: 50px;
	width: 100%;
	height: 50px;
	background-color: #fff;
	color: black;
}

.left_gnbWrap .mobileLogin {
	background-color: #333;
}

.left_gnbWrap .mobileLogin a {
	color: #fff;
}

/* 모바일 스타일 */
@media screen and (max-width:768px) {
	body {
		min-width: 480px;
	}
	.header {
		width: 100%;
		height: auto;
		background-color: #282320;
		background: url('<c:url value="../attach/banner/banner.jpg"/>')
			no-repeat;
		background-size: 100%;
		background-position: center;
	}
	.mainHeader {
		background: url('<c:url value="../attach/banner/banner.jpg"/>')
			no-repeat;
	}
	.mobileHead {
		display: block;
	}
	.header header {
		width: 90%;
		margin: 0 5%;
	}
	.header header .headA {
		display: none;
	}
	.header header .headB ul {
		display: none;
	}
	.header header .headB .logo {
		margin-top: 5%;
	}
	.header .headerBackground {
		height: 100%;
	}

	/* footer */
	footer {
		height: auto;
	}
	footer .fot {
		width: 100%;
		padding: 5% 0;
	}
	footer .fot div:nth-child(1) {
		margin: 1.5% 0 0 8%;
	}
	footer .fot div:nth-child(2) {
		margin: 0 5% 0 0;
		font-size: 11px;
		float: right;
	}
}
	/*툴팁 스타일*/
	a.tip {
	    position: relative;
	}
	
	a.tip span {
	    display: none;
	    position: absolute;
	    top: 30px;
	    left: -65px;
	    width: 150px;
	    padding: 5px;
	    z-index: 100;
	    background: #000;
	    color: #fff;
	    -moz-border-radius: 5px; /* 파폭 박스 둥근 정도 */
	    -webkit-border-radius: 5px; /* 사파리 박스 둥근 정도 */
	    font-family: 돋움;
	    font-size: 12px;
	}
	
	a:hover.tip span {
	    display: block;
	}	
</style>

<div class='headA'>
	<%
		if (session.getAttribute("userId") != null) {
	%>
	<%=session.getAttribute("userId")%>님 환영합니다<%
		}
	%>
	<ul id='headBtn'>
		<li><a href='<c:url value="/user/login"/>'>로그인</a></li>
		<li><a href='<c:url value="/user/join"/>'>회원가입</a></li>
	</ul>
</div>
<div class='headB'>
	<div class='logo'>
		<a href='<c:url value="/"/>'><br> <img
			src='<c:url value="/attach/logo/logo.jpg" />' /></a>
	</div>
	<ul>
		<li><a href="<c:url value="/introduce/introduceView"/>">보호소
				소개</a></li>
		<li><a href='<c:url value="/dog/dogListView"/>'>무료분양</a></li>
		<li><a href='<c:url value="/review/reviewListView"/>'>입양후기</a></li>
		<li><a href='<c:url value="/report/reportListView"/>'>신고하기</a></li>
		<li><a href='<c:url value="/donation/donate"/>' class="tip"><span id="tip">로그인 후 후원가능!</span>후원하기</a></li>
	</ul>
</div>
<div class='mobileHead'>
	<div class="menu">
		<a href="#"><i class="fas fa-bars"
			style="width: 40px; height: 40px;"></i></a>
	</div>
	<nav class="left_gnbWrap">
		<a href="#" class="close"><i class="fas fa-times"
			style="width: 40px; height: 40px;"></i></a>
		<ul class="left_gnb" id='mUl'>
			<li class='mobileLogin' id='mLoginBtn'><a
				href='<c:url value="/user/login"/>'>로그인</a></li>
			<li class='mobileLogin' id='mJoinBtn'><a
				href="<c:url value="/user/join"/>">회원가입</a></li>
			<br>
			<li><a href="<c:url value="/introduce/introduceView"/>">보호소
					소개</a></li>
			<li><a href="<c:url value="/dog/dogListView"/>">무료분양</a></li>
			<li><a href="<c:url value="/review/reviewListView"/>">입양후기</a></li>
			<li><a href="<c:url value="/report/reportListView"/>">신고하기</a></li>
			<li><a href="<c:url value="/donation/donate"/>">후원하기</a></li>
		</ul>
	</nav>
</div>
