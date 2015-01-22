package com.mercury.tests;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.Ticket;

public class Tests {
	@Autowired
	@Qualifier("ticketDao")
	private HibernateDao<Ticket, Integer> hd;
	/**
	 * @param args
	 */
	public void main(String[] args) {
		// TODO Auto-generated method stub

		Ticket t = new Ticket();
		t.setAvailable(1);
		t.setDep("princeton");
		t.setDeptime("11:11");
		t.setDes("penn");
		t.setPrice(15);
		t.setSold(2);
		t.setTotal(2);
		t.setTrain(56);
		hd.save(t);
	}

}
