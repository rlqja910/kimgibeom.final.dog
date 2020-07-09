package kimgibeom.dog.adopt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimgibeom.dog.adopt.dao.AdoptDao;
import kimgibeom.dog.adopt.domain.Adopt;
import kimgibeom.dog.adopt.domain.AdoptPagination;
import kimgibeom.dog.adopt.domain.AdoptSearch;

@Service
public class AdoptServiceImpl implements AdoptService {
	@Autowired
	private AdoptDao adoptDao;

	@Override
	public String readUserPw(String userId) {
		return adoptDao.getUserPw(userId);
	}

	@Override
	public boolean writeReservation(Adopt adopt) {
		if (adoptDao.addReservation(adopt) == 1) {
			return true;
		} else {
			return false;
		}
	}

	@Override
	public List<Adopt> readReservationUsersForDogNum(int dogNum) {
		return adoptDao.getReservationUsersForDogNum(dogNum);
	}

	@Override
	public List<Adopt> readReservationForUserId(String userId) {
		return adoptDao.getReservationForUserId(userId);
	}

	@Override
	public int raedAdoptListCnt(AdoptSearch adoptSearch) {
		System.out.println(adoptSearch.getSearchType()+"123123213123");
		System.out.println(adoptDao.getAdoptListCnt(adoptSearch));
		System.out.println("++++++++++++++++++++222222");

		return adoptDao.getAdoptListCnt(adoptSearch);
	}

	@Override
	public List<Adopt> raedAdopts(AdoptPagination adoptPagination) {
		return adoptDao.getAdopts(adoptPagination);
	}
}