package com.vn.hungtq.peace.service;

import java.util.List;

import com.vn.hungtq.peace.entity.User;

public interface UserDaoService {
	User findById(int id);
	
	User findBySSO(String sso);
	
	void save(User user);
	
	void deleteBySSO(String sso);
	
	List<User> findAllUsers(); 
	
	User getUserById(int userId);
	
	boolean isPasswordCorrect(int userId ,String rawPassword);
	
	void updateUser(User user);

	void updateLocation(User user);
}
