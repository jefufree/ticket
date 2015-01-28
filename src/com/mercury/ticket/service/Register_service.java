package com.mercury.ticket.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.Ticket;
import com.mercury.ticket.persistence.model.Transaction;
import com.mercury.ticket.persistence.model.User;

@Service
@Transactional
public class Register_service {
	@Autowired
	@Qualifier("userDao")
	private HibernateDao<User, Integer> hd;
	@Autowired
	@Qualifier("ticketDao")
	private HibernateDao<User, Integer> hd2;
	
	public String addUser(String username,String password){
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setAuthority("ROLE_USER");
		user.setEnable(1);
		hd.save(user);
		return "su";
	}
}
