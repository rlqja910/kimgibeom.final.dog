package kimgibeom.dog.review.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kimgibeom.dog.review.domain.Pagination;
import kimgibeom.dog.review.domain.Review;
import kimgibeom.dog.review.domain.ReviewReply;
import kimgibeom.dog.review.service.ReviewReplyService;
import kimgibeom.dog.review.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private ReviewReplyService reviewReplyService;

	@ExceptionHandler(MissingServletRequestParameterException.class)
	public String exception() {
		return "redirect:reviewListView";
	}

	@RequestMapping("/reviewListView")
	public String reviewList(Model model, @RequestParam(required = false, defaultValue = "1") int page,
			@RequestParam(required = false, defaultValue = "1") int range,
			@RequestParam(required = false, defaultValue = "true") String isData) {
		int listCnt = reviewService.readUserReviewCnt();
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, listCnt);

		if (isData.equals("true"))
			model.addAttribute("isData", true);
		else
			model.addAttribute("isData", false);

		model.addAttribute("pagination", pagination);
		model.addAttribute("reviewList", reviewService.readUserReviews(pagination));
		return "review/reviewListView";
	}

	@RequestMapping("/reviewView")
	public String reviewView(Model model, RedirectAttributes rttr, @RequestParam("reviewNum") int reviewNum,
			@RequestParam("page") int page, @RequestParam("range") int range) {
		List<ReviewReply> replies = reviewReplyService.readReviewReplies(reviewNum);
		int replySize = replies.size();

		int listCnt = reviewService.readUserReviewCnt();
		Pagination pagination = new Pagination();
		pagination.pageInfo(page, range, listCnt);

		Review review = reviewService.readReview(reviewNum);

		if (review == null) {
			rttr.addAttribute("isData", false);
			return "redirect:reviewListView";
		}

		model.addAttribute("replySize", replySize);
		model.addAttribute("page", page);
		model.addAttribute("range", range);
		model.addAttribute("reviewView", reviewService.readReview(reviewNum));
		model.addAttribute("replyList", replies);

		return "review/reviewView";
	}

	@RequestMapping("/mainReviewList")
	public String reviewList(Model model, RedirectAttributes rttr, @RequestParam("reviewNum") int reviewNum) {
		rttr.addAttribute("reviewNum", reviewNum);

		return "redirect:review/reviewView";
	}

	@RequestMapping("/mainReviewView")
	public String reviewView(Model model, @RequestParam("reviewNum") int reviewNum) {
		List<ReviewReply> replies = reviewReplyService.readReviewReplies(reviewNum);
		int replySize = replies.size();

		model.addAttribute("replySize", replySize);
		model.addAttribute("reviewView", reviewService.readReview(reviewNum));
		model.addAttribute("replyList", reviewReplyService.readReviewReplies(reviewNum));

		return "review/reviewView";
	}

	@ResponseBody
	@RequestMapping("/addReply")
	public int addReply(@RequestParam("content") String content, @RequestParam("userId") String userId,
			@RequestParam("reviewNumStr") String reviewNumStr, @ModelAttribute("reviewReply") ReviewReply reviewReply) {
		int reviewNum = Integer.parseInt(reviewNumStr);
		reviewReply = new ReviewReply(reviewNum, userId, content);

		return reviewReplyService.writeReviewReply(reviewReply);
	}

	@ResponseBody
	@RequestMapping("/delReply")
	public int delReply(@RequestParam("replyNumStr") String replyNumStr) {
		int replyNum = Integer.parseInt(replyNumStr);
		return reviewReplyService.removeReviewReply(replyNum);
	}
}