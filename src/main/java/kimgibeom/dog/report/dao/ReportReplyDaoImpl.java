package kimgibeom.dog.report.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.report.dao.map.ReportReplyMap;
import kimgibeom.dog.report.domain.ReportReply;

@Repository
public class ReportReplyDaoImpl implements ReportReplyDao {
	@Autowired
	private ReportReplyMap reportReplyMap;

	@Override
	public List<ReportReply> getReportReplies() {
		return reportReplyMap.getReportReplies();
	}

	@Override
	public ReportReply getReportReply(int replyNum) {
		return reportReplyMap.getReportReply(replyNum);
	}

	@Override
	public int addReportReply(ReportReply reply) {
		return reportReplyMap.addReportReply(reply);
	}

	@Override
	public int modifyReportReply(ReportReply reply) {
		return reportReplyMap.modifyReportReply(reply);
	}

	@Override
	public int delReportReply(int replyNum) {
		return reportReplyMap.delReportReply(replyNum);
	}
}
