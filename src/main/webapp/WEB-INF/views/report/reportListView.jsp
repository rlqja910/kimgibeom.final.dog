<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<script src="../res/layoutsub.js"></script>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function reportSearch() { 
	$('#searchBtn').click(() => {
		if(!$('#searchContent').val().trim()) {
			swal({ 
				title: '',
				text: '검색어를 입력해주세요.',
				type: 'warning',
				confirmButtonText: '확인'
			})	 
		} else {
			self.location = "reportListView" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + 
			"&keyword=" + encodeURIComponent($('#searchContent').val());
		}
	});
}

function managePaging() {
    // active 표시
	if (params.page == 1 || typeof params.page == 'undefined') { // 첫 페이지
		$('.page').find('a').first().removeAttr('href');
    	$('.page').find('a').eq(1).css({'background-color':'#333', color:'#fff'});
    	
    	if ($('.page').find('a').length == 3) // 첫 페이지가 마지막 페이지인 경우 
    		$('.page').find('a').last().removeAttr('href');
    } else {
    	$('.page').find('a').eq(params.page - (Math.ceil(${pageMaker.endPage} / 5) - 1) * 5)
    		.css({'background-color':'#333', color:'#fff'});
 
    	if (params.page == ${pageMaker.tempEndPage}) // 마지막 페이지
        	$('.page').find('a').last().removeAttr('href');
    }
    
    // prev 버튼
    $('.page').find('a').first().click(function() {
    	let prev = params.page - 1;
    	
    	if (prev > 0) // 1페이지가 아니면 이전 페이지로 이동
    		$(this).attr('href', 'reportListView?page=' + prev);
    })
    
    // next 버튼
    $('.page').find('a').last().click(function() {
    	let next = Number(params.page) + 1;
    	
    	let isNext = true;
    	if ($('.page').find('a').length == 3)
    		isNext = false;
    	
    	if (typeof params.page == 'undefined' && isNext) { // 게시판 첫 진입 시 2페이지로 이동
    		$(this).attr('href', 'reportListView?page=2');
    	} else if (params.page != ${pageMaker.tempEndPage} && isNext) { // 다음 페이지로 이동
    		$(this).attr('href', 'reportListView?page=' + next);
    	}
    }) 
}

let params = {};
window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });

function readReports() {
    if (typeof params.page == 'undefined') params.page = 1;
    
	$('.reportCont').html(
		`<c:forEach var='report' items='${reports}'>
			<a href='./reportView/${report.reportNum}?page=\${params.page}'>
				<ul>
					<li>
						<div style="height:280px; width:99.7%; border:1px solid #ccc;">
							<img src='<c:url value="/attach/report/${report.attachName}"/>'/>
						</div>
					</li>
					<li class='title'>${report.title}</li>
					<li class='contents'>${report.content}</li>
					<li class='more'>+더보기</li>
				</ul>
			</a>
		</c:forEach>`);
	
   // 게시물 내용 스타일 단일화
   $('.contents').each(function() {
       let contents = $(this).text().replace(/<(\/)?([a-zA-Z]*)(\s[a-zA-Z]*=[^>]*)?(\s)*(\/)?>/ig, "")
       $(this).text(contents);
   })
	
	if ($('.reportCont').html() == ``) { // 게시물 없을 때
		$('.reportCont').html('<br><br><br><div class="reportEmpty">등록된 게시글이 없습니다.</div><br>');
	
		$('.page').find('li').first().after('<li><a href="">1</a></li>');
		$('.page').find('a').removeAttr('href');
		$('.page').find('a').removeAttr('style');
	}
	
	$('img').each(function() { // 이미지가 없는 글
		if (isFinite($(this).attr('src').split('/').pop())) {
			$(this).parent().text('이미지 없음');
			$(this).remove();
		}
	})
	
	$('.contents').each(function (idx, content) { // 내용이 30자 이상이면 ... 처리
		if ($(this).text().length >= 31) {
			$(this).text($(this).text().substring(0, 30) + "...");
		}
	})
}

function register() {
	if (`${userId}`) { // 로그인 한 상태이면 등록 페이지로 이동
		$('#register').attr('onClick', "location.href='./reportRegister'");
	} else { // 로그인 안 한 상태이면 로그인 페이지로 이동
		$('#register').attr('onClick', "location.href='../user/login'");
	}
}

