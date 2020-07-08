<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<script src='http://code.jquery.com/jquery-3.4.1.min.js'></script>
<script
	src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script>
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>

<script>
$(()=>{
	let dogAdoptionStatus = '${dog.dogAdoptionStatus}';
	if(dogAdoptionStatus==='입양미완료'){
		$('#reservationAndGoList').append('<input type=button id="reser" value="입양신청" data-target="#myModal" data-toggle="modal" /> <input type="button" value="목록" onClick=location.href="../../dog/dogListView" />');
	}
	else if(dogAdoptionStatus==='입양완료'){
		$('#reservationAndGoList').append('<br><br><div style="font-size:20px; color:red; font-weight:bold;">분양완료된 유기견입니다.</div><br><input type="button" value="목록" onClick=location.href="../../dog/dogListView" />');
	}
	
	if(dogAdoptionStatus==='입양미완료' && '${userId}'===''){
		$('#reser').attr("onClick",'location.href="../../user/login"');
	}
	
	$('#adoptReservation').click(()=>{
		if($('#pwInput').val()===''){
			$('#pwMsg').text('암호를 입력해주세요');
		}else{
			$.ajax({
				url:'../../adopt/userPwConfirm',
				data:{
					userPw : $('#pwInput').val(),
				},
				success:(result)=>{
					if(result===true){
						$('#pwMsg').text('');
						
						$.ajax({
							url:'../../adopt/reservation',
							data:{
								dogNum:${dog.dogNum},
							},
							success:(result)=>{
								if(result==true){
									swal({
										 title: '',
									     text: '입양신청이 완료되었습니다',
									     type: 'success',
									     showCancelButton: false,
									     confirmButtonText: '확인',
									     closeOnConfirm: false,
									     },function(isConfirm){
									      location.href=${dog.dogNum};
									     });
								}else{
									swal({
										 title: '',
									     text: '이미 신청되었습니다',
									     type: 'warning',
									     showCancelButton: false,
									     confirmButtonText: '확인',
									     closeOnConfirm: false,
									     },function(isConfirm){
									      location.href=${dog.dogNum};
									     });
								}
							},
						});
					}else{
						$('#pwMsg').text('암호가 일치하지 않습니다');
					}
				},
			});
		}
	});
});
</script>

<!-- modal -->
<style>
/* madal을 사용할 때 padding을 0으로 맞춰줘야 한다.*/
.container {
	padding: 0;
}

/* header */
.header {
	width: 100%;
	height: 380px;
	background-color: #ccc;
	background-image: url('../../attach/banner/banner.jpg');
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

.contTitle {
	font-size: 32px;
	font-weight: bold;
	text-align: center;
}

.header header .headB ul li a {
	font-size: 16px;
}

.header header .headB ul li:hover a {
	color: #f5bf25 !important;
	transition-duration: .5s;
	font-size: 16px;
}

/* 무료입양 */
.review {
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
	margin-top: 100px;
	margin-bottom: 100px;
}

.marker {
	background-color: yellow;
}

.review .dogView {
	width: 90%;
	margin: 0 auto;
}

.review .dogView table {
	width: 100%;
	border-collapse: collapse;
}

.review .dogView table tr:nth-child(1) {
	border-top: 1px solid #333;
	border-bottom: 1px solid #ccc;
}

.review .dogView table tr {
	font-size: 16px;
	border-bottom: 1px solid #ccc;
}

.review .dogView table tr th {
	background-color: #efefef;
	width: 20%;
	padding: 1% 0;
	text-align: center;
}

.review .dogView table tr td {
	width: 30%;
	padding: 1% 0 1% 2%;
}

/* 입양신청 목록 버튼 */
.button {
	text-align: center;
	overflow: hidden;
}

.button input {
	background-color: #f5bf25;
	width: 70px;
	height: 40px;
	border: 0px;
	color: #fff;
	margin-top: 30px;
}

.button input:nth-child(2) {
	border: 1px solid #ccc;
	background-color: #fff;
	color: #666;
	margin-left: 5px;
}

/* modal */
.modal-dialog {
	width: 45%;
	margin: 0 auto;
	margin-top: 10%;
}

.modal-title {
	text-align: center;
	color: #333;
	font-size: 24px;
	font-weight: bold;
	border-bottom: 1px solid #f5bf25;
	padding: 4% 0;
}

.modal-header {
	border: 0;
}

.modal-footer {
	text-align: center;
	padding: 4% 0;
}

.modal-footer button {
	width: 80px;
	height: 40px;
}

.modal-footer button:nth-child(1) {
	background-color: #f5bf25;
	color: #fff;
	border: 0;
}

#pwInput {
	border: 1px solid #999;
	height: 40px;
	width: 40%;
	margin-bottom: 20px;
}

