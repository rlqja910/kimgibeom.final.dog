package kimgibeom.dog.adopt.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptPagination;
import kimgibeom.dog.adopt.domain.AdoptSearch;

public interface AdoptDao {
	String getUserPw(String userId);

	int addReservation(Adopt adopt);

	List<Adopt> getReservationUsersForDogNum(int dogNum);

	List<Adopt> getReservationForUserId(String userId);

	int getAdoptListCnt(AdoptSearch adoptSearch);

	List<Adopt> getAdopts(AdoptPagination adoptPagination);// 분양 완료 시 중복된 유기견 삭제

	int restDelAdopt(@Param("adoptNum") int adoptNum, @Param("dogNum") int dogNum);

	// 분양 완료 표시
	int completeAdopt(@Param("adoptNum") int adoptNum, @Param("dogNum") int dogNum);

	int delAdopt(int adoptNum);
}
