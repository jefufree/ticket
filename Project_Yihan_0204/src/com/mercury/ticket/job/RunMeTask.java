package com.mercury.ticket.job;

import org.springframework.beans.factory.annotation.Autowired;

import com.mercury.ticket.persistence.model.Transaction;
import com.mercury.ticket.service.TicketService;
import com.mercury.ticket.util.TransactionQueue;

public class RunMeTask {
	@Autowired
	private TicketService ts;
	
	
	public void printMe() {
		System.out.println("Spring 3 + Quartz 1.8.6");
		
		
		
		while(TransactionQueue.size()>0){
			Transaction trans=TransactionQueue.remove();
			String result=ts.buyTicketDequeue(trans);
			
			System.out.println(TransactionQueue.size()+result);
		}
	}
}
