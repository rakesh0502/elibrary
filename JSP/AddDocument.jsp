<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib uri="http://www.springframework.org/tags"  prefix="spring"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>E-Library Management :: Add Document</title>
<link href="css/Elib.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
	function CheckExt(file) {
		extArray = new Array(".pdf");
		allowSubmit = false;
		if (!file) {
			alert("Please select a file");
			return false;
		}

		while (file.indexOf("\\") != -1)
			file = file.slice(file.indexOf("\\") + 1);
		ext = file.slice(file.indexOf(".")).toLowerCase();
		for ( var i = 0; i < extArray.length; i++) {
			if (extArray[i] == ext) {
				allowSubmit = true;
				break;
			}
		}

		if (allowSubmit)
			return true;
		else			
			alert("File extension is not correct");
		return false;
		
	}

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
		var validFileExt = CheckExt(document.formAddDoc.fileData.value);
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
				&& validTitle && validFileExt) {
			
			return true;
		} else {
			
			return false;
		}
	}
	
	function dispPrice(){
		var price=document.getElementById("price");
		
		if(document.formAddDoc.docTypeId[document.formAddDoc.docTypeId.selectedIndex].value == "10002"){
			document.formAddDoc.price.value = "0.00";
			price.removeAttribute("readOnly");
			
			
			
		}	else{
		
			document.formAddDoc.price.value = "0.00";
			price.setAttribute("readOnly", "true");
			
			
		}	
	}
</script>
</head>
<body>
<div id="site-wrapper">
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
				<td align="left" class="headerLink">Welcome Admin!</td>
				<td align="right" class="headerLink"><a href="adminhome.elib">Home</a>|<a
					href="logout.elib">Logout</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<div id="body-wrapper">
<div id="module-wrapper">
<div id="addDocumentArea">
<table width="100%" cellpadding="0" cellspacing="0">
	<form:form method="post" modelAttribute="document" name="formAddDoc"
		id="formAddDoc" action="saveDoc.elib" enctype="multipart/form-data"
		onsubmit="return validAddDocForm()">
		<tr>
			<td class="moduleHeading"><spring:message code="label.add_document"/></td>
		</tr>
		<c:if test="${!empty success}">
			<tr>
				<td align="center" class="thanksText" colspan="2"><spring:message  code="${success}"/></td>
			</tr>
		</c:if>
		<tr>
			<td align="center" valign="middle">
			<table width="90%" cellpadding="0" cellspacing="15" border="0">
				<tr>
					<td align="right" class="moduleText" style="width: 50%"><spring:message code="label.documentName"/></td>
					<td align="left" style="width: 50%"><form:input path="docName"
						size="30" name="docName" id="docName" onfocus="clearErr('errDocName')" />
				</tr>
				<tr>
					<td></td>
					<td id="errDocName" ><small> <form:errors
						path="docName" cssStyle="color:red" /> </small></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.document_desc"/></td>
					<td align="left"><form:textarea name="docDescription" id="docDescription"
						path="docDescription" rows="2" cols="25"
						onfocus="clearErr('errDocDes')" /></td>
				</tr>
				<tr>
					<td></td>
					<td id="errDocDes"><small> <form:errors
						path="docDescription" cssStyle="color:red" /> </small></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.disciplines"/></td>
					<td align="left"><form:select path="discplineId" >
						<c:if test="${!empty dispList}">
							<c:forEach items="${dispList}" var="discipline">
								<form:option value="${discipline.disciplineId}">
										${discipline.disciplineName}
									</form:option>
							</c:forEach>
						</c:if>
					</form:select></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.title"/></td>
					<td align="left"><small> <form:input path="title" id="title"
						name="title" size="30" onfocus="clearErr('errTitle')" /> </small></td>
				</tr>
				<tr>
					<td></td>
					<td id="errTitle"><small> <form:errors path="title"
						cssStyle="color:red" /> </small></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.author"/></td>
					<td align="left"><form:input name="author" path="author" id="author"
						size="30" onfocus="clearErr('errAuthor')" /></td>
				</tr>
				<tr>
					<td></td>
					<td id="errAuthor"><small> <form:errors path="author"
						cssStyle="color:red" /> </small></td>
				</tr>
				
				
				<tr>
					<td align="right" class="moduleText"><spring:message code="label.document_type"/></td>
					<td align="left"><form:select name="docTypeId" path="docTypeId" onchange="dispPrice()">
						<c:if test="${!empty docTypeList}">
							<c:forEach items="${docTypeList}" var="docType">
								<form:option value="${docType.documenttypeId}">
										${docType.documenttypeName}
									</form:option>
							</c:forEach>
						</c:if>
					</form:select></td>
				</tr>
				

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.price"/></td>
					<td align="left"><form:input id="price" name="price" path="price" size="30"
						onfocus="clearErr('errPrice')" readonly="true" value="0.00" /></td>
				</tr>
				
				
				
				
				<tr>
					<td></td>
					<td id="errPrice"><small> <form:errors path="price"
						cssStyle="color:red" /> </small></td>
				</tr>

				<tr>
					<td align="right" class="moduleText"><spring:message code="label.file_upload"/></td>
					<td align="left"><form:input name="fileData" path="fileData"
						id="fileData" type="file" size="30"
						onfocus="clearErr('errFileData')" /></td>
				</tr>
				<tr>
					<td></td>
					<td id="errFileData"><small> <form:errors
						path="fileData" cssStyle="color:red" /> </small></td>
				</tr>

				

				<tr>
					<td align="right"><input type="submit" alt="Add"
						 value="Add" onclick="return validAddDocForm()"></td>
					<td align="left"><input type="reset" alt="Cancel"
						 value="Reset"></td>
				</tr>
			</table>
			</td>
		</tr>
	</form:form>
</table>
</div>
</div>
</div>
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
</div>
</body>
</html>