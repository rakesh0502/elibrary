package com.xyz.elibraryaccesssystem.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyz.elibraryaccesssystem.beans.Registration;
import com.xyz.elibraryaccesssystem.beans.User;
import com.xyz.elibraryaccesssystem.dao.ElibraryAccessSystemDaoImpl;




@Service("userService")
public class UserServiceImpl implements UserServiceInterface {
	
	
	@Autowired
	private ElibraryAccessSystemDaoImpl eLibDao;
	
	/*
	 * ********************************
	 * Login Module *
	 * Developed by :Pravicha Verma    * 
	 * Registration Module
	 * Developed by-Sheela Shree			  *
	 * ********************************
	 */
		
	@Override
	public User authenticate(User user) {
		return eLibDao.authenticate(user);
	}

	@Override
	public boolean addUser(Registration user) {
		return eLibDao.addUser(user);
	}

	@Override
	public boolean getMembership(String userId) {
		return eLibDao.getMembership(userId);
	}

	@Override
	public String getUserId() {
		return eLibDao.getUserId();
	}
	

	/*
	 * Login And Registration Methods Ends
	 * */
	
	//Successful Subscription
	@Override
	public boolean doSubscription(String userId) {
		
		return eLibDao.doSubscription(userId);
	}

}
