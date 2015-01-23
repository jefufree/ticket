package com.mercury.ticket.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.service.TicketService;

@Controller
@SessionAttributes
public class TicketController {
	@Autowired
	private TicketService ts;
	//private String viewPage;
	public TicketService getTs() {
		return ts;
	}
	public void setTs(TicketService ts) {
		this.ts = ts;
	}
	/*
	@RequestMapping("/hello")
	public String goHello(){
		return "hello";
	}*/
	
	@RequestMapping("/hello")
	public String hello() {
		return "hello";
	}
	
	
	@RequestMapping("/result")
	public ModelAndView sayHello(HttpServletRequest request){
		
		Ticket t=new Ticket();
		//int tid=Integer.parseInt(request.getParameter("tid"));
		String dep = request.getParameter("dep");
		//t.setTid(tid);
		t.setTrain(123);
		t.setDep(dep);
		t.setDes("plainsboro");
		t.setPrice(120);
		
		
		t.setAvailable(20);
		t.setSold(100);
		t.setTotal(120);
		t.setDeptime("5pmDec12th");
		String s= ts.updateTicket(t);
		
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("result");
		mav.addObject("msg", "Hello,welcome to Ticketing System!"+s+dep);
		
		return mav;
	}
	
}
