package kimgibeom.dog.review.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.dog.review.domain.Pagination;
import kimgibeom.dog.review.domain.Review;
import kimgibeom.dog.review.domain.Search;

public interface ReviewMap {
	List<Review> getAdminReviews(@Param("pagination") Pagination pagination, @Param("search") Search search);
	
	List<Review> getUserReviews(@Param("pagination") Pagination pagination);
	
	List<Review> getReviews();
	
	Review getReview(int reviewNum);
	
	int addReview(Review review);
	
	int modifyReview(Review review);
	
	int modifyReviewWithOutImg(Review review);
	
	int delReview(int reviewNum);
	
	int getAdminReviewCnt(@Param("search") Search search);
	
	int getUserReviewCnt();
}
