package com.xyz.elibraryaccesssystem.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.DocumentDiscipline;
import com.xyz.elibraryaccesssystem.beans.DocumentType;
import com.xyz.elibraryaccesssystem.beans.FileData;
import com.xyz.elibraryaccesssystem.dao.ElibraryAccessSystemDaoImpl;




@Service("documentService")
public class DocumentServiceImpl implements DocumentServiceInterface{
	
	@Autowired
	private ElibraryAccessSystemDaoImpl eLibDao;

	@Override
	public boolean addDocument(Document doc) {
		return eLibDao.addDocument(doc);
	}

	@Override
	public boolean editDocument(Document doc) {
		return eLibDao.editDocument(doc);
	}

	@Override
	public List searchDocument(Document doc) {
		return eLibDao.searchDocument(doc);
	}

	@Override
	public Document payment(Document doc) {

		return eLibDao.payment(doc);
	}

	@Override
	public List<DocumentDiscipline> getdId() {
		return eLibDao.getdId();
	}

	@Override
	public List<DocumentType> getdocumentId() {
		return eLibDao.getdocumentId();
	}

	@Override
	public InputStream download(String docId) {
		return eLibDao.download(docId);
	}
	
	@Override
	public boolean fileupload(FileData fileData) throws IOException {
		
		return eLibDao.fileUpload(fileData);
	}


}
