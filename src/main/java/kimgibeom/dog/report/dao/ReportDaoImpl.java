package kimgibeom.dog.report.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.report.dao.map.ReportMap;
import kimgibeom.dog.report.domain.Criteria;
import kimgibeom.dog.report.domain.Report;
import kimgibeom.dog.report.domain.SearchCriteria;

@Repository
public class ReportDaoImpl implements ReportDao {
	@Autowired
	private ReportMap reportMap;

	@Override
	public List<Report> getReports(SearchCriteria scri) {
		return reportMap.getReports(scri);
	}
	
	@Override
	public int getListCnt(SearchCriteria scri) {
		return reportMap.getListCnt(scri);
	}

	@Override
	public Report getReport(int reportNum) {
		return reportMap.getReport(reportNum);
	}

	@Override
	public int addReport(Report report) {
		return reportMap.addReport(report);
	}

	@Override
	public int modifyReport(Report report) {
		return reportMap.modifyReport(report);
	}
	
	@Override
	public int modifyViewCnt(int reportNum) {
		return reportMap.modifyViewCnt(reportNum);
	}

	@Override
	public int delReport(int reportNum) {
		return reportMap.delReport(reportNum);
	}
}
