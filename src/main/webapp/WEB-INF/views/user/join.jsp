<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<head>
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
	width: 45%;
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

.member th {
	border-left: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
	color: #333;
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

.member .text td span {
	font-size: 12px;
}

#availCheck {
	height: 33px;
	background-color: #666;
	border: 0px;
	color: #fff;
	height: 30px;
	width: 80px;
	margin-left: -5px;
	margin-top: 6px;
}

.agree {
	width: 80%;
	margin: 0 auto;
	margin-bottom: 30px;
}

.agree .textbox {
	overflow-y: scroll;
	height: 100px;
	border: 1px solid #ccc;
	padding: 15px;
	text-align: left;
}

.agree .text {
	text-align: right;
	margin-top: 10px;
}

.tableH td {
	height: 65px;
}

/* 모바일 스타일 */
@media screen and (max-width:768px) {
	.subHr {
		margin-top: 20%;
	}
	.contHr {
		margin-top: 5%;
		margin-bottom: 10%;
	}
	.member form .contTitle {
		font-size: 28px;
	}
	.header .subTitle {
		font-size: 36px;
		margin-top: 0;
		padding-bottom: 5%;
	}
	.member form {
		margin: 15% 0;
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
		width: 60%;
	}
	.member form .button input {
		margin-top: 10%;
	}
}
</style>

<script>
	let availCheck=false;
	 
	$(()=>{  
		join(); 
		availableIdCheck();
		idChange();
	});
	
	function idChange(){
		$('#userId').change(()=>{
			availCheck=false;
		}) 
	}
	
	function maxLengthCheck(object){ //숫자 max값 초과시 제한
	    if (object.value.length > object.maxLength){
	      object.value = object.value.slice(0, object.maxLength);
	    }    
	 }
	
	function availableIdCheck(){ //ID 중복확인
		$('#availCheck').click(()=>{ 
			clearConfirmMsg();
			let idCheck = /^[a-z]{1}[a-z0-9]{7,11}$/; //정규식으로 ID 제한
			
			if(!idCheck.test($('#userId').val())){
				swal('','아이디가 조건에 맞지 않습니다','error');
				return;
			}else{
				$.ajax({ 
					url:'idCheck', 
					data:{
						userId:$('#userId').val(),
					},
					success: (result) =>{ 
						if(result){
							swal('','사용 가능한 아이디입니다','success');
							availCheck=true;
						}else{
							swal('','이미 사용중인 아이디입니다','error');
						}
					},
				});
			}
		});
	}
	
	function clearConfirmMsg(){
		$('#idmsg').text('');
		$('#pwmsg').text('');
		$('#namemsg').text('');
		$('#phonemsg').text('');
		$('#emailmsg').text('');
	}
	
	function join(){ 
		$('#join').click(()=>{ 
			clearConfirmMsg(); 
			
			if(availCheck){
				if($(':input:checkbox:checked').val()){
					let idCheck = /^[a-z]{1}[a-z0-9]{7,11}$/; //정규식으로 ID 제한
					let pwCheck = /((?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})/;//정규식으로 PW 제한
					let emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//정규식으로 EMAIL 제한
					let updateUserName=$('#userName').val().replace(/ /gi, '');
					
					if(!idCheck.test($('#userId').val())){
						$('#idmsg').text('아이디가 조건에 맞지 않습니다');
						return;
					}
					
					if(!pwCheck.test($('#userPw').val())){
						$('#pwmsg').text('암호가 조건에 맞지 않습니다');
						return;
					}
	
					if(updateUserName===''){
						$('#namemsg').text('이름을 입력하세요');
						return;
					}
					
					if(!$('#userPhone1').val() &&
						!$('#userPhone2').val() && !$('#userPhone3').val()){
						$('#phonemsg').text('전화번호을 입력하세요');
						return;
					}
					else if($('#userPhone1').val().length != 3||$('#userPhone2').val().length != 4||$('#userPhone3').val().length != 4){
						$('#phonemsg').text('전화번호 형식에 맞게 입력해주세요.(000-0000-0000)');
						return;
					}
					
					if(!emailCheck.test($('#userEmail').val())){
						$('#emailmsg').text('이메일이 형식에 맞지 않습니다');
						return;
					}
					
					let phoneNum=$('#userPhone1').val()+'-'+$('#userPhone2').val()+'-'+$('#userPhone3').val();
					let user={
							userId:$('#userId').val().trim(),
							userPw:$('#userPw').val(),
							userName:updateUserName,
							userPhone:phoneNum,
							userEmail:$('#userEmail').val(),
					};
	
					
					$.ajax({
						url:'joinProc', 
						data:user,
						success: () =>{
							swal({
								title:'',
								text:'가입성공',
								type:'success', 
							},
							function(isConfirm){
									location.href='<c:url value='/'/>';
							});
						},
					});
				}else{
					swal('개인정보처리 방침에\n동의해 주세요');
					return;
				}
			}else{ //ID 중복확인 안했을 경우.
				swal('','아이디 중복확인을 해주세요');
				return;
			}
		});
	}
