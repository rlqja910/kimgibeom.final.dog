<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function userUpdate(){
	$('#modify').on('click', () => {
		$('#modifypMsg').html('회원 수정이 완료되었습니다.');
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
								<td>rlqja910</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td><input type='text' value='abcd1234!' />
									<p>* * 8자리 이상 16자리 이하, 영소문자, 숫자, 특수문자 각 최소 1개 이상 가능(공백 불가)
									</p></td>
							</tr>
							<tr>
								<th>이름</th>
								<td><input type='text' value='김소현' /></td>
							</tr>
							<tr>
								<th>전화번호</th>
								<td><input type='text' style='width: 80px;' value='010' /><strong>&nbsp;
										- &nbsp;</strong> <input type='text' style='width: 120px;' value='1234' /><strong>&nbsp;
										- &nbsp;</strong> <input type='text' style='width: 120px;' value='1234' />
								</td>
							</tr>
							<tr>
								<th>이메일</th>
								<td><input type='email' style='width: 370px;'
									value='sohyun2@google.com'></td>
							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<span id='modifypMsg' style='color: red'></span>
							<button type='button' class='btn btn-primary' id='modify'>수정</button>
							&nbsp;
							<button type='button' class='btn btn-default'
								onClick="location.href='01.html'">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>