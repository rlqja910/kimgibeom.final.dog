<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<script src="../res/layoutsub.js"></script>
<script src="//cdn.ckeditor.com/4.14.0/standard/ckeditor.js"></script>
<script src="${path}/ckeditor/ckeditor.js"></script>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function validateReport() {  // 수정 버튼 누르기 전 검증
	// 제목 글자수 검증
	$('input[name="title"]').keydown(() => {
		if($('input[name="title"]').val().length >= 30) {
			$('font').eq(0).text(' 제목은 최대 30자 입력 가능합니다.');
		} else $('font').eq(0).text('');
	});
	
	// 내용 글자수 검증
	CKEDITOR.replace('description', {
		removePlugins : 'image'
	});	
	
	let editor = CKEDITOR.instances.description;
	
	editor.on('key', function(e) {
	    content = this;
		if(content.getData().length > 1300) {
			$('font').eq(1).text(' 내용은 최대 1250자 입력 가능합니다.');
			$('#modify').attr('disabled', true);
		} else {
			$('font').eq(1).text('');
			$('#modify').removeAttr('disabled');
		}
	});
}

function modifyReport() {
    let params = {}; 
    window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
	
	$('input[name="attachFile"]').click(() => {
		$('font').eq(2).text('');
		
		// 이미지 파일 변경 시 기존 이미지명과 파일 제거
		$.ajax({
			url: 'reportModify',
			method: 'post',
			error: () => {
				$('img').parent().remove();
			}
		})
	})
	
	$('#modify').click(() => {
		let content = CKEDITOR.instances.description.getData();
		let isSubmit = false;
		
	    if ($('input[name="attachFile"]').val()) {
	      	let ext = $('input[name="attachFile"]').val().split('.').pop().toLowerCase();
	      	if ($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
				$('input[name="attachFile"]').val('');
				$('font').eq(2).text('gif, png, jpg, jpeg 파일만 첨부할 수 있습니다.');
		  	} else isSubmit = true;
	    } else isSubmit = true;
		
		if($('input[name="title"]').val().trim()) {
			if (content && content.trim()) {
				if (isSubmit) {
					swal({
						title:'',
						text:'게시물이 수정되었습니다.',
						type:'success',
						confirmButtonText: '확인',
						closeOnConfirm: false
					},
					function(isConfirm) {
						if(isConfirm) {
							$('form').attr('action', '../reportModify?page=' + params.page);
							$('form').submit();
						}	
					});
				}
			} else swal('', '내용을 입력하세요.', 'warning');
		} else 	{	
			swal({
				title:'',
				text:'제목을 입력하세요.',
				type:'warning',
				confirmButtonText:'확인'
			});
		}	
	})
}

$(validateReport);
$(modifyReport);
</script>
<style>
	/* header */
	.header{width:100%; height:380px; background-color:#ccc; background-image: url('../attach/banner/banner.jpg'); background-position: center;}
	.header .headerBackground{background:rgba(0, 0, 0, .4); height:380px;}
	
	.subHr{width:45px; margin-top:140px; border:1px solid #f5bf25;}
	.header .subTitle{text-align:center; font-size:42px; color:#fff; margin-top:20px;}
	.contHr{width:45px; margin-top:20px; margin-bottom:60px; border:1px solid #f5bf25;}
	.contTitle{font-size:32px; font-weight:bold; text-align:center;}

	/* 유기견 신고 */
	.review{width:80%;font-size:14px; margin:0 auto; margin-top:100px; margin-bottom:100px;}
	.review .reportWrite{width:90%; margin:0 auto;}
	.review .reportWrite table{width:100%; border-collapse: collapse;}
	.review .reportWrite table tr{font-size:16px;}
	.review .reportWrite table tr:nth-child(1){border-top:1px solid #333; border-bottom:1px solid #ccc;}
	.review .reportWrite table tr:nth-child(2){border-bottom:1px solid #ccc;}
	.review .reportWrite table tr:nth-child(3){border-bottom:1px solid #ccc;}
	.review .reportWrite table tr th{background-color:#ccc; width:20%; padding:1% 0;}
	.review .reportWrite table tr td{width:80%; padding:1% 0 1% 2%;}
	.review .reportWrite table tr:nth-child(2) td{padding:1% 0 1% 2%;}
	.review .reportWrite table tr:nth-child(1) input{width:70%; height:30px; border:1px solid #999;}
	.review .reportWrite table tr:nth-child(2) textarea{width:95%; height:250px; border:1px solid #999;}
	
	/* 등록, 취소버튼 */
	.button{text-align:center;}
	.button input{background-color:#f5bf25; width:70px; height:40px; border:0px; color:#fff; margin-top:30px;}
	.button input:nth-child(2){background-color:#fff; color:#666; border:1px solid #ccc;}

	/* 모바일 스타일 */
	@media screen and (max-width:768px){
		.subHr{margin-top:20%;}
		.contHr{margin-top:5%; margin-bottom:10%;}

		.header .subTitle{font-size:36px; margin-top:0; padding-bottom:5%;}
		.contTitle{font-size:28px;}
		
		.review{margin-top:10%; margin-bottom:10%;}
		.review .reviewView{width:100%;}
		.review .reviewView table tr{font-size:14px;}
		.review .reviewView table tr th{background-color:#ccc; width:20%; padding:2% 0;}

		.button input{margin-top:5%;}
		
		/* 유기견 신고 */
		.review .reportWrite table tr:nth-child(1) input{width:95%;}
		.review .reportWrite table tr td{width:80%; padding:2% 0 2% 2%;}
		.review .reportWrite table tr:nth-child(2) td{padding:2% 0 2% 2%;}
		.review .reportWrite table tr:nth-child(2) textarea{width:95%; height:200px; border:1px solid #999;}
	}
</style>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
				<header>
					<%@ include file="../common/header.jsp" %>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>유기견 신고</div>
			</div>
		</div>
		
		<!-- 유기견 신고 -->
		<div class="content">
			<div class="review">
				<div class='contTitle'>유기견 신고</div>
				<hr class='contHr'>
				<div class='reportWrite'>
					<form method='post' enctype='multipart/form-data'>
						<table>
							<tr>
								<th>제목</th>
								<td>
									<input type='text' name='title' value='${report.title}' maxlength='30' required/>
									<font color='red'></font>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<textarea name='content' id="description" required>${report.content}</textarea>
									<font color='red'></font> 
									<input type='hidden' name='reportNum' value='${report.reportNum}'/>
								</td>
							</tr>
							<tr>
								<th>이미지</th>
								<td>
									<input type='file' name='attachFile'/>
									<input type='hidden' name='attachName' value='${report.attachName}'/>
									<div>
										<br>
										<img src='<c:url value="/attach/report/${report.attachName}"/>' width='10%' height='10%'/>
										<span>${report.attachName}</span>
									</div>	
									<font color='red'></font>
								</td>
							</tr>
						</table>
					
						<!-- 목록 버튼 -->
						<div class='button'>
							<input type='button' id='modify' value='수정'/>
							<input type='button' value='취소' onClick='history.go(-1)'/>
						</div>
					</form>	
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