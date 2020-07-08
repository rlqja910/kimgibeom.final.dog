package kimgibeom.dog.user.controller;

import java.net.BindException;
import java.nio.file.AccessDeniedException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.method.annotation.MethodArgumentTypeMismatchException;

@ControllerAdvice
public class ControllerAdvise {
	/**
	 * javax.validation.Valid or @Validated 으로 binding error 발생시 발생한다.
	 * HttpMessageConverter 에서 등록한 HttpMessageConverter binding 못할경우 발생
	 * 주로 @RequestBody, @RequestPart 어노테이션에서 발생
	 */
	@ExceptionHandler(MethodArgumentNotValidException.class)
	protected String handleMethodArgumentNotValidException(MethodArgumentNotValidException e) {
		return "redirect:../";
	}

	/**
	 * @ModelAttribut 으로 binding error 발생시 BindException 발생한다. ref
	 *                https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html#mvc-ann-modelattrib-method-args
	 */
	@ExceptionHandler(BindException.class)
	protected void handleBindException(BindException e) {
	}

	/**
	 * enum type 일치하지 않아 binding 못할 경우 발생 주로 @RequestParam enum으로 binding 못했을 경우 발생
	 */
	@ExceptionHandler(MethodArgumentTypeMismatchException.class)
	protected String handleMethodArgumentTypeMismatchException(MethodArgumentTypeMismatchException e,
			HttpServletRequest request) {
		String urlFirstPath2 = (request.getServletPath().split("/"))[2]; // 기능
		String urlFirstPath3 = null;

		try {
			if (request.getServletPath().split("/")[3] != null) {
				urlFirstPath3 = (request.getServletPath().split("/"))[3]; // 기능
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		}

		if (urlFirstPath2.equals("reviewView")) {
			return "redirect:reviewListView";
		} else if (urlFirstPath3.equals("reviewView")) {
			return "redirect:reviewListView";
		} else {
			return "redirect:../../";
		}
	}

	/**
	 * 지원하지 않은 HTTP method 호출 할 경우 발생
	 */
	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	protected void handleHttpRequestMethodNotSupportedException(HttpRequestMethodNotSupportedException e) {
	}

	/**
	 * Authentication 객체가 필요한 권한을 보유하지 않은 경우 발생합
	 */
	@ExceptionHandler(AccessDeniedException.class)
	protected void handleAccessDeniedException(AccessDeniedException e) {
	}

	@ExceptionHandler(Exception.class)
	protected String handleException(Exception e, HttpServletRequest request) {
		String urlFirstPath2 = (request.getServletPath().split("/"))[2]; // 기능
		String urlFirstPath3 = (request.getServletPath().split("/"))[3]; // 기능

		if (urlFirstPath2.equals("dogView")) {
			return "redirect:../dogListView";
		} else if (urlFirstPath2.equals("reportView")) {
			return "redirect:../reportListView";
		} else if (urlFirstPath2.equals("reportModify")) {
			return "redirect:../reportListView";
		} else if (urlFirstPath3.equals("dogView")) {
			return "redirect:../dogListView";
		} else if (urlFirstPath3.equals("dogModify")) {
			return "redirect:../dogListView";
		} else if (urlFirstPath3.equals("reviewModify")) {
			return "redirect:reviewListView";
		} else if (urlFirstPath3.equals("reportView")) {
			return "redirect:../reportListView";
		} else {
			return "redirect:../../";
		}
	}
}