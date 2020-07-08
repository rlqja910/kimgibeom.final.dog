package kimgibeom.dog.user.controller;

import java.sql.Date;

import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMessage.RecipientType;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kimgibeom.dog.user.domain.User;
import kimgibeom.dog.user.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private JavaMailSender mailSender;

	@RequestMapping("/mypage")
	public String userMypage() {
		return "user/userInfoPwConfirm";
	}

	@RequestMapping("/userWithdraw")
	public String userWithdraw() {
		return "user/userWithdraw";
	}

	@RequestMapping("/login")
	public void userLogin() {
	}

	@RequestMapping("/join") // 회원가입 버튼 누를시
	public void userJoin() {
	}

	@RequestMapping("/idFindIn") // 아이디찾기 입력 화면 이동
	public void idFindIn() {
	}

	@RequestMapping("/idFindOut") // 아이디 찾은 화면 이동
	public void idFindOut() {
	}

	@RequestMapping("/pwFindIn") // 비밀번호찾기 입력 화면 이동
	public void pwFindIn() {
	}

	@RequestMapping("/pwFindOut") // 비밀번호 새롭게 설정하는 화면 이동
	public void pwFindOut() {
	}

	@RequestMapping("/joinProc") // 회원가입ㄱ
	@ResponseBody
	public void userJoinProc(User user) {
		userService.writeUser(user);
	}

	@RequestMapping("/userInfoModify") // 회원정보 수정
	public void userInfoModify(HttpServletRequest request, Model model) {
		String userId = (String) request.getSession().getAttribute("userId");
		User user = userService.findUser(userId);

		model.addAttribute("user", user);
	}

	@RequestMapping("/userModify") // 입력한 사용자 내용 수정
	public void userModify(String userId, String userPw, String userName, String userPhone, String userEmail) {

		Date data = new Date(1111, 11, 11);
		User user = new User(userId, userPw, userName, userPhone, userEmail, data);
		userService.modUser(user);
	}

	@RequestMapping("/idCheck") // 회원가입시 중복확인
	@ResponseBody
	public boolean userIdCheck(String userId) {
		if (userService.idCheck(userId)) { // 중복이 아니면 true로 출력
			return true;
		} else { // 이미 사용중인 ID인 경우 false 값 return
			return false;
		}
	}

	@RequestMapping("/loginProc") // 로그인 정보확인
	@ResponseBody
	public int userLoginProc(HttpServletRequest request, String userId, String userPw) {
		String pw = userService.readuserPw(userId); // 입력한 ID의 PW를 추출// null일경우 아이디가 없다는 의미

		if (userPw.equals(pw)) { // 로그인 성공
			request.getSession().setAttribute("userId", userId);

			return 1;// 로그인 성공
		} else if (pw == null) { // 아이디가 없음
			return 0;// 아이디가 아예 없음
		} else {
			return -1; // 암호가 틀림
		}
	}

	@RequestMapping("/logout")
	public String userLogout(HttpServletRequest request) {
		request.getSession().invalidate();
		return "redirect:/user/login";
	}

	// 아이디 찾기
	@RequestMapping(value = "/idFindProc", method = RequestMethod.POST)
	@ResponseBody
	public User idFindIn(String name, String phone) {
		User user = userService.findUserId(name, phone);
		return user;
	}

	// 비밀번호 찾기위한 이에일 전송
	@RequestMapping(value = "/pwFindProc", method = RequestMethod.POST)
	@ResponseBody
	public String pwFindIn(String userId, String inEmail) {
		User user = userService.findUserMail(userId);
		String userEmail = user.getUserEmail();

		MimeMessage message = mailSender.createMimeMessage();
		int num = (int) (Math.random() * 1000000);
		String code = Integer.toString(num);

		try {
			message.addRecipient(RecipientType.TO, new InternetAddress(userEmail));
			message.setSubject("BEFF - 유기견 보호소 인증번호 발송");
			message.setText("<div style='background-color:#efefef; width:500px; padding: 20px;'>"
					+ "<div style='background-color:#fff; =padding:20px 0'>"
					+ "<h3 style='text-align:center;font-weight:bold;'><span style='color:#f5bf25; font-size:48px;'>♥</span><br><br> <span style='font-size:25px;color:#1bb1bb'>안녕하세요. BEFF 입니다</span></h3>"
					+ "<p style='text-align:center; margin-top:-5px;'>BEFF 비밀번호 찾기 인증번호는 다음과 같습니다</p>" +

					"<div style='margin: 50px 0px 30px 0px; text-align:center;'>" +

					"<ul  style='width: 260px; padding:15px 0px 15px 0px; border:1px solid #1bb1bb; border-radius:30px; margin:0 auto;'>"
					+ "<li style='list-style:none;'><p style='font-size:large; margin:0; font-weight:bold;'>인증번호:"
					+ "<span style='color:red; font-weight:bold;'>"+code+"</span></p></li>" + "</ul>" + "</div>"
					+ "</div>" + "</div>", "utf-8", "html");
		} catch (Exception e) {
			e.printStackTrace();
		}

		// 사용자email과 입력email이 같으면 메일 전송
		if (userEmail.equals(inEmail)) {
			mailSender.send(message);
		} else {
			return "0";
		}
		return code;
	}

	// 유저의 새 비밀번호 설정
	@RequestMapping(value = "/pwFindOutProc", method = RequestMethod.POST)
	@ResponseBody
	public boolean pwFindOut(String userId, String userPw) {
		return userService.modPw(userId, userPw);
	}

	// 회원 탈퇴
	@RequestMapping(value = "/pwCheck", method = RequestMethod.POST)
	@ResponseBody
	public boolean pwCheck(String userId, String userPw, HttpServletRequest request) {
		String pw = userService.readuserPw(userId);

		if (pw.equals(userPw)) {
			userService.withdrawUser(userId);
			request.getSession().invalidate();

			return true;
		} else {
			return false;
		}
	}

	// 회원 수정(회원 비밀번호 체크)
	@RequestMapping(value = "/pwConfirm", method = RequestMethod.POST)
	@ResponseBody
	public boolean pwConfirm(String userId, String userPw) {
		String pw = userService.readuserPw(userId);

		if (pw.equals(userPw)) {
			return true;
		} else {
			return false;
		}
	}

}