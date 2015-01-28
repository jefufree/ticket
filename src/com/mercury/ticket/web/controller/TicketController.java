package com.mercury.ticket.web.controller;

import java.util.LinkedList;
import java.util.List;

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
import com.mercury.ticket.util.TransactionQueue;

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
	
	@RequestMapping("/showtransactionlist")
	public ModelAndView showTransactionList(){
		List<Transaction> l=transs.getAllTransaction();
		ModelAndView mav = new ModelAndView();
		mav.setViewName("hello");
		mav.addObject("list",l);
		return mav;
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
		
		List<Transaction> l=transs.getAllTransaction();
		ModelAndView mav=new ModelAndView();
		mav.setViewName("hello");
		mav.addObject("msg", "Hello,welcome to Ticketing System!"+s+password+ss+dep+sss);
		mav.addObject("list",l);
		return mav;
	}
	
	@RequestMapping("/buyticket")
	public String buyTicket() {
		return "buyticket";
	}
	@RequestMapping("/usersearch")
	public ModelAndView userSearch(HttpServletRequest request){
		String dep=request.getParameter("dep");
		String des=request.getParameter("des");
		String depdate=request.getParameter("depdate");
		int quantity=Integer.parseInt(request.getParameter("quantity"));
		
		List<Ticket> l=ts.userFindTicket(dep, des, depdate, quantity);
		ModelAndView mav=new ModelAndView();
		mav.setViewName("buyticket");
		mav.addObject("msg", dep+" "+des+" "+depdate+" "+quantity);
		mav.addObject("list",l);
		mav.addObject("quantity",quantity);
		return mav;
		
	}
	
	@RequestMapping("/buying")
	public ModelAndView buying(HttpServletRequest request){
		
		
		ModelAndView mav=new ModelAndView();
		
		int userid = 3763;
		//int tid = Integer.parseInt(request.getParameter("tid"));
		int tid=4;
		//int quantity = Integer.parseInt(request.getParameter("qty"));
		int quantity=3;
		int method = 0;
		LinkedList<Transaction> q=TransactionQueue.getTransactionQueue();
		System.out.println(TransactionQueue.size());
		Transaction trans=ts.buyTicketEnqueue(userid, tid, quantity, method);
		System.out.println(TransactionQueue.size());
		
		mav.setViewName("buyticket");
		mav.addObject("trans", trans);
		return mav;
	}
	
	
}