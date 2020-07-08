package kimgibeom.dog.user.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import kimgibeom.dog.review.domain.Search;
import kimgibeom.dog.user.domain.User;
import kimgibeom.dog.user.domain.UserPagination;
import kimgibeom.dog.user.domain.UserSearch;

public interface UserService {
	int writeUser(User user);

	boolean idCheck(String userId);
	
	int readUserListCnt(UserSearch userSearch);

	List<User> readUserList(UserSearch UserSearch);
	
	List<User> readUsers();

	String readuserPw(String userId);

	User findUserId(String userName, String userPhone);

	User findUserMail(String userId);

	boolean modPw(String userId, String userPw);

	boolean withdrawUser(String userId);
	
	User findUser(String userId);
	
	int modUser(User user);
}