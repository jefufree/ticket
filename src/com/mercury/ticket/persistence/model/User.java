package com.mercury.ticket.persistence.model;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;


@Entity
@Table(name="users")
public class User {
	private int userid;
	private String username;
	private String password;
	private String firstname;
	private String lastname;
	private String address;
	private String phone;
	private int enable;
	private String authority;
	private String accountnum;
	private String expiredate;
	private String accountname;
	private int sn;
	
	//private Set<Transaction> transactions;
	
	public User(){
		//transactions = new HashSet<Transaction>();
	}
	
	
	
	public User(int userid, String username, String password, String firstname,
			String lastname, String address, String phone, int enable,
			String authority, String accountnum, String expiredate,
			String accountname, int sn) {
		
		this.userid = userid;
		this.username = username;
		this.password = password;
		this.firstname = firstname;
		this.lastname = lastname;
		this.address = address;
		this.phone = phone;
		this.enable = enable;
		this.authority = authority;
		this.accountnum = accountnum;
		this.expiredate = expiredate;
		this.accountname = accountname;
		this.sn = sn;
	
	}



	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="seq_id")
	@SequenceGenerator(name ="seq_id",sequenceName="seq_id",allocationSize=1,initialValue=1)
	@Column(nullable=false)
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	@Column
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	@Column
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	@Column
	public String getFirstname() {
		return firstname;
	}
	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}
	@Column
	public String getLastname() {
		return lastname;
	}
	public void setLastname(String lastname) {
		this.lastname = lastname;
	}
	@Column
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Column
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	@Column
	public int getEnable() {
		return enable;
	}
	public void setEnable(int enable) {
		this.enable = enable;
	}
	@Column
	public String getAuthority() {
		return authority;
	}
	public void setAuthority(String authority) {
		this.authority = authority;
	}
	@Column
	public String getAccountnum() {
		return accountnum;
	}
	public void setAccountnum(String accountnum) {
		this.accountnum = accountnum;
	}
	@Column
	public String getExpiredate() {
		return expiredate;
	}
	public void setExpiredate(String expiredate) {
		this.expiredate = expiredate;
	}
	@Column
	public String getAccountname() {
		return accountname;
	}
	public void setAccountname(String accountname) {
		this.accountname = accountname;
	}
	@Column
	public int getSn() {
		return sn;
	}
	public void setSn(int sn) {
		this.sn = sn;
	}

	/*
	@OneToMany(fetch = FetchType.LAZY,cascade=CascadeType.ALL)
	@JoinColumn(name="userid")
	public Set<Transaction> getTransactions() {
		return transactions;
	}
	public void setTransactions(Set<Transaction> transactions) {
		this.transactions = transactions;
	}
	*/
	
}
