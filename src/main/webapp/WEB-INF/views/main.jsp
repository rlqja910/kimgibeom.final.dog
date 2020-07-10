<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<html lang="ko">
<head>
<title>유기견 보호소</title>
<meta name="viewport"
	content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<%@ include file="common/scriptImport.jsp"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/css/swiper.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/4.5.1/js/swiper.min.js"></script>

<script>
	$(()=>{
		if(${fn:length(mainDogList)}===0){
			$('#abandonDogListUl').append('<hr><div align=center>등록된 유기견이 없습니다.</div>');
		}
		
		$('#donate').click(()=>{
			if(`${userId}`){
				location.href='donation/donate';
			}
			else location.href='user/login';
		})
	});
	
function fn_reviewView(reviewNum){
	let url = "review/reviewView";
	url = url + "?reviewNum=" + reviewNum +"&page=1&range=1";
	
	location.href = url;
}
</script>
<style>
/* header */
.header {
	width: 100%;
	height: 520px;
	background-color: #ccc;
	background: url('./attach/banner/banner.jpg');
	padding-top: -50px;
	background-position: center;
}

.header .headerBackground {
	background: rgba(0, 0, 0, .4);
	height: 520px;
} /* 메인과 서브페이지의 background크기가 다르다. */
.header .banner {
	text-align: center;
	color: #fff;
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

.mainTitle {
	width: 80%;
	margin: 0 auto;
	overflow: hidden;
}

.mainTitle .subTitle {
	text-align: left;
	font-size: 42px;
	color: #fff;
	margin-top: 80px;
}

.mainTitle .subText {
	color: #ccc;
	margin-top: 15px;
}

.mainTitle .subText span {
	color: #f5bf25;
}

.mainTitle .mainBtn a {
	width: 140px;
	padding: 10px 20px;
	border-radius: 12px;
	border: 1px solid #f5bf25;
	margin-top: 40px;
	color: #f5bf25;
}

.mainTitle .mainBtn a:hover {
	border: 1px solid #fff;
	color: #fff;
	transition-duration: .5s;
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

/* introduction */
.content .introduction {
	text-align: center;
	margin: 0 auto;
	margin-top: 80px;
	width: 80%;
}

.content .introduction .introductionCont {
	overflow: hidden;
	margin-top: 50px;
}

.content .introduction .introductionCont div {
	float: left;
}

.content .introduction .introductionCont div:nth-child(1) {
	width: 42%;
	height: 287px;
}

.content .introduction .introductionCont div:nth-child(2) {
	width: 55%;
	text-align: left;
	margin-left: 3%;
	margin-top: 20px;
}

.content .introduction .introductionCont div:nth-child(2) ul {
	margin-top: 30px;
	color: #333;
}

.content .introduction .introductionCont .introductionTitle {
	font-size: 20px;
	font-weight: bold;
}

.introductionBtn a {
	width: 140px;
	background-color: #333;
	padding: 10px 20px;
	border-radius: 12px;
	color: #fff;
	margin-top: 40px;
}

.introductionBtn a:hover {
	background-color: #f5bf25;
	color: #fff;
	transition-duration: .5s;
}

/* count */
.content .count {
	width: 100%;
	height: 200px;
	background-color: #ccc;
	margin-top: 100px;
	background: url('img/countImg.jpg');
	background-position: center;
}

.content .count ul {
	width: 70%;
	margin: 0 auto;
	margin: 0 15% 0 15%;
	overflow: hidden;
	padding-top: 60px;
}

.content .count ul li {
	float: left;
	text-align: center;
	width: 33.33%;
	font-size: 14px;
}

.content .count ul li span {
	font-size: 54px;
	margin-bottom: 15px;
}

/* 유기견 소개 */
.content .animal {
	text-align: center;
	margin: 0 auto;
	margin-top: 80px;
	width: 80%;
}

.content .animal ul {
	overflow: hidden;
	margin-top: 60px;
}

.content .animal ul li {
	width: 23.5%;
	float: left; /*border:1px solid #ccc;*/
	margin-left: 1%;
	margin-top: 1%;
	position: relative;
	border: 1px solid #ccc;
	height: 33%;
}

.content .animal ul li div {
	width: 100%;
	height: 100%;
	background-color: rgba(255, 255, 255, 0);
	position: absolute;
	top: 0;
	left: 0;
}

.content .animal ul li div span {
	display: none;
	padding: 33% 0;
}

.content .animal ul li div span span {
	width: 20%;
	padding: 5px 10px;
	border: 1px solid #f5bf25;
	text-align: center;
	margin: 0 auto;
	border-radius: 30px;
	margin-top: 15px;
}

.content .animal ul li a:hover div {
	background-color: rgba(0, 0, 0, .7);
	transition-duration: .5s;
}

.content .animal ul li a:hover div span {
	display: block;
	color: #fff;
}

.content .animal ul li img {
	width: 100%;
}

.animalBtn {
	width: 100%;
	padding: 10px 0;
}

.animalBtn a {
	width: 140px;
	background-color: #333;
	margin: 0 auto;
	padding: 10px 20px;
	border-radius: 12px;
	color: #fff;
	margin-top: 40px;
}

.animalBtn a:hover {
	background-color: #f5bf25;
	color: #fff;
	transition-duration: .5s;
}

/* 후원하기 */
.content .sponsor {
	background: url('img/sponsorImg.jpg');
	background-position: center;
}

.content .sponsor {
	width: 100%;
	height: 280px;
	background-color: #ccc;
	margin-top: 80px;
	position: relative;
}

.content .sponsor .sponsorBack {
	width: 80%;
	margin: 0 auto;
	text-align: center;
	padding-top: 50px;
}

.content .sponsor .sponsorBack .sponsorTitle {
	font-size: 24px;
	font-weight: bold;
	color: #fff;
}

.content .sponsor .sponsorBack .sponsorText {
	margin-top: 30px;
	color: #ccc;
	z-index: 100;
}

.content .sponsor .sponsorBack .sponsorBtn a {
	width: 140px;
	border: 1px solid #f5bf25;
	margin: 0 auto;
	padding: 10px 20px;
	border-radius: 12px;
	color: #f5bf25;
	margin-top: 40px;
}

.content .sponsor .sponsorBack .sponsorBtn a:hover {
	border: 1px solid #fff;
	color: #fff;
	transition-duration: .5s;
}

.content .sponsor .sponsorBack {
	width: 100%;
	height: 230px;
	background-color: rgba(0, 0, 0, .7);
	position: absolute;
	top: 0;
	left: 0;
}

/* 후기 */
.review {
	width: 100%;
	text-align: center;
	margin-top: 80px;
}

.swiper-container {
	width: 100%;
	height: 30%;
	margin-top: 5%;
	margin-bottom: 7%;
}

.swiper-slide {
	text-align: center;
	font-size: 18px;
	background: #fff;
	border: 1px solid #ccc;
	float: left;
	padding: 0 0;
}

.swiper-slide img {
	width: 100%;
	height: 100%;
}

/* 모바일 스타일 */
@media screen and (max-width:768px) {
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

	/* 보호소 소개 */
	.content .introduction {
		margin-top: 10%;
	}
	.content .introduction .introductionCont {
		margin-top: 10%;
	}
	.content .introduction .introductionCont div {
		float: none;
	}
	.content .introduction .introductionCont div:nth-child(1) {
		width: 100%;
		height: 287px;
	}
	.content .introduction .introductionCont div:nth-child(2) {
		width: 100%;
		text-align: left;
		margin-top: 5%;
		margin-left: 0;
	}
	.introductionBtn a {
		margin: 0 auto;
		padding: 2% 2%;
		font-size: 14px;
		text-align: center;
		margin-top: 8%;
	}

	/* 카운트 */
	.content .count {
		margin-top: 10%;
	}
	.content .count ul li span {
		font-size: 40px;
	}
	.content .count ul {
		width: 80%;
		margin: 0 10% 0 10%;
	}

	/* 유기견 소개 */
	.content .animal {
		margin-top: 10%;
	}
	.content .animal ul {
		margin-top: 10%;
	}
	.content .animal ul li {
		width: 48%;
		height: 24%;
	}
	.content .animal ul li div span {
		padding: 37% 0;
	}
	.animalBtn a {
		margin-top: 8%;
	}

	/* 후원하기 */
	.content .sponsor {
		margin-top: 10%;
	}

	/* 리뷰 */
	.swiper-slide {
		padding: 0 0;
	}
	.swiper-container {
		width: 100%;
		height: 20%;
		margin-top: 50px;
	}
	.swiper-slide img {
		width: 100%;
		height: 100%;
	}
}

@media screen and (max-width:480px) {
	.header {
		background-size: 113%;
	}
}

.reviewEmpty {
	align: center;
	width: 100%;
	margin-top: 5%;
}
</style>
</head>

<body>
	<div class='container'>
		<div class='header mainHeader'>
			<div class='headerBackground'>
				<header>
					<%@ include file="common/header.jsp"%>
				</header>
				<div class='mainTitle'>
					<div class='subTitle'>
						Not only people<br>Need a house
					</div>
					<p class='banner'></p>
					<div class='subText'>
						갈 곳 없는 유기 동물이 <span>당신의 손길</span>을 기다리고 있습니다.
					</div>
					<div class='mainBtn'>
						<a href='dog/dogListView'>무료분양 바로가기</a>
					</div>
				</div>
			</div>
		</div>

		<!-- 콘텐츠 -->
		<div class="content">
			<!-- 보호소 소개 -->
			<div class='introduction mainText'>
				<div class='text'>
					<span><span>S</span>helter <span>I</span>ntroduction</span><br>보호소를
					소개합니다.
				</div>
				<div class='introductionCont'>
					<div>
						<iframe width="100%" height="100%"
							src="https://www.youtube.com/embed/ICaagO06vbg?autoplay=1"
							frameborder="0"
							allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
							allowfullscreen></iframe>
					</div>
					<div>
						<span class='introductionTitle'>"한 해에 버려지는 유기동물의 수는 10만 마리
							입니다."</span>
						<ul>
							<li>반려동물에 대한 인식의 변화가 있다고는 하지만 아직도 여전히 반려동물을 소유물이라고 생각하고 버리거나
								학대하는 일들이 끊임없이 우리 모르게 벌어지고 있습니다.<br> <br> 이 세상 모든
								반려동물과의 삶이 행복하기를 원하며 보호소를 섭립하게 되었습니다.<br> 저희 보소호소는 동물에 대한
								마음으로 안락사 없는 동물 보호소 입니다.
							</li>
							<li class='introductionBtn'><a
								href='introduce/introduceView'>보호소 소개 더보기</a></li>
						</ul>
					</div>
				</div>
			</div>

			<!-- 카운트 -->

			<div class='count'>
				<ul>
					<li><span>${totalDogCnt}</span><br>총 유기견 수</li>
					<li><span>${todayDogCnt}</span><br>오늘 보호된 유기견수</li>
					<li><span>${afterAdoptDogCnt}</span><br>입양된 유기견 수</li>
				</ul>
			</div>

			<!-- 유기견 리스트 -->
			<div class='animal mainText'>
				<div class='text'>
					<span><span>P</span>rotective <span>A</span>nimal</span><br>보호하고
					있는 유기견을 소개합니다.
				</div>
				<ul id='abandonDogListUl'>
					<c:forEach items="${mainDogList}" var="dog" end="7">
						<li><a href='dog/dogView/${dog.dogNum}'>
								<div>
									<span>${dog.dogTitle}<br> <span>view</span></span>
								</div> <img style='width: 100%; height: 100%;'
								src='<c:url value="attach/dog/${dog.attachName}" />' />
						</a></li>
					</c:forEach>

				</ul>
				<div class='animalBtn'>
					<a href='dog/dogListView'>유기견 더보기</a>
				</div>
			</div>

			<!-- 후원하기 -->
			<div class='sponsor'>
				<div class='sponsorBack'>
					<div class='sponsorTitle'>후원자분들의 사랑과 관심이 필요합니다.</div>
					<div class='sponsorText'>
						후원금은 유기견이 생활하는 모든 곳에 사용됩니다.<br> 여러분의 도움으로 유기동물들이 밝고 건강하게 지낼 수
						있습니다.
					</div>
					<div class='sponsorBtn'>
						<a href='#' id='donate'>후원하기</a>
					</div>
				</div>
			</div>

			<!-- 후기 -->
			<div class='review mainText'>
				<div class='text'>
					<span><span>R</span>eview</span><br>새로운 가족을 소개합니다.
				</div>

				<div class="swiper-container">
					<div class="swiper-wrapper">
						<c:choose>
							<c:when test="${empty mainReviewList}">
								<p class="reviewEmpty">등록된 후기글이 없습니다.</p>
							</c:when>
							<c:when test="${!empty mainReviewList}">
								<c:forEach var="mainReviewList" items="${mainReviewList}">
									<div class="swiper-slide">
										<a href='#'
											onclick="fn_reviewView(<c:out value='${mainReviewList.reviewNum}'/>)">
											<img
											src="<c:url value='/attach/review/${mainReviewList.attachName}'/>" />
										</a>
									</div>
								</c:forEach>
							</c:when>
						</c:choose>
					</div>
				</div>
			</div>
		</div>

		<!-- 푸터 -->
		<footer>
			<%@ include file="common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>

<!-- 후기script -->
<script>
	var mql = window.matchMedia("screen and (max-width: 768px)");

	if (mql.matches) {
		var swiper = new Swiper('.swiper-container', {
			pagination : '.swiper-pagination',
			slidesPerView : 3,
			paginationClickable : true,
		});
	} else {
		var swiper = new Swiper('.swiper-container', {
			pagination : '.swiper-pagination',
			slidesPerView : 5,
			paginationClickable : true,
		});
	}
</script>