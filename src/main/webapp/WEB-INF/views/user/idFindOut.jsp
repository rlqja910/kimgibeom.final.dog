<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>유기견 보호소</title>
<%@ include file="../common/scriptImport.jsp" %>
<style>
	/* header */
	.header{width:100%; height:380px; background-color:#ccc; background-image: url('../attach/banner/banner.jpg'); background-position: center;}
	.header .headerBackground{background:rgba(0, 0, 0, .4); height:380px;}

	.subHr{width:45px; margin-top:140px; border:1px solid #f5bf25;}
	.header .subTitle{text-align:center; font-size:42px; color:#fff; margin-top:20px;}
	.contHr{width:45px; margin-top:20px; margin-bottom:60px; border:1px solid #f5bf25;}

	/* 아이디 찾기 */
	.idFind:nth-child(1){text-align:center;}
	.idFind:nth-child(1) span{font-weight:bold;}
	.idFind{width:80%;font-size:14px; margin:0 auto; margin-top:100px; margin-bottom:100px;}
	.idFind p{text-align:left; width:80%; margin-bottom:10px;}
	.idFind .idFindCont{width:80%; margin:0 auto;}
	.idFind .contTitle{font-size:32px; font-weight:bold;}
	.idFind .idFindCont .box{height:120px; border:1px solid #999; text-align:center; overflow:hidden;}
	.idFind .idFindCont .box ul{width:50%; margin:0 auto; margin-top:50px;}
	.idFind .button{margin-top:60px;}
	.idFind .button input{height:40px;}
	.idFind .button .loginBtn{background-color:#f5bf25; border:1px solid #f5bf25; width:70px; color:#fff; margin-left:5px;}
	
	/* 모바일 스타일 */
	@media screen and (max-width:768px){
	.subHr{margin-top:20%;}

	.header .subTitle{font-size:36px; margin-top:0; padding-bottom:5%;}
	.contHr{margin-top:5%; margin-bottom:10%;}
	.idFind .contTitle{font-size:28px;}

	.idFind{margin:0 auto; margin-top:10%; margin-bottom:10%;}
	.idFind .idFindCont{width:100%;}
	.idFind .button{margin-top:10%;}
	.idFind p{width:100%; text-align:center; margin-bottom:5%;}
	.idFind .idFindCont .box{height:80px;}
	.idFind .idFindCont .box ul{margin-top:30px;}
	}
</style>
</head>
<body>
	<div class='container'>
		<div class='header'>
			<div class='headerBackground'>
					<header><%@ include file="../common/header.jsp"%>
				</header>
				<hr class='subHr'>
				<div class='subTitle'>아이디 찾기</div>
			</div>
		</div>
		
		<!-- 아이디 찾음 -->
			<div class="content">
				<div class="idFind">
					<div class='contTitle'>아이디 찾기</div>
					<hr class='contHr'>
					<div class='idFindCont'>
						<p>고객님의 정보와 일치하는 아이디 입니다.</p>
						<div class='box'>
							<ul>
								<li>아이디:  <%= request.getParameter("userId") %></li>
							</ul>
						</div>
						<div class="button">
							<input type='button' class="loginBtn" type="submit" value='로그인' onClick="location.href='login'">
						</div>
					</div>
				</div>
			</div>

		<!-- 푸터 -->
<footer><%@ include file="../common/footer.jsp"%>
		</footer>
	</div>
</body>
</html>