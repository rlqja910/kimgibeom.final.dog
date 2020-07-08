package kimgibeom.dog.review.service;

import java.util.List;

import kimgibeom.dog.review.domain.Pagination;
import kimgibeom.dog.review.domain.Review;
import kimgibeom.dog.review.domain.Search;

public interface ReviewService {
	List<Review> readAdminReviews(Pagination pagination, Search search);
	
	List<Review> readUserReviews(Pagination pagination);
	
	List<Review> readReviews();
	
	Review readReview(int reviewNum);
	
	int writeReview(Review review);
	
	int updateReview(Review review);
	
	int updateReviewWithOutImg(Review review);
	
	int removeReview(int reviewNum);
	
	int readAdminReviewCnt(Search search);
	
	int readUserReviewCnt();
}
