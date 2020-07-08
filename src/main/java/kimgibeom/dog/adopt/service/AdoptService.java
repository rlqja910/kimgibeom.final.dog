package kimgibeom.dog.adopt.service;

import java.util.List;

import kimgibeom.dog.adopt.domain.Adopt;

public interface AdoptService {
	String readUserPw(String userId);

	boolean writeReservation(Adopt adopt);

	List<Adopt> readReservationUsersForDogNum(int dogNum);

	List<Adopt> readReservationForUserId(String userId);
}
