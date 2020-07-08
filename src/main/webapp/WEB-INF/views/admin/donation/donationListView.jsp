<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset='UTF-8'>
<title>ADMIN PAGE</title>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<%@ include file="../common/scriptImport.jsp"%>
<script src="https://code.jquery.com/jquery-1.10.1.js"
	integrity="sha256-663tSdtipgBgyqJXfypOwf9ocmvECGG8Zdl3q+tk+n0="
	crossorigin="anonymous"></script>
<script src="../res/adminNavSub.js"></script>
<script> 
function logoutSe(){
	$('#logoutSe').click(()=>{
		sessionStorage.removeItem('userId');
	});
}

let totalPageCnt = ${totalPageCnt};
let isOnePage = ${isOnePage};
let lastPageDataCnt = ${lastPageDataCnt};
let sponsorsData = null;
let sponsorsCnt = ${sponsorsCnt};


function sponsorList(){
	$('.pagination').append('<li class="li"><a href="#" id="firstViewBtn"><<</a></li>');
	
	for(let i=1; i<=totalPageCnt;i++){
		$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
		if(i==1){
			$('#'+i+'page').attr("style","font-weight:bold;");
		}
	}
	

	$('.pagination').append('<li class="li"><a href="#" id="lastViewBtn">>></a></li>');
	
	$('.list').empty();
	
	if(isOnePage===false){ 					
		let sponsorData = JSON.parse(JSON.stringify(${pageData})); 
		
		for(let i=1; i<=10; i++){ 			
			let date = new Date(sponsorData[i-1].donationDate);
			let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
			
			$('#table').append('<tr class="list"><td>'+ sponsorData[i-1].donationNum +'</td><td>'+ sponsorData[i-1].userId +'</td><td>'+ sponsorData[i-1].userName +'</td><td>'+ donationDate +'</td><td>'+ sponsorData[i-1].price +'</td><td>'+ sponsorData[i-1].userPhone +'</td></tr>')
		} 
		 
	}else if(isOnePage){ 					
		if(sponsorsCnt==0){ 				
			$('.paginations').empty();
			$('.li').hide();
			$('#table').append('<tr class="list"><td colspan="6">등록된 후원자가 없습니다.</td></tr>');
		}else{ 							
			let onlyOnePageData =JSON.parse(JSON.stringify(${onlyOnePageData})); 
			
			for(let i=1; i<=lastPageDataCnt; i++){ 
				let date = new Date(onlyOnePageData[i-1].donationDate);
				let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
				$('#table').append('<tr class="list"><td>'+ onlyOnePageData[i-1].donationNum +'</td><td>'+ onlyOnePageData[i-1].userId +'</td><td>'+ onlyOnePageData[i-1].userName +'</td><td>'+ donationDate +'</td><td>'+ onlyOnePageData[i-1].price +'</td><td>'+ onlyOnePageData[i-1].userPhone +'</td></tr>')
			}
		}
	}
	
	$('#firstViewBtn').click(()=>{
		$('#1page').trigger('click');
		return false;
	});
	
	
	$('#lastViewBtn').click(()=>{
		$('#'+totalPageCnt+'page').trigger('click');
		return false;
	});
	
	for(let i=1; i<=totalPageCnt;i++){
		$('#'+i+'page').click(()=>{ 						
			
			for(let j=1; j<=totalPageCnt; j++){
				$('#'+j+'page').removeAttr('style'); 		
			}
			$('#'+i+'page').attr("style","font-weight:bold;"); 
			
			$('.list').empty(); 						
			
			if(isOnePage){									
				let sponsorData = JSON.parse(JSON.stringify(${onlyOnePageData})); 
				 
				let cnt=0; 
				for(let j=1; j<=lastPageDataCnt; j++){ 
					let date = new Date(sponsorData[(i-1)*10+cnt].donationDate);
					let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
					$('#table').append('<tr class="list"><td>'+ sponsorData[(i-1)*10+cnt].donationNum +'</td>' +
											'<td>'+ sponsorData[(i-1)*10+cnt].userId +'</td>' +
											'<td>'+ sponsorData[(i-1)*10+cnt].userName+ '</td>' +
											'<td>'+ donationDate +'</td>' +
											'<td>'+ sponsorData[(i-1)*10+cnt].price +'</td>'+
											'<td>'+ sponsorData[(i-1)*10+cnt].userPhone +'</td></tr>'
					)
					cnt++;
				} 
				
			}else if(i==totalPageCnt){ 						
				let sponsorData = JSON.parse(JSON.stringify(${pageData}));  
				
				let cnt=0;
				for(let j=1; j<=lastPageDataCnt; j++){		 
					let date = new Date(sponsorData[(i-1)*10+cnt].donationDate);
					let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
					
					$('#table').append('<tr class="list"><td>'+ sponsorData[(i-1)*10+cnt].donationNum +'</td>' +
							'<td>'+ sponsorData[(i-1)*10+cnt].userId +'</td>' +
							'<td>'+ sponsorData[(i-1)*10+cnt].userName+ '</td>' +
							'<td>'+ donationDate +'</td>' +
							'<td>'+ sponsorData[(i-1)*10+cnt].price +'</td>'+
							'<td>'+ sponsorData[(i-1)*10+cnt].userPhone +'</td></tr>'
					)
					cnt++;
				} 
				
			}else{ 												
				let sponsorData = JSON.parse(JSON.stringify(${pageData}));
				
				let cnt=0; 
				for(let j=1; j<=10; j++){ 
					let date = new Date(sponsorData[(i-1)*10+cnt].donationDate);
					let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
					
					$('#table').append('<tr class="list"><td>'+ sponsorData[(i-1)*10+cnt].donationNum +'</td>' +
							'<td>'+ sponsorData[(i-1)*10+cnt].userId +'</td>' +
							'<td>'+ sponsorData[(i-1)*10+cnt].userName+ '</td>' +
							'<td>'+ donationDate +'</td>' +
							'<td>'+ sponsorData[(i-1)*10+cnt].price +'</td>'+
							'<td>'+ sponsorData[(i-1)*10+cnt].userPhone +'</td></tr>'
					)
					cnt++;
				}
			}
			return false;
		});
	}
}


