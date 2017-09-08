<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>E-Library Management :: Registration Page</title>
<link href="Elib.css" rel="stylesheet" type="text/css" />
<link href="MyCalenderCss.css" type="text/css" rel="stylesheet" />
<link href="jqueryui.css" type="text/css" rel="stylesheet" />

<script language="javascript" src="jquery.js"></script>
<script language="javascript" src="jqueryui.js"></script>

<script language="javascript">
	$(function() {
		//var today = new Date(new Date().getFullYear()-18, new Date().getMonth(), new Date().getDate());
		$("#dateOfBirth").datepicker({
			dateFormat : 'dd-M-yy',
			changeMonth : true,
            changeYear : true,
            yearRange: '-100y:c+nn',
            maxDate: '-1d'
		});
	});
</script>

<script type="text/javascript" language="javascript">
function validateForm(){
	var chkForm = validForm();
	if(chkForm){
		return true;
	}else{
		return false;
	}
}

//Validating Password
function chkPassword(password, repassword){
	if(password == repassword)
		return true;
	else if(password != repassword){
		var id= document.getElementById("txtConfirmPassword");
		id.innerHTML = "Password does not match";
		return false;
	} 
}

//Validating area of interest
function chkAreaOfInterest(name, id, errMsg){
	if(!name){
		id.innerHTML = errMsg;
		return false;
	}
	return true;
}

function validForm(){
	var password = document.registerform.password.value;
	var repassword = document.registerform.confirmpassword.value;
	var validPassword = chkPassword(password, repassword);
		
	var areaOfInterestErrorId =  document.getElementById("areaOfInterestErr");
	var areaOfInterest = document.getElementById('chkMedical').checked || document.getElementById('chkEngineering').checked || document.getElementById('chkLaw').checked ||document.getElementById('chkScience').checked;
	var validAreaOfInterest = chkAreaOfInterest(areaOfInterest, areaOfInterestErrorId, "Please select area of interest");
	if(validPassword && validAreaOfInterest) {
		return true;
	} else {
		return false;
	}
}

function clearErr(elementId){
	document.getElementById(elementId).innerHTML="";
}
</script>

