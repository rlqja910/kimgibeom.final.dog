package kimgibeom.dog.adopt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptPagination;
import kimgibeom.dog.adopt.service.AdoptService;

@Controller
@RequestMapping("admin/adopt")
public class AdminAdoptController {
	@Autowired
	private AdoptService adoptService;

	@RequestMapping("/adoptListView")
	public String adoptListView(Model model, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range) {
		int listCnt = adoptService.raedAdoptListCnt();
		AdoptPagination adoptPagination = new AdoptPagination();

		adoptPagination.pageInfo(page, range, listCnt);

		List<Adopt> adopts = adoptService.raedAdopts(adoptPagination);
		if (adopts.size() == 0 && page != 1) {
			if (page == adoptPagination.getStartPage()) {
				range = range - 1;
			}
			page = page - 1;

			adoptPagination.pageInfo(page, range, listCnt);
			adopts = adoptService.raedAdopts(adoptPagination);
			model.addAttribute("isDataDel", false);
			model.addAttribute("pageNo", page);
		} else {
			model.addAttribute("isDataDel", true);
			model.addAttribute("pageNo", true);
		}

		model.addAttribute("pagination", adoptPagination);
		model.addAttribute("adoptList", adopts);

		return "admin/adopt/adoptListView";
	}
}
