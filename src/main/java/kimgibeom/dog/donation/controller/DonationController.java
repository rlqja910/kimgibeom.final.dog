package kimgibeom.dog.donation.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kimgibeom.dog.donation.service.DonationService;

@Controller
@RequestMapping("/donation")
public class DonationController {
	@Autowired
	private DonationService donationService;

	@RequestMapping("/donate")
	public void donate(Model model) {
		int donaMon = donationService.readDonationMon();
		int donaTot = donationService.readDonationTot();
		model.addAttribute("donaMon", donaMon);
		model.addAttribute("donaTot", donaTot);
	}

	@RequestMapping(value = "donateProc", method = RequestMethod.POST)
	@ResponseBody
	public void addDonation(int price, String userId) {
		donationService.readDonations(userId, price);
	}
}
