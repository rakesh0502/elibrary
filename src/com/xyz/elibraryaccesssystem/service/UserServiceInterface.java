package com.xyz.elibraryaccesssystem.service;

import com.xyz.elibraryaccesssystem.beans.Registration;
import com.xyz.elibraryaccesssystem.beans.User;


public interface UserServiceInterface {
	
	
	public User authenticate(User user);
	public boolean addUser(Registration user);
	public boolean getMembership(String userId);
	public String getUserId();
	public boolean doSubscription(String userId);


}
