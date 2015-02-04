package com.mercury.ticket.web.controller;

import javax.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
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
	/*
	@RequestMapping("/successreg")
	public ModelAndView finduser(HttpServletRequest request) {
		String password = request.getParameter("password");
		String username = request.getParameter("username");
		
		ModelAndView mav = new ModelAndView();
		if(us.addNewUser(username, password)!=null){
			us.sendVerifyEmail(username);
			mav.addObject("msg", "send success");
			mav.setViewName("successreg");
		} else {
			mav.setViewName("errorGeneral");
		}
		return mav;
	}*/

	// **********verify page from email**************//
	@RequestMapping(value = "/success", method = RequestMethod.GET)
	public ModelAndView sayHello(HttpServletRequest request) {
		String username = request.getParameter("username_id");
		String key = request.getParameter("key");
		
		us.emailVerify(username, key);
		
		ModelAndView mav = new ModelAndView();
		//mav.addObject("msg", " : email verification finished");
		mav.setViewName("user-ticket");
		return mav;
	}

}
