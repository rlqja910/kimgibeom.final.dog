package kimgibeom.dog.review.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.review.dao.map.ReviewReplyMap;
import kimgibeom.dog.review.domain.ReviewReply;

@Repository
public class ReviewReplyDaoImpl implements ReviewReplyDao{
	@Autowired private ReviewReplyMap reviewReplyMap;
	
	@Override
	public List<ReviewReply> getReviewReplies(int reviewNum){
		return reviewReplyMap.getReviewReplies(reviewNum);
	}
	
	@Override
	public int addReviewReply(ReviewReply reviewReply) {
		return reviewReplyMap.addReviewReply(reviewReply);
	}
	
	@Override
	public int delReviewReply(int replyNum) {
		return reviewReplyMap.delReviewReply(replyNum);
	}
}
