package com.mercury.ticket.resources;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.ticket.service.TicketService;

@Component
@Path("/save")
public class TicketRescources {
	@Autowired
	private TicketService ts;
	
	
	
	@GET
	@Produces({MediaType.TEXT_HTML})
	public String registering() {
		//return String.valueOf(ts.getAllTickets().get(0).getTid());
		return String.valueOf(ts.getAllTickets().size());
	}	
	
	@GET
	@Path("/update")
	@Produces({MediaType.TEXT_HTML})
	public String insert(){
		return ts.saveticket();
	}
	
	
}
