package kimgibeom.dog.dog.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kimgibeom.dog.dog.domain.Dog;
import kimgibeom.dog.dog.service.DogService;
import net.sf.json.JSONArray;

@Controller
@RequestMapping("/admin/dog")
public class adminDogController {
	@Autowired
	private DogService dogService;
	@Value("${dogAttachDir}")
	private String attachDir;

	@RequestMapping("/dogDelProc")
	public String dogDel(String delDogsNum) {
		List<String> delDogsNumList = JSONArray.fromObject(delDogsNum);

		for (int i = 0; i < delDogsNumList.size(); i++) {
			int dogNum = Integer.parseInt(delDogsNumList.get(i));
			dogService.removeDog(dogNum);
		}

		return "admin/dog/dogListView";
	}

	@RequestMapping("/dogModify/{dogNumber}")
	public String dogModify(@PathVariable String dogNumber, Model model, RedirectAttributes re) {
		int dogNum = Integer.parseInt(dogNumber);
		Dog dog = dogService.findDog(dogNum);

		if (dog == null) {
			re.addAttribute("isData", false);
			return "redirect:../dogListView";
		}

		model.addAttribute("dog", dog);

		return "admin/dog/dogModify";
	}

	@RequestMapping(value = "/dogModify/{dogNumber}", method = RequestMethod.POST)
	public String dogModifyProc(@PathVariable String dogNumber, String dogTitle, String dogName, String dogKind,
			int dogWeight, int dogAge, String dogEntranceDate, String dogGender, String dogContent,
			MultipartFile attachFile, HttpServletRequest request) {
		String fileName = (int) (Math.random() * 100000000) + attachFile.getOriginalFilename(); // 파일명 중복방지
		int dogNum = Integer.parseInt(dogNumber);
		int urlDogNum = 0;

		if (attachFile.getOriginalFilename().equals("")) {
			Dog dog = new Dog(dogNum, dogTitle, dogName, dogAge, dogKind, dogWeight, dogGender, "", dogEntranceDate,
					dogContent, "");
			dogService.changeDogInfoWithoutImg(dog);
			urlDogNum = dog.getDogNum();
		} else {
			try {
				Dog dog = new Dog(dogNum, dogTitle, dogName, dogAge, dogKind, dogWeight, dogGender, "", dogEntranceDate,
						dogContent, fileName);
				dogService.changeDogInfo(dog); // dog 추가
				urlDogNum = dog.getDogNum();

				String dir = request.getServletContext().getRealPath(attachDir);

				save(dir + "/" + fileName, attachFile);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:../dogView/" + urlDogNum;
	}

	@RequestMapping("/dogView/{dogNumber}")
	public String readDogInfo(@PathVariable String dogNumber, Model model, RedirectAttributes re) {
		int dogNum = Integer.parseInt(dogNumber);
		Dog dog = dogService.findDog(dogNum);

		if (dog == null) {
			re.addAttribute("isData", false);
			return "redirect:../dogListView";
		}

		model.addAttribute("dog", dog);

		return "admin/dog/dogView";
	}

	@RequestMapping(value = "/dogRegist")
	public void dogRegistPage() {
	}

	@RequestMapping(value = "/dogRegist", method = RequestMethod.POST)
	public String dogRegist(String dogTitle, String dogName, String dogKind, int dogWeight, int dogAge,
			String dogEntranceDate, String dogGender, String dogContent, MultipartFile attachFile,
			HttpServletRequest request) {
		String fileName = (int) (Math.random() * 100000000) + attachFile.getOriginalFilename(); // 파일명 중복방지

		try {
			Dog dog = new Dog(1, dogTitle, dogName, dogAge, dogKind, dogWeight, dogGender, "", dogEntranceDate,
					dogContent, fileName);

			dogService.writeDog(dog); // dog 추가

			String dir = request.getServletContext().getRealPath(attachDir);

			save(dir + "/" + fileName, attachFile);
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "redirect:dogListView";
	}

	private void save(String filePath, MultipartFile attachFile) {
		try {
			attachFile.transferTo(new File(filePath));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@RequestMapping("/dogListView")
	public void dogListView(Model model, @RequestParam(required = false, defaultValue = "true") String isData) {
		model.addAttribute("totalPageCnt", "null");
		model.addAttribute("dogsCnt", "null");
		model.addAttribute("lastPageDataCnt", "null");
		model.addAttribute("onlyOnePageData", "null");
		model.addAttribute("isOnePage", "null");
		model.addAttribute("pageData", "null");

		if (isData.equals("true")) {
			model.addAttribute("isData", true);
		} else {
			model.addAttribute("isData", false);
		}

		List<Dog> dogs = dogService.readDogs();
		JSONArray jsonDogArray = new JSONArray();

		int dogsCnt = dogs.size(); // 데이터 개수
		model.addAttribute("dogsCnt", dogsCnt);
		int pageCnt = 0;
		if (dogsCnt % 8 == 0) {
			pageCnt = dogsCnt / 8; // 총 페이지 개수 (마지막 페이지 번호)
		} else {
			pageCnt = dogsCnt / 8 + 1;
		}
		// 총페이지 개수 model 저장-------------------------
		model.addAttribute("totalPageCnt", pageCnt);
		int lastPageDataCnt = dogsCnt % 8;// 마지막 페이지 데이터 개수
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 8;
		}
		if (dogsCnt == 0) {
			lastPageDataCnt = 0;
		}
		model.addAttribute("lastPageDataCnt", lastPageDataCnt);
		if (dogsCnt > 0 && dogsCnt <= 8) { // 데이터가 8개 이하면 페이지가 1페이지밖에 없으므로 기억해둔다.
			model.addAttribute("isOnePage", "true");// 데이터가 8개 이하인지 boolean값 model

			model.addAttribute("onlyOnePageData", jsonDogArray.fromObject(dogs));// 데이터가 8개 이하면 dog값들 model
			// 저장-------------------------
		} else if (dogsCnt == 0) {
			model.addAttribute("isOnePage", "true");
			model.addAttribute("pageData", "empty");
		} else {
			model.addAttribute("isOnePage", "false");// 데이터가 9개 이상인지 boolean값 model
														// 저장-------------------------
			List<Dog> dogList = new ArrayList<Dog>();
			for (int i = 1; i <= pageCnt; i++) { // 모든페이지 데이터를 저장한다.
				if (i == pageCnt) { // 마지막 페이지 저장할때
					int cnt = 0;
					for (int j = 1; j <= lastPageDataCnt; j++) {
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				} else {
					int cnt = 0;
					for (int j = 1; j <= 8; j++) {// 마지막 페이지가 아닌 데이터들을 저장할때
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				}
			}
			model.addAttribute("pageData", jsonDogArray.fromObject(dogList));// 모든페이지 데이터 저장
		}
	}

	@RequestMapping("/dogSearch") // 검색 리스트 추출
	@ResponseBody
	public HashMap<String, Object> getDogs(String dogTitle) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Dog> dogs = dogService.findDogsForTitle(dogTitle);
		JSONArray jsonDogArray = new JSONArray();
		int dogsCnt = dogs.size(); // 데이터 개수
		map.put("dogsCnt", dogsCnt);
		int pageCnt = 0;
		if (dogsCnt % 8 == 0) {
			pageCnt = dogsCnt / 8; // 총 페이지 개수 (마지막 페이지 번호)
		} else {
			pageCnt = dogsCnt / 8 + 1;
		}
		// 총페이지 개수 model 저장-------------------------
		map.put("totalPageCnt", pageCnt);
		int lastPageDataCnt = dogsCnt % 8;// 마지막 페이지 데이터 개수
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 8;
		}
		if (dogsCnt == 0) {
			lastPageDataCnt = 0;
		}
		map.put("lastPageDataCnt", lastPageDataCnt);
		if (dogsCnt > 0 && dogsCnt <= 8) { // 데이터가 8개 이하면 페이지가 1페이지밖에 없으므로 기억해둔다.
			// 데이터가 8개 이하인지 boolean값
			// 저장-------------------------
			map.put("isOnePage", true);
			// 데이터가
			// 8개 이하면 dog값들
			map.put("onlyOnePageData", dogs);
			// 저장-------------------------
		} else if (dogsCnt == 0) {
			map.put("isOnePage", true);
			map.put("pageData", "empty");
		} else {
			// 데이터가 9개 이상인지 boolean값
			// 저장-------------------------
			map.put("isOnePage", false);
			List<Dog> dogList = new ArrayList<Dog>();
			for (int i = 1; i <= pageCnt; i++) { // 모든페이지 데이터를 저장한다.
				if (i == pageCnt) { // 마지막 페이지 저장할때
					int cnt = 0;
					for (int j = 1; j <= lastPageDataCnt; j++) {
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				} else {
					int cnt = 0;
					for (int j = 1; j <= 8; j++) {// 마지막 페이지가 아닌 데이터들을 저장할때
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				}
			}
			// 모든페이지 데이터
			// 저장
			map.put("pageData", dogList);
		}
		return map;
	}

	@RequestMapping("/beforeAdoptSearch") // 검색 리스트 추출
	@ResponseBody
	public HashMap<String, Object> searchBeforeAdopt(String dogTitle) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Dog> dogs = dogService.findBeforeAdoptDogs(dogTitle);
		JSONArray jsonDogArray = new JSONArray();
		int dogsCnt = dogs.size(); // 데이터 개수
		map.put("dogsCnt", dogsCnt);
		int pageCnt = 0;
		if (dogsCnt % 8 == 0) {
			pageCnt = dogsCnt / 8; // 총 페이지 개수 (마지막 페이지 번호)
		} else {
			pageCnt = dogsCnt / 8 + 1;
		}
		// 총페이지 개수저장-------------------------
		map.put("totalPageCnt", pageCnt);
		int lastPageDataCnt = dogsCnt % 8;// 마지막 페이지 데이터 개수
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 8;
		}
		if (dogsCnt == 0) {
			lastPageDataCnt = 0;
		}
		map.put("lastPageDataCnt", lastPageDataCnt);
		if (dogsCnt > 0 && dogsCnt <= 8) { // 데이터가 8개 이하면 페이지가 1페이지밖에 없으므로 기억해둔다.
			// 데이터가 8개 이하인지 boolean값
			// 저장-------------------------
			map.put("isOnePage", true);
			// 데이터가
			// 8개 이하면 dog값들
			map.put("onlyOnePageData", dogs);
			// 저장-------------------------
		} else if (dogsCnt == 0) {
			map.put("isOnePage", true);
			map.put("pageData", "empty");
		} else {
			// 데이터가 9개 이상인지 boolean값
			// 저장-------------------------
			map.put("isOnePage", false);
			List<Dog> dogList = new ArrayList<Dog>();
			for (int i = 1; i <= pageCnt; i++) { // 모든페이지 데이터를 저장한다.
				if (i == pageCnt) { // 마지막 페이지 저장할때
					int cnt = 0;
					for (int j = 1; j <= lastPageDataCnt; j++) {
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				} else {
					int cnt = 0;
					for (int j = 1; j <= 8; j++) {// 마지막 페이지가 아닌 데이터들을 저장할때
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				}
			}
			// 모든페이지 데이터
			// 저장
			map.put("pageData", dogList);
		}
		return map;
	}

	@RequestMapping("/afterAdoptSearch") // 검색 리스트 추출
	@ResponseBody
	public HashMap<String, Object> searchAfterAdopt(String dogTitle) {
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<Dog> dogs = dogService.findAfterAdoptDogs(dogTitle);
		JSONArray jsonDogArray = new JSONArray();
		int dogsCnt = dogs.size(); // 데이터 개수
		map.put("dogsCnt", dogsCnt);
		int pageCnt = 0;
		if (dogsCnt % 8 == 0) {
			pageCnt = dogsCnt / 8; // 총 페이지 개수 (마지막 페이지 번호)
		} else {
			pageCnt = dogsCnt / 8 + 1;
		}
		// 총페이지 개수 저장-------------------------
		map.put("totalPageCnt", pageCnt);
		int lastPageDataCnt = dogsCnt % 8;// 마지막 페이지 데이터 개수
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 8;
		}
		if (dogsCnt == 0) {
			lastPageDataCnt = 0;
		}
		map.put("lastPageDataCnt", lastPageDataCnt);
		if (dogsCnt > 0 && dogsCnt <= 8) { // 데이터가 8개 이하면 페이지가 1페이지밖에 없으므로 기억해둔다.
			// 데이터가 8개 이하인지 boolean값
			// 저장-------------------------
			map.put("isOnePage", true);
			// 데이터가
			// 8개 이하면 dog값들
			map.put("onlyOnePageData", dogs);
			// 저장-------------------------
		} else if (dogsCnt == 0) {
			map.put("isOnePage", true);
			map.put("pageData", "empty");
		} else {
			// 데이터가 9개 이상인지 boolean값
			// 저장-------------------------
			map.put("isOnePage", false);
			List<Dog> dogList = new ArrayList<Dog>();
			for (int i = 1; i <= pageCnt; i++) { // 모든페이지 데이터를 저장한다.
				if (i == pageCnt) { // 마지막 페이지 저장할때
					int cnt = 0;
					for (int j = 1; j <= lastPageDataCnt; j++) {
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				} else {
					int cnt = 0;
					for (int j = 1; j <= 8; j++) {// 마지막 페이지가 아닌 데이터들을 저장할때
						dogList.add(dogs.get((i - 1) * 8 + cnt++));
					}
				}
			}
			// 모든페이지 데이터
			// 저장
			map.put("pageData", dogList);
		}
		return map;
	}
}