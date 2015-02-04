package com.mercury.ticket.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.ticket.persistence.model.User;
import com.mercury.ticket.service.UserService;
@Controller
public class LoginController {

	@Autowired
	private UserService us;
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(ModelMap model) {
		return "login";
	}
	
	@RequestMapping(value="/main", method = RequestMethod.GET)
	public ModelAndView mainPage() {	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("hello");
		mav.addObject("title", "Sample06");
		return mav;
	}
	
	@RequestMapping("/asuser")
	public ModelAndView asuser() {	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("asuser");
		mav.addObject("msg", "asuser");
		return mav;
	}
	@RequestMapping(value="/asadmin", method = RequestMethod.GET)
	public ModelAndView asadmin() {	
		ModelAndView mav = new ModelAndView();
		mav.setViewName("asadmin");
		mav.addObject("msg", "asadmin");
		return mav;
	}
//	@RequestMapping("/main")
//	public ModelAndView sayHello(HttpServletRequest request){
//	
//		User u=new User();
//		
//	//	String password = request.getParameter("password");	
//		String username = request.getParameter("username");
//		
//	u=us.findUser(username);
//	ModelAndView mav=new ModelAndView();
//	if(u.getAuthority()=="ROLE_ADMIN"){
//		
//		mav.setViewName("asadmin");
//		mav.addObject("msg", "welcome as adminto Ticket System!");
//	}else if(u.getAuthority()=="ROLE_USER"){
//		mav.setViewName("asuser");
//		mav.addObject("msg", "welcome as user to Ticket System!");
//	}
//	return mav;
//}


}