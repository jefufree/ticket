package com.mercury.finance.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "Transaction")
public class Transaction {
	public int trans_id;
	public int qty;
	//public int tid;
	public String status;
	public String t_date;
	public String process;
	public Trader trader;
	
	@Id
	@GeneratedValue(generator="trans_seq")
	@SequenceGenerator(name="trans_seq",sequenceName="seq_trans", allocationSize=1)
	@Column(name = "trans_id", unique = true, nullable = false)
	public int getTrans_id() {
		return trans_id;
	}
	public void setTrans_id(int trans_id) {
		this.trans_id = trans_id;
	}

	@Column(name = "qty")
	public int getQty() {
		return qty;
	}
	public void setQty(int qty) {
		this.qty = qty;
	}
	@Column(name = "status")
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Column(name = "t_date")
	public String getT_date() {
		return t_date;
	}
	public void setT_date(String t_date) {
		this.t_date = t_date;
	}
	@Column(name = "process")
	public String getProcess() {
		return process;
	}
	public void setProcess(String process) {
		this.process = process;
	}
	@ManyToOne
    @JoinColumn(name="tid", insertable=false, updatable=false, nullable=false)
	public Trader getTrader() {
		return trader;
	}
	public void setTrader(Trader trader) {
		this.trader = trader;
	}
	
//	@JoinColumn(name = "tid")
//	public int getTid() {
//		return tid;
//	}
//	public void setTid(int tid) {
//		this.tid = tid;
//	}

}
