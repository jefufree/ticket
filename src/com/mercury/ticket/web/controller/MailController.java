package com.mercury.ticket.web.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.ticket.persistence.model.User;
import com.mercury.ticket.service.UserService;

@Controller
public class MailController {

	@Autowired
	private UserService us;

	@RequestMapping("/register")
	public String register(HttpServletRequest request) {
		return "register";
	}

	// **********used for verified email sending************//
	@RequestMapping("/successreg")
	public ModelAndView finduser(HttpServletRequest request) {
		String password = request.getParameter("password");
		String username = request.getParameter("username");

		String body = "http://192.168.1.115:8080/Ticket/success.html?username_id="
				+ username;
		ModelAndView mav = new ModelAndView();
		if (us.emailValidator(username)) {
			us.addNewUser(username, password);
			us.sendRegEmail(username, body);
			mav.addObject("msg", " " + body);
			mav.setViewName("successreg");
		} else {
			mav.setViewName("errorGeneral");
		}
		return mav;
	}

	// **********verify page from email**************//
	@RequestMapping(value = "/success", method = RequestMethod.GET)
	public ModelAndView sayHello(HttpServletRequest request) {
		String username = request.getParameter("username_id");
		String authority = "USER_ROLE";// set authority for users
		ModelAndView mav = new ModelAndView();
		User user = us.findUser(username);
		user.setAuthority(authority);
		us.updateUser(user);
		mav.addObject("msg", user.getUsername()
				+ " : email verification finished");
		mav.setViewName("success");
		return mav;
	}

}
