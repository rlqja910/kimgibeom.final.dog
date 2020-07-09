<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css">
<script src="../res/adminNavSub.js"></script>
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

let params = {};
window.location.search.replace(/[?&]+([^=&]+)=([^&]*)/gi, function(str, key, value) { params[key] = value; });
if (typeof params.page == 'undefined') params.page = 1;

function managePaging() {
    // active 표시
    $('#pagination').find('a').eq(params.page - (Math.ceil(${pageMaker.endPage} / 5) - 1) * 5)
		.css({'background-color':'#333', color:'#fff'});
    
    // prev 버튼
    if (params.page == 1) {
   		$('#pagination').find('a').first().removeAttr('href');
   	} else { // 1페이지가 아니면 이전 버튼 활성화
   	   $('#pagination').find('a').first().click(function() {
	       let prev = params.page - 1;
	       $(this).attr('href', 'reportListView?page=' + prev);
   	   })
   	}	
    
	// next 버튼
   	if ($('#pagination').find('a').length == 3 || params.page == ${pageMaker.tempEndPage}) {
   		$('#pagination').find('a').last().removeAttr('href');
   	} else if ($('#pagination').find('a').length != 2) { // 마지막 페이지가 아니면 다음 버튼 활성화	
   		$('#pagination').find('a').last().click(function() {
	 		let next = Number(params.page) + 1;
	 	    $(this).attr('href', 'reportListView?page=' + next);
	   	})
   	}
}

function reportList() {
	let date = new Date(); 
	
	$('tbody').empty();
	$('tbody').html(
		`<c:forEach var='report' items='${reports}'>
		<tr>
			<td><input type='checkbox' value=${report.reportNum} name='reportNum'/></td>
			<td>${report.reportNum}</td>
			<td id='userId'>${report.userId}</td>
			<td>
				<a id='detailReport' href='./reportView/${report.reportNum}?page=\${params.page}'>${report.title}</a>
			</td>
			<td>${report.regDate}</td>
		</tr>
		</c:forEach>`)
		
	if ($('tbody').html() == ``) {
		$('#pagination').find('a').each(function() {
			if (params.page > 1) { // 2 이상의 페이지에서 게시물을 모두 삭제한 경우 전 페이지로 이동
				location.href = './reportListView?page=' + (params.page - 1);
			}
		})
		
		$('tbody').html('<tr><td colspan="5">게시글이 없습니다.</td></tr>');
		$('#pagination').find('li').first().after('<li><a href="">1</a></li>');
		$('#pagination').find('a').removeAttr('href');
		$('#pagination').find('a').removeAttr('style');
	}	
}

function reportDel() {
	let delReports = [];
	
	$('#reportDel').click(() => {
		if($('input:checkbox').is(':checked')) {
			jQuery.ajaxSettings.tranditional = true;
			
			$('input:checked').each(function() {
				delReports.push($(this).parent().next().text().trim());
			})
			
			swal({
				title: '',
				text: '신고글을 삭제하시겠습니까?',
				type: 'warning',
				showCancelButton: true,
				confirmButtonText: '확인',
				cancelButtonText: '취소',
				closeOnConfirm: false
			},
			function(isConfirm) {
				if(isConfirm) {
					$.ajax({
						url: 'remove',
						type: 'POST',
						data: {'reportNums': delReports},
						success: () => {
							swal({
								title: '',
								text: '신고글이 삭제되었습니다.',
								type: 'success',
								confirmButtonText: '확인',
								closeOnConfirm: false
							},
							function(isConfirm) {
								if(isConfirm)
									location.href = 'reportListView?page=' + params.page;
							});
						}
					});
				}	
			});
		} else {
			swal({
				title: '',
				text: '항목을 선택하세요.',
				type: 'warning',
				showCancelButton: false,
				confirmButtonText: '확인'
			})			
		}
	});
}

$(()=>{
	reportSearch();
	managePaging();
	reportList();
	reportDel();
	if(${isData}===false){
		swal({
	         title: '',
	         text: '등록된 게시글이 없습니다.',
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

#searchContent {
	float: left;
	margin-left: 10px;
	width: 400px;
	display: inline;
}

#search {
	background: #4b4276;
}

#searchBtn {
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
	width: 60px;
}

.title {
	width: 400px;
}

.date {
	width: 150px;
}

.buttons {
	float: right;
}

#pagination {
	display: block;
	text-align: center;
}

#detailReport {
	text-decoration: none;
	color: #EA3462;
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
						<span class='glyphicon glyphicon-bullhorn'></span> <strong>신고
							게시판 관리</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<form>
						<div class='form-group'>
							<select name="searchType" class='form-control'
								style='width: 100px; height: 35px; float: left;'>
								<option value="userId"
									<c:out value="${scri.searchType eq 'userId' ? 'selected' : ''}"/>>아이디</option>
								<option value="title"
									<c:out value="${scri.searchType eq 'title' ? 'selected' : ''}"/>>제목</option>
							</select> <input id='searchContent' type='text' class='form-control'
								placeholder='검색어를 입력해주세요.' />
							<button type='button' class='btn btn-default' id='search'>
								<span id='searchBtn'>검색</span>
							</button>
						</div>
					</form>
					<br>
					<p>&nbsp;</p>
					<table class='table table-hover'>
						<thead>
							<tr>
								<th>선택</th>
								<th>번호</th>
								<th>아이디</th>
								<th class='title'>제목</th>
								<th class='date'>작성일</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>

					<button type='button' class='btn btn-warning buttons'
						id='reportDel'>삭제</button>

					<br> <br> <br>

					<div id="pagination">
						<ul class="pagination">
							<li><a href=''>&laquo;</a></li>
							<c:forEach begin="${pageMaker.startPage}"
								end="${pageMaker.endPage}" var="idx">
								<li><a href="reportListView${pageMaker.makeSearch(idx)}">${idx}</a></li>
							</c:forEach>
							<li><a href=''>&raquo;</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>