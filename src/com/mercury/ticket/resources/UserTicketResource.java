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
import com.mercury.ticket.util.TransactionQueue;

@Component
@Path("/userticket")
public class UserTicketResource {
	@Autowired
	private TransactionService transs;
	
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
		
		
		List<Ticket> l = ts.userFindTicket(dep, des, date, Integer.parseInt(quantity));
		
		return l;
	}
	
	@GET
	@Path("/buy")
	@Produces({MediaType.TEXT_PLAIN})
	public String buyTicket(@QueryParam("tid") int tid,@QueryParam("userid") int userid,@QueryParam("method") int method){
		LinkedList<Transaction> q=TransactionQueue.getTransactionQueue();
		int quantity=1;
		System.out.println(TransactionQueue.size());
		Transaction trans=ts.buyTicketEnqueue(userid, tid, quantity, method);
		System.out.println(TransactionQueue.size());
		
		return trans.getUserid()+" "+trans.getTid()+" "+trans.getTime();
	}
	
	
	
}
