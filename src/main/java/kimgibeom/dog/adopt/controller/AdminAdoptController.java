package kimgibeom.dog.adopt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptSearch;
import kimgibeom.dog.adopt.service.AdoptService;

@Controller
@RequestMapping("admin/adopt")
public class AdminAdoptController {
	@Autowired
	private AdoptService adoptService;

	@RequestMapping("/adoptListView")
	public String adoptListView(Model model, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "전체") String searchType) {
		AdoptSearch adoptSearch = new AdoptSearch();
		if (searchType.equals("전체"))
			searchType = "";
		adoptSearch.setSearchType(searchType);

		int listCnt = adoptService.raedAdoptListCnt(adoptSearch);
		adoptSearch.pageInfo(page, range, listCnt);

		List<Adopt> adopts = adoptService.raedAdopts(adoptSearch);
		if (adopts.size() == 0 && page != 1) {
			if (page == adoptSearch.getStartPage()) {
				range = range - 1;
			}
			page = page - 1;

			adoptSearch.pageInfo(page, range, listCnt);
			adopts = adoptService.raedAdopts(adoptSearch);
			model.addAttribute("isDataDel", false);
			model.addAttribute("pageNo", page);
		} else {
			model.addAttribute("isDataDel", true);
			model.addAttribute("pageNo", true);
		}

		model.addAttribute("pagination", adoptSearch);
		model.addAttribute("adoptList", adopts);

		return "admin/adopt/adoptListView";
	}

	@RequestMapping(value = "/adoptProc")
	public String adoptProc(int adoptNum, int dogNum) {
		adoptService.outAdopt(adoptNum, dogNum);
		adoptService.successAdopt(adoptNum, dogNum);

		return "admin/adopt/adoptListView";
	}

	@RequestMapping(value = "/adoptCancel")
	public String adoptCancel(int adoptNum) {
		adoptService.removeAdopt(adoptNum);

		return "admin/adopt/adoptListView";
	}
}
