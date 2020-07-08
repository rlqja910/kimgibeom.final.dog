<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<%@ include file="../common/scriptImport.jsp" %>
<script>
$(() => {
	$('#complete').click(() => {
		if($('input:checkbox').is(':checked')) {
			swal({
				title: '',
				text: '분양을 완료하시겠습니까?',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				closeOnConfirm: false
			})
		}
	});
	
	$('#cancel').click(() => {
		if($('input:checkbox').is(':checked')) {
			swal({
				title: '',
				text: '분양을 취소하시겠습니까?',
				type: 'warning',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				closeOnConfirm: false
			})
		}
	});
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
	border-bottom: 1px solid rgba(0,0,0,0.05);
	border-top: 1px solid rgba(225,225,225,0.05);
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

#leftNav .main_content .header .border{
	font-size: 19px;
}

#leftNav .main_content .header #topButton {
	text-decoration: none;
	margin-top: 4px;
	margin-right: 20px;
	float: right;
}

#leftNav .main_content .header #topButton a{
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

tr > th {
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

.buttons{
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
					<a href='<c:url value='/'/>'>홈페이지 돌아가기</a>&nbsp;|&nbsp; 
					<a href='<c:url value='/user/logout'/>'>로그아웃</a>
			</div>
		</div>
		<div class='info'>
			<div class='content'>
				<h3>
					<span class='glyphicon glyphicon-calendar'></span>
					<strong> 분양관리</strong>
				</h3>
				<hr style='border: 1px solid #a0a0a0;'>
			
				<form action='#'>
					<div class='form-group' style='background-color:#eeeeee;'>
						<select class='form-control' style='width: 120px; height: 35px; float:left;'>
							<option>분양 미완료</option>
							<option>분양 완료</option>
						</select>
					</div>		
				</form>
				
				<br>
				<p>&nbsp;</p>
				
				<table class='table table-hover'>
					<thead>
						<tr>
							<th>선택</th>
							<th>번호</th>
							<th>이름</th>
							<th class='phone_num'>핸드폰 번호</th>
							<th class='date'>신청일</th>
							<th class='state'>상태</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type='checkbox'/></td>
							<td>123</td>
							<td>김소현</td>
							<td>010-3534-8984</td>
							<td>2016-06-02</td>
							<td>입양 미완료</td>
						</tr>
						<tr>
							<td><input type='checkbox'/></td>
							<td>122</td>
							<td>김아림</td>
							<td>010-9844-4548</td>
							<td>2016-06-02</td>
							<td>입양 미완료</td>
						</tr>				
					</tbody>
				</table>	
					
				<div class='buttons'>
					<button type='button' class='btn btn-primary' id='complete'>분양 완료</button>&nbsp;
					<button type='button' class='btn btn-warning' id='cancel'>분양 취소</button>
				</div>	
				
				<br><br><br>
					
				<div id="pagination">
					<ul class="pagination">
					    <li><a href="#">&laquo;</a></li>
					    <li><a href="#">1</a></li>
					    <li><a href="#">2</a></li>
					    <li><a href="#">3</a></li>
					    <li><a href="#">4</a></li>
					    <li><a href="#">5</a></li>
					    <li><a href="#">&raquo;</a></li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
</body>
</html>