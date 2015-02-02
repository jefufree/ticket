package com.mercury.ticket.web.controller;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mercury.ticket.persistence.model.Ticket;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class testcontroller {
	/*@RequestMapping("/test")
	public ModelAndView select(){
		ModelAndView mav = new ModelAndView();
		mav.setViewName("test");
		System.out.println("1");
		mav.addObject("msg",ts.saveticket());
		System.out.println("2");
		return mav;
	}*/
	
	@RequestMapping("/test")
	public String goMain(){
		return "test";
	} 
	
	@RequestMapping("/getdata")
	@ResponseBody
	public String getData(){
		return "<b>This is a message from Spring</b>";
	}
}
