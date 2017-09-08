package com.xyz.elibraryaccesssystem.dao;

import java.io.InputStream;
import java.util.List;

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.DocumentDiscipline;
import com.xyz.elibraryaccesssystem.beans.DocumentType;
import com.xyz.elibraryaccesssystem.beans.Registration;
import com.xyz.elibraryaccesssystem.beans.User;
import com.xyz.elibraryaccesssystem.exception.ElibraryException;

public interface ElibraryAccessSystemDaoInterface {
	
	/************* USER MANAGEMENT METHODS *************/
	public User authenticate(User user);

	public boolean addUser(Registration user);

	public boolean getMembership(String userId);

	public String getUserId();

	/***************************************************/

	/*********** DOCUMENT MANAGEMENT METHODS ***********/
	public boolean addDocument(Document doc) throws ElibraryException;

	public boolean editDocument(Document doc);

	public List searchDocument(Document doc);
	
	public Document payment(Document doc);

	public List<DocumentDiscipline> getdId();

	public List<DocumentType> getdocumentId();

	public InputStream download(String docId);

	/***************************************************/
	// from here successful subscription
	public boolean doSubscription(String userId);


}
