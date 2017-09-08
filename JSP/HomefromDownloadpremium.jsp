<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>E-Library Management ::Download Document</title>
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
<td align="right" class="headerLink"><a href="showsubhome.elib"><spring:message code="label.home"/></a> | <a href="logout.elib"><spring:message code="label.logout"/></a></td>
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
<div id="editDocumentArea">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td class="moduleHeading"><spring:message code="label.docdet"/></td>
</tr>
<tr>
<td align="center" valign="middle">
<table width="90%" cellpadding="0" cellspacing="15" border="0">
<tr>
<td align="center" class="thanksText" colspan="2"><spring:message code="message.thanks"/></td>
</tr>
<tr>
<td align="right" class="moduleText" style="width:50%"><spring:message code="label.documentId"/></td>
<td align="left" style="width:50%"><span class="moduleText" id="documentID">${docID}</span></td>
</tr>
<tr>
<td align="right" class="moduleText"><spring:message code="label.documentName"/></td>
<td align="left" ><span class="moduleText" id="documentName">${docName}</span></td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.title"/></td>
<td align="left"><span class="moduleText" id="title">${title}</span></td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.discipline"/></td>
<td align="left"><span class="moduleText" id="discipline">${discipline}</span></td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.author"/></td>
<td align="left"><span class="moduleText" id="author">${author}</span></td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.name5"/></td>
<td align="left"><span class="moduleText" id="documentType">${documentTypeName}</span></td>
</tr>

<tr>
<td  align="right" class="moduleText"><spring:message code="label.price"/></td>
<td align="left"><span class="moduleText" id="price">${price}</span></td>
</tr>

<tr>
<td align="center" colspan="2">
	<a href="download.elib?docId=${docID}">
		<img src="images/download.jpg" alt="Download"/>
	</a>
</td>
<td><input type="hidden" name="docId" value="${docID}"></td>
</tr>
</table>
</td>
</tr>
</table>
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