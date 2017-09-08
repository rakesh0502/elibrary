<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<script type="text/javascript">
function checkfirst()
{
	var ch=true;
	var cvv=document.nonsubpayment.txtCvvNumber.value;
	var creditnofirst=document.nonsubpayment.txtFirstSet.value;
	var txtSecondSet=document.nonsubpayment.txtSecondSet.value;
	var txtThirdSet=document.nonsubpayment.txtThirdSet.value;
	var txtFourthSet=document.nonsubpayment.txtFourthSet.value;
	var creditnopattern=/[1-9][0-9]{3}/;
	var creditnopattern1=/[0-9]{4}/;
	var cvvpattern=/^[1-9][0-9]{2}$/;
	if(!creditnofirst.match(creditnopattern))
	{
	alert("Enter Correct credit card Number");
	ch=false;
	}
else if(!txtSecondSet.match(creditnopattern1))
	{
	alert("Enter Correct credit card Number");
	ch=false;
	}
else if(!txtThirdSet.match(creditnopattern1))
	{
	alert("Enter Correct credit card Number");
	ch=false;
	}
else if(!txtFourthSet.match(creditnopattern1))
	{
	alert("Enter Correct credit card Number");
	ch=false;
	}
	
	if(!cvv.match(cvvpattern))
		{
			alert("Enter the Valid CVV value");
			ch=false;
		}
	if(ch==false)
		{
			return false;
		}
	document.nonsubpayment.submit();
}

</script>
<link href="Elib.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!-- Site Wrapper Starts -->
<div id="site-wrapper">
<!-- Header Wrapper Starts -->
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
<td align="left" class="headerLink"><spring:message code="label.welcome"/> <%=session.getAttribute("username")%></td>
<td align="right" class="headerLink"><a href="show1.elib"><spring:message code="label.home"/></a> | <a href="logout.elib"><spring:message code="label.logout"/></a></td>
</tr>
</table>
</td>
</tr>
</table>
</div>
<!-- Header Wrapper Ends -->
<!-- Body Wrapper Starts -->
<div id="body-wrapper">
<div id="module-wrapper">
<div id="paymentArea">
<form name="nonsubpayment" action="successpayment.elib">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td class="moduleHeading"><spring:message code="label.payment"/></td>
</tr>
<tr>
<td align="center" valign="middle">
<table width="90%" cellpadding="0" cellspacing="15" border="0">
<tr>
<td align="right" class="moduleText" style="width:40%"><spring:message code="label.payableamount"/></td>
<td align="left" style="width:60%">${price}</td>
</tr>
<tr>
<td align="right" class="moduleText"><spring:message code="label.creditcardtype"/></td>
<td align="left" >
<select id="cardType">
<option><spring:message code="label.cardtype1"/></option>
<option><spring:message code="label.cardtype2"/></option>
</select>
</td>
</tr>
<tr>
<td align="right" class="moduleText" ><spring:message code="label.cardno"/></td>
<td align="left">
<input id="txtFirstSet" type="text" size="3" maxlength="4"/>-<input id="txtSecondSet" type="text" size="3" maxlength="4"/>-<input id="txtThirdSet" type="text" size="3" maxlength="4"/>-<input id="txtFourthSet" type="text" size="3" maxlength="4"/>
</td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.creditcardexpiry"/></td>
<td align="left" >
<spring:message code="label.month"/> &nbsp;
<select id="month">

<option>01</option>
<option>02</option>
<option>03</option>
<option>04</option>
<option>05</option>
<option>06</option>
<option>07</option>
<option>08</option>
<option>09</option>
<option>10</option>
<option>11</option>
<option>12</option>
</select>
&nbsp;&nbsp;&nbsp; <spring:message code="label.year"/> &nbsp;
<select id="year">
<option>2010</option>
<option>2011</option>
<option>2012</option>
<option>2013</option>
<option>2014</option>
<option>2015</option>
<option>2016</option>
<option>2017</option>
<option>2018</option>
<option>2019</option>
<option>2020</option>
</select>
</td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.cvv"/> </td>
<td align="left" ><input id="txtCvvNumber" type="text" size="2" maxlength="3"/></td>
</tr>
<tr>
<td align="right"><img src="images/Buy.jpg" onclick="return checkfirst();document.nonsubpayment.submit()"class="noBorder" alt="Buy" style="cursor:hand"/></td>
<td align="left"><a href="showsubhome.elib"><img src="images/Cancel.jpg" class="noBorder" alt="Cancel" style="cursor:hand"/></a></td>
<td><input type="hidden" name="price" value="${price}"></td><td><input type="hidden" name="docId" value="${docId}"></td>
</tr>
</table>
</td>
</tr>
</table>
</form>
</div>
</div>
</div>
<!-- Body Wrapper Ends -->
<!-- Footer Wrapper Starts -->
<div id="footer-wrapper">
<table width="100%" cellpadding="0" cellspacing="0">
<tr class="bottomBorder" >
<td></td>
</tr>
<tr>
<td class="copyright">Copyright &copy; 2013 XYZ Global Solutions Limited.All rights reserved.</td>
</tr>
</table>

</div>
<!-- Footer Wrapper Ends -->
</div>
<!-- Site Wrapper Ends -->
</body>
</html>