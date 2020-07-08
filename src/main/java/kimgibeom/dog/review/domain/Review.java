package kimgibeom.dog.review.domain;

import java.sql.Date;

public class Review {
	private int reviewNum;
	private String title;
	private String content;
	private Date regDate;
	private String attachName;
	
	public Review() {}
	
	public Review(String title, String content) {
		this.title = title;
		this.content = content;
	}

	public Review(String title, String content, String attachName) {
		this.title = title;
		this.content = content;
		this.attachName = attachName;
	}
	
	public int getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getAttachName() {
		return attachName;
	}

	public void setAttachName(String attachName) {
		this.attachName = attachName;
	}
}
