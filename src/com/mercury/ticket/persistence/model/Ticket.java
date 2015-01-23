package com.mercury.ticket.persistence.model;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;

import org.hibernate.annotations.GenericGenerator;

@Entity
@Table(name="tickets")
public class Ticket {
	private int tid;
	private String train;
	private String dep;
	private String des;
	private String price;
	private int total;
	private int available;
	private int sold;
	private String deptime;
	
	public Ticket(){}
	@Id
    @GeneratedValue(generator="increment")
	@GenericGenerator(name="increment", strategy="increment")
    @Column(nullable = false)
	public int getTid() {
		return tid;
	}
	public void setTid(int tid) {
		this.tid = tid;
	}
	
	@Column
	public String getTrain() {
		return train;
	}
	public void setTrain(String train) {
		this.train = train;
	}
	
	@Column
	public String getDep() {
		return dep;
	}
	public void setDep(String dep) {
		this.dep = dep;
	}
	
	@Column
	public String getDes() {
		return des;
	}
	public void setDes(String des) {
		this.des = des;
	}
	
	@Column
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	
	@Column
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	
	@Column
	public int getAvailable() {
		return available;
	}
	public void setAvailable(int available) {
		this.available = available;
	}
	
	@Column
	public int getSold() {
		return sold;
	}
	public void setSold(int sold) {
		this.sold = sold;
	}
	
	@Column
	public String getDeptime() {
		return deptime;
	}
	public void setDeptime(String deptime) {
		this.deptime = deptime;
	}
	
}
