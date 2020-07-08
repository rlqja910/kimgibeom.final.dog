package kimgibeom.dog.review.dao;

import java.util.List;

import kimgibeom.dog.review.domain.Pagination;
import kimgibeom.dog.review.domain.Review;
import kimgibeom.dog.review.domain.Search;

public interface ReviewDao {
	List<Review> getAdminReviews(Pagination pagination, Search search);
	
	List<Review> getUserReviews(Pagination pagination);
	
	List<Review> getReviews();
	
	Review getReview(int reviewNum);
	
	int addReview(Review review);
	
	int modifyReview(Review review);
	
	int modifyReviewWithOutImg(Review review);
	
	int delReview(int reviewNum);
	
	int getAdminReviewCnt(Search search);
	
	int getUserReviewCnt();
}
