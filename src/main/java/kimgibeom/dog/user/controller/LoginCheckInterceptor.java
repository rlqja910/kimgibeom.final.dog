package kimgibeom.dog.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		boolean isCheck = true;
		String urlFirstPath = (request.getServletPath().split("/"))[2]; // 기능
		try {
			if (urlFirstPath.equals("login") || urlFirstPath.equals("join")) { // url 쳐서 로그인이나 회원가입 페이지 이동시
				if (request.getSession().getAttribute("userId") == null) { // 로그인 안되어있으면 로그인,회원가입 페이지 진입가능
				} else { // // 로그인 되어있으면 로그인,회원가입 페이지 진입거부(사용자페이지 메인으로 이동)
					response.sendRedirect("/dog");
					return false;
				}
			}
			if (urlFirstPath.equals("userWithdraw")) { // 로그인 안되어있으면 회원탈퇴 페이지 접근불가
				if (request.getSession().getAttribute("userId") == null) {
					response.sendRedirect("/dog");
					return false;
				}
			}
			if (urlFirstPath.equals("reportRegister")) {// 로그인 안되어있으면 신고등록 페이지 접근불가
				if (request.getSession().getAttribute("userId") == null) {
					response.sendRedirect("/dog");
					return false;
				}
			}
			if (urlFirstPath.equals("mypage")) {// 로그인 안되어있으면 마이페이지 접근불가
				if (request.getSession().getAttribute("userId") == null) {
					response.sendRedirect("/dog");
					return false;
				}
			}
			if (urlFirstPath.equals("userInfoModify")) {// 로그인 안되어있으면 회원수정 접근불가
				if (request.getSession().getAttribute("userId") == null) {
					response.sendRedirect("/dog");
					return false;
				}
			}
			if (urlFirstPath.equals("adoptReservationView")) {// 로그인 안되어있으면 예약조회 접근불가
				if (request.getSession().getAttribute("userId") == null) {
					response.sendRedirect("/dog");
					return false;
				}
			}
			if (urlFirstPath.equals("reportModify")) {// 로그인 안되어있으면 신고수정 접근불가
				if (request.getSession().getAttribute("userId") == null) {
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