</script>

</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
				<header><%@ include file="../common/header.jsp"%>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>회원가입</div>
			</div>
		</div>


		<!-- 회원가입 -->
		<div class="content">
			<div class="member">
				<form id='goLogin'>
					<div class='contTitle'>회원가입</div>
					<hr class='contHr'>
					<div class='agree'>
						<div class="textbox">
							유기견 보호소에서는 기업/단체 및 개인의 정보 수집 및 이용 등 처리에 있어 아래의 사항을 관계법령에 따라 고지하고<br>
							안내해 드립니다.<br> <br> 1. 정보수집의 이용 목적 : 유기견 분양, 신고<br>
							2. 수집/이용 항목 : 이름, 전화번호, E-mail<br> 3. 보유 및 이용기간 : 상담 종료 후
							2년, 정보제공자의 삭제 요청 시 즉시
						</div>
						<div class="text">
							<input type="checkbox" id="agreecheck" /> 개인정보 수집 및 이용에 동의합니다.
						</div>
					</div>
					<table>
						<tr class="text">
							<th><span>*</span> 아이디</th>
							<td><font color='tomato'><p id='idmsg'></p> </font><input
								type="text" maxlength="12" id="userId" value='' /> <input
								type="button" value="중복확인" id='availCheck'> <br> <span>8자리
									이상 12자리 이하, 영문, 숫자 최소 1개 이상 가능(시작은 영문, 공백불가)</span></td>
						</tr>
						<tr class="text">
							<th><span>*</span> 암호</th>
							<td><font color='tomato'><p id='pwmsg'></p> </font><input
								type="password" maxlength="16" id="userPw" />&nbsp;&nbsp;&nbsp;<br>
								<span>8자리 이상 16자리 이하, 영소문자, 숫자, 특수문자 각 최소 1개 이상 가능(공백불가)</span></td>
						</tr>
						<tr class="text">
							<th><span>*</span> 이름</th>
							<td><font color='tomato'><p id='namemsg'></p> </font><input
								type="text" id="userName" maxlength="10" value='' /></td>
						</tr>
						<tr class="number">
							<th><span>*</span> 전화번호</th>
							<td><font color='tomato'><p id='phonemsg'></p> </font><input
								type="number" id="userPhone1" min="0" maxlength="3"
								oninput="maxLengthCheck(this)" /> - <input type="number"
								id="userPhone2" min="0" maxlength="4"
								oninput="maxLengthCheck(this)" /> - <input type="number"
								id="userPhone3" min="0" maxlength="4"
								oninput="maxLengthCheck(this)" /></td>
						</tr>
						<tr class="text">
							<th><span>*</span> 이메일</th>
							<td><font color='tomato'><p id='emailmsg'></p> </font><input
								type="email" id="userEmail" maxlength="40" /></td>
						</tr>
					</table>
					<div class="button">
						<input type="button" class="ok" id="join" value="확인"> <input
							type="button" class="no" value="취소"
							onClick="location.href='login'">
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