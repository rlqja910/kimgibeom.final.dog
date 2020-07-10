package kimgibeom.dog.adopt.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.service.AdoptService;
import kimgibeom.dog.dog.domain.Dog;
import kimgibeom.dog.user.domain.User;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/adopt")
public class AdoptController {
	@Autowired
	private AdoptService adoptService;

	@RequestMapping("/userPwConfirm")
	@ResponseBody
	public boolean userPwConfirmProc(String userPw, HttpServletRequest request) {
		boolean isCorrect = false;
		String userId = (String) request.getSession().getAttribute("userId");
		String originalUserPw = adoptService.readUserPw(userId);

		if (userPw.equals(originalUserPw)) {
			isCorrect = true;
		}

		return isCorrect;
	}

	@RequestMapping(value = "/adoptCancel")
	public String adoptCancel(int adoptNum) {
		adoptService.removeAdopt(adoptNum);

		return "adopt/adoptReservationView";
	}

	@RequestMapping("/reservation")
	@ResponseBody
	public boolean reservationProc(int dogNum, HttpServletRequest request, Model model) {
		String userId = (String) request.getSession().getAttribute("userId");

		List<Adopt> reservationUsersForDogNum = adoptService.readReservationUsersForDogNum(dogNum);

		for (Adopt adopt : reservationUsersForDogNum) {
			if (adopt.getUserId().equals(userId)) {
				model.addAttribute("alreadyReservation", true); // 예약이 이미 되어있다면 모델에 기록하고 바로 false 리턴
				return false;
			}
		}

		if (adoptService.writeReservation(new Adopt(1, "1111-11-11", new Dog(dogNum), new User(userId)))) {
			return true;
		} else {
			return false;
		}
	}

	@RequestMapping("/adoptReservationView")
	public void adoptReservationView(HttpServletRequest request, Model model) {
		String userId = (String) request.getSession().getAttribute("userId");
		List<Adopt> userAdoptList = adoptService.readReservationForUserId(userId);

		model.addAttribute("totalPageCnt", "null");
		model.addAttribute("adoptsCnt", "null");
		model.addAttribute("lastPageDataCnt", "null");
		model.addAttribute("onlyOnePageData", "null");
		model.addAttribute("isOnePage", "null");
		model.addAttribute("pageData", "null");

		JSONArray jsonDogArray = new JSONArray();

		int adoptsCnt = userAdoptList.size(); // 데이터 개수
		model.addAttribute("adoptsCnt", adoptsCnt);

		int pageCnt = 0;
		if (adoptsCnt % 8 == 0) {
			pageCnt = adoptsCnt / 8; // 총 페이지 개수 (마지막 페이지 번호)
		} else {
			pageCnt = adoptsCnt / 8 + 1;
		}
		// 총페이지 개수 model 저장-------------------------
		model.addAttribute("totalPageCnt", pageCnt);

		int lastPageDataCnt = adoptsCnt % 8;// 마지막 페이지 데이터 개수
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 8;
		}
		if (adoptsCnt == 0) {
			lastPageDataCnt = 0;
		}
		model.addAttribute("lastPageDataCnt", lastPageDataCnt);

		if (adoptsCnt > 0 && adoptsCnt <= 8) { // 데이터가 8개 이하면 페이지가 1페이지밖에 없으므로 기억해둔다.
			model.addAttribute("isOnePage", "true");// 데이터가 8개 이하인지 boolean값 model
													// 저장-------------------------
			model.addAttribute("onlyOnePageData", jsonDogArray.fromObject(userAdoptList));// 데이터가 8개 이하면 dog값들 model
			// 저장-------------------------
		} else if (adoptsCnt == 0) {
			model.addAttribute("isOnePage", "true");
			model.addAttribute("pageData", "empty");
		} else {
			model.addAttribute("isOnePage", "false");// 데이터가 9개 이상인지 boolean값 model
														// 저장-------------------------
			List<Adopt> adoptList = new ArrayList<Adopt>();
			for (int i = 1; i <= pageCnt; i++) { // 모든페이지 데이터를 저장한다.

				if (i == pageCnt) { // 마지막 페이지 저장할때
					int cnt = 0;
					for (int j = 1; j <= lastPageDataCnt; j++) {
						adoptList.add(userAdoptList.get((i - 1) * 8 + cnt++));
					}
				} else {
					int cnt = 0;
					for (int j = 1; j <= 8; j++) {// 마지막 페이지가 아닌 데이터들을 저장할때
						adoptList.add(userAdoptList.get((i - 1) * 8 + cnt++));
					}
				}
			}
			model.addAttribute("pageData", jsonDogArray.fromObject(adoptList));// 모든페이지 데이터 저장
		}
	}
}