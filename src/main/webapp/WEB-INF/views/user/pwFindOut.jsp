<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
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

/* 회원가입 */
.pwFind {
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
}

.pwFind table input {
	border: 1px solid #999;
}

.pwFind table {
	border: 1px solid #f5bf25;
	border-collapse: collapse;
	text-align: left;
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
}

.pwFind table .text input {
	height: 30px;
	width: 45%;
}

.pwFind form {
	margin: 100px 0;
	text-align: center;
}

.pwFind form .contTitle {
	font-size: 32px;
	font-weight: bold;
}

.pwFind form .button {
	overflow: hidden;
	width: 100%;
	text-align: center;
}

.pwFind form .button button {
	height: 40px;
	margin-top: 60px;
}

.pwFind form .button .ok {
	background-color: #f5bf25;
	border: 1px solid #f5bf25;
	width: 70px;
	color: #fff;
	margin-left: 5px;
}

.pwFind form .button .no {
	width: 70px;
	margin-left: 5px;
	background-color: #fff;
	border: 1px solid #999;
}

.pwFind table tr {
	height: 30px;
}

.pwFind table tr {
	height: 30px;
}

.pwFind th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
	color: #333;
}

.pwFind td {
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 50px;
}

.pwFind .textH {
	height: 70px;
}

.pwFind th span {
	color: red;
}

.pwFind .text button {
	height: 33px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.pwFind .text td span {
	font-size: 12px;
}

.p {
	width: 80%;
	text-align: left;
	margin: 0 auto;
	margin-bottom: 10px;
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
	.pwFind form .contTitle {
		font-size: 28px;
	}
	.pwFind {
		width: 100%;
	}
	.pwFind form {
		margin: 10% 0;
	}
	.pwFind form .button button {
		margin-top: 10%;
	}
	.pwFind form .contTitle {
		font-size: 28px;
		font-weight: bold;
	}
	.pwFind table .text input {
		height: 30px;
		width: 60%;
	}
	.p {
		text-align: center;
	}
}
</style>
<script>
//비밀번호 입력 빈칸 체크
function isCheckNewPw(){
	result = false;
	if($('#newPw').val())result = true;
	return result;
}

//비밀번호 확인 입력 빈칸 체크
function isCheckRePw(){
	result = false;
	if($('#rePw').val())result = true;
	return result;
}

//새 비밀번호 입력하면  #errorPw에 나타난 문구 사라짐
function allWrite(){
	$('#newPw').keyup(()=>{
		$('#errorPw').text('');
	});
}

//비밀번호 변경
function changePw(){
	$('#ok').on('click',(e) =>{
		e.preventDefault();
		
		let userId = sessionStorage.getItem("userId");
		let pwCheck = /((?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})/;
		let newPw =  $('#newPw').val().trim();
		let rePw = $('#rePw').val().trim();
		
		if(isCheckNewPw()){
			if(!pwCheck.test($('#newPw').val())){
				$('#errorPw').text('비밀번호가 조건에 맞지 않습니다');
				return;
			}else{
				$('#errorPw').text('');
			
				if(newPw == rePw){
					$('#errorPw2').text('');
					
					$.ajax({
						url : 'pwFindOutProc',
						method: 'post',
						data : {
								'userId': userId,	
								'userPw': newPw,
						},
						success: (result) =>{ 	
							swal({
								title: '비밀번호가 변경되었습니다',
								text: '',
								type: 'success',
							},
								function(isConfirm){
									if(isConfirm) location.href='login';
							})
						}
					})
				}else {
					if($('#rePw').val()) $('#errorPw2').text('비밀번호가 일치하지 않습니다');
					else $('#errorPw2').text('비밀번호 확인을 입력해주세요');
				}
			}
		}
		else {
			$('#errorPw').text('비밀번호를 입력하세요');
			$('#newPw').keyup(()=>{$('#rePw').val('');});
		}
	}) 
}


$(()=>{
	changePw();
	allWrite();
});
</script>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
				<header><%@ include file="../common/header.jsp"%>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>비밀번호 찾기</div>
			</div>
		</div>

		<!-- 비밀번호 찾기 -->
		<div class="content">
			<div class="pwFind">
				<form action="#" method="post">
					<div class='contTitle'>비밀번호 찾기</div>
					<hr class='contHr'>

					<table>
						<div class='p'>비밀번호를 변경해 주세요.</div>
						<colgroup>
							<col width='25%'>
							<col width='75%'>
						</colgroup>
						<tr class="text textH">
							<th><span>*</span>새 비밀번호</th>
							<td><input type="password" id="newPw" min="8" maxlength="16" />&nbsp;<span
								id='errorPw' style='color: red;'></span><br> <span><small>8자리
										이상 16자리 이하, 영소문자 숫자, 특수문자 각 최소 1개 이상 가능</small></span></td>
						</tr>
						<tr class="text">
							<th><span>*</span>새 비밀번호 확인</th>
							<td><input type="password" id='rePw' min="8" maxlength="16" />&nbsp;
								<span id='errorPw2' style='color: red;'></span></td>
						</tr>
					</table>
					<div class="button">
						<button class="ok" type="button" id="ok">확인</button>
						<button class="no" type="button" onClick="location.href='login'">취소</button>
					</div>
				</form>
			</div>
		</div>

		<!-- 푸터 -->
		<footer><%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>