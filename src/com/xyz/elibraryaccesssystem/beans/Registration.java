package com.xyz.elibraryaccesssystem.beans;

import java.util.Date;

import javax.validation.constraints.Pattern;
import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.NotEmpty;

public class Registration {

	@Pattern(regexp="^[1]{1}[0-9]{5}$", message="User Id not valid")
	@Size(min=6,max=6,message = "Please enter valid user id")
	private String userId;
	
	@Pattern(regexp="^[A-Za-z]{1}[A-Za-z\\'\\s\\-\\`\\,]{1,}",message="First Name is not valid")
	private String firstName;
	
	@Pattern(regexp="^[A-Z]{1}[A-Za-z\\'\\s\\-\\`\\,]{1,}",message="Last Name is not valid")
	private String lastName;
	
	@NotEmpty(message = "DOB field can't be empty")
	private String dateOfBirth;
	
	//@Pattern(regexp="^[A-Za-z0-9#@,.()]{1,}$", message="Address is not valid")
	@NotEmpty(message = "Address field can't be empty")
	private String address;
	
	@Pattern(regexp="^[0-9]{3}\\-[0-9]{4}\\-[0-9]{4}$", message="Landline Number format is incorrect")
	private String landLineNumber;
	
	@Pattern(regexp="^[0-9]{3}\\-[0-9]{4}\\-[0-9]{4}$", message="Mobile Number format is incorrect")
	private String mobileNumber;

	
	private String areaOfInterest;
	
	private char gender;
	private String userType;
	private Date dor;
	
	@Email(message="Invalid Email-Id")
	@NotEmpty(message = "Please enter email")
	private String email;
	
	@NotEmpty(message = "Please enter password")
	@Size(min=8, max=16, message = "Please enter valid Password")
	private String password;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getLandLineNumber() {
		return landLineNumber;
	}

	public void setLandLineNumber(String landLineNumber) {
		this.landLineNumber = landLineNumber;
	}

	public String getMobileNumber() {
		return mobileNumber;
	}

	public void setMobileNumber(String mobileNumber) {
		this.mobileNumber = mobileNumber;
	}

	public String getAreaOfInterest() {
		return areaOfInterest;
	}

	public void setAreaOfInterest(String areaOfInterest) {
		this.areaOfInterest = areaOfInterest;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public Date getDor() {
		return dor;
	}

	public void setDor(Date dor) {
		this.dor = dor;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

}
