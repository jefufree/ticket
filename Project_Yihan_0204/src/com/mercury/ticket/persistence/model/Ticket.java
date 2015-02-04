package com.mercury.ticket.persistence.model;

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
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="Tickets")
@XmlRootElement
public class Ticket {
	private int tid;
	
	private String dep;
	private String des;
	private String price;
	private int total;
	private int sold;
	private int available;
	private String deptime;
	private String depdate;
	
	
	//private Set<Transaction> transactions;
	
	public Ticket(){
		//transactions = new HashSet<Transaction>();
	}
	
	
	public Ticket(int tid, String dep, String des, String price, int total,
			int sold, int available, String deptime, String depdate) {
		super();
		this.tid = tid;
		this.dep = dep;
		this.des = des;
		this.price = price;
		this.total = total;
		this.sold = sold;
		this.available = available;
		this.deptime = deptime;
		this.depdate = depdate;
	}
	
	@Id
    @GeneratedValue(generator="increment")
	@GenericGenerator(name="increment", strategy="increment")
    @Column(nullable = false)
	//@XmlElement(name="Ticket ID")
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	@Column
	//@XmlElement(name="Depature")
	public String getDep() {
		return dep;
	}
	public void setDep(String dep) {
		this.dep = dep;
	}
	
	@Column
	//@XmlElement(name="Destination")
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	
	@Column
	//@XmlElement(name="Date")
	public String getDepdate() {
		return depdate;
	}
	public void setDepdate(String depdate) {
		this.depdate = depdate;
	}
	
	@Column
	//@XmlElement(name="Time")
	public String getDeptime() {
		return deptime;
	}
	public void setDeptime(String deptime) {
		this.deptime = deptime;
	}
	
	@Column
	//@XmlElement(name="Price")
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	@Column
	//@XmlElement(name="Total")
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	@Column
	//@XmlElement(name="Sold")
	public int getSold() {
		return sold;
	}
	public void setSold(int sold) {
		this.sold = sold;
	}
	
	@Column
	//@XmlElement(name="Available")
	public int getAvailable() {
		return available;
	}
	public void setAvailable(int available) {
		this.available = available;
	}
	
	/*
	@OneToMany(fetch = FetchType.LAZY,cascade=CascadeType.ALL)
	@JoinColumn(name="tid")
	public Set<Transaction> getTransactions() {
		return transactions;
	}


	public void setTransactions(Set<Transaction> transactions) {
		this.transactions = transactions;
	}
	*/
}
