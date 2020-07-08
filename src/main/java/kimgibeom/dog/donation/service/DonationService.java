package kimgibeom.dog.donation.service;

import java.util.List;

import kimgibeom.dog.donation.domain.Donation;

public interface DonationService {
	// 이번달 후원금액
	int readDonationMon();

	// 누적 후원금액
	int readDonationTot();

	// 후원자의 후원한 금액 읽기
	boolean readDonations(String userId, int price);

	// 전체 후원자 읽어오기
	List<Donation> readSponsors();

	// 검색된 후원자 읽어오기
	List<Donation> readSponsors(String name);
}
