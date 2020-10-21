package com.kh.runningdog.sponsor.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.sponsor.model.service.SponsorService;
import com.kh.runningdog.sponsor.model.vo.Sponsor;
import com.kh.runningdog.sponsor.model.vo.SponsorList;

@Controller
public class SponsorController {
	private Logger logger = LoggerFactory.getLogger(SponsorController.class);
	
	@Autowired
	private SponsorService sponsorService;
	
	@RequestMapping("slist.do")
	public ModelAndView moveSponsorList(ModelAndView mv, HttpServletRequest request) {
		int currentPage = 1;
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		int countList = 6;
		int countPage = 5;
		
		int totalList = sponsorService.selectListCount();
		int totalPage = (int)(((double)totalList / countList) + 0.9);
		int startPage = ((int)(((double)currentPage / countPage) + 0.9) - 1) * countPage + 1;
		int endPage = startPage + countPage - 1;
		if(endPage > totalPage)
			endPage = totalPage;
		
		ArrayList<Sponsor> list = sponsorService.selectList(currentPage, countList);
		
		if(list.size() > -1) {
			mv.addObject("flag", "1");
			mv.addObject("list", list);
			mv.addObject("page", currentPage);
			mv.addObject("totalList", totalList);
			mv.addObject("totalPage", totalPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.setViewName("sponsor/sponsorList");
		}
		return mv;
	}
	
    @RequestMapping("sdetail.do")
	public ModelAndView moveSponsorView(HttpServletRequest request, HttpServletResponse response, ModelAndView mv, @RequestParam() int sNum) {
    	Sponsor sponsor = sponsorService.selectOne(sNum);
    	
    	Cookie[] cookies = request.getCookies();
	    Cookie viewCookie = null;
    	
	    //쿠키가 있을 경우 이름 만들기
        if(cookies != null && cookies.length > 0) {
        	for(int i = 0; i < cookies.length; i++) {
        		//Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌 
                if (cookies[i].getName().equals("cookie" + sNum)) {
                    viewCookie = cookies[i];
                }
            }
        }
        
        if(sponsor != null) {
            //만일 viewCookie가 null일 경우 쿠키를 생성해서 조회수 증가 로직을 처리함.
            if (viewCookie == null) {
            	//쿠키 생성(이름, 값)
                Cookie newCookie = new Cookie("cookie"+sNum, "|" + sNum + "|");
                                
                // 쿠키 추가
                response.addCookie(newCookie);
 
                // 쿠키를 추가 시키고 조회수 증가시킴
                sponsorService.updateSponsorReadCount(sNum); //조회수 증가
            } else {
                // 쿠키 값 받아옴
                String value = viewCookie.getValue();
            }
         
         Integer preNo = sponsorService.selectSponsorPre(sNum); //이전글 번호 조회, int는 null값을 못 받아서 integer사용
         Integer nextNo = sponsorService.selectSponsorNext(sNum); //다음글 번호 조회
         if(preNo == null){ preNo = 0;}   //이전글이 없을 때 0으로 설정
         if(nextNo == null){ nextNo = 0;}   //다음글이 없울 때 0으로 설정 
         
         mv.addObject("preNo", preNo);
         mv.addObject("nextNo", nextNo);
         mv.addObject("sponsor", sponsor);
         mv.setViewName("sponsor/sponsorView");
    	}
		return mv;
	}
    
    @RequestMapping("spay.do")
	public String moveSponsoredPayment(Model model, @RequestParam() String title, @RequestParam() int sNum) {
    	model.addAttribute("sNum", sNum);
    	model.addAttribute("title", title);
		return "sponsor/sponsoredPayment";
	}
    
    @RequestMapping("spaysu.do")
	public String moveSponsoredPaySuccess(Model model, @RequestParam() String date, SponsorList slist, @RequestParam() String title) {
    	slist = sponsorService.selectSponsorListOne(date);
    	
    	model.addAttribute("way", slist.getSpWay());
    	model.addAttribute("cash", slist.getSpCash());
    	model.addAttribute("title", title);
		return "sponsor/sponsoredPaySuccess";
	}
    
    @RequestMapping("ssearch.do")
	public ModelAndView moveSponsorSearch(ModelAndView mv, HttpServletRequest request) {
    	HashMap<String, Object> key = new HashMap<>();
		key.put("selected", request.getParameter("selected"));
		key.put("keyword", request.getParameter("keyword"));
    	
    	int currentPage = 1;
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		int countList = 6;
		int countPage = 5;
		
		int totalList = sponsorService.selectListCount(key);
		int totalPage = (int)(((double)totalList / countList) + 0.9);
		int startPage = ((int)(((double)currentPage / countPage) + 0.9) - 1) * countPage + 1;
		int endPage = startPage + countPage - 1;
		if(endPage > totalPage)
			endPage = totalPage;
		
		
		ArrayList<Sponsor> list = sponsorService.selectSearch(key, currentPage, countList);
		
		if(list.size() > -1) {
			mv.addObject("selected", request.getParameter("selected"));
			mv.addObject("keyword", request.getParameter("keyword"));
			mv.addObject("flag", "1");
			mv.addObject("list", list);
			mv.addObject("page", currentPage);
			mv.addObject("totalList", totalList);
			mv.addObject("totalPage", totalPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.setViewName("sponsor/sponsorList");
		}
		return mv;
	}
    
    @RequestMapping(value="sSpon.do", method=RequestMethod.POST)
    public ModelAndView SponsorPay(SponsorList slist, HttpServletRequest request, ModelAndView mv, @RequestParam() String title) {
    	SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String spDate = sdf.format(new java.sql.Date(System.currentTimeMillis()));
		slist.setSpDate(spDate);
    	
		slist.setSpCash(Integer.parseInt(request.getParameter("amount").replaceAll(",", "")));
    	
    	if(slist.getSpEch() == null)
    		slist.setSpEch("n");
    	if(slist.getSpPch() == null)
    		slist.setSpPch("n");

    	switch(slist.getSpWay()) {
    	case "chk1" : slist.setSpWay("신용카드"); break;
    	case "chk2" : slist.setSpWay("무통장입금"); break;
    	}
    	
    	logger.info("결제창 열리기 전 : "+slist.toString());
    	
    	if(slist.getSpWay().equals("무통장입금")) {
    		slist.setSpBankbook("y");
    		slist.setSpRealCash(0);
    		
    		sponsorService.insertSponsorList(slist);
    		
    		mv.addObject("way", slist.getSpWay());
    		mv.addObject("cash", slist.getSpCash());
    		mv.addObject("title", title);
    		mv.setViewName("sponsor/sponsoredPaySuccess");
    	}else {
    		mv.addObject("title", title.replaceAll("'", "\\\\'"));
        	mv.addObject("sponsorList", slist);
        	mv.setViewName("sponsor/sponsoredPayment2");
    	}
    	
    	return mv;
    }
    
    @RequestMapping(value="sSponpay.do", method=RequestMethod.POST)
    public ResponseEntity<String> SponsorPayreal(@RequestBody String param, SponsorList slist, Sponsor sponsor) {
    	
    	JSONParser jparser = new JSONParser();
		JSONObject job = null;
		try {
			job = (JSONObject) jparser.parse(param);
		} catch (ParseException e) {
			e.printStackTrace();
		}
    	
		slist.setSpDate((String)job.get("spDate"));
		slist.setSpName((String)job.get("spName"));
		slist.setSpEmail((String)job.get("spEmail"));
		slist.setSpPhone((String)job.get("spPhone"));
		slist.setSpSnumber((String)job.get("spSnumber"));
		slist.setSpCash(Integer.valueOf((String)job.get("spCash")));
		slist.setSpEch((String)job.get("spEch"));
		slist.setSpPch((String)job.get("spPch"));
		slist.setSpWay((String)job.get("spWay"));
		slist.setsNum(Integer.valueOf((String)job.get("sNum")));
		slist.setSpBankbook("n");
		
		logger.info("결제 완료 후 : "+slist.toString());
		
		sponsorService.insertSponsorList(slist);
		
		sponsor.setsCurrent(Integer.valueOf((String)job.get("spCash")));
		sponsor.setsNum(Integer.valueOf((String)job.get("sNum")));
		sponsorService.updateSponsorCash(sponsor);
		
		
		sponsor = sponsorService.selectOne(Integer.parseInt((String)job.get("sNum")));
		
		if(sponsor.getsAmount() <= sponsor.getsCurrent())
			sponsorService.updateSponsorComplete(Integer.parseInt((String)job.get("sNum")));
		
		return new ResponseEntity<String>("success", HttpStatus.OK);
    }
    
    @RequestMapping("prog.do")
	public ModelAndView SponsorProgress(ModelAndView mv, HttpServletRequest request) {
		int currentPage = 1;
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		int countList = 6;
		int countPage = 5;
		
		int totalList = sponsorService.selectListCount("p");
		int totalPage = (int)(((double)totalList / countList) + 0.9);
		int startPage = ((int)(((double)currentPage / countPage) + 0.9) - 1) * countPage + 1;
		int endPage = startPage + countPage - 1;
		if(endPage > totalPage)
			endPage = totalPage;
		
		ArrayList<Sponsor> list = sponsorService.selectProgress(currentPage, countList);
		
		if(list.size() > -1) {
			mv.addObject("flag", "2");
			mv.addObject("list", list);
			mv.addObject("page", currentPage);
			mv.addObject("totalList", totalList);
			mv.addObject("totalPage", totalPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.setViewName("sponsor/sponsorList");
		}
		return mv;
	}
    
    @RequestMapping("comple.do")
	public ModelAndView SponsorComple(ModelAndView mv, HttpServletRequest request) {
		int currentPage = 1;
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));
		
		int countList = 6;
		int countPage = 5;
		
		int totalList = sponsorService.selectListCount("c");
		int totalPage = (int)(((double)totalList / countList) + 0.9);
		int startPage = ((int)(((double)currentPage / countPage) + 0.9) - 1) * countPage + 1;
		int endPage = startPage + countPage - 1;
		if(endPage > totalPage)
			endPage = totalPage;
		
		ArrayList<Sponsor> list = sponsorService.selectComple(currentPage, countList);
		
		if(list.size() > -1) {
			mv.addObject("flag", "3");
			mv.addObject("list", list);
			mv.addObject("page", currentPage);
			mv.addObject("totalList", totalList);
			mv.addObject("totalPage", totalPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.setViewName("sponsor/sponsorList");
		}
		return mv;
	}
}
