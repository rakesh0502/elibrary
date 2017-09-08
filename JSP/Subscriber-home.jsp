<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>E-Library Management :: Subscriber Home</title>
<script>
function disableback()
{
	window.history.forward();
	}
</script>
<script type="text/javascript">



function validateSearch()
{
	var ch=true;	
	var docId = document.frm.docId.value;
	if(isNaN(docId))
	{
		alert("Document Id should be a number!!!");
		ch=false;
	}
	if(ch==false)
	{
		return false;
	}
document.frm.submit();
}

</script>
<SCRIPT type="text/javascript" src="js/sort.js"></SCRIPT>
<link href="Elib.css" rel="stylesheet" type="text/css" />
</head>
<body alink="white" vlink="white" >
<c:choose>
<c:when test="${!empty username }">
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
<td align="left" class="headerLink"><spring:message code="label.welcome"/>&nbsp;&nbsp;<c:out value="${username}"></c:out></td>
<td align="right" class="headerLink"><a href="logout.elib"><spring:message code="label.logout"/></a></td>
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
<form:form name="frm" method="post" modelAttribute="doc" action="sample.elib?page=&reqPage=Subscriber-home">
<table width="100%" cellpadding="0" cellspacing="0">
<tr>
<td class="moduleHeading"><spring:message code="label.search_doc"/></td>
</tr>
<tr>
				<td align="center" class="thanksText" colspan="2"><spring:message  code="${message1}"/></td>
			</tr>
<tr>
<td align="center" valign="middle">
<table width="90%" cellpadding="0" cellspacing="15" border="0">
<tr>
<td align="right" class="moduleText" style="width:50%"><spring:message code="label.documentId"/></td>
<td align="left" style="width:50%"><form:input path="docId" id="docId" type="text" size="30" maxlength="6"/></td>
</tr>
<tr>
<td align="right" class="moduleText"><spring:message code="label.name1"/></td>
<td align="left"><form:input path="docName" id="txtdocumentName" type="text" size="30"/></td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.name2"/></td>
<td align="left"><form:input path="author" id="txtauthorName" type="text" size="30"/></td>
</tr>
<tr>
<td  align="right" class="moduleText"><spring:message code="label.name3"/></td>
<td align="left"><form:input path="title" id="txtTitle" type="text" size="30" /></td>
</tr>
<tr>
<td align="right" class="moduleText"><form:label path="discplineId"><spring:message code="label.name4"/></form:label></td>
<td><form:select path="discplineId" style="width:215px">
<c:forEach items="${dId}" var="List">
<form:option value='${List.disciplineId}' > ${List.disciplineName}</form:option>
</c:forEach>
<form:option value='100' selected="true"> ALL</form:option>
</form:select></td>
</tr>
<tr>
<td align="right" class="moduleText"><form:label path="docTypeId"><spring:message code="label.name5"/></form:label></td>
<td><form:select path="docTypeId" style="width:215px">
<c:forEach items="${DoctType}" var="List">
<form:option value='${List.documenttypeId}'> ${List.documenttypeName}</form:option>
</c:forEach>
<form:option value='100' selected="true"> ALL</form:option>
</form:select></td>
</tr>
<tr>
<td align="right"><img src="images/Search.jpg" alt="Search" onclick="return validateSearch()"/></td>
<td align="left"><img src="images/reset.jpg" alt="Reset" onclick="document.frm.reset()"/></td>
</tr>
</table>
</td>
</tr>
</table>
</form:form>
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

<tr><td>${recordno}&nbsp;&nbsp;<spring:message  code="${message}"/></td></tr>
</table>
</div>

<div id="contentBody">
<table id="table"   width="100%" cellpadding="0"
		cellspacing="0" cols="5">
		
			<tr class="contentTableHeading">
				<td style="width: 23%"><spring:message code="label.document_name"/></td>
				<td style="width: 30%"><spring:message code="label.title1"/></td>
				<td style="width: 20%"><spring:message code="label.author1"/></td>
				<td style="width: 13%"><spring:message code="label.price1"/></td>
				<td style="width: 14%"><spring:message code="label.mode"/></td>
			</tr>
<c:forEach items="${result}"  var="docs" >
<tr class="contentTableData">
<td>${docs.docName}</td>
<td>${docs.title}</td>
<td>${docs.author}</td>
<td>${docs.price}</td>
<c:if test="${!empty docs.docTypeId}">
<c:choose>
<c:when test="${docs.docTypeId eq '10001'}">

<td><a href="downloadfreebie.elib?docId=${docs.docId}"><img src="images/download.jpg" class="noBorder" alt="Download"/></a></td>
</c:when>
<c:otherwise>

<td><a href="makepayment.elib?docId=${docs.docId}&price=${docs.price}"><img src="images/Buy.jpg" class="noBorder" alt="Download"/></a></td>
</c:otherwise>
</c:choose>
</c:if>
</tr>
</c:forEach>
</table>



<%--For displaying Previous link except for the 1st page --%>
<table align="right" cellpadding="5" cellspacing="5">
<tr class="contentTableHeading">
<c:if test="${currentPage != 1}">
<th class="headerLink"><a href="pagination.elib?page=${currentPage - 1}&reqPage=Subscriber-home">Previous</a></th>
</c:if>
<%--For displaying Page numbers.
The when condition does not display a link for the current page--%>

<c:forEach begin="1" end="${noOfPages}" var="i">
<c:choose>
<c:when test="${currentPage eq i}">
<th class="headerLink">${i}</th>
</c:when>
<c:otherwise>
<th ><a href="pagination.elib?page=${i}&reqPage=Subscriber-home">${i}</a></th>
</c:otherwise>
</c:choose>
</c:forEach>

<%--For displaying Next link --%>
<c:if test="${currentPage lt noOfPages}">
<th class="headerLink"><a href="pagination.elib?page=${currentPage + 1}&reqPage=Subscriber-home">Next</a></th>
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
</c:when>
<c:otherwise><c:redirect>logout.elib</c:redirect></c:otherwise>
</c:choose>
</body>
</html>