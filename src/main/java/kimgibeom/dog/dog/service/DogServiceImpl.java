package kimgibeom.dog.dog.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimgibeom.dog.dog.dao.DogDao;
import kimgibeom.dog.dog.domain.Dog;

@Service
public class DogServiceImpl implements DogService {
	@Autowired
	private DogDao dogDao;

	@Override
	public List<Dog> readDogs() { // 강아지 리스트로 출력
		return dogDao.getDogs();
	}

	@Override
	public List<Dog> findDogs(String dogKind, String dogEntDate) {
		return dogDao.searchDogs(dogKind, dogEntDate);
	}

	@Override
	public List<Dog> findDogsForTitle(String dogTitle) {
		return dogDao.searchDogsForTitle(dogTitle);
	}

	@Override
	public List<Dog> findBeforeAdoptDogs(String dogTitle) {
		return dogDao.searchBeforeAdoptDogs(dogTitle);
	}

	@Override
	public List<Dog> findAfterAdoptDogs(String dogTitle) {
		return dogDao.searchAfterAdoptDogs(dogTitle);
	}

	@Override
	public int writeDog(Dog dog) {
		return dogDao.addDog(dog);
	}

	@Override
	public Dog findDog(int dogNum) {
		return dogDao.searchDog(dogNum);
	}

	@Override
	public int readTodayFindDogsCnt(String entranceDate) {
		return dogDao.getTodayFindDogsCnt(entranceDate);
	}

	@Override
	public int readTotalAbandonDogsCnt() {
		return dogDao.getTotalAbandonDogsCnt();
	}

	@Override
	public int readAfterAdoptDogCnt() {
		return dogDao.getAfterAdoptDogCnt();
	}

	@Override
	public int changeDogInfo(Dog dog) {
		return dogDao.modifyDogInfo(dog);
	}

	@Override
	public int changeDogInfoWithoutImg(Dog dog) {
		return dogDao.modifyDogInfoWithoutImg(dog);
	}

	@Override
	public int removeDog(int dogNum) {
		return dogDao.delDog(dogNum);
	}

}