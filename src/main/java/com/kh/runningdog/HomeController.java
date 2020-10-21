package com.kh.runningdog;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.kh.runningdog.contents.model.service.IssueService;
import com.kh.runningdog.contents.model.vo.Issue;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@Autowired
	private IssueService issueService;
	
	@RequestMapping(value="main.do", method=RequestMethod.GET)
	public String mainViewForward(HttpServletRequest request) {
		
		ArrayList<Issue> list = issueService.selectMainIssueList();
		System.out.println(list);
		request.setAttribute("issuelist", list);
		return "main/main"; 
		//Servlet-Context의 beans에 views까지만 경로로 써있어서 common파일에 있는 경로를 여기에 써야함 
	}
	
}
