package com.mercury.ticket.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

@Service("mailservice")
public class MailService {
	@Autowired
	private MailSender mailSender;
	@Autowired
	private SimpleMailMessage simpleMailMessage;

	public void sendMail(String to, String subject) {
		sendMail(to, subject, "this is an automatic mail please do not reply");
	}

	public void sendMail(String to, String subject, String body) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject(subject);
		message.setText(body);
		mailSender.send(message);
	}

	public void sendPreConfiguredMail(String message) {
		SimpleMailMessage mailMessage = new SimpleMailMessage(simpleMailMessage);
		mailMessage.setText(message);
		mailSender.send(mailMessage);
	}

}
