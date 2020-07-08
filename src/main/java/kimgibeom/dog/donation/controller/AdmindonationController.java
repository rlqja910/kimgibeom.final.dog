package kimgibeom.dog.donation.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import kimgibeom.dog.donation.domain.Donation;
import kimgibeom.dog.donation.service.DonationService;

@Controller
@RequestMapping("/admin/donation")
public class AdmindonationController {
	@Autowired
	private DonationService donationService;

	@RequestMapping("/donationListView")
	public void donationListView(Model model) throws JsonProcessingException {
		List<Donation> sponsors = donationService.readSponsors();

		int sponsorsCnt = sponsors.size(); 
		model.addAttribute("sponsorsCnt", sponsorsCnt);

		ObjectMapper mapper = new ObjectMapper();
		int pageCnt = 0;

		if (sponsorsCnt % 10 == 0) {
			pageCnt = sponsorsCnt / 10; 
		} else {
			pageCnt = sponsorsCnt / 10 + 1;
		}

		model.addAttribute("totalPageCnt", pageCnt);

		int lastPageDataCnt = sponsorsCnt % 10; 
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 10;
		}
		if (sponsorsCnt == 0) {
			lastPageDataCnt = 0;
		}
		model.addAttribute("lastPageDataCnt", lastPageDataCnt);

		if (0 < sponsorsCnt && sponsorsCnt <= 10) { 
			model.addAttribute("isOnePage", "true"); 

			String Jsonsponsors = mapper.writeValueAsString(sponsors); // sponsors를 문자열 형식으로 변환
			model.addAttribute("onlyOnePageData", Jsonsponsors);

		} else if (sponsorsCnt == 0) {
			model.addAttribute("isOnePage", "true");
			model.addAttribute("pageData", "empty");

		} else {
			try {
				model.addAttribute("isOnePage", "false"); 
				List<Donation> sponsorList = new ArrayList<Donation>();
				for (int i = 1; i <= pageCnt; i++) { 

					if (i == pageCnt) { 
						int cnt = 0;
						for (int j = 1; j <= lastPageDataCnt; j++) {
							sponsorList.add(sponsors.get((i - 1) * 10 + cnt++));
						}
					}else {
						int cnt = 0;
						for (int j = 1; j <= 10; j++) { 
							sponsorList.add(sponsors.get((i - 1) * 10 + cnt++));
						}
					}
				}

				String JsonsponsorList = mapper.writeValueAsString(sponsorList);
				model.addAttribute("pageData", JsonsponsorList); 

			}catch (Exception e) {
				e.printStackTrace();
			}
		}

		int donaMon = donationService.readDonationMon();
		int donaTot = donationService.readDonationTot();
		model.addAttribute("donaMon", donaMon);
		model.addAttribute("donaTot", donaTot);
	}
	
	@RequestMapping(value= "/searchProc")
	@ResponseBody
	public HashMap<String, Object> searchSponsor(String userName) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		
		List<Donation> sponsors = donationService.readSponsors(userName);
		
		int sponsorsCnt = sponsors.size(); 
		map.put("sponsorsCnt", sponsorsCnt);
		
		int pageCnt = 0;

		if (sponsorsCnt % 10 == 0) {
			pageCnt = sponsorsCnt / 10; 
		} else {
			pageCnt = sponsorsCnt / 10 + 1;
		}
		map.put("totalPageCnt", pageCnt);

		int lastPageDataCnt = sponsorsCnt % 10; 
		if (lastPageDataCnt == 0) {
			lastPageDataCnt = 10;
		}
		if (sponsorsCnt == 0) {
			lastPageDataCnt = 0;
		}
		map.put("lastPageDataCnt", lastPageDataCnt);

		if (0 < sponsorsCnt && sponsorsCnt <= 10) { 
			map.put("isOnePageData", true);
			map.put("onlyOnePageData", sponsors);
			map.put("isOnePage", true);

		} else if (sponsorsCnt == 0) {
			map.put("isOnePage", true);
			map.put("pageData", "empty");

		} else {
			map.put("isOnePage", false);
				List<Donation> sponsorList = new ArrayList<Donation>();
				for (int i = 1; i <= pageCnt; i++) { 

					if (i == pageCnt) { 
						int cnt = 0;
						for (int j = 1; j <= lastPageDataCnt; j++) {
							sponsorList.add(sponsors.get((i - 1) * 10 + cnt++));
						}
					}else {
						int cnt = 0;
						for (int j = 1; j <= 10; j++) { 
							sponsorList.add(sponsors.get((i - 1) * 10 + cnt++));
						}
					}
				}
				map.put("pageData", sponsorList);
		}
		return map;
	}
}
