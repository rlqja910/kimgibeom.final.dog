package kimgibeom.dog.user.dao;

import java.util.List;

import kimgibeom.dog.user.domain.UserSearch;
import kimgibeom.dog.user.domain.User;

public interface UserDao {
	int addUser(User user);
	
	int getUserListCnt(UserSearch userSearch);

	List<User> getUserList(UserSearch search);
	
	List<User> getUsers();

	String getuserPw(String userId);

	User getUserId(String userName, String userPhone);

	User getUserMail(String userId);

	int updatePw(String userId, String userPw);

	// 회원 탈퇴
	int delUser(String userId);
	
	// 사용자 1명 데이터 가져오기
	User getUser(String userId);
	
	// 사용자 정보 변경
	int updateUser(User user);
}
