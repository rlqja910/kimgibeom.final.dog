package kimgibeom.dog.user.controller;

import java.sql.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kimgibeom.dog.user.domain.User;
import kimgibeom.dog.user.domain.UserSearch;
import kimgibeom.dog.user.service.UserService;

@Controller
@RequestMapping("/admin/user")
public class AdminUserController {
	@Autowired
	private UserService userService;

	@RequestMapping("/userListView")
	public String moveUserListView(Model model, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false) String keyword,
			@RequestParam(required = false, defaultValue = "userId") String searchType) {
		UserSearch userSearch = new UserSearch();

		if (keyword == null)
			keyword = "";
		userSearch.setSearchType(searchType);
		userSearch.setKeyword(keyword);

		int listCnt = userService.readUserListCnt(userSearch);
		userSearch.pageInfo(page, range, listCnt);

		List<User> users = userService.readUserList(userSearch);
		if (users.size() == 0 && page != 1) {
			if (page == userSearch.getStartPage())
				range = range - 1;
			page = page - 1;

			userSearch.pageInfo(page, range, listCnt);
			users = userService.readUserList(userSearch);
			model.addAttribute("isDataDel", false);
			model.addAttribute("pageNo", page);
		} else {
			model.addAttribute("isDataDel", true);
			model.addAttribute("pageNo", true);
		}

		model.addAttribute("pagination", userSearch);
		model.addAttribute("userList", users);

		return "admin/user/userListView";
	}

	@ResponseBody
	@RequestMapping("/userDel")
	public void userDel(@RequestParam(value = "userIds[]") List<String> userIds) {
		for (String userId : userIds) {
			userService.withdrawUser(userId);
		}
	}

	@RequestMapping("/userModify/{userId}")
	public String userDel(@PathVariable String userId, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range, Model model) {

		User user = userService.findUser(userId);

		model.addAttribute("user", user);
		model.addAttribute("page", page);
		model.addAttribute("range", range);

		return "admin/user/userModify";
	}

	@RequestMapping("/userModifyProc")
	@ResponseBody
	public String userModify(User user, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range, Model model) {
		System.out.println(user.getUserEmail());
		System.out.println(user.getUserId());
		System.out.println(user.getUserName());

		userService.modUser(user);

		return "admin/user/userModify/" + user.getUserId() + "?page=" + page + "&range=" + range;
	}

	@RequestMapping("/userRegist")
	public void userRegist() {
	}

	// 관리자 회원 등록

	@RequestMapping(value = "/userRegistProc", method = RequestMethod.POST)
	public void userRegistProc(String userId, String userPw, String userName, String userPhone, String userEmail) {
		Date data = new Date(1111, 11, 11);
		User user = new User(userId, userPw, userName, userPhone, userEmail, data);
		userService.writeUser(user);
	}

	// 관리자 회원 등록 시 id중복 체크
	@RequestMapping("/idCheck")
	@ResponseBody
	public boolean idCheck(String userId) {
		if (userService.idCheck(userId)) { // 중복이 아니면 true로 출력
			return true;
		} else { // 이미 사용중인 ID인 경우 false 값 return
			return false;
		}
	}
}
