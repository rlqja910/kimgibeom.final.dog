package kimgibeom.dog.review.domain;

import java.sql.Date;

public class ReviewReply {
	private int reviewNum;
	private int replyNum;
	private String userId;
	private String content;
	private Date regDate;
	
	public ReviewReply() {}
	
	public ReviewReply(int reviewNum, String userId, String content) {
		this.reviewNum = reviewNum;
		this.userId = userId;
		this.content = content;
	}

	public int getReviewNum() {
		return reviewNum;
	}

	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}

	public int getReplyNum() {
		return replyNum;
	}

	public void setReplyNum(int replyNum) {
		this.replyNum = replyNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
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
}
