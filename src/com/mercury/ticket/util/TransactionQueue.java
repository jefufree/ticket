package com.mercury.ticket.util;

import java.util.LinkedList;

import com.mercury.ticket.persistence.model.Transaction;


public class TransactionQueue{
		private static LinkedList<Transaction> q;
		//private static TransactionQueue q;
		private TransactionQueue(){
			
		}
		public static LinkedList<Transaction> getTransactionQueue(){
			if(q==null){
				synchronized (Transaction.class){
					if(q==null) q=new LinkedList<Transaction>();
				}
			}
			return q;
		}
		
		
		public static synchronized boolean add(Transaction t){
			q.add(t);
			return true;
		}
		
		public static Transaction remove(){
			return q.remove();
		}
		
		public static String print(){
			StringBuffer sb=new StringBuffer();
			
			return " ";
		}
		
		public static int size(){
			return q.size();
		}
}
