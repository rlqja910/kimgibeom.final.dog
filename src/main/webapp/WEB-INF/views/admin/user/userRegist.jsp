<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script>
let availCheck=false;

function clearConfirmMsg(){
	$('#idMsg').css("display", "none");
	$('#pwMsg').css("display", "none");
	$('#nameMsg').css("display", "none");
	$('#phoneMsg').css("display", "none");
	$('#emailMsg').css("display", "none");
}

function idCheck(){ //ID 중복확인
	$('#idCheck').click(()=>{ 
		clearConfirmMsg();
		let idCheck = /^[a-z]{1}[a-z0-9]{7,11}$/; //정규식으로 ID 제한

		if($('#userId').val() === ''){
			swal('','아이디를 입력해주세요.','error'); 
		}else if(!idCheck.test($('#userId').val())){
			swal('','아이디가 조건에 맞지 않습니다.','error');
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

function idOverlapTest(){
	$('#userAdd').click(() => {
		clearConfirmMsg();
		
		if(availCheck === true){
			let idCheck = /^[a-z]{1}[a-z0-9]{7,11}$/; //정규식으로 ID 제한
			let pwCheck = /((?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})/; // 정규식으로 PW 제한
			let emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i; // 정규식으로 EMAIL 제한

			// 아이디 예외처리
			if($('#userId').val() === ''){
				$('#idMsg').css("display", "inline").text('아이디를 입력해주세요.');
				return;
			}else if(!idCheck.test($('#userId').val())){
				$('#idMsg').css("display", "inline").text('아이디가 조건에 맞지 않습니다.');
				return;
				
			// 비밀번호 예외처리
			}else if($('#userPw').val() === ''){
				$('#pwMsg').css("display", "inline").text('비밀번호를 입력해주세요.');
				return;
			}else if(!pwCheck.test($('#userPw').val())){
				$('#pwMsg').css("display", "inline").text('비밀번호가 조건에 맞지 않습니다.');
				return;
				
			// 이름 예외처리
			}else if($('#userName').val() === ''){
				$('#nameMsg').css("display", "inline").text('이름을 입력해주세요.');
				return;
				
			// 전화번호 예외처리
			}else if($('#userPhone').val() === '' || $('#userPhone2').val() === '' || $('#userPhone3').val() === ''){
				$('#phoneMsg').css("display", "inline").text('전화번호를 입력해주세요.');
				return;
			}else if($('#userPhone').val().length != 3||$('#userPhone2').val().length != 4||$('#userPhone3').val().length != 4){
				$('#phoneMsg').css("display", "block").text('전화번호 형식에 맞게 입력해주세요.(000-0000-0000)');
				return;
			
			// 이메일 예외처리
			}else if($('#userEmail').val() === ''){
				$('#emailMsg').css("display", "inline").text('이메일을 입력해주세요.');
				return;
			}else if(!emailCheck.test($('#userEmail').val())){
				$('#emailMsg').css("display", "inline").text('이메일이 조건에 맞지 않습니다.');
				return;
				
			}else{
				swal({
					title: '',
					text: '회원 등록이 완료되었습니다.',
					type: 'success',
				},function(){	
					$.ajax({
						url: 'userRegistProc',
						method:'post',
						data: {
								'userId':  $('#userId').val().trim(),
								'userPw':  $('#userPw').val().trim(),
								'userName':  $('#userName').val().trim(),
								'userPhone': $('#userPhone').val() +'-'+ $('#userPhone2').val()+'-'+ $('#userPhone3').val(),
								'userEmail':  $('#userEmail').val().trim(),
						}
					});
					
					location.href='<c:url value="/admin/user/userListView"/>'
				});
			}
		}else{
			swal('','아이디 중복확인을 해주세요');
			return;
		}
	})
}

function numberMaxLength(e){
    if(e.value.length > e.maxLength){
        e.value = e.value.slice(0, e.maxLength);
    }
}

$(()=>{
	idCheck();
	clearConfirmMsg();
	idOverlapTest();
});
</script>
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	background: #f3f5f9;
}

#leftNav {
	display: flex;
	position: relative;
}

#leftNav #sidebar {
	position: fixed;
	width: 200px;
	height: 100%;
	background: #4b4276;
	padding: 20px 0;
}

#leftNav #sidebar h2 {
	color: #fff;
	text-align: center;
	margin-bottom: 30px;
}

