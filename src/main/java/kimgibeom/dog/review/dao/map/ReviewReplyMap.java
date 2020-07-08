package kimgibeom.dog.review.dao.map;

import java.util.List;

import kimgibeom.dog.review.domain.ReviewReply;

public interface ReviewReplyMap {
	List<ReviewReply> getReviewReplies(int reviewNum);
	
	int addReviewReply(ReviewReply reviewReply);
	
	int delReviewReply(int replyNum);
}
