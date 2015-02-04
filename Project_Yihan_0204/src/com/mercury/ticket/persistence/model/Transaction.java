package com.mercury.ticket.persistence.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.SequenceGenerator;
import javax.xml.bind.annotation.XmlRootElement;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="transactions")
@XmlRootElement
public class Transaction {
	private int transactionid;
	private int tid;
	private int userid;
	private int method;
	private int quantity;
	private String time;
	private String status;
	
	public Transaction(){}
	public Transaction(int transactionid, int tid, int userid,
			int method, int quantity, String time, String status) {
		super();
		this.transactionid = transactionid;
		this.tid = tid;
		this.userid = userid;
		this.method = method;
		this.quantity = quantity;
		this.time = time;
		this.status = status;
	}
	@Id
	@GeneratedValue(generator="increment")
	@GenericGenerator(name="increment",strategy="increment")
	@Column(nullable=false)
	public int getTransactionid() {
		return transactionid;
	}
	public void setTransactionid(int transactionid) {
		this.transactionid = transactionid;
	}
	/*
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="userid",insertable=false,updatable=false)
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="tid",insertable=false,updatable=false)
	public Ticket getTicket() {
		return ticket;
	}
	public void setTicket(Ticket ticket) {
		this.ticket = ticket;
	}
	*/
	
	@Column
	public int getMethod() {
		return method;
	}
	public void setMethod(int method) {
		this.method = method;
	}
	
	@Column
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	@Column
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	
	@Column
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Column
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	@Column
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
}
