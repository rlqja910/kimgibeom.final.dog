<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function addReply(){
	$("#addRepy").click(() => {
		let content = $("#reply").val().trim();
		let reviewNumStr = ${reviewView.reviewNum};
		let userId = `${userId}`;

		if(userId){
			if(content){
				$.ajax({
					url: "addReply",
					data: {"content": content, "reviewNumStr": reviewNumStr, "userId": userId},
					success: () => {location.reload();}
				});
			}
		}else {
			location.href = "../user/login";
		}
	});
}

function delButton(){
	$(".view").find("ul").each(function() {
		let loginUserId = `${userId}`;
		let replyUserId = $(this).attr("class");

		if(loginUserId != replyUserId) {
			$(".delButton").eq($(this).index()).hide(); //eq로 해당 인덱스에 해당하는 버튼을 찾는다.
		}
	});
}

function delReply(){
	$(".viewDel").click(function(e){
		let replyNumStr = $(this).children().attr("id"); //this를 쓸때는 function을 사용한다.
		
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
					url: "delReply",
					data: {"replyNumStr": replyNumStr},
					success: () => {location.reload();}
				});
			}	
		});
	});
}

function chkContent(){
	$("textarea[name='content']").keyup(function (e) {
	    let content = $(this).val();
	    $('.bytes').html(content.length + '/840');
	});
	$("textarea[name='content']").keyup();
}

function fn_reviewList(page, range){
	let url = "reviewListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	
	location.href = url;
}

$(() => {
	addReply();
	delButton();
	delReply();
	chkContent();
});
</script>
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

.contTitle {
	font-size: 32px;
	font-weight: bold;
	text-align: center;
}

/* 입양후기 */
.review {
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
	margin-top: 100px;
	margin-bottom: 100px;
}

.review .reviewView {
	width: 90%;
	margin: 0 auto;
}

.review .reviewView table {
	width: 100%;
	border-collapse: collapse;
}

.review .reviewView table tr {
	font-size: 16px;
}

.review .reviewView table tr:nth-child(1) {
	border-top: 1px solid #333;
	border-bottom: 1px solid #ccc;
}

.review .reviewView table tr:nth-child(2) {
	border-bottom: 1px solid #ccc;
}

.review .reviewView table tr th {
	background-color: #ccc;
	width: 20%;
	padding: 1% 0;
}

.review .reviewView table tr td {
	width: 80%;
	padding: 1% 0 1% 2%;
}

.review .reviewView table tr:nth-child(2) td {
	padding: 2% 0 2% 2%;
}

/* 목록 버튼 */
.button {
	text-align: right;
}

.button input {
	background-color: #f5bf25;
	width: 70px;
	height: 40px;
	border: 0px;
	color: #fff;
	margin-top: 30px;
}

/* 댓글 */
.writeCont {
	width: 100%;
}

.writeCont p {
	font-size: 20px;
	font-weight: bold;
	color: #333;
}

.writeCont .write {
	border: 1px solid #ccc;
}

.writeCont .write textarea {
	width: 98%;
	height: 60px;
	padding: 1%;
	border: 0px;
	font-size: 14px;
	font-family: "맑은고딕", "Malgun Gothic", serif;
	resize: both;
}

.writeCont .write div {
	text-align: right;
}

.writeCont .write div div {
	width: 100%;
	border-top: 1px solid #e2e2e2;
}

.writeCont .write div div input {
	background-color: #f5bf25;
	width: 70px;
	height: 40px;
	border: 0px;
	color: #fff;
}

.writeCont .view {
	margin-top: 5%;
	font-size: 16px;
}

.writeCont .view ul {
	border-bottom: 1px solid #ccc;
	padding: 2% 0;
}

.writeCont .view ul li:nth-child(1) {
	margin-bottom: 1%;
	overflow: hidden;
}

.writeCont .view ul li .viewDel {
	float: right;
}

.writeCont .view ul li .viewDel input {
	background-color: #fff;
	border: 1px solid #ccc;
	color: #666;
	padding: 5px 10px;
}

.writeCont .view ul li span {
	color: #999;
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
	.contTitle {
		font-size: 28px;
	}
	.review {
		margin-top: 10%;
		margin-bottom: 10%;
	}
	.review .reviewView {
		width: 100%;
	}
	.review .reviewView table tr {
		font-size: 14px;
	}
	.review .reviewView table tr th {
		background-color: #ccc;
		width: 20%;
		padding: 2% 0;
	}
	.button input {
		margin-top: 5%;
	}
	.writeCont .view {
		font-size: 14px;
	}
	.writeCont .view ul {
		border-bottom: 1px solid #ccc;
		padding: 4% 0;
	}
	.writeCont .view ul li:nth-child(1) {
		margin-bottom: 2%;
	}
}

.marker {
	background-color: yellow;
}

p {
	margin-top: 0;
	margin-bottom: 0;
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
				<div class='subTitle'>입양후기</div>
			</div>
		</div>

		<!-- 입양후기 -->
		<div class="content">
			<div class="review">
				<div class='contTitle'>입양후기</div>
				<hr class='contHr'>
				<div class='reviewView'>
					<table>
						<tr>
							<th>제목</th>
							<td>${reviewView.title}</td>
						</tr>
						<tr>
							<td colspan='2'>
								<div>
									<img style="height: 250px; width: 370px;"
										src="<c:url value='/attach/review/${reviewView.attachName}'/>" />
								</div>
								<br>
								<div style="width:1320px; overflow:hidden; word-wrap:break-word;">
									${reviewView.content}
								</div>
							</td>
						</tr>
					</table>

					<!-- 목록 버튼 -->
					<div class='button'>
						<input type='button' value='목록' onclick="fn_reviewList('${page}', '${range}')" />
					</div>

					<!-- 답글 -->
					<div class='writeCont'>
						<p>댓글 ${replySize}</p>
						<br>
						<div class='write'>
							<div>
								<textarea id="reply" name="content" placeholder="댓글을 입력하세요." maxlength="839"></textarea>
								<div>
									<span class='bytes'></span>
									<input id="addRepy" type='button' value='등록' />
								</div>
							</div>
						</div>
						<div class='view'>
							<c:choose>
								<c:when test="${empty replyList}">
									<p style="font-size: 15px;">등록된 댓글이 없습니다.</p>
								</c:when>
								<c:when test="${!empty replyList}">
									<c:forEach var="replyList" items="${replyList}">
										<ul class="${replyList.userId}">
											<li>${replyList.userId}<span>&nbsp;${replyList.regDate}</span>
											<span class='viewDel'> 
												<input id="${replyList.replyNum}" class="delButton" type='button' value='삭제' />
											</span>
											</li>
											<li style="style:100%; white-space:pre-wrap; word-wrap:break-word;">${replyList.content}</li>
										</ul>
									</c:forEach>
								</c:when>
							</c:choose>
						</div>
					</div>
				</div>

				<!-- 페이징 -->

			</div>
		</div>

		<!-- 푸터 -->
		<footer>
			<%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>