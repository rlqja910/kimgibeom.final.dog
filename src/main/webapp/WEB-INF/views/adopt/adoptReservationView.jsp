<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
<script>
let totalPageCnt=${totalPageCnt};
let isOnePage=${isOnePage};
let lastPageDataCnt=${lastPageDataCnt};
let adoptsData=null;
let adoptsCnt=${adoptsCnt};

$(()=>{
	adoptList();
	
	$('#adoptCancel').click(()=>{
		$.ajax({
			success: () =>{
				swal({
					title:'',
					text:'입양신청이 취소되었습니다',
					type:'success', 
				},
				function(result){
						location.href='#';
				})
			}
		});
	});
	
	function adoptList(){
		$('#pagingUl').append('<li><a href="#" id="firstViewBtn"><<</a></li>');
		for(let i=1; i<=totalPageCnt;i++){
			$('#pagingUl').append('<li><a href="#" id='+i+'page >' + i + '</a></li>');
			if(i==1){
				$('#'+i+'page').attr("style","font-weight:bold;");
			}
		}
		$('#pagingUl').append('<li><a href="#" id="lastViewBtn">>></a></li>');
		
		$('#reservationTable').empty();
		$('#reservationTable').append('<colgroup><col width=10%><col width=10%><col width=20%><col width=20%><col width=20%><col width=20%></colgroup><tr class="text tableH"><th>선택</th><th>유기견 이름</th><th>신청일</th><th>상태</th></tr>');
		if(isOnePage===false){ //한페이지가 아니라 여러 페이지일 경우
			adoptsData=${pageData}; //controller에서 뽑은 데이터들을 준비한다.
			
			for(let i=1;i<=8;i++){ //한페이지당 8개의 게시물이 있으므로 8번 반복한다. adoptsData[i-1].adoptNum
				$('#reservationTable').append('<tr><td><input type="checkbox" name="reservationCheckBox" value='+adoptsData[i-1].adoptNum+' /></td><td>'+adoptsData[i-1].dog.dogName+'</td><td>'+adoptsData[i-1].adoptRegDate.substr(0,10)+'</td><td>'+adoptsData[i-1].dog.dogAdoptionStatus+'</td></tr>');
			}
			
		}else if(isOnePage){ //1페이지만 있을때 (데이터가 아예 없는 경우에도 여기로 진입한다)
			if(adoptsCnt==0){ //아예 데이터가 없을때
				$('#pagingUl').empty();
				$('#reservationTable').append('<tr><td colspan=6>신청한 예약이 없습니다.</td></tr>');
			}else{ //아예 데이터가 없는게 아니라 단 하나라도 있을때
				let onlyOnePageData=${onlyOnePageData};
				
				for(let i=1;i<=lastPageDataCnt;i++){ //데이터 출력 onlyOnePageData[i-1].adoptNum
					$('#reservationTable').append('<tr><td><input type="checkbox" name="reservationCheckBox" value='+onlyOnePageData[i-1].adoptNum+' /></td><td>'+onlyOnePageData[i-1].dog.dogName+'</td><td>'+onlyOnePageData[i-1].adoptRegDate.substr(0,10)+'</td><td>'+onlyOnePageData[i-1].dog.dogAdoptionStatus+'</td></tr>');
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
				
				$('#reservationTable').empty(); //리스트를 완전히 다 없앤다.
				$('#reservationTable').append('<colgroup><col width=10%><col width=10%><col width=20%><col width=20%><col width=20%><col width=20%></colgroup><tr class="text tableH"><th>선택</th><th>유기견 이름</th><th>신청일</th><th>상태</th></tr>');
				
				if(isOnePage){ //페이지가 만약 1페이지밖에 없다면 진입
					adoptsData=${onlyOnePageData};
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동 adoptsData[(i-1)*8+cnt].adoptNum
						$('#reservationTable').append('<tr><td><input type="checkbox" name="reservationCheckBox" value='+adoptsData[(i-1)*8+cnt].adoptNum+' /></td><td>'+adoptsData[(i-1)*8+cnt].dog.dogName+'</td><td>'+adoptsData[(i-1)*8+cnt].adoptRegDate.substr(0,10)+'</td><td>'+adoptsData[(i-1)*8+cnt].dog.dogAdoptionStatus+'</td></tr>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}else if(i==totalPageCnt){ //만약에 마지막 페이지를 클릭했을 경우
					adoptsData=${pageData}; //그리고 Controller에서 불러온 데이터를 준비한다.
					
					let cnt=0;
					for(let j=1;j<=lastPageDataCnt;j++){ //마지막 페이지의 data 개수만큼 for를 작동
						$('#reservationTable').append('<tr><td><input type="checkbox" name="reservationCheckBox" value='+adoptsData[(i-1)*8+cnt].adoptNum+' /></td><td>'+adoptsData[(i-1)*8+cnt].dog.dogName+'</td><td>'+adoptsData[(i-1)*8+cnt].adoptRegDate.substr(0,10)+'</td><td>'+adoptsData[(i-1)*8+cnt].dog.dogAdoptionStatus+'</td></tr>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
					
				}else{ //마지막 페이지가 아닌 다른 페이지번호를 클릭했을경우
					adoptsData=${pageData}; //그리고 Controller에서 불러온 데이터를 준비한다.
					
					let cnt=0;
					for(let j=1;j<=8;j++){ //1페이지당 8개의 게시물이므로 8번 반복해서 데이터를 출력
						$('#reservationTable').append('<tr><td><input type="checkbox" name="reservationCheckBox" value='+adoptsData[(i-1)*8+cnt].adoptNum+' /></td><td>'+adoptsData[(i-1)*8+cnt].dog.dogName+'</td><td>'+adoptsData[(i-1)*8+cnt].adoptRegDate.substr(0,10)+'</td><td>'+adoptsData[(i-1)*8+cnt].dog.dogAdoptionStatus+'</td></tr>');
						cnt++; //하나씩 넣고 cnt를 올려주어 계단식 저장
					}
				}
				
				return false;
			});
		}
	}
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

/* sub메뉴 */
.subMenu {
	width: 100%;
}

.subMenu ul {
	overflow: hidden;
}

.subMenu ul li {
	float: left;
	width: 33.33%;
	text-align: center;
	box-shadow: 0 0 0 1px #ccc inset;
	color: #666;
}

.subMenu ul li a {
	padding: 12px 0;
}

.subMenu ul li:hover a {
	background-color: #f5bf25;
	color: #fff;
}

.subMenu .menuOn {
	background-color: #f5bf25;
	color: #fff;
}

/* 분양 예약 조회 */
.member>div:nth-child(1) {
	text-align: center;
}

.member>div:nth-child(1) span {
	font-weight: bold;
}

.member {
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
}

.member table input {
	border: 1px solid #999;
}

.member table {
	border: 1px solid #f5bf25;
	border-collapse: collapse;
	text-align: left;
	width: 80%;
	font-size: 14px;
	margin: 0 auto;
}

.member table .text input {
	height: 30px;
	width: 45%;
}

.member table .number input {
	height: 30px;
	width: 10%;
}

.member form {
	margin: 100px 0;
	text-align: center;
}

.member form .contTitle {
	font-size: 32px;
	font-weight: bold;
}

.member form .button {
	overflow: hidden;
	width: 100%;
	text-align: center;
}

.member form .button input {
	height: 40px;
	margin-top: 60px;
}

.member form .button .cancel {
	background-color: #f5bf25;
	border: 1px solid #f5bf25;
	width: 90px;
	color: #fff;
	margin-left: 5px;
}

.member table tr {
	height: 30px;
}

.member th {
	text-align: center;
	border-left: 1px solid #fff;
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 45px;
	background-color: #eee;
	color: #333;
}

.member td {
	text-align: center;
	border-left: 1px solid #fff;
	border-right: 1px solid #fff;
	padding: 0 10px;
	border-bottom: 1px solid #ccc;
	height: 50px;
}

.member th span {
	color: red;
}

.member .text button {
	height: 33px;
	background-color: #666;
	border: 0px;
	color: #fff;
}

.member .text td span {
	font-size: 12px;
}

.member .incomplete {
	color: red;
}

/* 페이징 */
.member .page {
	width: 100%;
	margin-top: 70px;
}

.member .page ul {
	display: flex;
	margin: 0 auto;
	justify-content: center;
}

.member .page ul li {
	border: 1px solid #ccc;
}

.member .page ul li a {
	padding: 10px 15px;
}

.member .page ul li a:hover {
	background-color: #333;
	color: #fff;
}

/* 모바일 스타일 */
@media screen and (max-width:768px) {
	.subHr {
		margin-top: 20%;
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
	.subMenu ul li a {
		padding: 5%;
	}
	.member form .contTitle {
		font-size: 28px;
	}
	.member form {
		margin: 10% 0;
	}
	.contHr {
		margin-top: 5%;
		margin-bottom: 10%;
	}
	.member table {
		width: 100%;
		font-size: 12px;
	}
	.member table .text input {
		width: 95%;
	}
	.member form .button input {
		margin-top: 10%;
	}
	.member table .number input {
		height: 30px;
		width: 20%;
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
				<div class='subTitle'>마이페이지</div>
			</div>
		</div>

		<!-- 회원가입 -->
		<div class="content">
			<div class='subMenu'>
				<ul>
					<li><a href='../user/mypage'>회원정보 변경</a></li>
					<li><a href='adoptReservationView' class='menuOn'>입양 예약 조회</a></li>
					<li><a href='../user/userWithdraw'>회원탈퇴</a></li>
				</ul>
			</div>
			<div class="member">
				<form action="#">
					<div class='contTitle'>입양 예약 조회</div>
					<hr class='contHr'>
					<table id='reservationTable'>
					</table>
					<div class="button">
						<input type='button' class="cancel" value='입양 취소' id='adoptCancel'>
					</div>
				</form>

				<div class='page'>
					<ul id='pagingUl'>
					</ul>
				</div>
				<br> <br>
			</div>
		</div>

		<!-- 푸터 -->
		<footer>
			<%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>