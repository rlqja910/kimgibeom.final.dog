package kimgibeom.dog.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class AdminCheckInterceptor extends HandlerInterceptorAdapter {
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean isCheck = true;
		String urlFirstPath = (request.getServletPath().split("/"))[1]; // 묹자열 admin 추출, url servletPath 맨앞만 추출
		try {
			if (urlFirstPath.equals("admin")) { // url 쳐서 관리자페이지로 가려고할경우
				if (((String) request.getSession().getAttribute("userId")) == null) { // 현재 로그인 안했을경우 사용자페이지 main으로
																						// 진입
					response.sendRedirect("/dog");
					return false;
				} else if (((String) request.getSession().getAttribute("userId")).equals("admin")) { // 현재 관리자계정이면 진입
				} else if (((String) request.getSession().getAttribute("userId")) != null) {// 관리자가 아닌 사용자로 로그인 했을경우
																							// 사용자페이지 main으로 진입
					response.sendRedirect("/dog");
					return false;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return isCheck;
	}
}
