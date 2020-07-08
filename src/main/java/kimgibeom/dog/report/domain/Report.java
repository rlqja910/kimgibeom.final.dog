package kimgibeom.dog.report.domain;

import java.sql.Date;

public class Report {
	private String title;
	private String userId;
	private String content;
	private int viewCount;
	private Date regDate;
	private int reportNum;
	private String attachName;

	public String getTitle() {
		return title;
	}

	public String getUserId() {
		return userId;
	}

	public int getViewCount() {
		return viewCount;
	}

	public Date getRegDate() {
		return regDate;
	}

	public int getReportNum() {
		return reportNum;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public void setReportNum(int reportNum) {
		this.reportNum = reportNum;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}
	
	public String getAttachName() {
		return attachName;
	}

	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}	
}
