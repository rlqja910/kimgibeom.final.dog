package kimgibeom.dog.dog.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.dog.dog.domain.Dog;

public interface DogMap {
	List<Dog> getDogs(); // 동물 리스트 뽑음

	List<Dog> searchDogs(@Param("dogKind") String dogKind, @Param("dogEntDate") String dogEntDate);

	List<Dog> searchDogsForTitle(String dogTitle);

	List<Dog> searchBeforeAdoptDogs(String dogTitle);

	List<Dog> searchAfterAdoptDogs(String dogTitle);

	int addDog(Dog dog);

	Dog searchDog(int dogNum);

	int getTodayFindDogsCnt(String entranceDate);

	int getTotalAbandonDogsCnt();

	int getAfterAdoptDogCnt();

	int modifyDogInfo(Dog dog);

	int modifyDogInfoWithoutImg(Dog dog);

	int delDog(int dogNum);
}
