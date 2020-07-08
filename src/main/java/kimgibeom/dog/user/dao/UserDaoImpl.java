package kimgibeom.dog.user.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kimgibeom.dog.review.domain.Search;
import kimgibeom.dog.user.dao.map.UserMap;
import kimgibeom.dog.user.domain.UserPagination;
import kimgibeom.dog.user.domain.UserSearch;
import kimgibeom.dog.user.domain.User;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	private UserMap userMap;

	@Override
	public int addUser(User user) {
		return userMap.addUser(user);
	}
	
	@Override
	public int getUserListCnt(UserSearch userSearch) {
		return userMap.getUserListCnt(userSearch);
	}

	@Override
	public List<User> getUserList(UserSearch search) {
		return userMap.getUserList(search);
	}
	
	@Override
	public List<User> getUsers(){
		return userMap.getUsers();
	}

	@Override
	public String getuserPw(String userId) {
		return userMap.getuserPw(userId);
	}

	@Override
	public User getUserId(String userName, String userPhone) {
		return userMap.getUserId(userName, userPhone);
	}

	@Override
	public User getUserMail(String userId) {
		return userMap.getUserMail(userId);
	}

	@Override
	public int updatePw(String userId, String userPw) {
		return userMap.updatePw(userId, userPw);
	}

	@Override
	public int delUser(String userId) {
		return userMap.delUser(userId);
	}
	
	@Override
	public User getUser(String userId) {
		return userMap.getUser(userId);
	}
	
	@Override
	public int updateUser(User user) {
		return userMap.updateUser(user);
	}
}
