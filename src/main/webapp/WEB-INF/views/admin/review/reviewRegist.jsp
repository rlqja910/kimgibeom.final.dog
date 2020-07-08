<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script src="//cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
<script src="${path}/ckeditor/ckeditor.js"></script>
<script>
function cencelAdd(){
	$("#cancelAdd").click(() => {
		location.href = "reviewListView";
	});
}

function addReview(){
	$("#addReview").click(() => {
		if(!$("#title").val().trim()){
			$("#chkTitle").text("제목을 입력해주세요.");
			$("#title").focus();
		}else if(!$("#imgFile").val()){
			$("#chkFile").html("첨부할 파일을 선택해주세요.");
		}else if(!CKEDITOR.instances.description.getData()){
			$("#chkContent").text("내용을 입력해주세요.");
		}else {
			$("#reviewForm").submit();
		}
	});
}

function fn_chkByteTitle(obj){
	   let maxByte = 100; //최대 입력 바이트 수
	   let str = obj.value;
	   let strLength = str.length;
	   
	   let titleByte = 0; 
	   let titleLength = 0; 
	   let oneChar = "";
	   let str2 = "";
	   
	   for(let i=0; i<strLength; i++){
	      oneChar = str.charAt(i); //한글자씩 분해
	      
	      if(escape(oneChar).length > 4) titleByte += 3; //AS32UTF8은 한글 3byte로 인식함
	      else titleByte++; //영어 숫자 특수문자 1byte 
	      
	      if(titleByte <= maxByte) titleLength = i + 1; //리턴할 문자열 갯수
	   }
	   
	   if(titleByte > maxByte){
	      $("#chkTitle").text("한글" + Math.round(maxByte/3) + "자 / 영문" + maxByte + "자까지 입력 가능합니다.");
	      str2 = str.substr(0, titleLength); //문자열 자르기
	      obj.value = str2;
	   }else {
	      $("#chkTitle").text("");
	   }
	}

function fn_chkFile(obj){
	let ext = $("#imgFile").val().split(".").pop().toLowerCase(); 
	//"."를 기준으로 문자열로 나눈다. 배열의 마지막 요소를 제거한 후 제거한 요소를 반환하여 소문자로 변환한다.
	
	if($.inArray(ext, ["gif", "jpg", "jpeg", "png", "bmp"]) == -1){ //요소가 없을 경우 -1을 반환 
		$("#chkFile").html("gif, jpg, jpeg, png, bmp 파일만 업로드 해주세요.");
		$("#imgFile").val("");
	}else {
		$("#chkFile").html("");
	}
}

$(() => {
	addReview();
	cencelAdd();
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
	display: inline;
}

th {
	background-color: #EFEFEF;
	text-align: center;
	width: 150px;
}

.contentTd {
	height: 350px;
}

textarea {
	width: 1300px;
	height: 300px;
	resize: none;
	padding: 20px;
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
							후기관리 > 등록</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form id="reviewForm" action="addReview" method="post"
						enctype="multipart/form-data">
						<table class='table'>
							<tr>
								<th>제목</th>
								<td><input type='text' style='width: 500px;' id="title"
									name="title" onkeyup="fn_chkByteTitle(this);" /> <span
									id="chkTitle" style="color: red"></span></td>
							</tr>
							<tr>
								<th>이미지</th>
								<td><input type='file' id="imgFile" name="attachFile"
									onchange="fn_chkFile(this)" /> <span id="chkFile"
									style="color: red"></span></td>
							</tr>
							<tr class="contentTd">
								<th>내용</th>
								<td><textarea id="description" name="content"
										maxlength="1250"></textarea> <span id="chkContent"
									style="color: red"></span> <script>
									CKEDITOR.replace("description", {
										removePlugins: "image, blockquote, list",
									});

									CKEDITOR.instances.description.getData();
									
									CKEDITOR.instances.description.on('key', function(e) {
									    content = this;
									    text = content.getData();

									    if(text.length > 1250) {
											$("#chkContent").text("내용은 1250자까지 입력 가능합니다.");
											$("#addReview").attr("disabled", true);

										}else{
											$("#chkContent").text("");
											$("#addReview").attr("disabled", false);
										}
									});
								</script></td>
							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<span id="chkAdd"></span>
							<button type='button' class='btn btn-primary' id="addReview">등록</button>
							&nbsp;
							<button type='button' class='btn btn-default' id="cancelAdd">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>