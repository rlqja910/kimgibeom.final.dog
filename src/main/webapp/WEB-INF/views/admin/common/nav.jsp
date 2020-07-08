<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri='http://java.sun.com/jsp/jstl/core'%>
<style>
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
</style>
<h2>
	<b>DOG SHELTER</b>
</h2>
<ul>
	<li><a href='<c:url value='/admin'/>'> <span
			class='glyphicon glyphicon-home'></span>메인
	</a></li>
	<li><a href='<c:url value='/admin/user/userListView'/>'> <span
			class='glyphicon glyphicon-user'></span>회원관리
	</a></li>
	<li><a href='<c:url value='/admin/dog/dogListView'/>'> <span
			class='glyphicon glyphicon-heart'></span>유기견관리
	</a></li>
	<li><a href='#'> <span class='glyphicon glyphicon-calendar'></span>입양관리
	</a></li>
	<li><a href='<c:url value='/admin/review/reviewListView'/>'> <span
			class='glyphicon glyphicon-list'></span>후기관리
	</a></li>
	<li><a href='<c:url value='/admin/report/reportListView'/>'> <span
			class='glyphicon glyphicon-bullhorn'></span>신고관리
	</a></li>
	<li><a href='#'> <span class='glyphicon glyphicon-piggy-bank'></span>후원금
			관리
	</a></li>

</ul>