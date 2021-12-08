package com.hago.getchaTable.member.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	@Autowired
	private JavaMailSender mailSender;
	
	public void sendMail(String to, String subject, String body) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
			MimeMessageHelper messageHelper = new MimeMessageHelper(message, true, "UTF-8");
			messageHelper.setSubject(subject);
			messageHelper.setTo(to);
			messageHelper.setText(body);
			mailSender.send(message);;
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
