package kimgibeom.dog.dog.service;

import java.util.List;

import kimgibeom.dog.dog.domain.Dog;

public interface DogService {
	List<Dog> readDogs();

	List<Dog> findDogs(String dogKind, String dogEntDate);

	List<Dog> findDogsForTitle(String dogTitle);

	List<Dog> findBeforeAdoptDogs(String dogTitle);

	List<Dog> findAfterAdoptDogs(String dogTitle);

	int writeDog(Dog dog);

	Dog findDog(int dogNum);

	int readTodayFindDogsCnt(String entranceDate);

	int readTotalAbandonDogsCnt();

	int readAfterAdoptDogCnt();

	int changeDogInfo(Dog dog);

	int changeDogInfoWithoutImg(Dog dog);

	int removeDog(int dogNum);
}
