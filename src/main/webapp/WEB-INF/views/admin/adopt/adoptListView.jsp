<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../common/scriptImport.jsp"%>
<script>
function complete(){
	$('#complete').click(() => {
		if($('#adoptTable input:checked').val()){
					let isMany=false;
					let end=0;
					for(let i=0; i < $('input[name=adoptCheck]:checked').length; i++){
						let dog = $('#adoptTable input:checked').eq(i).val();
						let dogNum = dog.split('/')[1];
						
						if(i == ($('input[name=adoptCheck]:checked').length)-1){
							break;
						}else{
							for(let j=i+1;j<$('input[name=adoptCheck]:checked').length;j++){
								if(end===1){
									break;
								}
								let dog2 = $('#adoptTable input:checked').eq(j).val();
								let dogNum2 = dog2.split('/')[1];
								
								if(dogNum===dogNum2){
									isMany=true;
									end=1;
									break;
								}
							}
						}
						
						if(end===1){
							break;
						}
					}
					
					if(isMany){
						swal({
							title: '분양완료 실패',
							text: '유기견 한마리에 여러명이 분양완료신청 되었습니다',
							type: 'error',
						});
					}else{
						for(let i=0; i < $('input[name=adoptCheck]:checked').length; i++){
							let dogNumber = $('#adoptTable input:checked').eq(i).val();
							let splitAdoptNumDogNum = dogNumber.split('/');
							
							$.ajax({
								url: 'adoptProc',
								data: {
										'adoptNum':  splitAdoptNumDogNum[0],
										'dogNum':  splitAdoptNumDogNum[1],
								},
								success:()=>{
									swal({
										title: '입양이 완료되었습니다',
										text: '',
										type: 'success',
									},function(){
										location.reload();
									});
								}
							});
						
						} 
					}
		}else{
			swal({
				title: '', 
				text: '항목을 선택해주세요.',
				type:'warning',
			})
		}
	});
}

function exception(){
	  if(${isDataDel}===false) {
		  let pageNo = ${pageNo};
		 if(pageNo !== true){
		  fn_pagination(pageNo, '${pagination.range}', '${pagination.rangeSize}','${search.searchType}');
		 }
	  }
}

function cancel(){
	$('#cancel').click(() => {
		if($('#adoptTable input:checked').val()){
				swal({
					title: '',
					text: '정말 취소하시겠습니까?',
					type: 'warning',
					showCancelButton: true,
					confirmButtonText: '확인',
					cancelButtonText: '취소',
					closeOnConfirm: false
				},
				function(isConfirm) {				
						if(isConfirm) {
							for(let i=0; i < $('input[name=adoptCheck]:checked').length; i++){
								let dogNumber = $('#adoptTable input:checked').eq(i).val();
								let splitAdoptNumDogNum = dogNumber.split('/');
								
							$.ajax({
								url: 'adoptCancel',
								data: {
									'adoptNum':  splitAdoptNumDogNum[0],
								},
								success: () => {
									location.reload();
								}
							});
						}	
					}
				});
		}else{
			swal({
				title: '', 
				text: '삭제할 항목을 선택해주세요.',
				confirmButtonText: '확인',
			})
		}	
	});
}

function selectSort(){
	$('#selectBox').change(()=>{
		let url = "adoptListView";
		
		if($("#selectBox option:selected").val()==='전체'){
			$('#selectBox').val('전체').prop("selected",true);
			sessionStorage.setItem("selectStorage",'전체');
			location.href = url;
		}else if($("#selectBox option:selected").val()==='입양완료'){
			$('#selectBox').val('입양완료').prop("selected",true);
			url = url + "?searchType=입양완료";
			sessionStorage.setItem("selectStorage",'입양완료');
			location.href = url;
		}else if($("#selectBox option:selected").val()==='입양미완료'){
			$('#selectBox').val('입양미완료').prop("selected",true);
			url = url + "?searchType=입양미완료";
			sessionStorage.setItem("selectStorage",'입양미완료');
			location.href = url;
		}	
	})
}

function fn_prev(page, range, rangeSize,searchType){
	page = ((range - 2) * rangeSize) + 1;
	range = range - 1;
	
	let url = "adoptListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&searchType=" + searchType;
	
	location.href = url;
}

function fn_pagination(page, range, rangeSize,searchType){
	let url = "adoptListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&searchType=" + searchType;
	
	location.href = url;
}

