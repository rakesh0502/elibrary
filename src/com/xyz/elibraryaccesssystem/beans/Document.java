package com.xyz.elibraryaccesssystem.beans;

import javax.validation.constraints.Min;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class Document extends FileData {
	
	private String docId;

	//@NotEmpty(message = "Document Name is required")
	private String docName;

	//@NotEmpty(message = "Select a Document")
	//@Pattern(regexp = "[.pdf]$", message = "Only pdf files are allowed")
	private String docPath;

	//@Min(value = 1, message = "Description is Required")
	//@Max(value = 200, message = "Description should contain only 200 characters")
	private String docDescription;
	
	//@Pattern(regexp = "^[0-9]{3,7}$", message = "Please Select Document Type")
	@Min(value = 2, message = "Please Select Document Type")
	private String docTypeId;
	
	//@Pattern(regexp = "^[0-9]{3,7}$", message = "Please Select Discipline Type")
	//@Min(value = 2, message = "Please Select Document Type")
	private String discplineId;

	//@NotEmpty(message = "Title is required")
	//@Max(value = 30, message = "Title should contain maximum 30 value")
	//@Pattern(regexp = "^[A-Za-z\\s]$", message = "Title Should contain characters only")
	private String title;

	//@NotEmpty(message = "Author Name is Required")
	//@Pattern(regexp = "^[A-Za-z]{1}[A-Za-z\\'\\s\\-\\`\\,]", message = "Author name is not valid")
	private String author;
	
	private String uploadDate;

	//@NotEmpty(message = "Price is Required")
	//@Range(min = 0, max = 99999, message = "Price should be in the range Rs.(0-99999)")
	private String price;
	
	private String discipline;
	
	private String documentTypeName;
	
	private CommonsMultipartFile fileData;

	public CommonsMultipartFile getFileData() {
		return fileData;
	}

	public void setFileData(CommonsMultipartFile fileData) {
		this.fileData = fileData;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}

	public String getDocName() {
		return docName;
	}

	public void setDocName(String docName) {
		this.docName = docName;
	}

	public String getDocPath() {
		return docPath;
	}

	public void setDocPath(String docPath) {
		this.docPath = docPath;
	}

	public String getDocDescription() {
		return docDescription;
	}

	public void setDocDescription(String docDescription) {
		this.docDescription = docDescription;
	}

	public String getDocTypeId() {
		return docTypeId;
	}

	public void setDocTypeId(String docTypeId) {
		this.docTypeId = docTypeId;
	}

	public String getDiscplineId() {
		return discplineId;
	}

	public void setDiscplineId(String discplineId) {
		this.discplineId = discplineId;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(String uploadDate) {
		this.uploadDate = uploadDate;
	}

	public String getPrice() {
		return price;
	}

	public void setPrice(String price) {
		this.price = price;
	}

	public String getDiscipline() {
		return discipline;
	}

	public void setDiscipline(String discipline) {
		this.discipline = discipline;
	}

	public String getDocumentTypeName() {
		return documentTypeName;
	}

	public void setDocumentTypeName(String documentTypeName) {
		this.documentTypeName = documentTypeName;
	}
	

}
