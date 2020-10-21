package com.kh.runningdog.member.model.vo;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sun.media.jfxmedia.logging.Logger;

@Service
public class MailUtil {
	
	public MailUtil() {}
	
	//메일 보내는 클래스
	@Autowired
	public static void sendMail(String email, String subject, String msg) {
		
		//Mail Server 설정
		String charSet = "utf-8";
		String hostSMTP = "smtp.naver.com"; //SMTP 서버명
		String hostSMTPid = "spark720"; //아이디
		String hostSMTPpwd = "asdf123!@#$"; //비밀번호
		
		//보내는 사람
		String fromEmail = "spark720@naver.com"; //보내는 사람 메일
		String fromName = "지금 달려갈 개"; //보내는 사람 이름
		
		// email 전송
		try {
			HtmlEmail mail = new HtmlEmail();
			mail.setDebug(true);
			mail.setCharset(charSet);
			mail.setSSLOnConnect(true); //SSL 사용 (TLS가 없는 경우 SSL 사용)
			
			mail.setHostName(hostSMTP);
			mail.setSmtpPort(587); //SMTP 포트 번호
			
			mail.setAuthentication(hostSMTPid, hostSMTPpwd);
			mail.setStartTLSEnabled(true); //TLS 사용
			mail.addTo(email);
			mail.setFrom(fromEmail, fromName, charSet);
			mail.setSubject(subject);
			mail.setHtmlMsg(msg);
			mail.send();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
}
