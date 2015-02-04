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
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket saveTicket(@QueryParam("dep") String dep,@QueryParam("des") String des){
		return as.addNewTicket(dep, des);
	}

	@GET
	@Path("/setprice")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setPrice(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String price){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		if(t.getSold()==0){
			return as.setTicketPrice(t, price);
		}
		else{
			return null;
		}
		
	}
	
	@GET
	@Path("/setdep")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setDep(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String newDep){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		if(t.getSold()==0){
			return as.setTicketDep(t, newDep);
		}
		else{
			return null;
		}		
	}
	
	@GET
	@Path("/setdes")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setDes(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String newDes){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		if(t.getSold()==0){
			return as.setTicketDes(t, newDes);
		}
		else{
			return null;
		}		
	}
	
	@GET
	@Path("/settotal")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setTotal(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") int total){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		if(t.getAvailable()!=-1){
			as.setAvailable(t, total-t.getSold());
		}		
		return as.setTicketTotal(t, total);
	}
	
	@GET
	@Path("/setdate")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setDate(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text") String newDate){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		if(t.getSold()==0){
			return as.setTicketDate(t, newDate);
		}
		else{
			return null;
		}		
	}
	
	@GET
	@Path("/settime")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setTime(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time,@QueryParam("text")String newTime){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		if(t.getSold()==0){
			return as.setTicketTime(t, newTime);
		}
		else{
			return null;
		}		
	}

	@GET
	@Path("/disable")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setDisable(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		return as.setTicketDisable(t);				
	}

	@GET
	@Path("/enable")
	@Produces({MediaType.APPLICATION_JSON})
	public Ticket setAvailable(@QueryParam("dep") String dep,@QueryParam("des") String des,@QueryParam("date") String date,@QueryParam("time") String time){
		Ticket t = as.findTicket(dep, des, date , time);
		if(t==null) return null;
		return as.setAvailable(t, t.getTotal()-t.getSold());
	}
	
}
