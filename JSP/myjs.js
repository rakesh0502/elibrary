


function validateForm(){
	var chkForm = validForm();
	if(chkForm){
		document.registerform.submit();
	}else{
		return false;
	}
}


//Validating Password
function chkPassword(password,repassword)
{
	if(password==repassword )
				return true;
	else if(password!=repassword ){
		var id= document.getElementById("txtConfirmPassword");
		id.innerHTML = "Password does not match";
			return false;
	} 
	
}






//Validating date of birth
function chkDOB(name,errId,errMsg){
	if( name == "" ){
		errId.innerHTML = errMsg;
		return false;
	}
	return true;	
}
	

//Validating Gender
function chkSelectDropDown(name, id, errMsg){
	if( name == "" ){
		id.innerHTML = errMsg;
		return false;
	}
	return true;
}

//Validating area of interest
function chkAreaOfInterest( name,id,errMsg){
	if(name == false){
		id.innerHTML = errMsg;
		return false;
	}
	return true;
}

function validForm(){
		
		var password = document.registerform.password.value;
		var repassword = document.registerform.confirmpassword.value;
		var validPassword = chkPassword(password,repassword);
		
		var dateOfBirthErrorId = document.getElementById("dateofBirthErr");
		var dateOfBirth = document.registerform.dateOfBirth.value;
		var validDateOfBirth = chkDOB(dateOfBirth,dateOfBirthErrorId,"Please enter date of birth");
		
		var genderErrorId = document.getElementById("gender");
		var gender = document.registerform.gender.value;
		var validGender = chkSelectDropDown(gender,genderErrorId,"Select Gender!!!!");
		
		var areaOfInterestErrorId =  document.getElementById("areaOfInterestErr");
		
		var areaOfInterest = document.getElementById('chkMedical').checked || document.getElementById('chkEngineering').checked || document.getElementById('chkLaw').checked ||document.getElementById('chkScience').checked;
		
		var validAreaOfInterest = chkAreaOfInterest(areaOfInterest,areaOfInterestErrorId,"Please select area of interest");
		
		if( validPassword && validDateOfBirth && validGender && validAreaOfInterest){
			return true;
		}else{
			return false;
		}
}
function clearErr(elementId) {
	document.getElementById(elementId).innerHTML = "";
}