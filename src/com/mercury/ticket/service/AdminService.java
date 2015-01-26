package com.mercury.ticket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.Ticket;

@Service
@Transactional
public class AdminService {
	@Autowired
	@Qualifier("ticketDao")
	private HibernateDao<Ticket,Integer> hd;
	
	public Ticket findTicket(String dep,String des,String depdate,String deptime){
		return (hd.findAllBy4("dep", dep, "des", des, 
				"depdate", depdate, "deptime", deptime)).get(0);
	}
	
	public String addNewTicket(String dep,String des){
		Ticket t = new Ticket();
		t.setDep(dep);
		t.setDes(des);
		t.setDepdate("0");
		t.setDeptime("0");
		t.setAvailable(-1);
		hd.save(t);
		return "New ticket: " + dep +" ---> " + des+" added!";
	}
	
	public List<Ticket> findAllTicket(){
		return hd.findAll();
	}
	
	public String setTicketDep(Ticket ticket, String dep){
		ticket.setDep(dep);
		hd.save(ticket);
		return ticket.getTid()+" depature is changed to "+ticket.getDep();
	}
	public String setTicketDes(Ticket ticket, String des){
		ticket.setDep(des);
		hd.save(ticket);
		return ticket.getTid()+" destination is changed to "+ticket.getDes();
	}
	public String setTicketPrice(Ticket ticket,String price){
		ticket.setPrice(price);
		hd.save(ticket);
		return ticket.getTid()+" price is changed to "+ticket.getPrice();
	}
	public String setTicketTotal(Ticket ticket,int total ){
		ticket.setTotal(total);
		hd.save(ticket);
		return ticket.getTid()+" total is changed to "+ticket.getTotal();
	}
	public String setTicketDate(Ticket ticket,String date){
		ticket.setDepdate(date);
		hd.save(ticket);
		return ticket.getTid()+"date is changed to "+ticket.getDepdate();
	}
	public String setTicketTime(Ticket ticket,String time){
		ticket.setDeptime(time);
		hd.save(ticket);
		return ticket.getTid()+"time is changed to "+ticket.getDeptime();
	}
	public String setTicketDisable(Ticket ticket){
		ticket.setAvailable(-1);
		hd.save(ticket);
		return ticket.getTid()+"is no longer available!";
	}
	public String setAvailable(Ticket ticket, int available){
		ticket.setAvailable(available);
		hd.save(ticket);
		return ticket.getTid()+" has "+ ticket.getAvailable()+" left.";
	}
}
