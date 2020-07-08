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
function fn_reviewView(reviewNum, page, range){
   let url = "reviewView";
   url = url + "?reviewNum=" + reviewNum;
   url = url + "&page=" + page;
   url = url + "&range=" + range;
   
   location.href = url;
}

function fn_prev(page, range, rangeSize){
   page = parseInt((range - 2) * rangeSize) + 1;
   range = parseInt(range) - 1;
   
   let url = "reviewListView";
   url = url + "?page=" + page;
   url = url + "&range=" + range;
   
   location.href = url;
}

function fn_pagination(page, range, rangeSize){
   let url = "reviewListView";
   url = url + "?page=" + page;
   url = url + "&range=" + range;
   
   location.href = url;
}

function fn_next(page, range, rangeSize){
   page = parseInt((range * rangeSize)) + 1;
   range = parseInt(range) + 1;
   
   let url = "reviewListView";
   url = url + "?page=" + page;
   url = url + "&range=" + range;
   
   location.href = url;
}

function exception(){
   if(${isData}===false) {
      swal({
         title: '',
         text: '등록된 후기가 없습니다.',
         type: 'warning',
         confirmButtonText: '확인',
         closeOnConfirm: false
      },
      function(isConfirm){
         if(isConfirm){
            let url = "reviewListView";
            url = url +"?isData=" + true;
            location.href = url;
         }
      });
   }
}

$(exception);
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

.review .reviewCont {
	width: 100%;
	overflow: hidden;
}

.review .reviewCont ul {
	width: 23.5%;
	float: left;
	margin: 1% 0 0 1%;
	border: 1px solid #ccc;
}

.review .reviewCont ul li:nth-child(2) {
	font-weight: bold;
	margin: 5% 3% 3% 3%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.review .reviewCont ul li:nth-child(3) {
	margin: 0 3% 0 3%;
	color: #666;
	font-size: 12px;
	overflow: hidden;
	white-space: nowrap;
}

.review .reviewCont ul li:nth-child(4) {
	text-align: right;
	margin: 4% 3% 5% 3%;
}

.review .reviewCont ul img {
	width: 100%;
	height: 100%;
}

/* 페이징 */
.review .page {
	width: 100%;
	margin-top: 70px;
}

.review .page ul {
	display: flex;
	margin: 0 auto;
	justify-content: center;
}

.review .page ul li {
	border: 1px solid #ccc;
}

.review .page ul li a {
	padding: 10px 15px;
}

.review .page ul li a:hover {
	background-color: #333;
	color: #fff;
}

.pagination>.active>a, .pagination>.active>span, .pagination>.active>a:hover,
	.pagination>.active>span:hover, .pagination>.active>a:focus,
	.pagination>.active>span:focus {
	background-color: #333;
	color: #fff;
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
	.review .reviewCont ul {
		width: 48%;
	}
	.review .page {
		width: 100%;
		margin-top: 10%;
	}
	.review .page ul li a {
		padding: 8px 14px;
	}
}

/*에디터 marker클래스*/
.marker {
	background-color: yellow;
}

h1, h2, h3, h4, h5, h6 {
	font-size: 1em;
	border-style: none;
	font-weight: normal;
	display: inline;
}

strong {
	font-weight: normal;
}

big, small {
	font-size: 1em;
}

.review .reviewCont .contents {
	height: 16px;
}

.review .reviewCont .contents br {
	display: none;
}

.review .reviewCont .contents div {
	display: inline;
}

.review .reviewCont .contents hr {
	display: none;
}

.review .reviewCont .contents table {
	display: none;
}

.review .reviewCont .contents ul {
	height: 16px;
	margin-top: 0;
}

.review .reviewCont .contents ol {
	width: 95%;
	height: 16px;
	margin-top: 0;
	padding-left: 0;
}

.review .reviewCont .contents ul li {
	list-style: none;
}

.review .reviewCont .contents ol li {
	list-style: none;
}

.review .reviewCont .contents p {
	margin-block-start: 0em;
	margin-block-end: 0em;
	display: inline;
	width: 214px;
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
				<div class='reviewCont'>
					<c:choose>
						<c:when test="${empty reviewList}">
							<p style="font-size: 15px;">등록된 후기글이 없습니다.</p>
						</c:when>
						<c:when test="${!empty reviewList}">
							<c:forEach var="reviewList" items="${reviewList}">
								<a href='#'
									onclick="fn_reviewView(<c:out value='${reviewList.reviewNum}'/>, '${pagination.page}', '${pagination.range}')">
									<ul>
										<li>
											<div style="height: 280px; width: 100%;">
												<img
													src="<c:url value='/attach/review/${reviewList.attachName}'/>" />
											</div>
										</li>
										<li>${reviewList.title}</li>
										<li class="contents">${reviewList.content}</li>
										<li>+더보기</li>
									</ul>
								</a>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>

				<!-- 페이징 -->
				<div class='page'>
					<ul class="pagination">
						<c:if test="${pagination.prev}">
							<li><a href='#'
								onclick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">
									&laquo; </a></li>
						</c:if>

						<c:forEach begin="${pagination.startPage}"
							end="${pagination.endPage}" var="idx">
							<li
								class="<c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
								<a href="#"
								onclick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')">
									${idx} </a>
							</li>
						</c:forEach>

						<c:if test="${pagination.next}">
							<li><a href='#'
								onclick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">
									&raquo; </a></li>
						</c:if>
					</ul>
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