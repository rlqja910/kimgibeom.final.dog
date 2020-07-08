<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<%@ page import="kimgibeom.dog.user.domain.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function clearConfirmMsg(){
	$('#pwmsg').text('');
	$('#namemsg').text('');
	$('#phonemsg').text('');
	$('#emailmsg').text('');
}

function numberMaxLength(object){ //숫자 max값 초과시 제한
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
 }
 
function userUpdate(){
	$('#modify').on('click', () => {
		clearConfirmMsg();
		
		let idCheck = /^[a-z]{1}[a-z0-9]{7,11}$/; //정규식으로 ID 제한
		let pwCheck = /((?=.*[a-z])(?=.*[0-9])(?=.*[^a-zA-Z0-9가-힣]).{8,15})/;//정규식으로 PW 제한
		let emailCheck = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;//정규식으로 EMAIL 제한
		let updateUserName=$('#userName').val().replace(/ /gi, '');
		
		if($('#userPw').val() ===''){
			$('#pwmsg').text('암호를 입력하세요');
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
		
		if($('#userEmail').val()===''){
			$('#emailmsg').text('이메일을 입력하세요');
			return;
		}
		
		if(!emailCheck.test($('#userEmail').val())){
			$('#emailmsg').text('이메일이 형식에 맞지 않습니다');
			return;
		}
		
		let phoneNum=$('#userPhone1').val()+'-'+$('#userPhone2').val()+'-'+$('#userPhone3').val();
		let user={
				userId:'${user.userId}',
				userPw:$('#userPw').val(),
				userName:updateUserName,
				userPhone:phoneNum,
				userEmail:$('#userEmail').val(),
		};

		$.ajax({
			url:'../userModifyProc?page='+${page}+'&range='+${range},
			data:user,
			success: () =>{
				swal({
					title:'',
					text:'수정성공',
					type:'success', 
				},function(){
					location.href='../userListView?page='+ ${page} + "&range=" + ${range};
				});
			},
		});
	});
}

$(userUpdate);

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
							회원관리 > 수정</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form>
						<table class='table'>
							<tr>
								<th>아이디</th>
								<td>${user.userId}</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input id='userPw' type='password' maxlength="16"
									value=${user.userPw } />
									<p>*8~16글자, 영문, 숫자, 특수문자(1개 이상)</p> <font color='tomato'><p
											id='pwmsg'></p> </font></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type='text' id='userName' maxlength="10"
									type='text' value=${user.userName } /><font color='tomato'><p
											id='namemsg'></p> </font></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<%
									String userPhone = ((User) request.getAttribute("user")).getUserPhone();
									String[] userPhoneArray = userPhone.split("-");
								%>
								<td><input id='userPhone1' type='number' maxlength='3'
									oninput="numberMaxLength(this);" style='width: 80px;'
									value=<%=userPhoneArray[0]%> /><strong>&nbsp; -
										&nbsp;</strong> <input id='userPhone2' type='number' maxlength='4'
									oninput="numberMaxLength(this);" style='width: 120px;'
									value=<%=userPhoneArray[1]%> /><strong>&nbsp; -
										&nbsp;</strong> <input id='userPhone3' type='number' maxlength='4'
									oninput="numberMaxLength(this);" style='width: 120px;'
									value=<%=userPhoneArray[2]%> /><font color='tomato'><p
											id='phonemsg'></p> </font></td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type='email' id='userEmail' maxlength="40"
									style='width: 370px;' value=${user.userEmail}><font
									color='tomato'><p id='emailmsg'></p> </font></td>
							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<span id='modifypMsg' style='color: red'></span>
							<button type='button' class='btn btn-primary' id='modify'>수정</button>
							&nbsp;
							<button type='button' class='btn btn-default'
								onClick='location.href="../userListView?page="+ ${page} + "&range=" + ${range};'>취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>