.modal-body table .pw strong {
	padding-bottom: 20px;
}

.modal-body p {
	width: 90%;
	text-align: center;
	background-color: #efefef;
	margin: 0 auto;
	margin-top: 20px;
	padding: 5% 0;
}

#dogImg {
	width: 300px;
	height: auto;
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
	.header .subTitle {
		font-size: 36px;
		margin-top: 0;
		padding-bottom: 5%;
	}
	.contHr {
		margin-top: 5%;
		margin-bottom: 10%;
	}
	.contTitle {
		font-size: 28px;
	}
	.review {
		margin-top: 10%;
		margin-bottom: 10%;
	}
	.review .dogView {
		width: 100%;
	}
	.review .dogView table tr {
		font-size: 14px;
	}
	.review .dogView table tr th {
		background-color: #efefef;
		width: 20%;
		padding: 2% 0;
	}
	.review .dogView table tr:nth-child(5) td {
		padding: 2% 2%;
	}
	.button input {
		margin-top: 5%;
	}

	/* modal */
	.modal-dialog {
		width: 80%;
		margin: 0 auto;
		margin-top: 30%;
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
				<div class='subTitle'>무료 분양</div>
			</div>
		</div>

		<!-- 입양후기 -->
		<div class="content">
			<div class="review">
				<div class='contTitle'>무료 분양</div>
				<hr class='contHr'>
				<div class='dogView'>
					<table>
						<tr>
							<th>제목</th>
							<td colspan='3'>${dog.dogTitle}</td>
						</tr>
						<tr>
							<th>품종</th>
							<td>${dog.dogKind}</td>
							<th>이름</th>
							<td>${dog.dogName}</td>
						</tr>
						<tr>
							<th>성별</th>
							<td>${dog.dogGender}</td>
							<th>나이</th>
							<td>${dog.dogAge}</td>
						</tr>
						<tr>
							<th>체중</th>
							<td>${dog.dogWeight}</td>
							<th>입소날짜</th>
							<td>${dog.dogEntranceDate}</td>
						</tr>
						<tr>
							<td colspan='4' align="center">
								<div>
									<img id='dogImg' src='../../attach/dog/${dog.attachName}' />
								</div> <br> <br> ${dog.dogContent}
							</td>
						</tr>
					</table>

					<!-- 목록 버튼 -->
					<div class='button' id='reservationAndGoList'></div>
				</div>

				<!-- modal -->
				<div class='modal fade' id='myModal'>
					<div class='modal-dialog modal-sm'>
						<div class='modal-content'>
							<div class='modal-header'>
								<button class='close' data-dismiss='modal'>&times;</button>
								<h4 class='modal-title'>입양신청</h4>
							</div>
							<div class='modal-body'>
								<table>
									<tr class='pw'>
										<div align="center" id=pwDiv>
											<strong>암호&nbsp&nbsp</strong><input type='password'
												id=pwInput /><br> <span style='color: red;' id='pwMsg'></span>
										</div>
									</tr>
								</table>
								<p>
									암호를 입력하면 입양신청이 완료됩니다.<br>회원정보의 전화번호로 상담원의 안내를 기다려주세요.(1~2일
									이내)

								</p>
							</div>
							<div class='modal-footer'>
								<button class='btn btn-default' id='adoptReservation'>신청하기</button>
								<button class='btn btn-default' data-dismiss='modal'>취소</button>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<!-- 푸터 -->
		<footer>
			<%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>