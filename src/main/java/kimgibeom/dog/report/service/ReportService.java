package kimgibeom.dog.report.service;

import java.util.List;

import kimgibeom.dog.report.domain.Criteria;
import kimgibeom.dog.report.domain.Report;
import kimgibeom.dog.report.domain.SearchCriteria;

public interface ReportService {
	List<Report> readReports(SearchCriteria scri);

	int readListCnt(SearchCriteria scri);

	Report readReport(int reportNum);

	int writeReport(Report report);

	int updateReport(Report report);
	
	int updateViewCnt(int reportNum);

	int removeReport(int reportNum);
}
