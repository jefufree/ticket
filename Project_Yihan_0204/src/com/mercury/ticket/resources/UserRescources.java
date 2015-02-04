package com.mercury.ticket.resources;

import javax.ws.rs.FormParam;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.mercury.ticket.service.UserService;

@Component
@Path("/user")
public class UserRescources {
	@Autowired
	private UserService us;

	@POST
	@Path("/register")
	@Produces({ MediaType.TEXT_PLAIN })
	public String register(@FormParam("username_input") String username_input,
			@FormParam("pwd") String pwd, @FormParam("cardName_input") String cardName_input,
			@FormParam("card_input") String card_input, @FormParam("exp_input") String exp_input,@FormParam("sec_input") int sec_input) {
		if (!us.userExist(username_input)) {
			if (us.addNewUser(username_input, pwd,cardName_input,card_input,exp_input,sec_input) != null) {
				us.sendVerifyEmail(username_input);
				return "Please check your email, and verify your registration! Thank you";
			} else {
				return "Error";
			}
		}else{
			return "Username exists.";
		}
	}
	
}
