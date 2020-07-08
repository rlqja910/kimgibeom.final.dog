package kimgibeom.dog;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import kimgibeom.dog.dog.domain.Dog;
import kimgibeom.dog.dog.service.DogService;
import kimgibeom.dog.report.domain.Report;
import kimgibeom.dog.report.domain.SearchCriteria;
import kimgibeom.dog.report.service.ReportService;
import kimgibeom.dog.review.domain.ReviewReply;
import kimgibeom.dog.review.service.ReviewReplyService;
import kimgibeom.dog.review.service.ReviewService;

@Controller
@RequestMapping
public class MainController {
	@Autowired
	private DogService dogService;
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private ReportService reportService;

	@RequestMapping("/admin") // admin 페이지 메인
	public String adminMain(Model model, SearchCriteria scri) {
		List<Dog> dogsList = dogService.readDogs();
		model.addAttribute("abandonDogList", dogsList);

		scri.setPerPageNum(10);
		List<Report> reports = reportService.readReports(scri);
		model.addAttribute("reports", reports);
		
		return "admin/main";
	}

	@RequestMapping("/") // 사용자 페이지 메인
	public String userMain(Model model) {
		Date today = new Date();

		SimpleDateFormat date = new SimpleDateFormat("yyyy-MM-dd");

		int totalDogCnt = dogService.readTotalAbandonDogsCnt();
		int todayDogCnt = dogService.readTodayFindDogsCnt(date.format(today));
		int afterAdoptDogCnt = dogService.readAfterAdoptDogCnt();

		model.addAttribute("totalDogCnt", totalDogCnt);
		model.addAttribute("todayDogCnt", todayDogCnt);
		model.addAttribute("afterAdoptDogCnt", afterAdoptDogCnt);
		model.addAttribute("mainDogList", dogService.readDogs());
		
		model.addAttribute("mainReviewList", reviewService.readReviews());

		return "main";
	}
}