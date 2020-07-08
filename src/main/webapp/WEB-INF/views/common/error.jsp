<%@page import="org.apache.logging.log4j.LogManager"%>
<%@page import="org.apache.logging.log4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page isErrorPage='true'%>

<h3>시스템 에러가 발생했습니다.</h3>
<h5>고객센터 1577-1577 로 문의하세요.</h5>

<%
	Logger logger = null;
	if (application.getAttribute("logger") != null)
		logger = (Logger) application.getAttribute("logger");
	else {
		logger = LogManager.getLogger();
		application.setAttribute("logger", logger);
	}

	logger.debug(exception); 
%>