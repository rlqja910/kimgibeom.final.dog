package kimgibeom.dog.report.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
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

import kimgibeom.dog.report.domain.PageMaker;
import kimgibeom.dog.report.domain.Report;
import kimgibeom.dog.report.domain.ReportReply;
import kimgibeom.dog.report.domain.SearchCriteria;
import kimgibeom.dog.report.service.ReportReplyService;
import kimgibeom.dog.report.service.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController {
	@Autowired
	private ReportService reportService;
	@Autowired
	private ReportReplyService reportReplyService;
	@Value("${reportAttachDir}")
	private String reportAttachDir;
	private int attachSeq;

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
		// 게시글 조회
		int reportNo = Integer.parseInt(reportNum);
		Report report = reportService.readReport(reportNo);
		model.addAttribute("report", report);

		if (report == null) {
			re.addAttribute("isData", false);
			return "redirect:../reportListView";
		}

		// 조회수 갱신
		reportService.updateViewCnt(reportNo);

		// 댓글 조회
		List<ReportReply> replies = reportReplyService.readReportReplies();
		List<ReportReply> repliesOfReport = new ArrayList<ReportReply>();

		for (int idx = 0; idx < replies.size(); idx++) {
			if (replies.get(idx).getReportNum() == reportNo) {
				repliesOfReport.add(replies.get(idx));
			}
		}
		model.addAttribute("replies", repliesOfReport);

		return "report/reportView";
	}

	// 게시물 등록
	@RequestMapping("/reportRegister")
	public String reportIn() {
		return "report/reportRegister";
	}

	@RequestMapping(value = "/reportRegister", method = RequestMethod.POST)
	public String reportOut(Report report, MultipartFile attachFile, HttpServletRequest request) {
		String dir = request.getServletContext().getRealPath(reportAttachDir);

		attachSeq++;
		String fileName = attachSeq + attachFile.getOriginalFilename(); // 첨부 파일명 중복 방지
		save(dir + "/" + fileName, attachFile);

		report.setAttachName(fileName);
		reportService.writeReport(report);

		return "redirect:reportListView";
	}

	private void save(String destFile, MultipartFile attachFile) {
		try { // 서버에 실제 파일을 저장한다.
			attachFile.transferTo(new File(destFile)); // binary 데이터들을 새로운 파일 객체에 넣는다.
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	// 게시물 수정
	@RequestMapping("/reportModify/{reportNum}")
	public String modifyIn(@PathVariable String reportNum, Model model, RedirectAttributes re) {
		int reportNo = Integer.parseInt(reportNum);
		Report report = reportService.readReport(reportNo);

		if (report == null) {
			re.addAttribute("isData", false);
			return "redirect:../reportView/" + reportNum;
		}

		model.addAttribute("report", report);
		return "report/reportModify";
	}

	@RequestMapping(value = "/reportModify", method = RequestMethod.POST)
	public String modifyOut(Report report, MultipartFile attachFile, HttpServletRequest request) {
		attachSeq++;
		String dir = request.getServletContext().getRealPath(reportAttachDir);
		String fileName = attachSeq + attachFile.getOriginalFilename();
		save(dir + "/" + fileName, attachFile);

		if (!attachFile.getOriginalFilename().equals(""))
			report.setAttachName(fileName);

		reportService.updateReport(report);
		int reportNum = report.getReportNum();

		String page = request.getParameter("page");

		return "redirect:reportView/" + reportNum + "?page=" + page;
	}

	// 게시물 삭제
	@ResponseBody
	@RequestMapping("/remove")
	public int removeReport(String reportNum) {
		int reportNo = Integer.parseInt(reportNum);
		return reportService.removeReport(reportNo);
	}

	// 댓글 등록
	@ResponseBody
	@RequestMapping("/replyView")
	public void registerReply(ReportReply reply) {
		reportReplyService.writeReportReply(reply);
	}

	// 댓글 삭제
	@ResponseBody
	@RequestMapping("/removeReply")
	public void removeReply(String replyNum) {
		int replyNo = Integer.parseInt(replyNum);
		reportReplyService.removeReportReply(replyNo);
	}
}