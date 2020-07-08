<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>

<script type='text/javascript'>
let totalPageCnt=${totalPageCnt};
let isOnePage=${isOnePage};
let lastPageDataCnt=${lastPageDataCnt};
let dogsData=null;
let dogsCnt=${dogsCnt};

	$(()=>{
		if(${isData}===false){
			swal({
		         title: '',
		         text: '등록된 유기견이 없습니다.',
		         type: 'warning',
		         confirmButtonText: '확인',
		         closeOnConfirm: false
		      },
		      function(isConfirm){
		         if(isConfirm){
		            let url = "dogListView";
		            url = url +"?isData=" + true;
		            location.href = url;
		         }
		      });
		}
		dogList();
		
		$('#searchDogBtn').click(()=>{
				let dogKind = $('#dogKind').val();
				let dogEntDate = $('#dogEntDate').val();
				
				if(dogKind==='' && dogEntDate===''){ //아무것도 입력안하면 리스트 전체 출력
					$('#pagingUl').empty();
					$('#dogPost').empty();
					totalPageCnt=${totalPageCnt};
					isOnePage=${isOnePage};
					lastPageDataCnt=${lastPageDataCnt};
					dogsData=null;
					dogsCnt=${dogsCnt};
					dogList();
				}else{
					if(dogEntDate===''){
						dogEntDate='1111-11-11';
					}
					$.ajax({
						url:'dogSearch',
						data:{
							'dogKind':dogKind,
							'dogEntDate':dogEntDate,
						},
						success:(data)=>{  
							$('#pagingUl').empty();
							$('#dogPost').empty();
							
							totalPageCnt=data.totalPageCnt;
							isOnePage=data.isOnePage;
							lastPageDataCnt=data.lastPageDataCnt;
							dogsData=null;
							dogsCnt=data.dogsCnt;
							
							$('#pagingUl').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
							for(let i=1; i<=totalPageCnt;i++){
								$('#pagingUl').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
								if(i==1){
									$('#'+i+'page').attr("style","font-weight:bold;");
								}
							}
							$('#pagingUl').append('<li><a href="#" id="lastViewBtn">>></a></li>');
							
							$('.reviewCont').empty();
							
							if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
								dogsData=data.pageData; //controller에서 뽑은 데이터들을 준비한다.
								
								for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
									let contentStr=dogsData[i-1].dogContent.replace(/<p>/gi,' ');
									$('#dogPost').append('<a href="../dog/dogView/'+dogsData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[i-1].attachName+'" />" /></li><li>'+dogsData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
								}
								
							}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
								if(dogsCnt==0){ //아예 데이터가 없을때
									$('#pagingUl').empty();
									$('#dogPost').append('<div>검색된 유기견이 없습니다.</div>');
								}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
									let onlyOnePageData=data.onlyOnePageData;
									
									for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
										let contentStr=onlyOnePageData[i-1].dogContent.replace(/<p>/gi,' ');
										$('#dogPost').append('<a href="../dog/dogView/'+onlyOnePageData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+onlyOnePageData[i-1].attachName+'" />" /></li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
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
								$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
									for(let j=1; j<=totalPageCnt; j++){
										$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
									}
									$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
									
									$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
									
									if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
										dogsData=data.onlyOnePageData;
										
										let cnt=0;
										for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
											let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
											$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
									}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
										dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
										
										let cnt=0;
										for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
											let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
											$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
										
									}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
										dogsData=data.pageData; //그리고 Controller에서 불러온 데이터를 준비한다.
										
										let cnt=0;
										for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
											let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
											$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
											cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
										}
									}
									
									return false;
								});
							}
							
						},error: function (xhr, ajaxOptions, thrownError) {
		                }
					});
				}
		});
	});
	
	function dogList(){
		$('#pagingUl').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
		for(let i=1; i<=totalPageCnt;i++){
			$('#pagingUl').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
			if(i==1){
				$('#'+i+'page').attr("style","font-weight:bold;");
			}
		}
		$('#pagingUl').append('<li><a href="#" id="lastViewBtn">>></a></li>');
		
		$('.reviewCont').empty();
		
		if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
			dogsData=${pageData}; //controller에서 뽑은 데이터들을 준비한다.
			
			for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다.
				let contentStr=dogsData[i-1].dogContent.replace(/<p>/gi,' '); 
				$('#dogPost').append('<a href="../dog/dogView/'+dogsData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[i-1].attachName+'" />" /></li><li>'+dogsData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
			}
			
		}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
			if(dogsCnt==0){ //아예 데이터가 없을때
				$('#pagingUl').empty();
				$('#dogPost').append('<div>등록된 유기견이 없습니다.</div>');
			}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
				let onlyOnePageData=${onlyOnePageData};
				
				for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력
					let contentStr=onlyOnePageData[i-1].dogContent.replace(/<p>/gi,' ');
					$('#dogPost').append('<a href="../dog/dogView/'+onlyOnePageData[i-1].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+onlyOnePageData[i-1].attachName+'" />" /></li><li>'+onlyOnePageData[i-1].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
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
			$('#'+i+'page').click(()=>{ //페이지 버튼 클릭시 발동
				for(let j=1; j<=totalPageCnt; j++){
					$('#'+j+'page').removeAttr('style'); //페이지 눌렀을때 스타일을 지웠다가 해당 페이지에 입힌다.
				}
				$('#'+i+'page').attr("style","font-weight:bold;"); //클릭한 페이지 번호 글씨체를 굵게 한다.
				
				$('#dogPost').empty(); //리스트를 완전히 다 없앤다.
				
				if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
					dogsData=${onlyOnePageData};
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
						$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
					dogsData=${pageData}; //그리고 Controller에서 불러온 데이터를 준비한다.
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
						$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
					
				}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
					dogsData=${pageData}; //그리고 Controller에서 불러온 데이터를 준비한다.
					
					let cnt=0;
					for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
						let contentStr=dogsData[(i-1)*8+cnt].dogContent.replace(/<p>/gi,' ');
						$('#dogPost').append('<a href="../dog/dogView/'+dogsData[(i-1)*8+cnt].dogNum+'"><ul><li><img src="<c:url value="/attach/dog/'+dogsData[(i-1)*8+cnt].attachName+'" />" /></li><li>'+dogsData[(i-1)*8+cnt].dogTitle+'</li><li>'+contentStr+'</li><li>+더보기</li></ul></a>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}
				
				return false;
			});
		}
	}
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

