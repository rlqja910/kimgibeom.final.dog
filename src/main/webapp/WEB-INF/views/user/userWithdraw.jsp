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
function enroll(){
	$('#confirm').click(() => {
		if($('#password').val() === ''){
			swal({
				title: '',
				text: '비밀번호를 입력해주세요.',
				type: 'warning',
			},function(){
				false;
			});
		}
		else{
			$.ajax({
				url: 'pwCheck',
				method: 'post',
				data: {
					userId: `${userId}`,
					userPw: $('#password').val(),
				},
				success: (result) => {
					if(result === true){
						swal({
							title: '',
							text: '회원탈퇴가 완료되었습니다.',
							type: 'success',
						},function(){
							location.href='<c:url value="/"/>';
						});
					}else {
						swal({
							title: '',
							text: '비밀번호를 다시 확인해 주세요.',
							type: 'warning'
						},function(){
							false;
						});
					}
				}
			})
		}
	});
}

$(()=>{
	enroll();
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
	width: 60%;
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
	.agree {
		width: 100%;
	}
	.member table {
		width: 100%;
	}
	table th {
		width: 25%;
	}
	.member table .text input {
		width: 95%;
	}
	.member form .button input {
		margin-top: 10%;
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
					<li><a href='<c:url value='/user/mypage'/>'>회원정보 변경</a></li>
					<li><a href='<c:url value='/adopt/adoptReservationView'/>'>입양
							예약 조회</a></li>
					<li><a href='<c:url value='/user/userWithdraw'/>'
						class='menuOn'>회원탈퇴</a></li>
				</ul>
			</div>
			<div class="member">
				<form action="#">
					<div class='contTitle'>회원탈퇴</div>
					<hr class='contHr'> 
					<table>
						<tr class="text tableH">
							<th><span>*</span> 비밀번호</th>
							<td><input type="password" id='password' /></td>
						</tr>
					</table>
					<div class="button">
						<input type='button' class="ok" value='확인 ' id="confirm">
						<input type='button' class="no" formaction="#" value='취소'>
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