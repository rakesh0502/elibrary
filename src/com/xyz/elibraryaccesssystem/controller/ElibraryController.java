package com.xyz.elibraryaccesssystem.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.DocumentDiscipline;
import com.xyz.elibraryaccesssystem.beans.DocumentType;
import com.xyz.elibraryaccesssystem.beans.FileData;
import com.xyz.elibraryaccesssystem.service.DocumentServiceInterface;
import com.xyz.elibraryaccesssystem.service.UserServiceInterface;




@Controller
@SessionAttributes("search")
public class ElibraryController {
	
	@Autowired
	private UserServiceInterface userService;

	@Autowired
	private DocumentServiceInterface documentService;
	/*
	 * ********************************
	 * Login Module
	 * Developed by :Pravicha Verma
	 * ********************************
	 */
	@RequestMapping("show")
	public String showLogin(Model model) {
		model.addAttribute("doc", new Document());
		return "temp";
	}

	@RequestMapping("adminhome")
	public String showadminhome(Model model)
	{
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType",
				documentService.getdocumentId());
		model.addAttribute("doc", new Document());
		return "Admin-Home";
	}
	
	
	
	
	
	/*
	 * ********************************
	 * Search Module
	 * Developed by :Sheela Shree
	 * ********************************
	 */
	@RequestMapping("sample")
	public String search(@ModelAttribute("doc") @Valid Document doc,
			@RequestParam("page") String pages,
			@RequestParam("reqPage") String reqPage, Model model) {
		List<Document> results = new ArrayList<Document>();
		results = documentService.searchDocument(doc);
		if(results.isEmpty())
		{
			model.addAttribute("message1", "error.record");
		}
		
		int page = 1;
		int recordsPerPage = 10;
		if (!pages.equals("")) {
			page = Integer.parseInt(pages);
		}

		int noOfRecords = results.size();
		int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
		
		List<Document> result = getCurrentPageRecords(results, page);
		model.addAttribute("noOfPages", noOfPages);
		model.addAttribute("currentPage", page);
		model.addAttribute("search", results);

		if (result.size() > 0) {
			// model.addAttribute("currentPageRecords", result);
			model.addAttribute("doc", new Document());
			model.addAttribute("result", result);
			model.addAttribute("recordno", results.size());
			model.addAttribute("message","message.record3");

		} else {
			model.addAttribute("doc", new Document());
			model.addAttribute("message", "error.record2");
		}
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType", documentService.getdocumentId());
		return reqPage;

	}

	@RequestMapping("pagination")
	public String pagination(@ModelAttribute("search") List<Document> results,
			@RequestParam("page") String pages,
			@RequestParam("reqPage") String reqPage, Model model) {

		int page = 1;
		int recordsPerPage = 10;
		if (!pages.equals("")) {
			page = Integer.parseInt(pages);
		}

		int noOfRecords = results.size();
		int noOfPages = (int) Math.ceil(noOfRecords * 1.0 / recordsPerPage);
		//System.out.println(results.toString());
		List<Document> result = getCurrentPageRecords(results, page);
		model.addAttribute("noOfPages", noOfPages);
		model.addAttribute("currentPage", page);

		if (result.size() > 0) {
			// model.addAttribute("currentPageRecords", result);
			model.addAttribute("result", result);
			model.addAttribute("recordno", results.size());
			model.addAttribute("message","message.record3");
		} else {
			model.addAttribute("message", "error.record2");
		}
		model.addAttribute("doc", new Document());
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType", documentService.getdocumentId());
		return reqPage;

	}

	public List<Document> getCurrentPageRecords(List<Document> totalList,
			int currentPageNo) {
		if (totalList == null) {
			return null;
		}
		int startIndex = (currentPageNo - 1) * 10;
		int endIndex = (startIndex + 10 > totalList.size() ? totalList.size()
				: startIndex + 10);
		//System.out.println(totalList.subList(startIndex, endIndex).toString());
		return totalList.subList(startIndex, endIndex);
	}

	
	/*
	 * ********************************
	 * Add Document Module
	 * Developed by :Shraddha Verma
	 * ********************************
	 */
	
	@RequestMapping("addDoc")
	public String loadAddDoc(Model model) {
		List<DocumentDiscipline> disciplineList = documentService.getdId();
		List<DocumentType> docTypeList = documentService.getdocumentId();

		model.addAttribute("dispList", disciplineList);
		model.addAttribute("docTypeList", docTypeList);
		model.addAttribute(new Document());

		return "AddDocument";
	}

	@RequestMapping("saveDoc")
	public String saveDoc(@ModelAttribute("document") @Valid Document document,FileData fileData,
			BindingResult bindingResults, Model model) throws IOException {
		if (bindingResults.hasErrors()) {
			List<DocumentDiscipline> disciplineList = documentService.getdId();
			List<DocumentType> docTypeList = documentService.getdocumentId();

			model.addAttribute("dispList", disciplineList);
			model.addAttribute("docTypeList", docTypeList);

			return "AddDocument";
		} else if(documentService.fileupload(fileData)==true)
		{
			if (documentService.addDocument(document)) {
				List<DocumentDiscipline> disciplineList = documentService
						.getdId();
				List<DocumentType> docTypeList = documentService
						.getdocumentId();

				model.addAttribute("dispList", disciplineList);
				model.addAttribute("docTypeList", docTypeList);
				model.addAttribute(new Document());
				model.addAttribute("success", "message.docadded");
			} else {
				List<DocumentDiscipline> disciplineList = documentService
						.getdId();
				List<DocumentType> docTypeList = documentService
						.getdocumentId();

				model.addAttribute("dispList", disciplineList);
				model.addAttribute("docTypeList", docTypeList);
				model.addAttribute(new Document());
				model.addAttribute("success", "message.docaddedalready");
			}
		}
		return "AddDocument";
	}

	// paymet starting
	@RequestMapping("show1")
	public String showLogin1(Model model) {
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType", documentService.getdocumentId());
		model.addAttribute("doc", new Document());
		return "temp1";
	}

	@RequestMapping("membershipSubscription")
	public String showPaymentGateway() {
		
		return "Subscriber-Payment";
	}

	@RequestMapping("show2")
	public String showSubscriberPage(Model model,
			@RequestParam("userId") String userId, HttpServletRequest request) {
		model.addAttribute("doc", new Document());
		HttpSession session = request.getSession();
		if (userService.doSubscription(userId)) {
			model.addAttribute("dId", documentService.getdId());
			model.addAttribute("DoctType", documentService.getdocumentId());
			model.addAttribute("doc", new Document());
			session.setAttribute("userType", "sub");
			return "Subscriber-home";
		} else {
			model.addAttribute("dId", documentService.getdId());
			model.addAttribute("DoctType", documentService.getdocumentId());
			model.addAttribute("doc", new Document());
			return "temp1";
		}

	}

	@RequestMapping("makepayment")
	public String makePayment(@RequestParam("docId") String docId,
			@RequestParam("price") double price, Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		String userType = (String) session.getAttribute("userType");
		if (userType.equalsIgnoreCase("sub")) {

			double discount = price * 0.2;
			double pricefinal = price - discount;
			String pricefinal1 = pricefinal + "";
			model.addAttribute("price", pricefinal1);
			model.addAttribute("docId", docId);
			return "subdocumentpayment";
		} else {

			model.addAttribute("price", price);
			model.addAttribute("docId", docId);
			return "nonsubpayment";
		}
	}

	@RequestMapping("successpayment")
	public String successPayment(@RequestParam("docId") String docId,
			@RequestParam("price") String price, Model model,
			HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		//System.out.println("id" + docId + "price" + price);
		Document doc = new Document();
		doc.setDocId(docId);
		Document doc1 = documentService.payment(doc);
		
		model.addAttribute("docID", docId);
		model.addAttribute("docName", doc1.getDocName());
		model.addAttribute("discipline", doc1.getDiscipline());
		model.addAttribute("documentTypeName", doc1.getDocumentTypeName());
		model.addAttribute("price", price);
		model.addAttribute("author", doc1.getAuthor());
		model.addAttribute("title", doc1.getTitle());
		String userType = (String) session.getAttribute("userType");
		if (userType.equalsIgnoreCase("nonsub"))
			return "Download-Premium";
		else
			return "HomefromDownloadpremium";
	}

	
	
	
	/*
	 * ********************************
	 * Download Module
	 * Developed by :Shikhar Bajpai
	 * ********************************
	 */
	@RequestMapping("downloadfreebie")
	public String downloadFreebie(@RequestParam("docId") String docId,
			Model model, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Document doc = new Document();
		doc.setDocId(docId);
		Document doc1 = documentService.payment(doc);
		model.addAttribute("docID", docId);
		model.addAttribute("docName", doc1.getDocName());
		model.addAttribute("discipline", doc1.getDiscipline());
		model.addAttribute("documentTypeName", doc1.getDocumentTypeName());
		model.addAttribute("price", "0");
		model.addAttribute("author", doc1.getAuthor());
		model.addAttribute("title", doc1.getTitle());
		String userType = (String) session.getAttribute("userType");
		if (userType != null) {

			if (userType.equalsIgnoreCase("sub"))
				return "Download-freebie-sub";
			else if (userType.equalsIgnoreCase("nonsub"))
				return "Download-freebie-nonsub";
		}
		return "Download-freebie";
	}

	// for showing subscriber page again
	@RequestMapping("showsubhome")
	public String showSubHome(Model model) {
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType", documentService.getdocumentId());
		model.addAttribute("doc", new Document());
		return "Subscriber-home";
	}
	
	
	
	/*
	 * ********************************
	 * EditDocument Module
	 * Developed by :Karun Wadhera
	 * ********************************
	 */

	// modify document
	@RequestMapping("showEditPage")
	public String showEditPage(Model model, @RequestParam("docId") String docId) {
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType", documentService.getdocumentId());
		Document doc = new Document();
		doc.setDocId(docId);
		model.addAttribute("doc", documentService.payment(doc));
		return "EditDocument";
	}

	@RequestMapping("updateDocument")
	public String addDocument(@ModelAttribute("doc") @Valid Document doc,
			BindingResult bindingResults, Model model) {
		if (bindingResults.hasErrors()) {
			model.addAttribute("dId", documentService.getdId());
			model.addAttribute("DoctType", documentService.getdocumentId());
			return "EditDocument";
		} else {
			if(documentService.editDocument(doc))
			{
				model.addAttribute("msgResult","message.docdetailsupdated");
				return "EditDocument";
			}
			else
			{
				model.addAttribute("msgResult","error.updationfailed");
				return "EditDocument";
			}
		}
	}
	
	/*
	 * ********************************
	 * Download Module
	 * Developed by :Shikhar Bajpai
	 * ********************************
	 */
	
	@RequestMapping("download")
	public ModelAndView downloadData(@RequestParam("docId") String docId, HttpServletResponse res) {
		res.setContentType("application/pdf");
		res.setHeader("Content-Disposition", "attachment;filename=attachment.pdf");
		InputStream b = documentService.download(docId);
		try {
			//System.out.println(b.available());
			OutputStream os = res.getOutputStream();
			byte ba[] = new byte[b.available()];
			int nextbyte = b.read(ba);
			os.write(ba);
			os.close();

		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
