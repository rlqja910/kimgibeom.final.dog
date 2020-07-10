package kimgibeom.dog.adopt.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptPagination;
import kimgibeom.dog.adopt.domain.AdoptSearch;

public interface AdoptService {
	String readUserPw(String userId);

	boolean writeReservation(Adopt adopt);

	List<Adopt> readReservationUsersForDogNum(int dogNum);

	List<Adopt> readReservationForUserId(String userId);

	int raedAdoptListCnt(AdoptSearch adoptSearch);

	List<Adopt> raedAdopts(AdoptPagination adoptPagination);

	// 분양 완료 시 중복된 유기견 삭제
	int outAdopt(@Param("adoptNum") int adoptNum, @Param("dogNum") int dogNum);

	// 분양 완료 표시
	int successAdopt(@Param("adoptNum") int adoptNum, @Param("dogNum") int dogNum);

	int removeAdopt(int adoptNum);
}
