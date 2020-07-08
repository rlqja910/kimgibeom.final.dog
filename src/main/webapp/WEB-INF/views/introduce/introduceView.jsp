<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp" %>
<script>
	/* 원페이지 스크롤 */
	$(function(){
	   $('a[href^=#]').click(function() {
		  var speed = 500; /* 스크롤링 속도 */
		  var href= $(this).attr("href");
		  var target = $(href == "#" || href == "" ? 'html' : href);
		  var position = target.offset().top;
		  $('body,html').animate({scrollTop:position}, speed, 'swing');
		  return false;
	   });
	});
</script>
<style>
	/* header */
	.header{width:100%; height:380px; background-color:#ccc; background-image: url('../attach/banner/banner.jpg'); background-position: center;}
	.header .headerBackground{background:rgba(0, 0, 0, .4); height:380px;}

	.subHr{width:45px; margin-top:140px; border:1px solid #f5bf25;}
	.header .subTitle{text-align:center; font-size:42px; color:#fff; margin-top:20px;}
	.contHr{width:45px; margin-top:20px; margin-bottom:60px; border:1px solid #f5bf25;}
	
	/* sub메뉴 */
	.subMenu{width:100%;}
	.subMenu ul{overflow:hidden;}
	.subMenu ul li{float:left; width:50%; text-align:center; box-shadow: 0 0 0 1px #ccc inset; color:#666;}
	.subMenu ul li a{padding:12px 0;}
	.subMenu ul li:hover a{background-color:#f5bf25; color:#fff;}

	/* introduction */
	.contTitle{font-size:32px; font-weight:bold;}
	.content .introduction{width:80%; text-align:center; margin:0 auto; margin-top:100px; margin-bottom:100px;}
	.content .introduction .introductionCont{overflow:hidden; margin-top:50px;}
	.content .introduction .introductionCont .video-container{margin:0 auto; margin-top:80px;}
	.content .introduction .introductionCont .video-container ul{margin-top:30px; color:#333;}
	.content .introduction .introductionCont .introductionTitle{font-size:24px; font-weight:bold;}
	
	/* 유뷰브 넓이 높이 100% 맞춤 소스 */
	.video-container{position:relative;padding-bottom:56.25%;padding-top:30px;height:0;overflow:hidden;} 
	.video-container iframe,.video-container object,.video-container embed{position:absolute;top:0;left:0;width:100%;height:100%;} 
	
	/* 오시는 길 */
	.content .loation{width:100%; text-align:center; background-color:#f6f5f5; padding:100px 0;}
	.content .loation iframe{height:400px;}
	.content .loation ul{margin-top:50px;}
	.content .loation ul li{margin-top:8px;}
	.content .loation ul li:nth-child(1){font-weight:bold;}
	.content .loation ul li span{font-weight:bold; color:#f5bf25;}

	/* 보호소 소개 */
	@media screen and (max-width:768px){
		.subHr{margin-top:20%;}

		.header .subTitle{font-size:36px; margin-top:0; padding-bottom:5%;}
		.contHr{margin-top:5%; margin-bottom:10%;}

		.subMenu ul li a{padding:5%;}
		.contTitle{font-size:28px;}
		
		.content .introduction{width:80%; text-align:center; margin:0 auto; margin-top:10%; margin-bottom:10%;}
		.contTitle{font-size:28px; font-weight:bold;}
		.content .introduction .introductionCont{margin-top:10%;}
		.content .introduction .introductionCont div:nth-child(1){width:100%;}
		.content .introduction .introductionCont .video-container{margin:0 auto; margin-top:10%;}
		.content .introduction .introductionCont .introductionTitle{font-size:20px;}
		
		.content .loation{padding:10% 0;}
		.content .loation iframe{height:300px;}
		.content .loation ul{margin-top:5%;}
		.content .loation ul li{margin-top:1%;}
	}
</style>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
				<header>
					<%@ include file="../common/header.jsp" %>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>보호소 소개</div>
			</div>
		</div>
		
		<!-- 콘텐츠 -->
		<div class="content">
			<!-- 보호소 소개 -->
			<div class='subMenu'>
				<ul>
					<li><a href='#move01' class='scroll_move'>보호소 소개</a></li>
					<li><a href='#move02' class='scroll_move'>오시는 길</a></li>
				</ul>
			</div>
			<div class='introduction' id='move01'>
				<div class='contTitle'>보호소 소개</div>
				<hr class='contHr'>
				<div class='introductionCont'>
					<div>
						<span class='introductionTitle'>"한 해에 버려지는 유기동물의 수는 10만 마리 입니다."</span><br><br>
						반려동물에 대한 인식의 변화가 있다고는 하지만 아직도 여전히 반려동물을 소유물이라고 생각하고 버리거나<br>
						학대하는 일들이 끊임없이 우리 모르게 벌어지고 있습니다.<br><br>

						이 세상 모든 반려동물과의 삶이 행복하기를 원하며 보호소를 설립하게 되었습니다.<br>
						저희 보호소는 동물에 대한 마음으로 안락사 없는 동물 보호소 입니다.
					</div>
					<div class='video-container'>
						<iframe width="100%" src="https://www.youtube.com/embed/ICaagO06vbg?autoplay=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
					</div>					
				</div>
			</div>
			<div class='loation' id='move02'>
				<div class='contTitle'>오시는 길</div>
				<hr class='contHr'>
				<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3162.9294519888836!2d126.91744211511975!3d37.55672587979967!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357c98dcf3c61b6b%3A0xf87b1385bb2b013a!2z7ISc7Jq47Yq567OE7IucIOuniO2PrOq1rCDshJzqtZDrj5kgNDQ1LTc!5e0!3m2!1sko!2skr!4v1592531069742!5m2!1sko!2skr" width="100%" frameborder="0" style="border:0;" allowfullscreen="" aria-hidden="false" tabindex="0"></iframe>
				<ul>
					<li>서울 마포구 월드컵북로 21 2층 풍성빌딩</li>
					<li>홍대역에서 도보 10분</li>
					<li><span>T.</span> 010-0000-0000 <span>F.</span> 02-3397-0802 <span>E.</span> aaa@naver.com</li>
				</ul>
			</div>
		</div>	

		<!-- 푸터 -->
		<footer>
			<%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>