package kimgibeom.dog.adopt.dao;

import java.util.List;

import kimgibeom.dog.adopt.domain.Adopt;

public interface AdoptDao {
	String getUserPw(String userId);

	int addReservation(Adopt adopt);

	List<Adopt> getReservationUsersForDogNum(int dogNum);

	List<Adopt> getReservationForUserId(String userId);
}
