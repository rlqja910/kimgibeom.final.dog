package kimgibeom.dog.adopt.dao;

import java.util.List;

import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptPagination;

public interface AdoptDao {
	String getUserPw(String userId);

	int addReservation(Adopt adopt);

	List<Adopt> getReservationUsersForDogNum(int dogNum);

	List<Adopt> getReservationForUserId(String userId);

	int getAdoptListCnt();

	List<Adopt> getAdopts(AdoptPagination adoptPagination);
}
