<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp"%>
<!-- modal -->
<script src='http://code.jquery.com/jquery-3.4.1.min.js'></script>
<script
	src='http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js'></script>
<link rel='stylesheet'
	href='https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css'>

<script>
//로그인 상태만 후원하기 버튼 보임
function showDonationButton(){
	if(`${userId}`)
		$('#donationButton').show();
	else
		$('#donationButton').hide();
}

function maxLengthCheck(object){
    if (object.value.length > object.maxLength){
      object.value = object.value.slice(0, object.maxLength);
    }    
}
  
//이름 빈칸 체크
function isCheckName(){
	result = false;
	if($('#userName').val()) result=true;
	return result;
} 

//전화번호 빈칸 체크
function isCheckPhone(){
	result = false;
	if($('#userPhone1').val() && $('#userPhone2').val() && $('#userPhone3').val()) result= true;
	return result;
}

//계좌번호 빈칸 체크
function isCheckAccount(){
	result = false;
	if($('#account').val()) result=true;
	return result;
}

//후원금액 빈칸 체크
function isCheckPrice(){
	result = false;
	if($('#price').val()) result=true;
	return result;
}

//후원하기
function donate(){
	$('#donate').click(()=>{
		$('#pay').click(()=>{
			if(isCheckName() && isCheckPhone()){
				$('#myModal_2').modal('show');
			}
			else swal({
				title: "이름과 전화번호를 모두 입력해주세요",
				type: 'warning'
			}); 
		});
		
		$('#ok').on('click',()=>{
			if(isCheckAccount() && isCheckPrice()){
				$.ajax({
						url:'donateProc',
						data: {
								'price': $('#price').val(),
								'userId': `${userId}`,
								'userPhone': $('#userPhone1').val() +'-'+ $('#userPhone2').val()+'-'+$('#userPhone3').val()
						},
						type:'post',			
						success: (result) =>{
							swal({
								title:'후원금 결제가 완료되었습니다',
								text:'',
								type:'success', 
							}, 
							function(result){
									location.reload();
							})
						},
						error: (xhr)=> swal("후원금 결제 실패")
					});
			}
			else {
				if(!isCheckAccount()) swal("카드번호를 입력해주세요");
				if(!isCheckPrice()) swal("후원금액을 입력해주세요");
			}
		});
	});	
}

$(()=>{
	donate();
	showDonationButton();
});

</script>
<style>
/* madal을 사용할 때 padding을 0으로 맞춰줘야 한다.*/
body {
	padding-right: 0 !important;
}

.container {
	padding: 0 !important;
}

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

.header header .headB {
	overflow: hidden;
}

.header header .headB .logo a {
	float: left;
	color: #fff;
}

.header header .headB ul li:hover {
	color: #f5bf25;
	transition-duration: .5s;
}

.header header .headB ul li a {
	font-size: 16px;
}

.header header .headB ul li:hover a {
	color: #f5bf25 !important;
	transition-duration: .5s;
	font-size: 16px;
}

.subHr {
	width: 45px;
	margin-top: 140px;
	border: 1px solid #f5bf25;
}

.contHr {
	width: 45px;
	margin-top: 20px;
	margin-bottom: 60px;
	border: 1px solid #f5bf25;
}

.header .subTitle {
	text-align: center;
	font-size: 42px;
	color: #fff;
	margin-top: 20px;
}

/* mainText */
.content .mainText .text {
	color: #666;
}

.content .mainText .text span {
	font-size: 40px;
	color: #282320;
	font-weight: bold;
}

.content .mainText .text span span {
	color: #f5bf25;
}

.content .mainText .text i {
	list-style: none
}

/* donation */
.content .donation {
	text-align: center;
	margin: 0 auto;
	margin-top: 100px;
	margin-bottom: 60px;
	width: 90%;
}

.content .donation .donationCont {
	overflow: hidden;
	margin-top: 50px;
}

.content .donation .donationCont div {
	margin: auto;
	width: 100%;
}

.content .donation .donationCont .donationTitle {
	font-size: 24px;
	font-weight: bold;
}

.content .donation .donationCont p {
	font-size: 16px;
}

.donationCount {
	margin-bottom: 100px;
}

/* 후원하기 */
.contTitle {
	font-size: 32px;
	font-weight: bold;
}