function fn_next(page, range, rangeSize,searchType){
	page = parseInt(range * rangeSize) + 1;
	range = parseInt(range) + 1;
	
	let url = "adoptListView";
	url = url + "?page=" + page;
	url = url + "&range=" + range;
	url = url + "&searchType=" + searchType;
	
	location.href = url;
}

$(() => {
	complete();
	cancel();
	exception();
	selectSort();
	
	if(sessionStorage.getItem("selectStorage")==='입양미완료'){
		$('#selectBox').val('입양미완료').prop("selected",true);
	}
	else if(sessionStorage.getItem("selectStorage")==='입양완료'){
		$('#selectBox').val('입양완료').prop("selected",true);
	}
	else if(sessionStorage.getItem("selectStorage")==='전체'){
		$('#selectBox').val('전체').prop("selected",true);
	}
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
	width: 400px;
	display: inline;
}

#search {
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
	width: 100px;
}

.phone_num {
	width: 400px;
}

.state, .date {
	width: 200px;
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
					<a href='<c:url value='/admin/logo/logoRegist'/>'>로고관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='/admin/banner/bannerRegist'/>'>배너관리</a>&nbsp;|&nbsp;
					<a href='<c:url value='/'/>'>홈페이지 돌아가기</a>&nbsp;|&nbsp; <a
						href='<c:url value='/user/logout'/>'>로그아웃</a>
				</div>
			</div>
			<div class='info'>
				<div class='content'>
					<h3>
						<span class='glyphicon glyphicon-calendar'></span> <strong>
							분양관리</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form action='#'>
						<div class='form-group' style='background-color: #eeeeee;'>
							<select class='form-control' id='selectBox'
								style='width: 120px; height: 35px; float: left;'>
								<option>전체</option>
								<option>입양미완료</option>
								<option>입양완료</option>
							</select>
						</div>
					</form>

					<br>
					<p>&nbsp;</p>

					<table class='table table-hover' id='adoptTable'>
						<thead>
							<tr>
								<th>선택</th>
								<th>예약번호</th>
								<th>신청자</th>
								<th>유기견명</th>
								<th>유기번호</th>
								<th class='phone_num'>핸드폰 번호</th>
								<th class='date'>신청일</th>
								<th class='state'>상태</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty adoptList}">
									<tr>
										<td colspan=7>신청된 예약이 없습니다.</td>
									</tr>
								</c:when>
								<c:when test="${!empty adoptList}">
									<c:forEach var="adoptList" items="${adoptList}">
										<tr>
											<c:if test="${adoptList.dog.dogAdoptionStatus=='입양완료'}">
												<td><input type='checkbox' disabled /></td>
											</c:if>
											<c:if test="${adoptList.dog.dogAdoptionStatus=='입양미완료'}">
												<td><input type='checkbox'
													value='${adoptList.adoptNum}/${adoptList.dog.dogNum}'
													name='adoptCheck' /></td>
											</c:if>
											<td>${adoptList.adoptNum}</td>
											<td>${adoptList.user.userName}</td>
											<td>${adoptList.dog.dogName}</td>
											<td>${adoptList.dog.dogNum}</td>
											<td>${adoptList.user.userPhone}</td>
											<td>${fn:substring(adoptList.adoptRegDate,0,10)}</td>
											<td>${adoptList.dog.dogAdoptionStatus}</td>
										</tr>
									</c:forEach>
								</c:when>
							</c:choose>
						</tbody>
					</table>

					<div class='buttons'>
						<button type='button' class='btn btn-primary' id='complete'>분양
							완료</button>
						&nbsp;
						<button type='button' class='btn btn-warning' id='cancel'>분양
							취소</button>
					</div>

					<br> <br> <br>

					<div id="pagination">
						<ul class="pagination">
							<c:if test="${pagination.prev}">
								<li><a href='#'
									onclick="fn_prev('${pagination.page}','${pagination.range}','${pagination.rangeSize}', '${pagination.searchType}')">&laquo;
								</a></li>
							</c:if>

							<c:forEach begin="${pagination.startPage}"
								end="${pagination.endPage}" var="idx">
								<li
									class="<c:out value="${pagination.page == idx ? 'active' : ''}"/>">
									<a href="#"
									onclick="fn_pagination('${idx}','${pagination.range}','${pagination.rangeSize}', '${pagination.searchType}')">${idx}</a>
								</li>
							</c:forEach>

							<c:if test="${pagination.next}">
								<li><a href='#'
									onclick="fn_next('${pagination.page}','${pagination.range}','${pagination.rangeSize}', '${pagination.searchType}')">&raquo;
								</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>