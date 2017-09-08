package com.xyz.elibraryaccesssystem.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.DocumentDiscipline;
import com.xyz.elibraryaccesssystem.beans.DocumentType;
import com.xyz.elibraryaccesssystem.beans.FileData;


public interface DocumentServiceInterface {
	
	public boolean addDocument(Document doc) ;

	public boolean editDocument(Document doc);

	public List searchDocument(Document doc);

	public Document payment(Document doc);

	public List<DocumentDiscipline> getdId();

	public List<DocumentType> getdocumentId();
	
	public InputStream download(String docId);
	
	public boolean fileupload(FileData fileData)throws IOException;


}
