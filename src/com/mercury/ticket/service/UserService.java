package com.mercury.ticket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.User;

@Service
@Transactional
public class UserService {
	@Autowired
	@Qualifier("userDao")
	private HibernateDao<User,Integer> hd;
	/*
	public HibernateDao<User, Integer> getHd() {
		return hd;
	}

	public void setHd(HibernateDao<User, Integer> hd) {
		this.hd = hd;
	}
	*/
	public List<User> getAllUsers(){
		return hd.findAll();
	}
	public String updateUser(User user){
		hd.save(user);
		return "Succeed";
	}
}