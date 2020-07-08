package kimgibeom.dog.adopt.domain;

import kimgibeom.dog.dog.domain.Dog;
import kimgibeom.dog.user.domain.User;

public class Adopt {
	private int adoptNum;
	private String adoptRegDate;
	private Dog dog;
	private User user;
	private String userId;
	private int dogNum;

	public Adopt() {
	}

	public Adopt(int adoptNum, String adoptRegDate, Dog dog, User user) {
		this.adoptNum = adoptNum;
		this.adoptRegDate = adoptRegDate;
		this.dog = dog;
		this.user = user;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getDogNum() {
		return dogNum;
	}

	public void setDogNum(int dogNum) {
		this.dogNum = dogNum;
	}

	public int getAdoptNum() {
		return adoptNum;
	}

	public void setAdoptNum(int adoptNum) {
		this.adoptNum = adoptNum;
	}

	public String getAdoptRegDate() {
		return adoptRegDate;
	}

	public void setAdoptRegDate(String adoptRegDate) {
		this.adoptRegDate = adoptRegDate;
	}

	public Dog getDog() {
		return dog;
	}

	public void setDog(Dog dog) {
		this.dog = dog;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
