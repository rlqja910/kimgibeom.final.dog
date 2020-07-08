<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function clearConfirmMsg(){
	$('#pwMsg').css("display", "none");
	$('#pwCheckMsg').css("display", "none");
	$('#nameMsg').css("display", "none");
	$('#tellMsg').css("display", "none");
	$('#emailMsg').css("display", "none");
}

function enroll(){	
	$('#register').click(() => {
		clearConfirmMsg();
		
		let pwCheck = /((?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})/; // 정규식으로 PW 제한
		let emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 정규식으로 EMAIL 제한
		
		// 이름 예외처리
		if($('#name').val() === ''){
			$('#nameMsg').css("display", "block").text('이름을 입력해주세요.');
			return;
		
		// 전화번호 예외처리
		}else if($('#tell').val() === '' || $('#tell2').val() === '' || $('#tell3').val() === ''){
			$('#tellMsg').css("display", "block").text('전화번호를 입력해주세요.');
			return;
		}else if($('#tell').val().length != 3||$('#tell2').val().length != 4||$('#tell3').val().length != 4){
			$('#tellMsg').css("display", "block").text('전화번호 형식에 맞게 입력해주세요.(000-0000-0000)');
			return;
		
		// email 예외처리
		}else if($('#email').val() === ''){
			$('#emailMsg').css("display", "block").text('e-mail을 입력해 주세요.');
			return;
		}else if(!emailCheck.test($('#email').val())){
			$('#emailMsg').css("display", "block").text('e-mail이 조건에 맞지 않습니다');
			return;
		
		// 비밀번호 에외처리
		}else if($('#pw').val() === '' && $('#pwCheck').val() === ''){
			swal({
				title: '',
				text: '회원수정이 완료되었습니다.',
				type: 'success',
			},function(){
				$.ajax({
					url: 'userModify',
					method:'post',
					data: {
							'userId':  `${userId}`,
							'userPw':  `${user.userPw}`,
							'userName':  $('#name').val().trim(),
							'userPhone': $('#tell').val() +'-'+ $('#tell2').val()+'-'+ $('#tell3').val(),
							'userEmail':  $('#email').val().trim()
					}
				});
				location.href='<c:url value="/user/mypage"/>';
			});
		}else if($('#pw').val() !== '' && !pwCheck.test($('#pw').val())){
			$('#pwMsg').css("display", "block").text('비밀번호가 조건에 맞지 않습니다');
			return;
		}else if($('#pw').val() !== $('#pwCheck').val()){
			$('#pwCheckMsg').css("display", "block").text('비밀번호가 다릅니다.');
			return;
		}else{
			swal({
				title: '',
				text: '회원수정이 완료되었습니다.',
				type: 'success',
			},function(){
				$.ajax({
					url: 'userModify',
					method:'post',
					data: {
							'userId':  `${userId}`,
							'userPw':  $('#pw').val().trim(),
							'userName':  $('#name').val().trim(),
							'userPhone': $('#tell').val() +'-'+ $('#tell2').val()+'-'+ $('#tell3').val(),
							'userEmail':  $('#email').val().trim()
					}
				});
				location.href='<c:url value="/user/mypage"/>';
			});
		}
	});
}

// 핸드폰 번호를 input의  value에 등록
function phone(){
	var tellNumber = '${user.userPhone}';
	var phone = tellNumber.split('-');
	
	$('#tell').val(phone[0]);
	$('#tell2').val(phone[1]);
	$('#tell3').val(phone[2]);
}

function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}

$(()=>{
	enroll();
	phone();
});

</script>
<style>
/* header */
.header {
	width: 100%;
	height: 380px;
	background-color: #ccc;
	background-image: url('../attach/banner/banner.jpg');
	background-position: center;
}

.header .headerBackground {
	background: rgba(0, 0, 0, .4);
	height: 380px;
}

.subHr {
	width: 45px;
	margin-top: 140px;
	border: 1px solid #f5bf25;
}

.header .subTitle {
	text-align: center;
	font-size: 42px;
	color: #fff;
	margin-top: 20px;
}

.contHr {
	width: 45px;
	margin-top: 20px;
	margin-bottom: 60px;
	border: 1px solid #f5bf25;
}

/* sub메뉴 */
.subMenu {
	width: 100%;
}

.subMenu ul {
	overflow: hidden;
}

.subMenu ul li {
	float: left;
	width: 33.33%;
	text-align: center;
	box-shadow: 0 0 0 1px #ccc inset;
	color: #666;
}

.subMenu ul li a {
	padding: 12px 0;
}

.subMenu ul li:hover a {
	background-color: #f5bf25;
	color: #fff;
}

.subMenu .menuOn {
	background-color: #f5bf25;
	color: #fff;
}

/* 회원가입 */
.member>div:nth-child(1) {
	text-align: center;
}

.member>div:nth-child(1) span {
	font-weight: bold;
}

.member {
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
}

