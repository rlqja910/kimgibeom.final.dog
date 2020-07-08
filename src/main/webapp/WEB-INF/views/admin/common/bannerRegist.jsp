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
$(()=>{
	registBanner();
});

function registBanner(){
	$('#attachFile').change(function(){ 
		imgView(this);
	})
	
	$('#sendBtn').click(()=>{
		let data = new FormData($('form')[0]);
		
		if( $("#attachFile").val() != "" ){ 
			let ext = $('#attachFile').val().split('.').pop().toLowerCase(); //확장자만 추출
			
			if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) { //확장자확인
				$('#registMsg').text('gif, png, jpg, jpeg 파일만 첨부할 수 있습니다');
			return;
			}
		}else if($("#attachFile").val()==""){ //첨부된 파일이 없을때
			$('#registMsg').text('파일을 첨부해 주세요');
			return;
		}
		
		$.ajax({
			url:'bannerRegistProc',
			method:'post',
			data:data,
			processData:false,
			contentType:false,
			success:(result)=>{
				if(result){
					$('#registMsg').text('배너등록이 완료되었습니다');
				}else{
					$('#registMsg').text('등록실패');
				}
			},
		});
	});
}

function imgView(input){
	if(input.files && input.files[0]){
		let reader = new FileReader();
		reader.addEventListener('load', ()=>{
			$('#previewImg').attr('src', reader.result);
		},false);
		reader.readAsDataURL(input.files[0]);
	}
}

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

img {
	width: 500px;
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
						href='<c:url value='/user/logout'/>'>로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-picture'></span> <strong>
							배너관리</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form>
						<table class='table'>
							<tr>
								<th>배너 이미지</th>
								<td><input type='file' id='attachFile' name='attachFile' />
									<div></div><br><img id='previewImg' /></td>
							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<span id='registMsg' style='color: red'></span>
							<button type='button' class='btn btn-primary' id='sendBtn'>등록</button>
							&nbsp;
							<button type='button' class='btn btn-default'
								onClick="location.href='../../admin'">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>