package kimgibeom.dog.report.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kimgibeom.dog.report.domain.PageMaker;
import kimgibeom.dog.report.domain.Report;
import kimgibeom.dog.report.domain.ReportReply;
import kimgibeom.dog.report.domain.SearchCriteria;
import kimgibeom.dog.report.service.ReportReplyService;
import kimgibeom.dog.report.service.ReportService;

@Controller
@RequestMapping("/admin/report")
public class AdminReportController {
	@Autowired
	private ReportService reportService;
	@Autowired
	private ReportReplyService reportReplyService;

	// 게시물 목록
	@RequestMapping("/reportListView")
	public void readReports(Model model, SearchCriteria scri,
			@RequestParam(required = false, defaultValue = "true") String isData) {

		if (isData.equals("true")) {
			model.addAttribute("isData", true);
		} else {
			model.addAttribute("isData", false);
		}

		model.addAttribute("reports", reportService.readReports(scri));

		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(scri);
		pageMaker.setTotalCount(reportService.readListCnt(scri));

		model.addAttribute("pageMaker", pageMaker);
	}

	// 게시물 상세 조회
	@RequestMapping("/reportView/{reportNum}")
	public String readReport(@PathVariable String reportNum, Model model, RedirectAttributes re) {
		// 게시물
		int reportNo = Integer.parseInt(reportNum);
		Report report = reportService.readReport(reportNo);
		model.addAttribute("report", report);

		if (report == null) {
			re.addAttribute("isData", false);
			return "redirect:../reportListView";
		}

		// 댓글
		List<ReportReply> replies = reportReplyService.readReportReplies();
		List<ReportReply> repliesOfReport = new ArrayList<ReportReply>();
		for (int idx = 0; idx < replies.size(); idx++) {
			if (replies.get(idx).getReportNum() == reportNo) {
				repliesOfReport.add(replies.get(idx));
			}
		}
		model.addAttribute("replies", repliesOfReport);

		return "admin/report/reportView";
	}

	// 게시물 삭제
	@ResponseBody
	@RequestMapping("/remove")
	public void removeReport(@RequestParam(value = "reportNums[]") List<String> reportNums) {
		for (String reportNum : reportNums) {
			int reportNo = Integer.parseInt(reportNum);
			reportService.removeReport(reportNo);
		}
	}

	// 댓글 삭제
	@ResponseBody
	@RequestMapping("/removeReply")
	public void removeReply(String replyNum) {
		int replyNo = Integer.parseInt(replyNum);
		reportReplyService.removeReportReply(replyNo);
	}
}