</head>
<body>
<form:form name="registerform" method="post" modelAttribute="ruser"
	action="acceptregister.elib" onsubmit="return validateForm()">
	<!-- Site Wrapper Starts -->
	<div id="site-wrapper"><!-- Header Wrapper Starts -->
	<div id="header-wrapper">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr class="topBorder">
			<td></td>
		</tr>
		<tr class="headerBanner">
			<td></td>
		</tr>
		<tr class="topBorder">
			<td>
			<table width="100%">
				<tr>
					<td align="left" class="headerLink">Welcome Guest!</td>
					<td align="right" class="headerLink"><a href="showHome.elib">Home</a>
					</td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</div>
	<!-- Header Wrapper Ends --> <!-- Body Wrapper Starts -->
	<div id="body-wrapper">
	<div id="module-wrapper">
	<div id="registerArea">

	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="moduleHeading">Registration Details</td>
		</tr>
		<tr>
				<td align="center" class="thanksText" colspan="2">${message}</td>
			</tr>
		<tr>
			<td align="center" valign="middle">
			<table width="90%" cellpadding="0" cellspacing="15" border="0">

				<c:if test="${!empty ruser.userId}">
					<tr>
						<td align="right" class="moduleText"><form:label
							path="userId"><spring:message code="label.userId"/> </form:label></td>
						<td align="left"><form:input value="${ruser.userId}"
							readonly="true" maxlength="30" path="userId" /></td>
						<td align="left" id="txtuserID"></td>
					</tr>

				</c:if>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="firstName"><spring:message code="label.firstName"/> </form:label></td>
					<td align="left"><form:input maxlength="30" path="firstName"
						onfocus="clearErr('txtFirstName')" /></td>
					<td align="left" id="txtFirstName" class="moduleText"><form:errors
						path="firstName" cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="lastName"><spring:message code="label.lastName"/></form:label></td>
					<td align="left"><form:input maxlength="30" path="lastName"
						onfocus="clearErr('txtLastName')" /></td>
					<td align="left" id="txtLastName" class="moduleText"><form:errors path="lastName"
						cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="password"><spring:message code="label.password"/></form:label></td>
					<td align="left"><form:password maxlength="30" path="password"
						name="password" onfocus="clearErr('txtPassword')" /></td>
					<td align="left" id="txtPassword" class="moduleText"><form:errors path="password"
						cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.confirmPassword"/></td>
					<td align="left"><input type="password" name="confirmpassword"
						maxlength="30" onfocus="clearErr('txtConfirmPassword')" /></td>
					<td align="left" id="txtConfirmPassword" style="color: red"></td>
				</tr>
				<tr>
					<td align="right" class="moduleText"><form:label path="gender"><spring:message code="label.gender"/></form:label></td>
					<td align="left"><form:select path="gender" name="gender"
						style="width:215px">
						<form:option value="M"><spring:message code="label.gender1"/></form:option>
						<form:option value="F"><spring:message code="label.gender2"/></form:option>
					</form:select></td>
					<td align="left" id="gender"><form:errors path="gender"
						cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="dateOfBirth"><spring:message code="label.dateOfBirth"/></form:label></td>
					<td align="left"><form:input maxlength="30" path="dateOfBirth"
						name="dateOfBirth" id="dateOfBirth"
						onfocus="clearErr('dateofBirthErr')" /></td>
					<td align="left" id="dateofBirthErr" class="moduleText"><form:errors
						path="dateOfBirth" cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="address"><spring:message code="label.address"/></form:label></td>
					<td align="left"><form:textarea rows="3" cols="25"
						path="address" name="address" onfocus="clearErr('txtAddress')" /></td>
					<td align="left" id="txtAddress" class="moduleText"><form:errors path="address"
						cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="landLineNumber"><spring:message code="label.landline"/></form:label></td>
					<td align="left"><form:input maxlength="30"
						path="landLineNumber" name="landLineNumber"
						onfocus="clearErr('txtLandline')" /><spring:message code="label.format"/></td>
					<td align="left" id="txtLandline" class="moduleText"><form:errors
						path="landLineNumber" cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label
						path="mobileNumber"><spring:message code="label.mobile"/></form:label></td>
					<td align="left"><form:input maxlength="30"
						path="mobileNumber" name="mobileNumber"
						onfocus="clearErr('txtMobileNumber')" /><spring:message code="label.format"/></td>
					<td align="left" id="txtMobileNumber" class="moduleText"><form:errors
						path="mobileNumber" cssStyle="color:red;" /></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><form:label path="email"><spring:message code="label.email"/></form:label></td>
					<td align="left"><form:input maxlength="30" path="email"
						name="email" onfocus="clearErr('txtEmailID')" /></td>
					<td align="left" id="txtEmailID" class="moduleText"><form:errors path="email"
						cssStyle="color:red;" /></td>
				</tr>


				<tr>
					<td align="right" class="moduleText"><form:label
						path="areaOfInterest"><spring:message code="label.areaOfInterest"/></form:label></td>
					<td align="left"><input id="chkMedical" type="checkbox"
						name="samecheckbox" value="Medical" size="30" checked="checked" /><spring:message code="label.areaOfInterest1"/>
					<input id="chkEngineering" type="checkbox" name="samecheckbox"
						value="Engineering" size="30" /><spring:message code="label.areaOfInterest2"/> <br />
					<input id="chkLaw" type="checkbox" name="samecheckbox" value="Law"
						size="30" /><spring:message code="label.areaOfInterest3"/> <input id="chkScience" type="checkbox"
						name="samecheckbox" value="Science" size="30" /><spring:message code="label.areaOfInterest4"/></td>
					<td align="left" id="areaofinterest"></td>
				</tr>

				<tr>
					<td align="right">
					<!--<input type="submit" value="Register">
					
					--><img src="images/submit.jpg"
						onclick="document.registerform.submit()" alt="Submit"
						style="cursor: hand" />
					</td>
					<td align="left"><img src="images/reset.jpg" onclick="document.registerform.reset()" alt="Reset" /> 
					<!--<input type="reset" value="Reset">
					
					
					
					--></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	
	</div>
	</div>
	</div>
	<!-- Body Wrapper Ends --> <!-- Footer Wrapper Starts -->
	<div id="footer-wrapper">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr class="bottomBorder">
			<td></td>
		</tr>
		<tr>
			<td class="copyright">Copyright &copy; 2013 XYZ Global
			Solutions Limited.All rights reserved.</td>
		</tr>
	</table>
	</div>
	<!-- Footer Wrapper Ends --></div>
	<!-- Site Wrapper Ends -->
</form:form>
</body>
</html>