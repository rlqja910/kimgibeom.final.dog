<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage='true'%>
<script src='https://code.jquery.com/jquery-3.4.1.min.js'></script>

<style>
@import "lesshat";

@import url(https://fonts.googleapis.com/css?family=Roboto);

html {
	background:
		url(https://38.media.tumblr.com/546c0cd48d71f210f9b67a389003790d/tumblr_neq0yw9rMA1tm16jjo1_500.gif)
		no-repeat center center fixed;
	background-size: cover;
	font-family: 'Roboto', sans-serif;
}

h1 {
	font-size: 16em;
	margin: .2em .5em;
	color: rgba(255, 255, 255, 0.7);
	margin-bottom: 0px;
}

h2 {
	font-size: 1.7em;
	margin: .2em .5em;
	color: rgba(255, 255, 255, 0.6); . material-icons { font-size : 1.5em;
	position: relative;
	top: 10px;
}

}
div.error {
	position: absolute;
	top: 30%;
	margin-top: -8em;
	width: 100%;
	text-align: center;
}
</style>

<div class="error">
	<h1>404</h1>
	<h2>
		페이지를 찾을수 없습니다. <br>
	</h2>
</div>