.contHr {
	width: 45px;
	margin-top: 20px;
	margin-bottom: 60px;
	border: 1px solid #f5bf25;
}

/*후원금액*/
.donations {
	background-image: url('../img/donationImg.jpg');
	background-position: center;
	width: 100%;
	height: 250px;
	background-color: #333;
}

.donations p {
	font-size: 16px;
	color: #ccc;
}

.totalDonation {
	width: 50%;
	float: left;
	font-size: 20px;
	text-align: center;
}

.monthDonation {
	width: 50%;
	float: right;
	font-size: 20px;
	text-align: center;
}

#count1 {
	font-size: 40px;
	font-weight: bold;
	font-family: 'Pacifico', cursive;
	color: #fff;
}

#count2 {
	font-size: 40px;
	font-weight: bold;
	font-family: 'Pacifico', cursive;
	color: #fff;
}

.center {
	width: 60%;
	margin: 0 auto;
	padding-top: 80px;
}

/*후원하기 버튼*/
.donaButton {
	background-color: #f5bf25;
	border: 1px solid #f5bf25;
	width: 90px;
	color: #fff;
	height: 40px;
	display: block;
	margin: 0 auto;
	justify-content: center;
	margin-top: 60px;
}

/* modal */
.modal-dialog {
	width: 45%;
	margin: 0 auto;
	margin-top: 10%;
}

.modal-title {
	text-align: center;
	color: #333;
	font-size: 24px;
	font-weight: bold;
	border-bottom: 1px solid #f5bf25;
	padding: 4% 0;
}

.modal-header {
	border: 0;
}

.modal-footer {
	text-align: center;
	padding: 4% 0;
}

.modal-footer button {
	width: 80px;
	height: 40px;
}

.modal-footer button:nth-child(1) {
	background-color: #f5bf25;
	color: #fff;
	border: 0;
}

.modal-body table tr input {
	border: 1px solid #999;
	height: 40px;
}

.modal-body table tr th {
	width: 25%;
	text-align: center;
}

.modal-body table tr td {
	width: 75%;
}

.modal-body table .name td input {
	width: 80%;
	margin-bottom: 20px;
}

.modal-body table .name th {
	padding-bottom: 35px;
}

.modal-body table .tall td input {
	width: 24%;
}

.modal-body table .bank td {
	padding-bottom: 20px;
}

.modal-body table .bank th {
	padding-bottom: 25px;
}

.modal-body table .cardNum th {
	padding-bottom: 35px;
}

table {
	width: 100%;
}

