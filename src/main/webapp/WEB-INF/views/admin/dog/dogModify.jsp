<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Dog Modify</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="//cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
<script src="${path}/ckeditor/ckeditor.js"></script>
<%@ include file="../common/scriptImport.jsp"%>
<script>
$(()=>{
	textEditer();
	
	onTypying();
	
	limitContent();
	
	if('${dog.dogGender}'==='암컷'){ 
		$('#female').attr('checked',true);
	}else{
		$('#male').attr('checked',true);
	}
	
	$('#modifyBtn').click(()=>{
		let dogTitle=$('#dogTitle').val();
		let dogName=$('#dogName').val();
		let dogKind=$('#dogKind').val();
		let dogWeight=$('#dogWeight').val();
		let dogAge=$('#dogAge').val();
		let dogEntranceDate=$('#dogEntranceDate').val();
		let dogGender=$('input[name="dogGender"]:checked').val();
		let dogContent = CKEDITOR.instances.description.getData();
		
		
		if(dogTitle===''){
			$('#modifyTitleMsg').text('제목을 입력해 주세요');
			return false;
		}else if(dogName===''){
			$('#modifyNameMsg').text('이름을 입력해 주세요');
			return false;
		}else if(dogKind===''){
			$('#modifyKindMsg').text('품종을 입력해 주세요');
			return false;
		}else if(dogWeight===''){
			$('#modifyWeightMsg').text('체중을 입력해 주세요');
			return false;
		}else if(dogAge===''){
			$('#modifyAgeMsg').text('나이를 입력해 주세요');
			return false;
		}else if(dogEntranceDate===''){
			$('#modifyEntranceDateMsg').text('입소날짜를 선택해 주세요');
			return false;
		}else if(dogContent===''){
			$('#modifyContentMsg').text('내용을 입력해 주세요');
			return false;
		}else if(dogContent!=''){
			$('#modifyContentMsg').text('');
			
			if($("#attachFile").val() != ""){
				let ext = $('#attachFile').val().split('.').pop().toLowerCase(); //확장자만 추출
				
				if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) { //확장자확인
					$('#modifyAttachMsg').text('gif, png, jpg, jpeg 파일만 첨부할 수 있습니다');
					return false;
				}
			}
		}
	});
});

function onTypying(){
	$('#dogTitle').keyup(()=>{$('#modifyTitleMsg').text(''); });
	$('#dogName').keyup(()=>{$('#modifyNameMsg').text(''); });
	$('#dogKind').keyup(()=>{$('#modifyKindMsg').text(''); });
	$('#dogWeight').keyup(()=>{$('#modifyWeightMsg').text(''); });
	$('#dogWeight').change(()=>{$('#modifyWeightMsg').text(''); });
	$('#dogAge').keyup(()=>{$('#modifyAgeMsg').text(''); });
	$('#dogEntranceDate').change(()=>{$('#modifyEntranceDateMsg').text(''); });
	$('input[name="dogGender"]').change(()=>{$('#modifyGenderMsg').text(''); });
	$('#attachFile').change(()=>{$('#modifyAttachMsg').text(''); });
}

function limitContent(){
	 let editor = CKEDITOR.instances.description;
		editor.on('key', function(e) {
			 content = this;
			    text = content.getData();
			    if(text.length > 1250) {
					$("#modifyContentMsg").text("내용은 1250자까지 입력 가능합니다.");
					$("#modifyBtn").attr("disabled", true);
				}else{
					$("#modifyContentMsg").text("");
					$("#modifyBtn").attr("disabled", false);
				}
		});
}

function maxLengthCheck(object){ //숫자 max값 초과시 제한
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
 }

function textEditer(){
	CKEDITOR.replace('description', {
		removePlugins : 'image'
	});
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

img {
	width: 300px;
	height: auto;
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
	margin: 50px;
	color: #717171;
}

.item {
	width: 640px;
	height: 300px;
	margin: 0 120px 50px 30px;;
	float: left;
}

.th {
	background-color: #EFEFEF;
	width: 100px;
	text-align: center;
}

textarea {
	width: 1000px;
	height: 200px;
	resize: none;
	padding: 15px;
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
				<!-- info 밑으로 화면 구성하면되고 글리피콘 사용할때 id 만들어서 사용해주세요. 안그러면 네비게이션바 글리피콘도 움직여요. -->
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-heart'></span><strong>
							유기견 관리 > 수정</strong>
					</h3>
					<br> <br>

					<form id='form1' method='post' enctype='multipart/form-data'>
						<table class='table'>
							<tr>
								<th class='th'>제목</th>
								<td colspan='3'><input type='text' style='width: 400px;'
									id='dogTitle' name='dogTitle' maxlength=30
									value='${dog.dogTitle}' /><span id='modifyTitleMsg'
									style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>이름</th>
								<td><input type='text' id='dogName' name='dogName'
									maxlength=15 value='${dog.dogName}' /><span id='modifyNameMsg'
									style='color: red'></span></td>
								<th class='th'>품종</th>
								<td><input type='text' id='dogKind' name='dogKind'
									maxlength=15 value='${dog.dogKind}' /><span id='modifyKindMsg'
									style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>체중</th>
								<td><input type='number' style='width: 70px;'
									id='dogWeight' name='dogWeight' min=0 maxlength=3
									oninput="maxLengthCheck(this)" value='${dog.dogWeight}' />
									(kg)<span id='modifyWeightMsg' style='color: red'></span></td>
								<th class='th'>나이</th>
								<td><input type='number' id='dogAge' name='dogAge' min=0
									maxlength=2 oninput="maxLengthCheck(this)"
									value='${dog.dogAge}' /><span id='modifyAgeMsg'
									style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>입소날짜</th>
								<td colspan='3'><input type='date' name='dogEntranceDate'
									id='dogEntranceDate' value='${dog.dogEntranceDate}' /><span
									id='modifyEntranceDateMsg' style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>성별</th>
								<td colspan='3'><input type='radio' name='dogGender'
									id='male' value='수컷' />수컷 &nbsp;&nbsp; <input type='radio'
									name='dogGender' id='female' value='암컷' />암컷<span
									id='modifyGenderMsg' style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>내용</th>
								<td colspan='3'><textarea id='description'
										name='dogContent'>${dog.dogContent}</textarea><span
									id='modifyContentMsg' style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>이미지</th>
								<td colspan='3'><input type='file' id='attachFile'
									name='attachFile' /><span id='modifyAttachMsg'
									style='color: red'></span></td>
							</tr>
							<tr>
								<th class='th'>이전 이미지</th>
								<td colspan='3'><img
									src='../../../attach/dog/${dog.attachName}' /></td>

							</tr>
						</table>

						<div class='button' style='text-align: right;'>
							<button type='submit' class='btn btn-primary' id='modifyBtn'>수정</button>
							<button type='button' class='btn btn-default' id='cancel'
								onClick="location.href='03.html'">취소</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>