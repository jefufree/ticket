package com.mercury.ticket.resources;

import java.util.List;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.service.AdminService;

@Component
@Path("/admin")
public class AdminRescources {
	@Autowired
	private AdminService as;
	
	@GET
	@Path("/printall")
	@Produces({MediaType.APPLICATION_JSON})
	public List<Ticket> findAllTicket(){
		return as.findAllTicket();		
	}

	@GET
	@Path("/save")
	@Produces({MediaType.TEXT_PLAIN})
	public String saveTicket(@QueryParam("dep") String dep,@QueryParam("des") String des){
		return as.addNewTicket(dep, des);
	}

	@GET
	@Path("/setprice")
	@Produces({MediaType.TEXT_PLAIN})
	public String setPrice(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String price){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		if(t.getSold()!=0){
			return as.setTicketPrice(t, price);
		}
		else{
			return "This ticket can not be modified.Please add new ticket";
		}
		
	}
	
	@GET
	@Path("/setdep")
	@Produces({MediaType.TEXT_PLAIN})
	public String setDep(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String newDep){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		if(t.getSold()!=0){
			return as.setTicketDep(t, newDep);
		}
		else{
			return "This ticket can not be modified.Please add new ticket";
		}		
	}
	
	@GET
	@Path("/setdes")
	@Produces({MediaType.TEXT_PLAIN})
	public String setDes(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String newDes){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		if(t.getSold()!=0){
			return as.setTicketDes(t, newDes);
		}
		else{
			return "This ticket can not be modified.Please add new ticket";
		}		
	}
	
	@GET
	@Path("/settotal")
	@Produces({MediaType.TEXT_PLAIN})
	public String setTotal(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") int total){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		as.setAvailable(t, total-t.getSold());
		return as.setTicketTotal(t, total);
	}
	
	@GET
	@Path("/setdate")
	@Produces({MediaType.TEXT_PLAIN})
	public String setDate(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String newDate){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		if(t.getSold()!=0){
			return as.setTicketDate(t, newDate);
		}
		else{
			return "This ticket can not be modified.Please add new ticket.";
		}		
	}
	
	@GET
	@Path("/settime")
	@Produces({MediaType.TEXT_PLAIN})
	public String setTime(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text")String newTime){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		if(t.getSold()!=0){
			return as.setTicketTime(t, newTime);
		}
		else{
			return "This ticket can not be modified.Please add new ticket.";
		}		
	}

	@GET
	@Path("/disable")
	@Produces({MediaType.TEXT_PLAIN})
	public String setDisable(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		return as.setTicketDisable(t);				
	}

	@GET
	@Path("/enable")
	@Produces({MediaType.TEXT_PLAIN})
	public String setAvailable(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return "This Ticket doesn't exist.";
		return as.setAvailable(t, t.getTotal()-t.getSold());
	}
	
}
