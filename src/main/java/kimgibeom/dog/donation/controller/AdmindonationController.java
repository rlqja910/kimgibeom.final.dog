package kimgibeom.dog.donation.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import kimgibeom.dog.donation.domain.Donation;
import kimgibeom.dog.donation.service.DonationService;

@Controller
@RequestMapping("/admin/donation")
public class AdmindonationController {
	@Autowired
	private DonationService donationService;

	@RequestMapping("/donationListView")
	public @ModelAttribute("sponsors") List<Donation> listDonationUsers(Model model) {
		int donaMon = donationService.readDonationMon();
		int donaTot = donationService.readDonationTot();
		model.addAttribute("donaMon", donaMon);
		model.addAttribute("donaTot", donaTot);
		
		return donationService.readSponsors();
	}
	

}
