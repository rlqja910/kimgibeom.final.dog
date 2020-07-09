<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>Dog Manage</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script>
function addReview(){
	$("#addReview").click(() => {
		location.href = "reviewRegist";
	});
}

function delReview(){
	$("#deleteReview").click(() => {
		let checkNums = []; 
		$("input[name='checkNum']:checked").each(function() {
			checkNums.push($(this).val());	
		});
		
		if($("input[name='checkNum']:checked").val()) {
			swal({
				title: '',
				text: '정말 후기를 삭제하시겠습니까?',
				type: 'warning',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				closeOnConfirm: false
			},
			function(isConfirm) {
				if(isConfirm) {
					$.ajax({
						url: "deleteReview",
						data: {"checkNums": checkNums},
						success: (isDel) => {
							if(isDel){
								swal({
									title: '',
									text: '후기가 삭제되었습니다.',
									type: 'success',
									confirmButtonText: '확인',
									closeOnConfirm: false
								},
								function(isConfirm){
									if(isConfirm) location.reload();
								});
							}
						}
					});
				}
			});
		}else {
			swal({
				 title: '',
				 text: '항목을 선택하세요.',
				 type: 'warning',
				 confirmButtonText: '확인',
				 closeOnConfirm: false
	  		});
		}
	});
}

function fn_reviewView(reviewNum, page, range){
	let url = "reviewView";
	url = url + "?reviewNum=" + reviewNum;
	url = url + "&page=" + page;
	url = url + "&range=" + range;

	location.href = url;
}

function searchReview(){
	$("#search").click(() => {
		let url = "reviewListView";
		url = url + "?searchType=" + $("#searchType").val();
		url = url + "&keyword=" + $("#keyword").val();
		
		location.href = url;
	});
}

function fn_prev(page, range, rangeSize, keyword, searchType){
	page = ((range - 2) * rangeSize) + 1;
	range = range - 1;
	
	let url = "reviewListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&searchType=" + searchType;
	url = url + "&keyword=" + keyword;
	
	location.href = url;
	
}

function fn_pagination(page, range, rangeSize, keyword, searchType){
	let url = "reviewListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&searchType=" + searchType;
	url = url + "&keyword=" + keyword;
	
	location.href = url;
}

function fn_next(page, range, rangeSize, keyword, searchType){
	page = parseInt(range * rangeSize) + 1;
	range = parseInt(range) + 1;
	
	let url = "reviewListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&searchType=" + searchType;
	url = url + "&keyword=" + keyword;
	
	location.href = url;
}

function exception1(){
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

function exception2(){
   if(${isDataDel}===false) {
	   let pageNo = ${pageNo};
	  if(pageNo !== true){
		  fn_pagination(pageNo, '${pagination.range}', '${pagination.rangeSize}', '${search.keyword}', '${search.searchType}');
	  }
   }
}

$(() => {	
	addReview();
	delReview();
	searchReview();
	exception1();
	exception2();
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
	overflow: hidden;
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

/*------- 검색창 테두리-------- */
#inputBackground {
	height: 50px;
	padding: 7px;
	margin-bottom: 30px;
}

/*------- 이미지 체크박스-------- */
.reviewCheck {
	border: 2px solid black;
	width: 25px;
	height: 25px;
	position: relative;
	top: -259px;
	left: -178px;
}

/*------- 모든 이미지후기-------- */
.totalReview {
	display: flex;
	flex-flow: wrap;
	margin-left: 0;
}

/*------- imgbox(이미지+제목)-------- */
.imgbox {
	margin: 0 20px 20px 0;
	text-align: center;
}

.img {
	width: 370px;
	height: 250px;
	text-align: center;
	margin-bottom: 5px;
	background-color: white;
	margin-right: 10px;
}

img {
	width: 370px;
	height: 250px;
}

.button {
	text-align: right;
	margin-right: 40px;
}

#content {
	float: left;
	margin-left: 10px;
	width: 490px;
	display: inline;
}

#search {
	background: #4b4276;
}

#spanSearch {
	color: #fff;
}

#pagination {
	display: block;
	text-align: center;
}

.titleBox {
	width: 350px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
	margin-top: -30px;
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
						<span class='glyphicon glyphicon-list'></span><strong>
							후기관리</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0; width: 1570px;'>

					<form>
						<div>
							<button class='form-control' style='width: 100px; height: 35px; float: left;' id="searchType" name='searchType' value="제목">제목</button>
							<div class='form-group' id='content'>
								<input type='text' id='keyword' name='keyword' class='form-control' placeholder='검색어를 입력해주세요.' />
							</div>
							<div class='form-group'>
								<button type='button' class='btn btn-default' id='search'>
									<span id='spanSearch'>검색</span>
								</button>
							</div>
						</div>
						<br>

						<c:choose>
							<c:when test="${empty reviewList}">
								<p>등록된 후기글이 없습니다.</p>
							</c:when>
							<c:when test="${!empty reviewList}">
								<div class="totalReview">
									<c:forEach var="reviewList" items="${reviewList}">
										<div class="imgbox">
											<a href='#'
												onclick="fn_reviewView('${reviewList.reviewNum}', '${pagination.page}', '${pagination.range}')">
												<div class='img'>
													<div>
														<img src="<c:url value='/attach/review/${reviewList.attachName}'/>" />
													</div>
												</div>
											</a> <input type="checkbox" class="reviewCheck" name="checkNum"
												value='${reviewList.reviewNum}' />
											<div class="titleBox">
												<strong><c:out value="${reviewList.title}" /></strong>
											</div>
										</div>
									</c:forEach>
								</div>
							</c:when>
						</c:choose>

						<div class='button'>
							<button type='button' class='btn btn-primary' id="addReview">등록</button>
							<button type='button' class='btn btn-warning' id="deleteReview">삭제</button>
						</div>
					</form>
					<br>

					<div id="pagination">
						<ul class="pagination">
							<c:if test="${pagination.prev}">
								<li>
									<a href='#' onclick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}',
																 '${search.keyword}', '${search.searchType}')">
										&laquo;
									</a>
								</li>
							</c:if>
							
							<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">		
						    	<li class="<c:out value="${pagination.page == idx ? 'active' : ''}"/> ">
						    		<a href="#" id="${idx}" onclick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}',
						    							  			   '${search.keyword}', '${search.searchType}')">
						    			${idx}
						    		</a>
						    	</li>
							</c:forEach>
						    	
						    <c:if test="${pagination.next}">
						        <li>
						        	<a href='#' onclick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}',
						        								 '${search.keyword}', '${search.searchType}')">
						        		&raquo;
						        	</a>
						        </li>
						    </c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>