package kimgibeom.dog.review.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.review.dao.map.ReviewMap;
import kimgibeom.dog.review.domain.Pagination;
import kimgibeom.dog.review.domain.Review;
import kimgibeom.dog.review.domain.Search;

@Repository
public class ReviewDaoImpl implements ReviewDao{
	@Autowired private ReviewMap reviewMap;
	
	@Override
	public List<Review> getAdminReviews(Pagination pagination, Search search){
		return reviewMap.getAdminReviews(pagination, search);
	}
	
	@Override
	public List<Review> getUserReviews(Pagination pagination){
		return reviewMap.getUserReviews(pagination);
	}
	
	@Override
	public List<Review> getReviews(){
		return reviewMap.getReviews();
	}
	
	@Override
	public Review getReview(int reviewNum) {
		return reviewMap.getReview(reviewNum);
	}
	
	@Override
	public int addReview(Review review) {
		return reviewMap.addReview(review);
	}
	
	@Override
	public int modifyReview(Review review) {
		return reviewMap.modifyReview(review);
	}
	
	@Override
	public int modifyReviewWithOutImg(Review review) {
		return reviewMap.modifyReviewWithOutImg(review);
	}
	
	@Override
	public int delReview(int reviewNum) {
		return reviewMap.delReview(reviewNum);
	}
	
	@Override
	public int getAdminReviewCnt(Search search) {
		return reviewMap.getAdminReviewCnt(search);
	}
	
	@Override
	public int getUserReviewCnt() {
		return reviewMap.getUserReviewCnt();
	}
}
