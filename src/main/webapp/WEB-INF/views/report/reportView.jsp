<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core' %>     
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<script src="../res/layoutsub.js"></script>
<%@ include file="../common/scriptImport.jsp"%>
<script>
let params = {}; 
window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
if (typeof params.page == 'undefined')
	params.page = 1;

function delReport() {
	$('#reportDel').click(() => {
		swal({
			title:'',
			text:'게시물을 삭제하시겠습니까?',
			type:'warning', 
			showCancelButton: true,
			confirmButtonText: '확인',
			cancelButtonText: '취소',
			closeOnConfirm: false
		},
		function(isConfirm) {
			if (isConfirm) {
				$.ajax({
					url: '../remove',
					data: {reportNum: $('table').attr('id')},
					success: () => {
						location.href = '../reportListView?page=' + params.page;
					}
				});
			}	
		});
	});
}

function registerReply() {
	let reportNum = $('table').attr('id');

	$('#replyRegister').click(() => {
		let reply = {
			reportNum: reportNum,
			userId: `${userId}`,
			content: $('textarea').val()
		};
		
		if (`${userId}` != '') {
			$.ajax({
				url: '../replyView',
				data: reply,
				success: () => {
					location.reload();
				}
			})
		}
	})
}

function readReply() {
	$('.view').html(
			`<c:forEach var='reply' items='${replies}'>
				<ul class='${reply.userId}'>
					<li>
						${reply.userId} 
						<span>${reply.regDate}</span>
						<span class='replyDel'>
							<input id='${reply.replyNum}' type='button' value='삭제'/>
						</span>
					</li>
					<li style="white-space:pre-wrap;">${reply.content}</li>
				</ul>
			</c:forEach>`
		);
		
		if ($('.view').html() == ``)
			$('.view').html('<div class="viewEmpty">등록된 댓글이 없습니다.</div>')
}

function delReply() {
	$('.replyDel').click(function(e) {
		let replyNo = $(this).children().attr('id');
		
		swal({
			title: '',
			text: '댓글을 삭제하시겠습니까?',
			type: 'warning',
			showCancelButton: true,
			confirmButtonText: '확인',
			cancelButtonText: '취소',
			closeOnConfirm: false
		},
		function(isConfirm) {
			if (isConfirm) {
				$.ajax({
					url: '../removeReply',
					data: {replyNum: replyNo},
					success: () => {
						location.reload();
					}
				});
			}	
		});
	});
}

function checkAuthority() {
	// 글쓴이만 수정, 삭제 가능
	if ($('table').attr('class') != `${userId}`) {
		$('#reportDel').hide();
		$('#reportUpdate').hide();
	}
	
	// 댓글쓴이만 삭제 가능
	$('.view').find('ul').each(function() {
		if ($(this).attr('class') != `${userId}`) 
			$('.replyDel').eq($(this).index()).hide();
	})
	
	// 댓글 등록 시 로그인 안 한 상태이면 로그인 페이지로 이동
	if (!`${userId}`) { 
		$('#replyRegister').attr('onClick', "location.href='../../user/login'");
	}
	
	// 이미지가 없는 글
	$('img').each(function() { 
		if (isFinite($(this).attr('src').split('/').pop()))
			$(this).remove();
	})
	
	// 댓글 bytes 세기
    $('textarea[name="content"]').keyup(function (e) {
        var content = $(this).val();
        $(this).height(((content.split('\n').length + 1) * 1.5) + 'em');
        $('.bytes').html(content.length + '/840');
    });
	$('textarea[name="content"]').keyup();
	
	// 페이징 번호
    $('#reportList').click(() => {
    	location.href = "../reportListView?page=" + params.page;
    })
    
    $('#reportUpdate').click(() => {
    	location.href = "../reportModify/${report.reportNum}?page=" + params.page;
    })
}

