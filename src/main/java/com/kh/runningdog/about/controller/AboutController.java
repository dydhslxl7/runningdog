package com.kh.runningdog.about.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class AboutController {
	private static final Logger logger = LoggerFactory.getLogger(AboutController.class);
	//사이트소개 페이지로 이동
	@RequestMapping(value="aboutView.do")
	public String moveAboutView() {
		logger.info("aboutView.do run...");
		return "about/aboutView";
	}
}
