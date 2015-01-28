package com.mercury.ticket.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.mercury.common.db.HibernateDao;
import com.mercury.ticket.persistence.model.Transaction;
	
@Service
@Transactional
public class TransactionService {
		@Autowired
		@Qualifier("transactionDao")
		private HibernateDao<Transaction,Integer> hd;
		/*
		public HibernateDao<Transaction, Integer> getHd() {
			return hd;
		}

		public void setHd(HibernateDao<Transaction, Integer> hd) {
			this.hd = hd;
		}
		*/
		public List<Transaction> getAllTransaction(){
			return hd.findAll();
		}
		public String updateTransaction(Transaction transaction){
			hd.save(transaction);
			return "Succeed";
		}
		
	}
