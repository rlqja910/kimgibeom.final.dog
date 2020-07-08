package kimgibeom.dog.review.dao;

import java.util.List;

import kimgibeom.dog.review.domain.ReviewReply;

public interface ReviewReplyDao {
	List<ReviewReply> getReviewReplies(int reviewNum);
	
	int addReviewReply(ReviewReply reviewReply);
	
	int delReviewReply(int replyNum);
}
