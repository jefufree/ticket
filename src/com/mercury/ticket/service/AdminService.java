package com.mercury.ticket.service;

import java.util.List;

import javax.ws.rs.QueryParam;

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
		List<Ticket> list = hd.findAllBy4("dep", dep, "des", des, 
				"depdate", depdate, "deptime", deptime);
		if(list.size()==0) return null;
		return list.get(0);
	}
	
	public Ticket addNewTicket(String dep,String des){
		if(findTicket(dep,  des,"20000101","0000")!=null){
			return null;
		}
		Ticket t = new Ticket();
		t.setDep(dep);
		t.setDes(des);
		t.setDepdate("20000101");
		t.setDeptime("0000");
		t.setTotal(0);
		t.setAvailable(-1);
		hd.save(t);
		return t;
				
	}
	
	public List<Ticket> findAllTicket(){
		return hd.findAll();
	}
	
	public Ticket setTicketDep(Ticket ticket, String dep){
		ticket.setDep(dep);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setTicketDes(Ticket ticket, String des){
		ticket.setDes(des);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setTicketPrice(Ticket ticket,String price){
		ticket.setPrice(price);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setTicketTotal(Ticket ticket,int total ){
		ticket.setTotal(total);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setTicketDate(Ticket ticket,String date){
		ticket.setDepdate(date);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setTicketTime(Ticket ticket,String time){
		ticket.setDeptime(time);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setTicketDisable(Ticket ticket){
		ticket.setAvailable(-1);
		hd.save(ticket);
		return ticket;
	}
	public Ticket setAvailable(Ticket ticket, int available){
		ticket.setAvailable(available);
		hd.save(ticket);
		return ticket;
	}
}
