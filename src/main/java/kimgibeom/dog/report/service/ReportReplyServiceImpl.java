package kimgibeom.dog.report.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimgibeom.dog.report.dao.ReportReplyDao;
import kimgibeom.dog.report.domain.ReportReply;

@Service
public class ReportReplyServiceImpl implements ReportReplyService {
	@Autowired
	private ReportReplyDao reportReplyDao;

	@Override
	public List<ReportReply> readReportReplies() {
		return reportReplyDao.getReportReplies();
	}

	@Override
	public ReportReply readReportReply(int replyNum) {
		return reportReplyDao.getReportReply(replyNum);
	}

	@Override
	public int writeReportReply(ReportReply reply) {
		return reportReplyDao.addReportReply(reply);
	}

	@Override
	public int updateReportReply(ReportReply reply) {
		return reportReplyDao.modifyReportReply(reply);
	}

	@Override
	public int removeReportReply(int replyNum) {
		return reportReplyDao.delReportReply(replyNum);
	}
}
