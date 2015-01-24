package com.mercury.finance.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


@Entity
@Table(name="trader")
public class Trader {
	public int tid;
	public String fname;
	public String lname;
	public String email;
	public String role;
	public int balance;
	public Login login;
	public Set<Transaction> transactions;
	
	
	public Trader(){
		transactions = new HashSet<Transaction>();
	}

	@GeneratedValue(generator="trader_seq")
	@SequenceGenerator(name="trader_seq",sequenceName="seq_trader", allocationSize=1)
	@Id
	@Column(name = "tid", unique = true, nullable = false)
	public int getTid() {
		return tid;
	}
	
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	@Column(name = "fname",  length = 30)
	public String getFname() {
		return fname;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}
	
	@Column(name = "lname",length = 30)
	public String getLname() {
		return lname;
	}

	public void setLname(String lname) {
		this.lname = lname;
	}
	@Column(name = "email", length = 30)
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Column(name = "role", length = 20)
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Column(name = "balance")
	public int getBalance() {
		return balance;
	}

	public void setBalance(int balance) {
		this.balance = balance;
	}
	@OneToMany(fetch=FetchType.LAZY, cascade = CascadeType.ALL)
	@JoinColumn(name="tid")
	public Set<Transaction> getTransactions() {
		return transactions;
	}

	public void setTransactions(Set<Transaction> transactions) {
		this.transactions = transactions;
	}
//	public void addTrans(Transaction transaction) {
//		transactions.add(transaction);
//		//transaction.setTid(tid);
//	}
//	
//	public void removeTrans(Transaction transaction) {
//		transactions.remove(transaction);
//	}

	@OneToOne(fetch = FetchType.LAZY, mappedBy = "trader", cascade = CascadeType.ALL)
	public Login getLogin() {
		return login;
	}

	public void setLogin(Login login) {
		this.login = login;
	}
}