.marker {
	background-color: yellow;
}

p {
	margin-top: 0;
	margin-bottom: 0;
	float: left;
}

h1, h2, h3, h4, h5, h6 {
	font-size: 1em;
	border-style: none;
	font-weight: normal;
}

strong {
	font-weight: normal;
}

big, small {
	font-size: 1em;
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
	font-size: 14px;
	margin-top: 100px;
	margin-bottom: 100px;
}

.report .reviewCont {
	overflow: hidden;
	margin: 7%;
}

.report .reviewCont div {
	text-align: center;
}

.report .reviewCont ul {
	width: 23.5%;
	float: left;
	margin: 1% 0 0 1%;
	border: 1px solid #ccc;
	height: 470px;
}

.report .reviewCont li {
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.report .reviewCont ul li:nth-child(1) {
	border-bottom: 1px solid #ccc;
	text-align: center;
	height: 68%;
}

.report .reviewCont ul li:nth-child(2) {
	font-weight: bold;
	margin: 5% 3% 3% 3%;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}

.report .reviewCont ul li:nth-child(3) {
	margin: 0 3% 0 3%;
	color: #666;
	font-size: 12px;
}

.report .reviewCont ul li:nth-child(4) {
	text-align: right;
	margin: 6% 3% 5% 3%;
}

.report .reviewCont ul img {
	width: 100%;
	height: 100%;
}

.reviewCont ul {
	position: relative;
}

/* 검색 */
.report .search {
	width: 100%;
	overflow: hidden;
	padding: 0.3%;
	margin: 0 auto;
	justify-content: center;
	margin-bottom: 60px;
	display: flex;
}

.report .search .search_1 {
	margin-right: 8px;
	overflow: hidden;
}

.report .search .search_2 {
	overflow: hidden;
}

.report .search .search_1 input {
	float: left;
}

.report .search .search_1 .select {
	float: left;
	width: 110px;
	height: 38px;
	padding: 0 5px 0 5px;
	border: 2px solid #f5bf25;
	text-align: center;
}

.report .search .search_1 .select p {
	margin-top: 10px;
}

.report .search .search_1 input:nth-child(2) {
	border: 2px solid #f5bf25;
	width: 140px;
	height: 38px;
	padding: 0 10px;
	border-left: 0px;
}

.report .search .search_2 input {
	float: left;
}

.report .search .search_2 .select {
	float: left;
	width: 80px;
	height: 38px;
	padding: 0 5px 0 5px;
	border: 2px solid #f5bf25;
	text-align: center;
}

.report .search .search_2 .select p {
	margin-top: 10px;
}

.report .search .search_2 input:nth-child(2) {
	border: 2px solid #f5bf25;
	width: 300px;
	height: 36px;
	border-left: 0px;
}

.report .search .search_2 input:nth-child(3) {
	width: 70px;
	height: 42px;
	background-color: #f5bf25;
	border: 0px;
	color: #fff;
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

@media screen and (max-width:960px) {
	.report .search .search_2 input:nth-child(2) {
		width: 45%;
	}
}

@media screen and (max-width:900px) {
	.report .search {
		display: block;
	}
	.report .search .search_1 {
		margin-bottom: 2%;
	}
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
	.contHr {
		margin-top: 5%;
		margin-bottom: 10%;
	}
	.contTitle {
		font-size: 28px;
	}

	/* 검색 */
	.report .search {
		margin-bottom: 10%;
		display: block;
	}
	.report .search .search_1 {
		float: none;
	}
	.report .search .search_2 {
		float: none;
	}
	.report .search .search_2 input:nth-child(2) {
		width: 50%;
	}

	/* 유기견 신고 */
	.report {
		margin-top: 10%;
		margin-bottom: 10%;
	}
	.report .reviewCont ul {
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
				<div class='subTitle'>무료 분양</div>
			</div>
		</div>

		<!-- 입양후기 -->
		<div class="content">
			<div class="report">
				<div class='contTitle'>무료 분양</div>
				<hr class='contHr'>

				<!-- 검색 -->
				<div class='search'>
					<div class='search_1'>
						<div class='select'>
							<p>입소날짜(이후)</p>
						</div>
						<input type='date' id='dogEntDate' />
					</div>
					<div class='search_2'>
						<div class='select'>
							<p>품종</p>
						</div>
						<input type='text' id='dogKind' maxlength='10' /> <input
							type='button' value='검색' id='searchDogBtn' />
					</div>
				</div>

				<div class='reviewCont' id='dogPost'></div>

				<!-- 페이징 -->
				<div class='page'>
					<ul id='pagingUl'>
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