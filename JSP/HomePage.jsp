
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>E-Library Management :: Home</title>
<SCRIPT type="text/javascript" src="js/sort.js"></SCRIPT>


<link href="Elib.css" rel="stylesheet" type="text/css" />
<style type="text/css">

.button{
background-color:white;
color:black;
font-weight: bold;

}

</style>
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
</head>
<body alink="white" vlink="white">
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
				<td align="left" class="headerLink"><spring:message code="label.welcome2"/></td>
				<td align="right" class="headerLink"><a href="loginForm.elib"><spring:message code="label.login"/></a>
				| <a href="register.elib"><spring:message code="label.registration"/></a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<!-- Header Wrapper Ends --> <!-- Body Wrapper Starts -->
<div id="body-wrapper">
<div id="module-wrapper">
<div id="searchDocumentArea"><form:form name="frm" id="frm" method="post"
	modelAttribute="doc" action="sample.elib?page=&reqPage=HomePage" onsubmit="return validateSearch()">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td class="moduleHeading"><spring:message code="label.search_doc"/></td>
		</tr>
		<tr>
				<td align="center" class="thanksText" colspan="2"><spring:message  code="${message1}"></spring:message></td>
			</tr>
		<tr>
			<td align="center" valign="middle">
			<table width="90%" cellpadding="0" cellspacing="15" border="0">
				<tr>
					<td align="right" class="moduleText" style="width: 50%"><spring:message code="label.documentId"/></td>
					<td align="left" style="width: 50%"><form:input path="docId"
						 id="docId" size="30" maxlength="6"/></td>
				</tr>
				<tr>
					<td align="right" class="moduleText"><spring:message code="label.documentName"/></td>
					<td align="left"><form:input path="docName"
						id="txtdocumentName" type="text" size="30" /></td>
				</tr>
				<tr>
					<td align="right" class="moduleText"><spring:message code="label.name2"/></td>
					<td align="left"><form:input path="author" id="txtauthorName"
						type="text" size="30" /></td>
				</tr>
				<tr>
					<td align="right" class="moduleText"><spring:message code="label.title"/></td>
					<td align="left"><form:input path="title" id="txtTitle"
						type="text" size="30" /></td>
				</tr>
				<tr>
					<td align="right" class="moduleText"><form:label path="discplineId"><spring:message code="label.discipline"/></form:label></td>
					<td><form:select path="discplineId" style="width:215px">
						<c:forEach items="${dId}" var="List">
							<form:option value='${List.disciplineId}' > ${List.disciplineName}</form:option>
						</c:forEach>
						<form:option value='100' selected="true"> ALL</form:option>
					</form:select></td>
				</tr>
				<tr>
					<td align="right" class="moduleText"><form:label path="docTypeId"><spring:message code="label.documentType"/></form:label></td>
					<td><form:select path="docTypeId" style="width:215px">
						<c:forEach items="${DoctType}" var="List">
							<form:option value='${List.documenttypeId}'> ${List.documenttypeName}</form:option>
						</c:forEach>
						<form:option value='100' selected="true"> ALL</form:option>
					</form:select></td>
				</tr>
				<tr>
					<td  align="right">
						 <img src="images/Search.jpg" alt="Search" onclick="return validateSearch()" /> 
					<!--<input  class="button" type="submit" value="Search">
					--></td>
					<td align="left">
						 <img src="images/reset.jpg" alt="Reset" onclick="document.frm.reset()" /> 
						<!--<input class="button" type="reset" value="Reset">
					--></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
</form:form></div>
</div>

<!-- Content Section Starts --> <c:if
	test="${!empty result && !empty message}">
	<div id="content">
	<div id="contentHeader">
	<table width="100%" cellpadding="0" cellspacing="0">
		<tr>
			<td>Search Results</td>
		</tr>

		<tr><td>${recordno}&nbsp;&nbsp;<spring:message  code="${message}"/></td></tr>
	</table>
	</div>

	<div id="contentBody">
	<form id="tble" name="tble">
	<table id="table"   width="100%" cellpadding="0"
		cellspacing="0" cols="5">
		
			<tr class="contentTableHeading">
					<td style="width: 23%"><spring:message code="label.document_name"/></td>
				<td style="width: 30%"><spring:message code="label.title1"/></td>
				<td style="width: 20%"><spring:message code="label.author1"/></td>
				<td style="width: 13%"><spring:message code="label.price1"/></td>
				<td style="width: 14%"><spring:message code="label.mode"/></td>
			</tr>
	
		<c:forEach items="${result}" var="docs">
		
				<tr class="contentTableData">
					<td>${docs.docName}</td>
					<td>${docs.title}</td>
					<td>${docs.author}</td>
					<td>${docs.price}</td>
					<td>
					<c:if test="${!empty docs.docTypeId}">
						<c:choose>
							<c:when test="${docs.docTypeId eq '10001'}">
								<a href="downloadfreebie.elib?docId=${docs.docId}">
									<img src="images/download.jpg" class="noBorder" alt="${docs.price}" />
								</a>
							</c:when>
							<c:otherwise>
								<img src="images/Buy-disabled.jpg" class="noBorder" alt="${docs.price}" />
							</c:otherwise>
						</c:choose>
					</c:if>
					</td>
				</tr>
		
		</c:forEach>
	</table>
	</form>


	<%--For displaying Previous link except for the 1st page --%>
	<table align="right" cellpadding="5" cellspacing="5">
		<tr class="contentTableHeading">
			<c:if test="${currentPage != 1}">
				<th class="headerLink"><a
					href="pagination.elib?page=${currentPage - 1}&reqPage=HomePage">Previous</a></th>
			</c:if>
			<%--For displaying Page numbers.
The when condition does not display a link for the current page--%>

			<c:forEach begin="1" end="${noOfPages}" var="i">
				<c:choose>
					<c:when test="${currentPage eq i}">
						<th class="headerLink">${i}</th>
					</c:when>
					<c:otherwise>
						<th><a href="pagination.elib?page=${i}&reqPage=HomePage">${i}</a></th>
					</c:otherwise>
				</c:choose>
			</c:forEach>

			<%--For displaying Next link --%>
			<c:if test="${currentPage lt noOfPages}">
				<th class="headerLink"><a
					href="pagination.elib?page=${currentPage + 1}&reqPage=HomePage">Next</a></th>
			</c:if>
		</tr>
	</table>
	








	</div>

	</div>
</c:if> <!-- Content Section Ends --></div>
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