function searchSponsor(){
	$('#search').on('click',()=>{
		let sponsorName = $('#searchSponsor').val().trim();
		
		if(sponsorName){
			$.ajax({
				url: 'searchProc',
				data: {'userName': sponsorName},
				success: (data)=>{
					$('.pagination').empty();
					$('.list').empty();
					
					totalPageCnt = data.totalPageCnt;
					isOnePage = data.isOnePage;
					lastPageDataCnt = data.lastPageDataCnt;
					sponsorData = null;
					sponsorsCnt = data.sponsorsCnt;
					
					$('.pagination').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
					for(let i=1; i<=totalPageCnt; i++){
						$('.pagination').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
						if(i==1){
							$('#'+i+'page').attr("style","font-weight:bold;");
						}
					}
					$('.pagination').append('<li><a href="#" id="lastViewBtn">>></a></li>');
					
					$('.list').empty(); 
					
					if(isOnePage === false){
						sponsorData = data.pageData;
						for(let i=1; i<=10; i++){
							let date = new Date(sponsorData[i-1].donationDate);
							let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
							
							$('#table').append('<tr class="list"><td>'+ sponsorData[i-1].donationNum +'</td><td>'+ sponsorData[i-1].userId +'</td><td>'+ sponsorData[i-1].userName +'</td><td>'+ donationDate +'</td><td>'+ sponsorData[i-1].price +'</td><td>'+ sponsorData[i-1].userPhone +'</td></tr>')
						}
					}
					else if(isOnePage){
						if(sponsorsCnt == 0){
							$('.pagination').empty();
							$('.list').empty();
							$('#table').append('<tr class="list"><td colspan="6">검색된 후원자가 없습니다</td></tr>');
						}
						else{
							let onlyOnePageData = data.onlyOnePageData;
							
							for(let i=1; i<=lastPageDataCnt; i++){ 
								let date = new Date(onlyOnePageData[i-1].donationDate);
								let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
								
								$('#table').append('<tr class="list"><td>'+ onlyOnePageData[i-1].donationNum +'</td><td>'+ onlyOnePageData[i-1].userId  +'</td><td>'+ onlyOnePageData[i-1].userName+'</td><td>'+ donationDate +'</td><td>'+ onlyOnePageData[i-1].price +'</td><td>'+ onlyOnePageData[i-1].userPhone +'</td></tr>')
							}	
						}
					}
					
					$('#firstViewBtn').click(()=>{
						$('#1page').trigger('click');
						return false;
					});
					
					$('#lastViewBtn').click(()=>{
						$('#'+totalPageCnt+'page').trigger('click');
						return false;
					});
					
					for(let i=1; i<=totalPageCnt; i++){
						$('#'+i+'page').click(()=>{
							for(let j=1; j<=totalPageCnt; j++){
								$('#'+j+'page').removeAttr('style');
							}
							$('#'+i+'page').attr("style","font-weight:bold;");
							
							$('.list').empty();
							
							if(isOnePage){
								sponsorData = data.onlyOnePageData;
								
								let cnt = 0;
								for(let j=1; j<=lastPageDataCnt; j++){ 
									let date = new Date(sponsorData[(i-1)*10+cnt].donationDate);
									let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
									
									$('#table').append('<tr class="list"><td>'+ sponsorData[(i-1)*10+cnt].donationNum +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].userId +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].userName+ '</td>' +
															'<td>'+ donationDate +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].price +'</td>'+
															'<td>'+ sponsorData[(i-1)*10+cnt].userPhone +'</td></tr>'
									)
									cnt++;
								} 
							}else if(i==totalPageCnt){
								sponsorData = data.pageData;
								
								let cnt = 0;
								for(let j=1; j<=lastPageDataCnt; j++){ 
									let date = new Date(sponsorData[(i-1)*10+cnt].donationDate);
									let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
									
									$('#table').append('<tr class="list"><td>'+ sponsorData[(i-1)*10+cnt].donationNum +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].userId +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].userName+ '</td>' +
															'<td>'+ donationDate +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].price +'</td>'+
															'<td>'+ sponsorData[(i-1)*10+cnt].userPhone +'</td></tr>'
									)
									cnt++;
								}
								  
							}else{
								sponsorData= data.pageData;
								
								let cnt = 0;
								for(let j=1; j<=10; j++){ 
									let date = new Date(sponsorData[(i-1)*10+cnt].donationDate);
									let donationDate = date.getFullYear()+'-'+ (date.getMonth()+1)+ '-'+ date.getDate();
									
									$('#table').append('<tr class="list"><td>'+ sponsorData[(i-1)*10+cnt].donationNum +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].userId +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].userName+ '</td>' +
															'<td>'+ donationDate +'</td>' +
															'<td>'+ sponsorData[(i-1)*10+cnt].price +'</td>'+
															'<td>'+ sponsorData[(i-1)*10+cnt].userPhone +'</td></tr>'
									)
									cnt++;
								} 
							}
							return false;
						})
					}
					
				},
				error: ()=>swal('검색내용을 찾지 못하였습니다.')
			})
		}else swal('검색어를 입력해주세요'); 
	})
}


