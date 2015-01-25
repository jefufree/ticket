package com.mercury.ticket.web.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.persistence.model.Transaction;
import com.mercury.ticket.persistence.model.User;
import com.mercury.ticket.service.TicketService;
import com.mercury.ticket.service.TransactionService;
import com.mercury.ticket.service.UserService;

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
	@Autowired
	private UserService us;
	public UserService getUs() {
		return us;
	}
	public void setUs(UserService us) {
		this.us = us;
	}
	
	@Autowired
	private TransactionService transs;
	
	public TransactionService getTranss() {
		return transs;
	}
	public void setTranss(TransactionService transs) {
		this.transs = transs;
	}
	@RequestMapping("/hello")
	public String hello() {
		return "hello";
	}
	
	
	@RequestMapping("/result")
	public ModelAndView sayHello(HttpServletRequest request){
		User u=new User();
		Ticket t=new Ticket();
		Transaction trans=new Transaction();
		trans.setMethod(0);
		trans.setQuantity(1);
		trans.setTime(String.valueOf(System.nanoTime()));
		trans.setStatus("p");
		
		String password = request.getParameter("password");
		//int tid=Integer.parseInt(request.getParameter("tid"));
		String dep = request.getParameter("dep");
		
		t.setDep(dep);
		t.setDes("plainsboro");
		t.setPrice("120");
		
		
		t.setAvailable(20);
		t.setSold(100);
		t.setTotal(120);
		t.setDeptime("5pm");
		t.setDepdate("Dec12th");
		u.setUsername("j");
		u.setPassword(password);
		u.setEnable(0);
		u.setAuthority("USER_ROLE");
		
		//t.getTransactions().add(trans);
		//u.getTransactions().add(trans);
		
		
		String ss= us.updateUser(u);
		String s= ts.updateTicket(t);
		trans.setTid(t.getTid());
		trans.setUserid(u.getUserid());
		String sss=transs.updateTransaction(trans);
		
		
		ModelAndView mav=new ModelAndView();
		mav.setViewName("hello");
		mav.addObject("msg", "Hello,welcome to Ticketing System!"+s+password+ss+dep+sss);
		
		return mav;
	}
	
}