.member table input {
	border: 1px solid #999;
}

.member table {
	border: 1px solid #f5bf25;
	border-collapse: collapse;
	text-align: left;
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
}

.member table .text input {
	height: 30px;
	width: 40%;
}

.member table .number input {
	height: 30px;
	width: 10%;
}

.member form {
	margin: 100px 0;
	text-align: center;
}

.member form .contTitle {
	font-size: 32px;
	font-weight: bold;
}

.member form .button {
	overflow: hidden;
	width: 100%;
	text-align: center;
}

.member form .button input {
	height: 40px;
	margin-top: 60px;
}

.member form .button .ok {
	background-color: #f5bf25;
	border: 1px solid #f5bf25;
	width: 70px;
	color: #fff;
	margin-left: 5px;
}

.member form .button .no {
	width: 70px;
	margin-left: 5px;
	background-color: #fff;
	border: 1px solid #999;
}

.member table tr {
	height: 30px;
}

.member table tr input {
	margin: 7px 0;
}

.member th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	background-color: #eee;
	color: #333;
	width: 120px;
}

.member td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 50px;
}

.member th span {
	color: red;
}

.member .text button {
	height: 33px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.member .text td span {
	font-size: 12px;
}

.confirm {
	background-color: #f5bf25 !important;
}

.msg {
	color: red;
	display: none;
	margin-bottom: 7px;
	font-size: 14px !important;
}

@media screen and (max-width:935px) {
	.member table .text input {
		width: 100%
	}
	.member table tr:nth-child(1) input {
		margin-bottom: 0;
	}
	.msg {
		font-size: 12px !important;
		margin-top: 5px;
	}
}

/* 모바일 스타일 */
@media screen and (max-width:768px) {
	.subHr {
		margin-top: 20%;
	}
	.header .subTitle {
		font-size: 36px;
		margin-top: 0;
		padding-bottom: 5%;
	}
	.contHr {
		margin-top: 5%;
		margin-bottom: 10%;
	}
	.subMenu ul li a {
		padding: 5%;
	}
	.member form .contTitle {
		font-size: 28px;
	}
	.member form {
		margin: 10% 0;
	}
	.contHr {
		margin-top: 5%;
		margin-bottom: 10%;
	}
	.member table {
		width: 100%;
	}
	table th {
		width: 25%;
	}
	.member form .button input {
		margin-top: 10%;
	}
	.member table .number input {
		height: 30px;
		width: 20%;
	}
}
</style>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
				<header>
					<%@ include file="../common/header.jsp"%>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>마이페이지</div>
			</div>
		</div>

		<!-- 회원가입 -->
		<div class="content">
			<div class='subMenu'>
				<ul>
					<li><a href='<c:url value='/user/mypage'/>' class='menuOn'>회원정보
							변경</a></li>
					<li><a href='<c:url value='/adopt/adoptReservationView'/>'>입양
							예약 조회</a></li>
					<li><a href='<c:url value='/user/userWithdraw'/>'>회원탈퇴</a></li>
				</ul>
			</div>
			<div class="member">
				<form action="#">
					<div class='contTitle'>회원정보 변경</div>
					<hr class='contHr'>
					<table>
						<tr class="text">
							<th>아이디</th>
							<td>${userId}</td>
						</tr>
						<tr class="text tableH">
							<th>비밀번호</th>
							<td><input id='pw' type='password' /><span> 8~16글자,
									영문, 숫자, 특수문자(1개 이상)</span> <br> <span id='pwMsg' class='msg'></span>
							</td>
						</tr>
						<tr class="text">
							<th>비밀번호 확인</th>
							<td><input id='pwCheck' type='password' /> <br> <span
								id='pwCheckMsg' class='msg'></span></td>
						</tr>
						<tr class="text">
							<th>이름</th>
							<td><input id='name' type='text' value='${user.userName}' />
								<br> <span id='nameMsg' class='msg'></span></td>
						</tr>
						<tr class="number">
							<th>전화번호</th>
							<td><input id='tell' type='number' maxlength='3'
								oninput="numberMaxLength(this);" value='' /> - <input id='tell2'
								type='number' maxlength='4' oninput="numberMaxLength(this);"
								value='' /> - <input id='tell3' type='number' maxlength='4'
								oninput="numberMaxLength(this);" value='' /> <br> <span
								id='tellMsg' class='msg'></span></td>
						</tr>
						<tr class="text">
							<th>E-mail</th>
							<td><input id='email' type="email" value='${user.userEmail}' />
								<br> <span id='emailMsg' class='msg'></span></td>
						</tr>
					</table>
					<div class="button">
						<input type='button' class="ok" value='등록 ' id="register">
						<input type='button' class="no"
							onClick="location.href='<c:url value="/user/mypage"/>'"
							value='취소'>
					</div>
				</form>
			</div>
		</div>

		<!-- 푸터 -->
		<footer>
			<%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>