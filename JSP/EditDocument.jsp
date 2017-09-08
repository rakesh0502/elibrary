<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>E-Library Management :: Edit Document</title>
<link href="Elib.css" rel="stylesheet" type="text/css" />
<script>
	function clearErr(elementId) {
		document.getElementById(elementId).innerHTML = "";
	}
	

	function chkEmpty(name, id, errMsg) {
		if (name=="") {
			
			id.innerHTML = errMsg;
			return false;
		}
		
		return true;
	}

	function chkNumber(name, id, errMsg) {
		if ((name < 0) || (name > 9999)) {
			id.innerHTML = errMsg;
			return false;
		}
		return true;
	}

	function validAddDocForm() {
		//var validFileExt = CheckExt(document.formAddDoc.fileData.value);
		var docName = document.formAddDoc.docName.value;
		var docNameErrorId = document.getElementById("errDocName");
		var validDocName = chkEmpty(docName, docNameErrorId,
				"Document name is required!!!");
		
		var docDes = document.formAddDoc.docDescription.value;
		var docDesErrorId = document.getElementById("errDocDes");
		var validDocDes = chkEmpty(docDes, docDesErrorId,
				"Document description is required!!!");
		
		var title = document.formAddDoc.title.value;
		var titleErrorId = document.getElementById("errTitle");
		var validTitle = chkEmpty(title, titleErrorId, "Title is required!!!");

		var author = document.formAddDoc.author.value;
		var authorErrorId = document.getElementById("errAuthor");
		var validAuthor = chkEmpty(author, authorErrorId,
				"Author name is required!!!");

		var price = document.formAddDoc.price.value;
		var priceErrorId = document.getElementById("errPrice");
		var validPrice = chkNumber(price, priceErrorId, "Price is required!!!");
		
		if (validDocName && validAuthor && validDocDes && validPrice
				&& validTitle ) {
			
			return true;
		} else {
			
			return false;
		}
	}
</script>
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
<td align="left" class="headerLink"><spring:message code="label.welcome3"/></td>
<td align="right" class="headerLink"><a href="adminhome.elib"><spring:message code="label.home"/></a> | <a href="logout.elib"><spring:message code="label.logout"/></a></td>
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
<form:form method="post" name="formAddDoc" modelAttribute="doc" action="updateDocument.elib">
	<table  width="100%" cellpadding="0" cellspacing="0">
	<tr>
	<td class="moduleHeading"><spring:message code="label.edit_document"/></td>
</tr>
<c:if test="${!empty msgResult}">
<tr>
<td align="center" class="thanksText" colspan="2"><spring:message  code="${msgResult}"/></td></tr></c:if>
<tr>
	<td align="center" valign="middle">
<table width="90%" cellpadding="0" cellspacing="15" border="0">
	
		<tr>
			<td align="right" class="moduleText" style="width:50%"><form:label path="docId" ><spring:message code="label.documentId"/></form:label></td>
			<td align="left" style="width:50%"><form:input path="docId" value="${doc_id}"  onfocus="clearErr('txtdocId')" readonly="true" /></td>
			<td align="left" id="txtdocId"><form:errors path="docId" cssStyle="color:red;"/></td>
		</tr>
		<tr>
			<td align="right" class="moduleText"><form:label path="docName"><spring:message code="label.documentName"/></form:label></td>
			<td align="left"><form:input path="docName" onfocus="clearErr('txtdocName')"/></td>
			<td align="left" id="txtdocName"><form:errors path="docName" cssStyle="color:red;" /></td>
		</tr>
		<tr>
					<td></td>
					<td id="errDocName" ><small> <form:errors
						path="docName" cssStyle="color:red" /> </small></td>
				</tr>
		
		<tr>
		<td align="right" class="moduleText"><form:label path="docDescription"><spring:message code="label.document"/></form:label> </td>
        <td align="left"><form:textarea path="docDescription" rows="2" cols="25" onfocus="clearErr('txtdocDescription')"></form:textarea></td>
        <td align="left" id="txtdocDescription"> <form:errors path="docDescription" cssStyle="color:red;"  /></td>
		</tr>
		<tr>
					<td></td>
					<td id="errDocDes"><small> <form:errors
						path="docDescription" cssStyle="color:red" /> </small></td>
				</tr>
		<tr>
			<td align="right" class="moduleText"><form:label path="discplineId">Discipline Id:  </form:label></td>
			<td align="left"><form:select path="discplineId">${doc.discplineId eq List.disciplineId} ${doc.discplineId} 
				<c:forEach items="${dId}" var="List">
				
				<c:choose>
				
				<c:when test="${discplineId eq List.disciplineId}">
				<form:option path="discplineId" value='${List.disciplineId}' selected="true"> ${List.disciplineName}</form:option>
				</c:when>
				
				<c:otherwise>
				<form:option path="discplineId" value='${List.disciplineId}'> ${List.disciplineName}</form:option>
				</c:otherwise>
				</c:choose>
				
				</c:forEach>
				</form:select></td><td align="left" id="txtprice"><form:errors path="discplineId" cssStyle="color:red;" /></td>
		</tr>
		<tr>
			<td align="right" class="moduleText"><form:label path="title"><spring:message code="label.title"/></form:label></td>
			<td align="left"><form:input path="title" onfocus="clearErr('txttitle')"/></td>
			<td align="left" id="txttitle"><form:errors path="title" cssStyle="color:red;"></form:errors></td>
		</tr>
		<tr>
					<td></td>
					<td id="errTitle"><small> <form:errors path="title"
						cssStyle="color:red" /> </small></td>
				</tr>
		<tr>
			<td align="right" class="moduleText"><form:label path="author"><spring:message code="label.author"/></form:label></td>
			<td align="left"><form:input path="author" onfocus="clearErr('txtauthor')"/></td>
			<td align="left" id="txtauthor"><form:errors path="author" cssStyle="color:red;" /></td>
		</tr>
		<tr>
					<td></td>
					<td id="errAuthor"><small> <form:errors path="author"
						cssStyle="color:red" /> </small></td>
				</tr>
		<tr>
			<td align="right" class="moduleText"><form:label path="price"><spring:message code="label.price"/></form:label></td>
			<td align="left"><form:input path="price" onfocus="clearErr('txtprice')"/></td>
			<td align="left" id="txtprice"><form:errors path="price" cssStyle="color:red;" /></td>
		</tr>
		<tr>
					<td></td>
					<td id="errPrice"><small> <form:errors path="price"
						cssStyle="color:red" /> </small></td>
				</tr>
		<tr>
<td align="right" class="moduleText"><form:label path="docTypeId"><spring:message code="label.name5"/></form:label></td>
<td align="left"><form:select id="docTypeId" path="docTypeId"><form:option value="1">--select--</form:option>
<c:forEach items="${DoctType}" var="List">
<form:option path="docTypeId" value='${List.documenttypeId}'> ${List.documenttypeName}</form:option>
</c:forEach>
</form:select></td><td align="left" id="txtprice"><form:errors path="docTypeId" cssStyle="color:red;" /></td>
</tr>
<tr>
<td align="right">

<!--<input type="submit" value="Modify" onclick="return validAddDocForm()" ></input>

--><img src="images/Modify.jpg"
						onclick="document.formAddDoc.submit()" alt="Modify"
						style="cursor: hand" onclick="return validAddDocForm()" />

</td>
<td align="left"><a href="adminhome.elib"><img src="images/Cancel.jpg" alt="Cancel"/></a></td>
</tr>

</table>
</td>
</tr>
</table>
	
</form:form>
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