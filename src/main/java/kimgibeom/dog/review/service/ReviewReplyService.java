package kimgibeom.dog.review.service;

import java.util.List;

import kimgibeom.dog.review.domain.ReviewReply;

public interface ReviewReplyService {
	List<ReviewReply> readReviewReplies(int reviewNum);
	
	int writeReviewReply(ReviewReply reviewReply);
	
	int removeReviewReply(int replyNum);
}
