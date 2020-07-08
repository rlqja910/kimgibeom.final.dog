package kimgibeom.dog.donation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kimgibeom.dog.donation.dao.DonationDao;
import kimgibeom.dog.donation.domain.Donation;

@Service
public class DonationServiceImpl implements DonationService {
	@Autowired
	private DonationDao donationDao;

	@Override
	public int readDonationMon() {
		return donationDao.getDonationMon();
	}

	@Override
	public int readDonationTot() {
		return donationDao.getDonationTot();
	}

	@Override
	public boolean readDonations(String userId, int price) {
		return donationDao.addDonations(userId, price) > 0;
	}

	@Override
	public List<Donation> readSponsors() {
		return donationDao.getSponsors();
	}

	@Override
	public List<Donation> readSponsors(String name) {
		return donationDao.getSearchSponsors(name);
	}
}