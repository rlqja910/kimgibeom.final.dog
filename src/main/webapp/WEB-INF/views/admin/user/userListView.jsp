<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../common/scriptImport.jsp"%>
<script>
function userDel(){
	let params = {};
	window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
	if (typeof params.page == 'undefined')
		params.page = 1;
	
	let delUsers = [];
	
	$('#delete').click(() => {
		if($('input:checkbox').is(':checked')) {
			jQuery.ajaxSettings.tranditional = true;
			
			$('input:checked').each(function() {
				delUsers.push($(this).parent().next().text().trim());
			})
			
			swal({
				title: '회원 삭제',
				text: '회원을 삭제하시겠습니까?',
				type: 'warning',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				closeOnConfirm: false
			},
			function(isConfirm) {
				if(isConfirm) {
					$.ajax({
						url: 'userDel',
						type: 'POST',
						data: {'userIds': delUsers},
						success: () => {
							swal({
								title: '',
								text: '회원이 삭제되었습니다.',
								type: 'success',
								confirmButtonText: '확인'
							},
							function(isConfirm) {
								if(isConfirm) 
									location.href = 'userListView?page=' + params.page;
							});
						}
					})
				}
			});
		}
	});
}

function userSearch(){
	$('#searchType').click(() => {
		let url = "userListView";
		url = url + "?searchType=" + $("select option:selected").val();
		url = url + "&keyword=" + $("#keyword").val();
		
		location.href = url;	
	});
}

function fn_prev(page, range, rangeSize, keyword, searchType){
	page = ((range - 2) * rangeSize) + 1;
	range = range - 1;
	
	let url = "userListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&keyword=" + keyword;
	url = url + "&searchType=" + $("#searchType").val();
	
	location.href = url;
}

function fn_pagination(page, range, rangeSize, keyword, searchType){
	let url = "userListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&keyword=" + keyword;
	url = url + "&searchType=" + $("#searchType").val();
	
	location.href = url;
}

function fn_next(page, range, rangeSize, keyword, searchType){
	page = parseInt(range * rangeSize) + 1;
	range = parseInt(range) + 1;
	
	let url = "userListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&keyword=" + keyword;
	url = url + "&searchType=" + $("#searchType").val();
	
	location.href = url;
}

$(userDel);
$(userSearch);
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

#searchType {
	background: #4b4276;
}

#spanSearch {
	color: #fff;
}

tr>th {
	background: #dbd9e3;
}

th, td {
	text-align: center;
}

th {
	color: #4b4276;
}

.buttons {
	float: right;
}

#pagination {
	display: block;
	text-align: center;
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
						<span class='glyphicon glyphicon-user'></span><strong>
							회원관리</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form action='#'>
						<div class='form-group'>
							<select class='form-control'
								style='width: 100px; height: 35px; float: left;'>
								<option value="userId">아이디</option>
								<option value="userName">이름</option>
							</select>
						</div>
						<div class='form-group' id='content'>
							<input type='text' id='keyword' class='form-control'
								placeholder='검색어를 입력해주세요.' />
						</div>
						<div class='form-group'>
							<button type='button' class='btn btn-default' id='searchType'>
								<span id='spanSearch'>검색</span>
							</button>
						</div>
					</form>
					<br>
					<table class='table table-hover'>
						<thead>
							<tr>
								<th>선택</th>
								<th>아이디</th>
								<th>이름</th>
								<th>전화번호</th>
								<th>이메일</th>
								<th>가입일</th>
								<th>수정</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty userList}">
									<tr>
										<td colspan="7">등록된 회원이 없습니다.</td>
									<tr>
								</c:when>
								<c:when test="${!empty userList}">
									<c:forEach var="userList" items="${userList}">
										<tr>
											<td><input type='checkbox' /></td>
											<td>${userList.userId}</td>
											<td>${userList.userName}</td>
											<td>${userList.userPhone}</td>
											<td>${userList.userEmail}</td>
											<td>${userList.regDate}</td>
											<td>
												<button type='button' class='btn btn-default btn-xs'>
													<a href='03.html'><span class='glyphicon glyphicon-pencil'></span></a>
												</button>
											</td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>

					<div class='buttons'>
						<button type='button' class='btn btn-primary' id='add'
							onClick="location.href='02.html'">등록</button>
						&nbsp;
						<button type='button' class='btn btn-warning' id='delete'>삭제</button>
					</div>

					<br>
					<br>
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
						    		<a href="#" onclick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}',
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