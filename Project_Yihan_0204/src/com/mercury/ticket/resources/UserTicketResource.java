package com.mercury.ticket.resources;

import java.util.LinkedList;
import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.persistence.model.Transaction;
import com.mercury.ticket.service.TicketService;
import com.mercury.ticket.service.TransactionService;
import com.mercury.ticket.service.UserService;
import com.mercury.ticket.util.TransactionQueue;

@Component
@Path("/userticket")
public class UserTicketResource {
	@Autowired
	private TransactionService transs;
	@Autowired
	private UserService us;
	
	@Autowired
	private TicketService ts;
	
	@GET
	@Path("/transactions")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Transaction> findAllTransaction(){
		return transs.getAllTransaction();
	}
	
	@GET
	@Path("/tickets")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Ticket> findAllTicket(){
		return ts.getAllTickets();
	}
	
	@GET
	@Path("/search")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Ticket> searchTicket(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("quantity") String quantity){
		
		System.out.println(dep+dep.getClass());
		if(dep.equals("")) dep=null;
		if(des.equals("")) des=null;
		if(date.equals("")) date=null;
		List<Ticket> l = ts.userFindTicket(dep, des, date, Integer.parseInt(quantity));
		
		return l;
	}
	
	@GET
	@Path("/buy")
	@Produces({MediaType.TEXT_PLAIN})
	public String buyTicket(@QueryParam("tid") int tid,@QueryParam("username") String username,@QueryParam("method") int method,@QueryParam("quantity2") int quantity){
		LinkedList<Transaction> q=TransactionQueue.getTransactionQueue();
		int userid=(us.findUser(username)).getUserid();
		
		System.out.println(TransactionQueue.size());
		Transaction trans=ts.buyTicketEnqueue(userid, tid, quantity, method);
		System.out.println(TransactionQueue.size());
		
		return trans.getUserid()+" "+trans.getTid()+" "+trans.getTime();
	}
	
	@GET
	@Path("/usertransactions")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Transaction> userTransactions(@QueryParam("username") String username){
		System.out.println(username);
		return transs.getTransactionByName(username);
		
	}
	
	@GET
	@Path("/refund")
	@Produces({MediaType.APPLICATION_JSON})
	public String refund(@QueryParam("transactionid") int transactionid,@QueryParam("tid") int tid,@QueryParam("quantity") int quantity){
		System.out.println(transactionid);
		return ts.removeTicket(transactionid, tid, quantity);
		
	}
	
}
