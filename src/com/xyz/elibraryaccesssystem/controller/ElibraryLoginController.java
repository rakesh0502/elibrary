package com.xyz.elibraryaccesssystem.controller;

import javax.servlet.http.HttpServletRequest;
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

import com.xyz.elibraryaccesssystem.beans.Document;
import com.xyz.elibraryaccesssystem.beans.Registration;
import com.xyz.elibraryaccesssystem.beans.User;
import com.xyz.elibraryaccesssystem.service.DocumentServiceInterface;
import com.xyz.elibraryaccesssystem.service.UserServiceInterface;



@Controller
@SessionAttributes("username")
public class ElibraryLoginController {
	
	@Autowired
	private DocumentServiceInterface documentService;

	@Autowired
	private UserServiceInterface userService;
	String role;
	String userId;

	@RequestMapping("showHome")
	public String loadHome(Model model) {
		model.addAttribute("user", new User());
		model.addAttribute("dId", documentService.getdId());
		model.addAttribute("DoctType", documentService.getdocumentId());
		model.addAttribute("doc", new Document());
		return "HomePage";
	}

	@RequestMapping("loginForm")
	public String loadObject(Model model) {
		model.addAttribute("user", new User());
		return "LoginPage";
	}
/**
 * 
 * @param model
 * @param req
 * @return String
 */
	@RequestMapping("logout")
	public String logout(Model model, HttpServletRequest req) {
		model.addAttribute("user", new User());
		HttpSession session = req.getSession();
		session.invalidate();
		return "LoginPage";
	}
/**
 * 
 * @param user
 * @param bindingResults
 * @param model
 * @param request
 * @return
 */
	@RequestMapping("validateUser")
	public String homePage(@ModelAttribute("user") @Valid User user,
			BindingResult bindingResults, Model model,
			HttpServletRequest request) {
		if (bindingResults.hasErrors()) {
			return "LoginPage";
		} else {
			HttpSession session = request.getSession(true);
			user = userService.authenticate(user);
			if (user != null) {
				role = user.getUserType();
				if (role != null) {
					if (role.equals("nonsub")) {
						System.out.println("username:-" + user.getFirstName()+" "+user.getLastName());
						session.setAttribute("userType", user.getUserType());
						session.setAttribute("username", user.getFirstName()+" "+user.getLastName()+"!");
						session.setAttribute("userId", user.getUserId());
						model.addAttribute("dId", documentService.getdId());
						model.addAttribute("DoctType",
								documentService.getdocumentId());
						model.addAttribute("doc", new Document());
						return "NonSubscriber-home";
					} else if (role.equals("sub")) {
						session.setAttribute("username", user.getFirstName()+" "+user.getLastName()+"!");
						session.setAttribute("userType", user.getUserType());
						model.addAttribute("dId", documentService.getdId());
						model.addAttribute("DoctType",
								documentService.getdocumentId());
						model.addAttribute("doc", new Document());
						return "Subscriber-home";
					} else if (role.equals("admin")) {
						session.setAttribute("username", "ADMIN");
						session.setAttribute("userType", user.getUserType());
						model.addAttribute("dId", documentService.getdId());
						model.addAttribute("DoctType",
								documentService.getdocumentId());
						model.addAttribute("doc", new Document());
						return "Admin-Home";
					}
				}
			} else {
				model.addAttribute("error",	"error.invalid");
				return "LoginPage";
			}
		}
		return null;
	}
/**
 * 
 * @param model
 * @return
 */
	@RequestMapping("register")
	public String newUser(Model model) {
		userId = userService.getUserId();
		Registration user = new Registration();
		user.setUserId(userId);
		model.addAttribute("ruser", user);
		return "Registration";
	}

	@RequestMapping("acceptregister")
	public String createUser(
			@RequestParam("samecheckbox") String areaofinterests,
			@ModelAttribute("ruser") @Valid Registration user,
			BindingResult bindingResults, Model model) {
		user.setAreaOfInterest(areaofinterests);
		user.setUserType("nonsub");
		if (bindingResults.hasErrors()) {
			return "Registration";
		} else if (userService.addUser(user)) {
			model.addAttribute("username", user.getFirstName()+" "+user.getLastName());
			model.addAttribute("user", user);
			model.addAttribute("dId", documentService.getdId());
			model.addAttribute("DoctType", documentService.getdocumentId());
			model.addAttribute("doc", new Document());
			return "NonSubscriber-home";
		} else {
			model.addAttribute("user", user);
			model.addAttribute("message","You are already registered...");
			return "Registration";
		}
	}
	
	
	

}
