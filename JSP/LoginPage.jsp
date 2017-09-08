<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<link href="Elib.css" rel="stylesheet" type="text/css" />
<script>
function clearErr(elementId) {
	document.getElementById(elementId).innerHTML = "";
}

</script>
<script>
function disableback()
{
	window.history.forward();
	}
</script>
</head>
<body onLoad="disableback();">
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
				<td align="left" class="headerLink"></td>
				<td align="right" class="headerLink"><a
					href="showHome.elib">Home</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-- Header Wrapper Ends --> <!-- Body Wrapper Starts -->
<div id="body-wrapper">
<div id="login-wrapper">
<div id="loginArea">
<fmt:bundle basename="message">
	<form:form name="loginForm" modelAttribute="user" 
	action="validateUser.elib">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="loginHeading">Please enter login credentials</td>
		</tr>
		<tr>
			<td align="center" valign="middle">
			<table width="50%" cellpadding="0" cellspacing="15" border="0">
				<tr>
					<td align="right" class="loginText"><form:label path="userId"><spring:message code="label.userId"/></form:label></td>
					<td align="left"><form:input path="userId" size="30"
						name="userId" onfocus="clearErr('userErr')" /></td>
				</tr>
				<tr>
					<td></td>
					<td id="userErr" class="loginText"><form:errors path="userId"
						cssStyle="color:red;" /></td>
				</tr>
				<tr>
					<td align="right" class="loginText"><form:label
						path="password"><spring:message code="label.password"/></form:label></td>
					<td align="left"><form:password path="password" size="31"
						onfocus="clearErr('passwordErr')" /></td>
				</tr>
				<tr>
					<td></td>
					<td id="passwordErr" class="loginText"><form:errors path="password"
						cssStyle="color:red;" /></td>
				</tr>
				 <c:if test="${!empty error}">
						<h3 align="center"  class="thanksText"><spring:message  code="${error}"></spring:message></h3>
				</c:if>
				
				<tr>
					<td align="center" colspan="2"><img src="images/submit.jpg"
						onclick="document.loginForm.submit()" alt="Submit"
						style="cursor: hand" />&nbsp;&nbsp;<img src="images/reset.jpg" onclick="document.loginForm.reset()" 
						alt="reset" style="cursor: hand" /></td>
				</tr>
				<tr>
					<td align="right" colspan="2" class="loginText"><a
						href="register.elib"><spring:message code="label.newUser?SignUp"/></a></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</form:form>
</fmt:bundle></div>
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
</body>
</html>