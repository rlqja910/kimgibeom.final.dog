package kimgibeom.dog.donation.dao.map;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.dog.donation.domain.Donation;

public interface DonationMap {
	// 이번달 후원금액 가져오기
	int getDonationMon();

	// 총 누적 후원금액 가져오기
	int getDonationTot();

	// 후원금 기부한 후원자 등록
	int addDonations(@Param("userId") String userId, @Param("price") int price);

	// 전체 후원자 리스트 가져오기
	List<Donation> getSponsors();

	// 후원자명 검색으로 리스트 가져오기
	List<Donation> getSearchSponsors(String name);
	
}
