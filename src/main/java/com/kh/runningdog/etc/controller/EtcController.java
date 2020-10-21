package com.kh.runningdog.etc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class EtcController {
	@RequestMapping("terms.do")
	public String termsPage() {
		return "etc/terms";
	}
	
	@RequestMapping("privacy.do")
	public String privacyPage() {
		return "etc/privacy";
	}
	
	@RequestMapping("email.do")
	public String emailPage() {
		return "etc/email";
	}
}
