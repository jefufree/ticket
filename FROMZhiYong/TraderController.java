package com.mercury.finance.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.mercury.finance.model.Login;
import com.mercury.finance.model.Trader;
import com.mercury.finance.model.Transaction;
import com.mercury.finance.service.TraderDetailsService;

@Controller
public class TraderController {
	@Autowired
	TraderDetailsService traders;
	@RequestMapping("/test")
	public ModelAndView insertTrader(HttpServletRequest request){
		ModelAndView mav = new ModelAndView();
		Trader trader = new Trader();
		Login login = new Login();
		Transaction transaction = new Transaction();
		transaction.setQty(100);
		transaction.setProcess("P");
		trader.setBalance(3000);
		trader.setEmail("alice@gmail.com");
		trader.setFname("Alice");
		trader.setLname("Chen");
		trader.setRole("Admin");

		//One to One mapping for trader and login
		login.setTrader(trader);
		trader.setLogin(login);
		
		//One to Many mapping for trader and transaction
		trader.getTransactions().add(transaction);
		
		
		traders.saveTrader(trader);
		//trader.addTrans(transaction);
		
		
		mav.setViewName("helloworld");//default forward
		mav.addObject("msg", "Hello Welcom to Spring MVC!");
		return mav;
	}
}