$(delReport);
$(registerReply);
$(readReply);
$(delReply);
$(checkAuthority);
</script>
<style>
	/* header */
	.header{width:100%; height:380px; background-color:#ccc; background-image: url('../../attach/banner/banner.jpg'); background-position: center;}
	.header .headerBackground{background:rgba(0, 0, 0, .4); height:380px;}
	
	.subHr{width:45px; margin-top:140px; border:1px solid #f5bf25;}
	.header .subTitle{text-align:center; font-size:42px; color:#fff; margin-top:20px;}
	.contHr{width:45px; margin-top:20px; margin-bottom:60px; border:1px solid #f5bf25;}
	.contTitle{font-size:32px; font-weight:bold; text-align:center;}

	/* 입양후기 */
	.review{width:80%;font-size:14px; margin:0 auto; margin-top:100px; margin-bottom:100px;}
	.review .reportView{width:90%; margin:0 auto;}
	.review .reportView table{width:100%; border-collapse: collapse;}
	.review .reportView table tr{font-size:16px;}
	.review .reportView table tr:nth-child(1){border-top:1px solid #333; border-bottom:1px solid #ccc;}
	.review .reportView table tr{border-bottom:1px solid #ccc;}
	.review .reportView table tr th{background-color:#ccc; width:20%; padding:1% 0;}
	.review .reportView table tr:nth-child(1) td{width:80%; padding:1% 0 1% 2%;}
	.review .reportView table tr:nth-child(2) td{width:5%; padding:1% 0 1% 2%;}
	.review .reportView table tr:nth-child(3) td{padding:2% 0 2% 2%; word-break:break-word;}
	.review .reportView .reportInfo{text-align:right;}
	.review .reportView .marker{background-color:yellow;}
	
	/* 목록 버튼 */
	.button{text-align:center; overflow:hidden;}
	.button input{background-color:#f5bf25; width:70px; height:40px; border:0px; color:#fff; margin-top:30px; }
	.button input:nth-child(1){float:left;}
	.button input:nth-child(2){border:1px solid #ccc; background-color:#fff; color:#666; margin-left:5px;}
	.button input{float:right;}

	/* 댓글 */
	.writeCont{width:100%;}
	.writeCont p{font-size:20px; font-weight:bold; colo:#333;}
	.writeCont .write{border:1px solid #ccc;}
	.writeCont .write textarea{width: 98%; height: 60px; padding:1%; border:0px; font-size: 14px; 
		font-family: "맑은고딕","Malgun Gothic",serif; resize: both;}
	.writeCont .write div{text-align:right;}
	.writeCont .write div div{width:100%; border-top:1px solid #e2e2e2;}
	.writeCont .write div div input{background-color:#f5bf25; width:70px; height:40px; border:0px; color:#fff;}

	.writeCont .view{margin-top:5%; font-size:16px;}
	.writeCont .view ul{border-bottom:1px solid #ccc; padding:2% 0; word-break:break-word;}
	.writeCont .view ul li:nth-child(1){margin-bottom:1%; overflow:hidden;}
	.writeCont .view ul li .replyDel{float:right;}
	.writeCont .view ul li .replyDel input{background-color:#fff; border:1px solid #ccc; color:#666; padding:5px 10px;}
	.writeCont .view ul li span{color:#999;}
	.viewEmpty{text-align:center;}

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

		.writeCont .view{font-size:14px;}
		.writeCont .view ul{border-bottom:1px solid #ccc; padding:4% 0;}
		.writeCont .view ul li:nth-child(1){margin-bottom:2%;}
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
				<div class='reportView'>
					<table id='${report.reportNum}' class='${report.userId}'>
						<tr>
							<th>제목</th>
							<td>${report.title}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${report.userId}</td>
						</tr>													
						<tr>
							<td colspan='2'>
								<div class='reportInfo'>조회 ${report.viewCount} &nbsp;&nbsp;&nbsp;${report.regDate}</div><br><br>
								<img src='<c:url value="/attach/report/${report.attachName}"/>'/>
								<br><br>
								${report.content}
							</td>
						</tr>
					</table>
					
					<!-- 목록 버튼 -->
					<div class='button'>
						<input type='button' value='목록' id='reportList'/>
						<input type='button' value='삭제' id='reportDel'/>
						<input type='button' value='수정' id='reportUpdate'/>
					</div>
					
					<!-- 댓글 -->
					<div class='writeCont'>
						<p>댓글</p>
						<div class='write'>
							<div>
								<textarea name='content' placeholder='댓글을 입력하세요.' maxlength='839'></textarea>
								<div>
									<span class='bytes'></span>
									<input type='button' id='replyRegister' value='등록'/>
								</div>
							</div>
						</div>
						<div class='view'></div>
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