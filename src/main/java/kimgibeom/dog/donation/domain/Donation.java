package kimgibeom.dog.donation.domain;

import java.sql.Date;

public class Donation {
	private int donationNum;
	private String userId;
	private int price;
	private Date donationDate;
	private String userPhone;

	private Donation() {
	};

	private Donation(int donationNum, String userId, int price, Date donationDate, String userPhone) {
		this.donationNum = donationNum;
		this.userId = userId;
		this.price = price;
		this.donationDate = donationDate;
		this.userPhone = userPhone;
	}

	public String getUserPhone() {
		return userPhone;
	}

	public void setUserPhone(String userPhone) {
		this.userPhone = userPhone;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getDonationNum() {
		return donationNum;
	}

	public int getPrice() {
		return price;
	}

	public Date getDonationDate() {
		return donationDate;
	}

	public void setDonationNum(int donationNum) {
		this.donationNum = donationNum;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public void setDonationDate(Date donationDate) {
		this.donationDate = donationDate;
	}
}
