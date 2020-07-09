package kimgibeom.dog.adopt.dao;

import java.util.List;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptPagination;
import kimgibeom.dog.adopt.domain.AdoptSearch;

public interface AdoptDao {
	String getUserPw(String userId);

	int addReservation(Adopt adopt);

	List<Adopt> getReservationUsersForDogNum(int dogNum);

	List<Adopt> getReservationForUserId(String userId);

	int getAdoptListCnt(AdoptSearch adoptSearch);

	List<Adopt> getAdopts(AdoptPagination adoptPagination);
}
