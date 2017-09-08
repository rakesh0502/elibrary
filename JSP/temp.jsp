<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>E-Library Management :: Home</title>
<link href="Elib.css" rel="stylesheet" type="text/css" />
</head>
<body alink="white" vlink="white">

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
<td align="left" class="headerLink">Welcome Guest!</td>
<td align="right" class="headerLink"><a href="login.html">Login</a> | <a href="register.html">Registration</a></td>
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
<div id="searchDocumentArea">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td class="moduleHeading">Search Documents</td>
</tr>
<tr>
<td align="center" valign="middle">
<form:form name="frm" method="post" modelAttribute="doc" action="sample.elib?page=">
<table width="90%" cellpadding="0" cellspacing="15" border="0">
<tr>
<td align="right" class="moduleText" style="width:50%">Document ID : </td>
<td align="left" style="width:50%"><form:input path="docId" id="documentID" type="text" size="30" /></td>
</tr>
<tr>
<td align="right" class="moduleText">Document Name : </td>
<td align="left"><form:input path="docName" id="txtdocumentName" type="text" size="30"/></td>
</tr>
<tr>
<td  align="right" class="moduleText">Author Name : </td>
<td align="left"><form:input path="author" id="txtauthorName" type="text" size="30"/></td>
</tr>
<tr>
<td  align="right" class="moduleText">Title : </td>
<td align="left"><form:input path="title" id="txtTitle" type="text" size="30" /></td>
</tr>
<tr>
<td  align="right" class="moduleText">Discipline : </td>
<td align="left">
<form:select path="discplineId" id="disciplines" style="width:215px">
<option value="1000001">Law</option>
<option value="1000002">Engineering</option>
<option value="1000003">Technical</option>
<option value="1000004">Medical</option>
<option value="100">All</option>
</form:select>
</td>
</tr>
<tr>
<td  align="right" class="moduleText">Document Type : </td>
<td align="left">
<form:select path="docTypeId" id="documentType" style="width:215px">
<option value="1000001">Freebie</option>
<option value="1000002">Premium</option>
<option value="100" selected="selected">All</option>
</form:select>
</td>
</tr>
<tr>
<td align="right"><img src="images/Search.jpg" alt="Search" onclick="document.frm.submit()"/></td>
<td align="left"><img src="images/reset.jpg" alt="Reset" onclick="document.frm.reset()"/></td>
</tr>
</table>

</form:form>
</td>
</tr>
</table>

</div>
</div>
<!-- Content Section Starts -->



<c:if test="${!empty result && !empty message}">
<div id="content">
<div id="contentHeader">
<table width="100%"  cellpadding="0" cellspacing="0">
<tr>
<td>Search Results</td>
</tr>

<tr><td><c:out value="${message}">${message}</c:out></td></tr>
</table>
</div>

<div id="contentBody">
<table width="100%" cellpadding="0" cellspacing="0">
<tr class="contentTableHeading">
<td style="width:23%">Document Name</td>
<td style="width:30%">Title</td>
<td style="width:20%">Author</td>
<td style="width:13%">Price</td>
<td style="width:14%">Mode</td>
</tr>
<c:forEach items="${result}"  var="docs" >
<tr class="contentTableData">
<td>${docs.docName}</td>
<td>${docs.title}</td>
<td>${docs.author}</td>
<td>${docs.price}</td>
<td><a href="download-freebie.html"><img src="images/download.jpg" class="noBorder" alt="Download"/></a></td>
</tr>
</c:forEach>
</table>



<%--For displaying Previous link except for the 1st page --%>
<table align="right" cellpadding="5" cellspacing="5">
<tr class="contentTableHeading">
<c:if test="${currentPage != 1}">
<th><a href="pagination.elib?page=${currentPage - 1}">Previous</a></th>
</c:if>
<%--For displaying Page numbers.
The when condition does not display a link for the current page--%>

<c:forEach begin="1" end="${noOfPages}" var="i">
<c:choose>
<c:when test="${currentPage eq i}">
<th>${i}</th>
</c:when>
<c:otherwise>
<th><a href="pagination.elib?page=${i}">${i}</a></th>
</c:otherwise>
</c:choose>
</c:forEach>

<%--For displaying Next link --%>
<c:if test="${currentPage lt noOfPages}">
<th><a href="pagination.elib?page=${currentPage + 1}">Next</a></th>
</c:if>
</tr>
</table>








</div>

</div>
</c:if>
<!-- Content Section Ends -->
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