#leftNav #sidebar ul li {
	padding: 15px;
	list-style: none;
	border-bottom: 1px solid rgba(0, 0, 0, 0.05);
	border-top: 1px solid rgba(225, 225, 225, 0.05);
}

#leftNav #sidebar ul li a {
	color: #bdb8d7;
	display: black;
}

#leftNav #sidebar ul li a span {
	width: 25px;
}

#leftNav #sidebar ul li:hover {
	background: #594f8d;
}

#leftNav #sidebar ul li:hover a {
	color: #fff;
	text-decoration: none;
}

#leftNav .main_content {
	width: 100%;
	margin-left: 200px;
}

#leftNav .main_content .header {
	padding: 11px;
	background: #fff;
	color: #717171;
	border-bottom: 1px solid #e0e4e8;
}

#leftNav .main_content .header .border {
	font-size: 19px;
}

#leftNav .main_content .header #topButton {
	text-decoration: none;
	margin-top: 4px;
	margin-right: 20px;
	float: right;
}

#leftNav .main_content .header #topButton a {
	text-decoration: none;
}

#leftNav .main_content .info {
	margin: 60px;
	color: #717171;
}

#content {
	float: left;
	margin-left: 10px;
	width: 400px;
	display: inline;
}

th {
	background-color: #EFEFEF;
	text-align: center;
	width: 150px;
}

p {
	margin-top: 6px;
	margin-bottom: 0;
	font-size: 8px;
}

.msg {
	color: red;
}
</style>
</head>
<body>
	<div class='wrapper' id='leftNav'>
		<div class='sidebar' id='sidebar'>
			<%@ include file="../common/nav.jsp"%>
		</div>
		<div class='main_content'>
			<div class='header'>
				<strong>&nbsp;&nbsp;ADMINSTRATOR</strong>
				<div id='topButton'>
					<a href='<c:url value='../common/logoRegist'/>'>로고관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='../common/bannerRegist'/>'>배너관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='/'/>'>홈페이지 돌아가기</a>&nbsp;|&nbsp; <a
						href='<c:url value='../../user/logout'/>'>로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-list'></span> <strong>
							회원관리 > 등록</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form>
						<table class='table'>
							<tr>
								<th>아이디</th>
								<td><input type='text' id='userId' />&nbsp;
									<button type='button' id='idCheck'>중복확인</button> <span
									id='idMsg' class='msg'></span> <br>
									<p>* 8자리 이상 12자리 이하, 영문, 숫자 최소 1개 이상 가능(시작은 영문, 공백불가)</p></td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input id='userPw' type='password' /> <span id='pwMsg'
									class='msg'></span> <br>
									<p>* 8자리 이상 16자리 이하, 영소문자, 숫자, 특수문자 각 최소 1개 이상 가능(공백불가)</p></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input id='userName' type='text' /> <span id='nameMsg'
									class='msg'></span></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input id='userPhone' type='text' style='width: 80px;'
									maxlength='3' oninput="numberMaxLength(this);" /><strong>
										&nbsp; - &nbsp;</strong> <input id='userPhone2' type='text'
									style='width: 120px;' maxlength='4'
									oninput="numberMaxLength(this);" /><strong> &nbsp; -
										&nbsp;</strong> <input id='userPhone3' type='text'
									style='width: 120px;' maxlength='4'
									oninput="numberMaxLength(this);" /> <span id='phoneMsg'
									class='msg'></span></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input id='userEmail' type='email'
									style='width: 370px;' /> <span id='emailMsg' class='msg'></span>
								</td>
							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<button type='button' id='userAdd' class='btn btn-primary'>등록</button>
							&nbsp;
							<button type='button' class='btn btn-default'
								onClick="location.href='<c:url value="/admin/user/userListView"/>'">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>