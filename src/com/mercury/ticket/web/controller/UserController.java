package com.mercury.ticket.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.persistence.model.Transaction;
import com.mercury.ticket.persistence.model.User;
import com.mercury.ticket.service.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService us;
	
	@RequestMapping("/adduser")
	public String hello() {
		return "adduser";
	}
	@RequestMapping("/result")
	public ModelAndView sayHello(HttpServletRequest request){
	
		User u=new User();
		
		String password = request.getParameter("password");	
		String username = request.getParameter("username");
		
	User u2=us.addNewUser(username, password);
	
	ModelAndView mav=new ModelAndView();
	mav.setViewName("adduserresult");
	mav.addObject("msg", u2.getUsername()+", welcome to Ticket System!");
	return mav;
}
	
	/////////////////////////////////////////////////
	@RequestMapping("/finduser")
//	@ResponseBody   //write the text directly into the HTTP response body, 
	public String finduser() {
		return "finduser";
	}
	@RequestMapping("/userresult")  // hello.html
	public ModelAndView finduser(HttpServletRequest request){
			String username=request.getParameter("username");
			
		ModelAndView mav=new ModelAndView();
		User u=new User();
		
		u=us.findUser(username);
		if(u==null){
			mav.addObject("msg","the user does not exist");
		}else{
			mav.addObject("msg","Hello "+u.getUsername()+"\n"+u.getPassword());
		}
		// add msg to helloworld.jsp
		
		mav.setViewName("userresult");                    
		return mav; // forwarding
	}
/////////////////////////////////////////////////
	
	@RequestMapping("/userinfo")
	public String setUser() {
		return "userinfo";
	}
	@RequestMapping("/setuserinfo")
	public ModelAndView setUserInfo(HttpServletRequest request){
			
		String password = request.getParameter("password");	
		String username = request.getParameter("username");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String phone = request.getParameter("phone");
		String address = request.getParameter("address");
		
   us.setUserInfo(username, firstname, lastname, phone, address);
	
	ModelAndView mav=new ModelAndView();
	mav.setViewName("setuserinfo");
	mav.addObject("msg", username+", welcome to Ticket System!");
	return mav;
}
	/////////////////////////////////
	
}
