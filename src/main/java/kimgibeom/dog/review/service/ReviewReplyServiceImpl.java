package kimgibeom.dog.review.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimgibeom.dog.review.dao.ReviewReplyDao;
import kimgibeom.dog.review.domain.ReviewReply;

@Service
public class ReviewReplyServiceImpl implements ReviewReplyService{
	@Autowired private ReviewReplyDao reviewReplyDao;
	
	@Override
	public List<ReviewReply> readReviewReplies(int reviewNum){
		return reviewReplyDao.getReviewReplies(reviewNum);
	}
	
	@Override
	public int writeReviewReply(ReviewReply reviewReply) {
		return reviewReplyDao.addReviewReply(reviewReply);
	}
	
	@Override
	public int removeReviewReply(int replyNum) {
		return reviewReplyDao.delReviewReply(replyNum);
	}
}
