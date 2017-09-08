/**
 * 
 */
package com.xyz.elibraryaccesssystem.test;

import junit.framework.Assert;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.Registration;
import com.xyz.elibraryaccesssystem.beans.User;
import com.xyz.elibraryaccesssystem.dao.ElibraryAccessSystemDaoImpl;



/**
 * @author sv812067
 *
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("UnitTest.xml")
public class ElibraryTest {
	
	User user;
	Registration register;
	Document doc;
	
	@Autowired
	private ElibraryAccessSystemDaoImpl dao;
	
	
	@Test
	public void firstTest() { 
		System.out.println("in test class 1");
		Assert.assertNotNull(dao.getUserId());
	}
	
	
	@Test
	public void secondTest() { 
		System.out.println("in test class 2");
		Assert.assertNotNull(dao.authenticate(user));
	}
	
	@Test
	public void thirdTest() { 
		System.out.println("in test class 3");
		Assert.assertNotNull(dao.download("1000681"));
	}
	
	@Test
	public void fourthTest() { 
		System.out.println("in test class 4");
		Assert.assertNotNull(dao.doSubscription("100424"));
	}

	
	@Test
	public void fifthTest() { 
		System.out.println("in test class 5");
		Assert.assertNotNull(dao.addUser(register));
	}
	
	
	@Test
	public void sixthTest() { 
		System.out.println("in test class 6");
		Assert.assertNotNull(dao.addDocument(doc));
	}
}