$(()=>{
	reportSearch();
	managePaging();
	readReports();
	register();
	
	if(${isData}===false){
		swal({
	         title: '',
	         text: '등록된 게시물이 없습니다.',
	         type: 'warning',
	         confirmButtonText: '확인',
	         closeOnConfirm: false
	      },
	      function(isConfirm){
	         if(isConfirm){
	            let url = "reportListView";
	            url = url +"?isData=" + true;
	            location.href = url;
	         }
	      });
	}
})

</script>
<style>
/* header */
.header {
	width: 100%;
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

/* 유기견 신고 */
.report {
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
	margin-top: 100px;
	margin-bottom: 100px;
}

.report .reportCont {
	width: 100%;
	overflow: hidden;
}

.report .reportCont ul {
	width: 23.5%;
	float: left;
	margin: 1% 0 0 1%;
	border: 1px solid #ccc;
}

.report .reportCont ul img {
	width: 100%;
	height: 100%;
}

.report .reportCont .title {
	font-weight: bold;
	margin: 5% 3% 3% 3%;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.report .reportCont .contents {
	margin: 0 3% 0 3%;
	color: #666;
	font-size: 12px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.report .reportCont P {
	margin-block-start: 0em;
	margin-block-end: 0em;
}

.report .reportCont .more {
	text-align: right;
	margin: 6% 3% 3% 3%;
}

.report .reportCont .reportEmpty {
	text-align: center;
}

.report .reportCont .marker {
	background-color: yellow;
}

/* 검색 */
.report .search {
	width: 100%;
	overflow: hidden;
	padding: 0.3%;
	display: flex;
	margin: 0 auto;
	justify-content: center;
	margin-bottom: 60px;
}

.report .search input {
	float: left;
}

.report .search select {
	float: left;
	width: 80px;
	height: 42px;
	padding: 0 5px 0 5px;
	border: 2px solid #f5bf25;
	border-right: 0px;
}

.report .search input:nth-child(2) {
	border: 2px solid #f5bf25;
	width: 350px;
	height: 36px;
	margin-left: -1px;
	border-left: 0px;
}

.report .search input:nth-child(3) {
	width: 70px;
	height: 42px;
	background-color: #f5bf25;
	border: 0px;
	color: #fff;
}

/* 등록버튼 */
.report .reportBtn {
	text-align: right;
	margin-top: 50px;
}

.report .reportBtn input {
	width: 70px;
	height: 40px;
	background-color: #f5bf25;
	color: #fff;
	border: 0px;
}

/* 페이징 */
.report .page {
	width: 100%;
	margin-top: 70px;
}

.report .page ul {
	display: flex;
	margin: 0 auto;
	justify-content: center;
}

.report .page ul li {
	border: 1px solid #ccc;
}

.report .page ul li a {
	padding: 10px 15px;
}

.report .page ul li a:hover {
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

	/* 검색 */
	.report .search {
		margin-bottom: 10%;
	}

	/* 유기견 신고 */
	.report {
		margin-top: 10%;
		margin-bottom: 10%;
	}
	.report .reportCont ul {
		width: 48%;
	}

	/* 페이징 */
	.report .page {
		width: 100%;
		margin-top: 10%;
	}
	.report .page ul li a {
		padding: 8px 14px;
	}

	/* 등록버튼 */
	.report .reportBtn {
		margin-top: 8%;
	}
}

@media screen and (max-width:540px) {
	.report .page ul li a {
		padding: 6px 12px;
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
				<div class='subTitle'>유기견 신고</div>
			</div>
		</div>

		<!-- 유기견 신고 -->
		<div class="content">
			<div class="report">
				<div class='contTitle'>유기견 신고</div>
				<hr class='contHr'>

				<!-- 검색 -->
				<form>
					<div class='search'>
						<select name="searchType">
							<option value="userId"
								<c:out value="${scri.searchType eq 'userId' ? 'selected' : ''}"/>>아이디</option>
							<option value="title"
								<c:out value="${scri.searchType eq 'title' ? 'selected' : ''}"/>>글제목</option>
						</select> <input id='searchContent' type='text' placeholder=' 검색어를 입력해주세요.' />
						<input id='searchBtn' type='button' value='검색' />
					</div>
				</form>

				<div class='reportCont'></div>

				<!-- 동록버튼 -->
				<div class='reportBtn'>
					<input id='register' type='button' value='등록' />
				</div>

				<!-- 페이징 -->
				<div class='page'>
					<ul>
						<li><a href=''><<</a></li>
						<c:forEach begin="${pageMaker.startPage}"
							end="${pageMaker.endPage}" var="idx">
							<li><a href="${pageMaker.makeSearch(idx)}">${idx}</a></li>
						</c:forEach>
						<li><a href=''>>></a></li>
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