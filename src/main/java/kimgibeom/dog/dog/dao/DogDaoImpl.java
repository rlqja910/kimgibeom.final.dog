package kimgibeom.dog.dog.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.dog.dao.map.DogMap;
import kimgibeom.dog.dog.domain.Dog;

@Repository
public class DogDaoImpl implements DogDao {
	@Autowired
	private DogMap dogMap;

	@Override
	public List<Dog> getDogs() {
		return dogMap.getDogs();
	}

	@Override
	public List<Dog> searchDogs(String dogKind, String dogEntDate) {
		return dogMap.searchDogs(dogKind, dogEntDate);
	}

	@Override
	public List<Dog> searchDogsForTitle(String dogTitle) {
		return dogMap.searchDogsForTitle(dogTitle);
	}

	@Override
	public List<Dog> searchBeforeAdoptDogs(String dogTitle) {
		return dogMap.searchBeforeAdoptDogs(dogTitle);
	}

	@Override
	public List<Dog> searchAfterAdoptDogs(String dogTitle) {
		return dogMap.searchAfterAdoptDogs(dogTitle);
	}

	@Override
	public int addDog(Dog dog) {
		return dogMap.addDog(dog);
	}

	@Override
	public Dog searchDog(int dogNum) {
		return dogMap.searchDog(dogNum);
	}

	@Override
	public int getTodayFindDogsCnt(String entranceDate) {
		return dogMap.getTodayFindDogsCnt(entranceDate);
	}

	@Override
	public int getTotalAbandonDogsCnt() {
		return dogMap.getTotalAbandonDogsCnt();
	}

	@Override
	public int getAfterAdoptDogCnt() {
		return dogMap.getAfterAdoptDogCnt();
	}

	@Override
	public int modifyDogInfo(Dog dog) {
		return dogMap.modifyDogInfo(dog);
	}

	@Override
	public int modifyDogInfoWithoutImg(Dog dog) {
		return dogMap.modifyDogInfoWithoutImg(dog);
	}

	@Override
	public int delDog(int dogNum) {
		return dogMap.delDog(dogNum);
	}

}