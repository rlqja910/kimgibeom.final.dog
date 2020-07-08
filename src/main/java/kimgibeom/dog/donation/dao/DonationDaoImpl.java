package kimgibeom.dog.donation.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.donation.dao.map.DonationMap;
import kimgibeom.dog.donation.domain.Donation;

@Repository
public class DonationDaoImpl implements DonationDao {
	@Autowired
	private DonationMap donationMap;

	@Override
	public int getDonationMon() {
		return donationMap.getDonationMon();
	}

	@Override
	public int getDonationTot() {
		return donationMap.getDonationTot();
	}

	@Override
	public int addDonations(String userId, int price) {
		return donationMap.addDonations(userId, price);
	}

	@Override
	public List<Donation> getSponsors() {
		return donationMap.getSponsors();
	}

	@Override
	public List<Donation> getSearchSponsors(String name) {
		return donationMap.getSearchSponsors(name);
	}

}
