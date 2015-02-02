package com.mercury.ticket.resources;

import javax.ws.rs.FormParam;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.ticket.service.Register_service;

@Component
@Path("/reg")
public class Register_test {
	
	@Autowired
	private Register_service rs;
	
	@POST
	@Produces({MediaType.TEXT_HTML})
	public String reg(@FormParam("username") String username,@FormParam("password") String password){
		return "<h1>"+rs.addUser(username,password)+"</h1>";
	}
}
