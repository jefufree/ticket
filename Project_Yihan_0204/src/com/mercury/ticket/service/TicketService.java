package com.mercury.ticket.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.persistence.model.Transaction;
import com.mercury.ticket.persistence.model.User;
import com.mercury.ticket.util.TransactionQueue;


@Service
@Transactional
public class TicketService {
	@Autowired
	@Qualifier("ticketDao")
	private HibernateDao<Ticket,Integer> hd;
	
	
	/*
	public HibernateDao<Ticket, Integer> getHd() {
		return hd;
	}

	public void setHd(HibernateDao<Ticket, Integer> hd) {
		this.hd = hd;
	}
	*/
	@Autowired
	@Qualifier("transactionDao")
	private HibernateDao<Transaction,Integer> hd2;
	
	@Autowired
	private UserService us;
	
	public List<Ticket> getAllTickets(){
		return hd.findAlllt("available", 0);
	}
	public String updateTicket(Ticket ticket){
		hd.save(ticket);
		return "Succeed";
	}
	public List<Ticket> userFindTicket(String dep,String des,String depdate,int quantity){
		List<Ticket> l=null;
		
		
		if(dep==null){
			if(des==null){
				l=hd.findAllBy("depdate", depdate);
			}else{
				if(depdate==null){
					l=hd.findAllBy("des", des);
				}else{
					l=hd.findAllBy2("des", des, "depdate", depdate);
				}
			}
		}else{
			if(des==null){
				if(depdate==null){
					l=hd.findAllBy("dep", dep);
				}else{
					l=hd.findAllBy2("dep", dep, "depdate", depdate);
				}
			}else{
				if(depdate==null){
					l=hd.findAllBy2("dep", dep, "des", des);
				}else{
					l=hd.findAllBy3("dep", dep, "des", des, "depdate", depdate);
				}
			}
		}
		List<Ticket> l2=new ArrayList<Ticket>();
		
		for(Ticket t:l){
			if(t.getAvailable()>=quantity) l2.add(t);
		}
		return l2;
	}
	
	public Transaction buyTicketEnqueue(int userid,int tid,int quantity,int method){
		//another way to get the current time only
		/* 
		Calendar cal = Calendar.getInstance();
    	cal.getTime();
    	SimpleDateFormat sdf = new SimpleDateFormat("HH:mm:ss");
    	System.out.println( sdf.format(cal.getTime()) );
		*/
		Date date = new Date();
		SimpleDateFormat ft = 
			      new SimpleDateFormat ("yyyyMMddhhmmss");
		
		
		Transaction trans=new Transaction();
		
		trans.setTid(tid);
		trans.setUserid(userid);
		trans.setQuantity(quantity);
		trans.setMethod(method);
		trans.setStatus("p");
		trans.setTime(ft.format(date));
		TransactionQueue.add(trans);
		return trans;
	}
	
	public String buyTicketDequeue(Transaction trans){
		String s=null;
		int quantity=trans.getQuantity();
		Ticket t=hd.findBy("tid", trans.getTid());
		int available=t.getAvailable();
		int userid=trans.getUserid();
		User u = us.findUserById(userid);
		if(quantity<=available){
			trans.setStatus("s");
			t.setAvailable(available-quantity);
			t.setSold(t.getSold()+quantity);
			hd.save(t);
			hd2.save(trans);
			us.sendLoginEmail(u.getUsername(), "USER_ROLE");
			s=trans.getUserid()+" "+trans.getTid()+trans.getStatus()+"Succeed";
		}
		return s;
	}
	
	public List<Transaction> findHistory(int userid){
		return hd2.findAllBy("userid", userid);
	}
	
	public String removeTicket(int transactionid,int tid,int quantity){
		Transaction trans=hd2.findBy("transactionid", transactionid);
		Ticket t=hd.findBy("tid", tid);
		t.setSold(t.getSold()-quantity);
		t.setAvailable(t.getAvailable()+quantity);
		hd.save(t);
		trans.setStatus("r");
		hd2.save(trans);
		/*
		Transaction newtrans=new Transaction();
		newtrans.setMethod(trans.getMethod());
		newtrans.setQuantity(quantity);
		newtrans.setStatus("r");
		newtrans.setTid(tid);
		newtrans.setUserid(trans.getUserid());
		
		Date date = new Date();
		SimpleDateFormat ft = 
			      new SimpleDateFormat ("yyyyMMddhhmmss");
		newtrans.setTime(ft.format(date));
		
		hd2.save(newtrans);
		*/
		return "ticket has been returned";
	}
}