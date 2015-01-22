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
public class TicketService {
	@Autowired
	@Qualifier("ticketDao")
	private HibernateDao<Ticket,Integer> hd;

	public HibernateDao<Ticket, Integer> getHd() {
		return hd;
	}

	public void setHd(HibernateDao<Ticket, Integer> hd) {
		this.hd = hd;
	}
	public List<Ticket> getAllTickets(){
		return hd.findAll();
	}
	public String updateTicket(Ticket ticket){
		hd.save(ticket);
		return "Succeed";
	}
	
}
