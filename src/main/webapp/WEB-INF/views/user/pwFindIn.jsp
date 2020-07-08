<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>

<!-- alert창 -->
<script>
function message() {
	swal("인증번호가 발송되었습니다.");
};
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

/* sweetalert */
.swal-button {
	background-color: #f5bf25;
}

.swal-button:hover {
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
	}
}
</style>
<script>
//숫자 max값 초과시 제한
function maxLengthCheck(object){ 
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }   
}
  
//아이디 빈칸 체크
function isCheckId(){
	result = false;
	if($('#userId').val()) result= true;
	return result;
}

//이메일 빈칸 체크
function isCheckEmail(){
	result = false;
	if($('#email').val()) result= true;
	return result;
}

//인증번호 빈칸 체크
function isCheckCode(){
	result = false;
	if($('#code').val()) result= true;
	return result;
}

//사용자가 입력하면 error문구를 없앰
function allWrite(){
	$('#userId').keyup(()=>{
		$('#errorMsg').text('');
	});
	$('#email').keyup(()=>{
		$('#errorEmail').text('');
		$('#errorMsg').text('');
	});
	$('#code').keyup(()=>{
		$('#errorCode').text('');
		$('#errorMsg').text('');
		$('#errorEmail').text('');
	});
}

//비밀번호 찾기
function findPw(){ 
	$('#ok').on('click',()=>{
		if((isCheckId() && isCheckEmail() && isCheckCode())){
			$('#errorMsg').text('입력하신 정보가 정확하지 않습니다');
			$('#errorEmail').text('');
		}else{
			$('#errorMsg').text('입력 정보를 모두 입력해주세요');
		}
	});
	
	//인증번호 요청시
	$('#sendEmail').on('click',(e)=>{
		$('#errorMsg').text('');
		e.preventDefault();
		
		if(isCheckId() && isCheckEmail()){
			let emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
			
		if(!emailCheck.test($('#email').val())){
			$('#errorEmail').text('이메일 형식에 맞지 않습니다');
			return;
		}
			
		let userId = $('#userId').val();
		let email = $('#email').val();
		sessionStorage.setItem("userId", $('#userId').val());
			
			$.ajax({
				url: 'pwFindProc',
				method: 'post', 
				data: {
					'userId' : userId,
					'inEmail' : email,
					},
				beforeSend: ()=> $('html').css("cursor","wait"),
				complete: ()=> $('html').css("cursor","auto"),
				success: (result) => {
						if(result=='0'){
							$('#errorEmail').text('아이디와 이메일이 일치하지 않습니다.');
							$('#ok').click(()=>$('#errorCode').text(''));
						}else {
							swal('인증번호가 발송되었습니다.');
							$('#sendEmail').text('인증번호 재발송');
						
							//인증코드 받는데 성공하고 확인 누를시
							$('#ok').on('click',()=> {
								$('#errorMsg').text('');
							
								//사용자가 입력한 인증번호
								inCode = $('#code').val(); 
								
								if(inCode == result){
									location.href='pwFindOut';
								}
								else {
									if($('#code').val()) {$('#errorCode').text('인증번호가 맞지않습니다');}
									else $('#errorCode').text('인증번호를 입력하세요');
								}
							})
						}
					},
				error: (xhr) =>	$('#errorMsg').text('아이디가 존재하지 않습니다')
			})
			
		}else $('#errorMsg').text('아이디와 이메일을 모두 입력해주세요');
	});
}


$(()=>{
	findPw();
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

		<!-- 비밀번호 찾기-->
		<div class="content">
			<div class="pwFind">
				<form action="#">
					<div class="contTitle">비밀번호 찾기</div>
					<hr class="contHr">

					<table>
						<tr class="text">
							<th><span>*</span> 아이디</th>
							<td><input type="text" id="userId" min="8" maxlength="12" />&nbsp;<span
								id="errorMsg" style="color: red;"></span></td>
						</tr>
						<tr class="text">
							<th><span>*</span> 이메일</th>
							<td><input type="text" id="email" name="userEmail" />
								<button type="button" id="sendEmail">인증번호 발송</button>&nbsp; <span
								id="errorEmail" style="color: red;"></span></td>
						</tr>
						<tr class="text">
							<th><span>*</span> 인증번호</th>
							<td><input type="number" id="code" min="0" maxlength="6"
								oninput="maxLengthCheck(this)" />&nbsp; <span id="errorCode"
								style="color: red;"></span></td>
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