.modal-body table .cardNum td input {
	width: 100%;
	margin-bottom: 20px;
	font-size: small;
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
	.contTitle {
		font-size: 28px;
	}
	.mainTitle {
		width: 90%;
		margin: 0 5%;
	}
	.mainTitle .subTitle {
		text-align: center;
		font-size: 36px;
		color: #fff;
		margin-top: 5%;
	}
	.mainTitle .subText {
		color: #ccc;
		margin-top: 15px;
		text-align: center;
		font-size: 14px;
	}
	.mainTitle .mainBtn {
		margin-bottom: 5%;
	}
	.mainTitle .mainBtn a {
		margin: 0 auto;
		padding: 2% 2%;
		border-radius: 12px;
		border: 1px solid #f5bf25;
		margin-top: 5%;
		color: #f5bf25;
		text-align: center;
		font-size: 14px;
	}

	/* donation */
	.content .donation {
		margin: 0 auto;
		margin-top: 10%;
		margin-bottom: 5%;
	}
	.donationCount {
		margin-bottom: 10%;
	}
	.donations div {
		float: none;
	}
	.content .donation .donationCont p {
		font-size: 14px;
	}
	.content .donation .donationCont .donationTitle {
		font-size: 20px;
	}

	/*후원금액*/
	.center {
		width: 80%;
		padding-top: 5%;
	}
	.totalDonation {
		width: 100%;
	}
	.monthDonation {
		width: 100%;
	}

	/*후원하기 버튼*/
	.donaButton {
		margin: 0 auto;
		margin-top: 10%;
	}

	/* modal */
	.modal-dialog {
		width: 80%;
		margin: 0 auto;
		margin-top: 30%;
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
				<div class='subTitle'>후원하기</div>
			</div>
		</div>

		<!-- 콘텐츠 -->
		<div class="content">
			<!-- 보호소 소개 -->
			<div class='donation mainText'>
				<div class='contTitle'>후원하기</div>
				<hr class='contHr'>
				<div class='donationCont'>
					<div>
						<span class='donationTitle'>"후원자분들의 사랑과 관심이 필요합니다."</span> <br>
						<br>
						<p>
							후원금은 유기견이 생활하는 모든 곳에 사용됩니다.<br> 여러분의 도움으로 유기동물들이 밝고 건강하게 지낼
							수 있습니다.<br>
						</p>
					</div>
				</div>
			</div>

			<form>
				<div class='donationCount'>
					<div class='donations'>
						<div class='center'>
							<div class='totalDonation'>
								<div id="count1" class="num"></div>
								<p>총 누적 후원금액(원)</p>
							</div>
							<div class='monthDonation'>
								<div id="count2" class="num"></div>
								<p>이번달 후원금액(원)</p>
							</div>
						</div>
					</div>

					<div id='donationButton'>
						<input type='button' class='donaButton' id='donate'
							data-target='#myModal' data-toggle='modal' value='후원하기'/>
					</div>
				</div>

				<!-- modal_후원하기 -->
				<div class='modal fade' id='myModal'>
					<div class='modal-dialog modal-sm'>
						<div class='modal-content'>
							<div class='modal-header'>
								<button class='close' data-dismiss='modal'>&times;</button>
								<h4 class='modal-title'>후원신청</h4>
							</div>
							<div class='modal-body'>
								<table>
									<tr class='name'>
										<th>이름</th>
										<td><input type='text' maxlength="10" id="userName" /></td>
									</tr>
									<tr class='tall'>
										<th>전화번호</th>
										<td><input type='number' id="userPhone1" min="0"
											maxlength="3" oninput="maxLengthCheck(this)" value="010"/> - <input
											type='number' id="userPhone2" min="0" maxlength="4"
											oninput="maxLengthCheck(this)" /> - <input type='number'
											id="userPhone3" min="0" maxlength="4"
											oninput="maxLengthCheck(this)" /></td>
									</tr>
								</table>
							</div>
							<div class='modal-footer'>
								<button class='btn btn-default' type='button'
									data-toggle='modal' id="pay">결제</button>
								<button class='btn btn-default' type='button'
									data-dismiss='modal' id="cancel">취소</button>
							</div>
						</div>
					</div>
				</div>

				<!-- modal_결제 -->
				<div class='modal fade' id='myModal_2'>
					<div class='modal-dialog modal-sm'>
						<div class='modal-content'>
							<div class='modal-header'>
								<button class='close' data-dismiss='modal'>&times;</button>
								<h4 class='modal-title'>결제</h4>
							</div>
							<div class='modal-body'>
								<table>
									<tr class='bank'>
										<th>은행</th>
										<td style="font-weight:bold;">국민은행</td>
									</tr>
									<tr class='cardNum'>
										<th>카드번호</th>
										<td><input type="number" id="account" min="14" 
											maxlength="14" oninput="maxLengthCheck(this)"
											placeholder="'-'를 제외한 번호만 입력해 주시기 바랍니다." /></td>
									</tr>
									<tr>
										<th>후원 금액</th>
										<td><input type="number" min="10000" value="10000"
											id="price" step="10000" style="text-align: right;"/> 원</td>
									</tr>
								</table>
							</div>
							<div class='modal-footer'>
								<button class='btn btn-default' type='button' id='ok'>확인</button>
								<button class='btn btn-default' type='button'
									data-dismiss='modal'>취소</button>
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>

		<!-- 푸터 -->
		<footer>
			<%@ include file="../common/footer.jsp"%>
		</footer>
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
		var $el = $("#count1");
		$({
			val : 0
		}).animate({
			val : num
		}, {
			duration : 2000,
			step : function() {
				$el.text(Math.floor(this.val).cf());
			},
			complete : function() {
				$el.text(Math.floor(this.val).cf());
			}
		});
	}
	function animateCount2(num) {
		var $el = $("#count2");
		$({
			val : 0
		}).animate({
			val : num
		}, {
			duration : 3000,
			step : function() {
				$el.text(Math.floor(this.val).cf());
			},
			complete : function() {
				$el.text(Math.floor(this.val).cf());
			}
		});
	}

	$(()=>{ 
		animateCount1(${donaTot});  
		animateCount2(${donaMon});
	});
</script>
</html>