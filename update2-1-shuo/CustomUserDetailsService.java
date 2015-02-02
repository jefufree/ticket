package com.mercury.ticket.service;

import java.util.ArrayList;
import java.util.Collection;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

//import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;

import com.mercury.ticket.persistence.model.User;
@Service
@Transactional(readOnly = true)
public class CustomUserDetailsService  implements UserDetailsService{
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	@Qualifier("userDao")
	private HibernateDao<User, Integer> hd;
		
	public HibernateDao<User, Integer> getPd() {
		return hd;
	}
	public void setPd(HibernateDao<User, Integer> hd) {
		this.hd = hd;
	}

	@Autowired
	private UserService us;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		UserDetails user = null;  
		try {
			User u =hd.findBy("username", username);
			Collection<GrantedAuthority> authorities = new ArrayList<GrantedAuthority>();
			authorities.add(new SimpleGrantedAuthority(u.getAuthority()));
			user = (UserDetails) new org.springframework.security.core.userdetails.User(
					u.getUsername(),
					u.getPassword(),
					true,
					true,
					true,
					true,
					authorities 
			);
		System.out.println(u.getUsername()+" "+u.getPassword()+" "+u.getAuthority());
		} catch (Exception e) {
			logger.error("Error in retrieving user" + e.getMessage());
			throw new UsernameNotFoundException("Error in retrieving user");
		}
		return user;
	}		  
}