function mainList(){
	$('#mainList').click(()=> location.reload())
}

$(()=>{
	logoutSe();
	
	sponsorList();
	searchSponsor();
	mainList();
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
	margin: 50px;
	color: #717171;
}

.item {
	width: 640px;
	height: 160px;
	margin: 0 120px 0 10px;
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

#moneyItem {
	margin-top: -15px;
	margin-left: 450px;
}

#totalPrice, #todayPrice {
	width: 310px;
	height: 170px;
	border: solid #4873AE;
	border-width: 8px 0 0 0;
	border-radius: 3%;
	background: #fff;
	text-align: center;
	float: left;
	margin-top: 25px;
}

#totalPrice {
	margin-right: 20px;
}

.totalPrice, .todayPrice {
	font-size: 20px;
	margin-top: 40px;
}

.num {
	margin: 0 0 10px 0;
	font-size: 30px;
	font-weight: bold;
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
						<span class='glyphicon glyphicon-bank'></span> <strong> <span
							class='glyphicon glyphicon-piggy-bank'></span> 후원금관리
						</strong>
					</h3>
					<hr style='border: 1px solid #a0a0a0;'>

					<div class='item' id='moneyItem'>
						<div class='money'>
							<div class='price' id='totalPrice'>
								<p class='totalPrice'>총 누적 후원금액</p>
								<div id="donaTot" class="num"></div>
							</div>
							<div class='price' id='todayPrice'>
								<p class='todayPrice'>이번달 후원금액</p>
								<div id="donaMon" class="num"></div>
							</div>
						</div>
					</div>
					<br> <br> <br> <br>
					<form>
						<div>
							<button class='form-control'
								style='width: 100px; height: 35px; float: left;'>후원자 명
							</button>
							<div class='form-group' id='content'>
								<input type='text' id='searchSponsor' class='form-control'
									maxlength="10" placeholder='검색어를 입력해주세요.' />
							</div>
							<div class='form-group'>
								<button type='button' class='btn btn-default' id='search'>
									<span id='spanSearch'>검색</span>
								</button>

								<button type='button' class='btn btn-primary'
									style='float: right;' id='mainList'>목록</button>
							</div>
						</div>
						<br>
					</form>

					<table class="table table-hover" id='table'>
						<tr class='title'>
							<th>후원번호</th>
							<th>후원자아이디</th>
							<th>후원자명</th>
							<th>후원날짜</th>
							<th>후원금액</th>
							<th>전화번호</th>
						</tr>

					</table>

					<div id="pagination">
						<ul class="pagination">
						</ul>
					</div>

				</div>
			</div>
		</div>
	</div>
</body>
<script>
	Number.prototype.cf = function() {
		var a = this.toString().split(".");
		a[0] = a[0].replace(/\B(?=(\d{3})+(?!\d))/g, ",");
		return a.join(".");
	}
	String.prototype.cf = function() {
		if (isNaN(this)) {
			return this;
		}
		return Number(this).cf();
	}

	function animateCount1(num) {
		var $el = $("#donaTot");
		$({
			val : 0
		}).animate({
			val : num
		}, {
			duration : 2000,
			step : function() {
				$el.text(Math.floor(this.val).cf() + "원");
			},
			complete : function() {
				$el.text(Math.floor(this.val).cf() + "원");
			}
		});
	}
	function animateCount2(num) {
		var $el = $("#donaMon");
		$({
			val : 0
		}).animate({
			val : num
		}, {
			duration : 3000,
			step : function() {
				$el.text(Math.floor(this.val).cf() + "원");
			},
			complete : function() {
				$el.text(Math.floor(this.val).cf() + "원");
			}
		});
	}

	$(()=>{
		animateCount1(${donaTot});
		animateCount2(${donaMon});
	});
</script>
</html>