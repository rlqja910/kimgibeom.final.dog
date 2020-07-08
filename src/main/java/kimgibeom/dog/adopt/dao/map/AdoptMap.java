package kimgibeom.dog.adopt.dao.map;

import java.util.List;

import kimgibeom.dog.adopt.domain.Adopt;

public interface AdoptMap {
	String getUserPw(String userId);

	int addReservation(Adopt adopt);

	List<Adopt> getReservationUsersForDogNum(int dogNum);

	List<Adopt> getReservationForUserId(String userId);
}