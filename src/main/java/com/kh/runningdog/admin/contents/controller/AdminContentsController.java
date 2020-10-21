package com.kh.runningdog.admin.contents.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.contents.IssueCrawling;
import com.kh.runningdog.contents.KnowledgeCrawling;
import com.kh.runningdog.contents.controller.ContentsController;
import com.kh.runningdog.contents.model.service.IssueService;
import com.kh.runningdog.contents.model.vo.Issue;
import com.kh.runningdog.contents.model.vo.Knowledge;
import com.kh.runningdog.notice.model.vo.NoticePage;

@Controller
public class AdminContentsController {
	private static final Logger logger = LoggerFactory.getLogger(ContentsController.class);
	
	@Autowired
	private IssueService issueService;
	

	//상식 목록페이지 이동, 출력
	@RequestMapping(value="cknowlist.ad")
	public ModelAndView contentsKnowledgeList(ModelAndView mv, HttpServletRequest request) {
		logger.info("cknowlist.ad run...");
		
		String search = "subject";
		String keyword = "";
		//검색값 받기
		if(request.getParameter("searchKnow") != null) {
			search = request.getParameter("searchKnow");
		}
		if(request.getParameter("searchKnow") != null) {
			keyword = request.getParameter("keyword");
		}
		 
		//키워드 있을경우 앞뒤 공백제거
		if(!(keyword == null || keyword == "")) {	
			keyword.replaceAll("\\p{Z}", ""); //사이 공백
			keyword = keyword.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "");  //앞뒤 공백 제거
		}
		
		int currentPage = 1; //기본 페이지
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		int limit = 27;
		
		String animal = "dog"; //기본 분류 dog
		if(request.getParameter("animal") != null) {
			animal = request.getParameter("animal");
		}
		JSONObject jobj = KnowledgeCrawling.knowledgeList(animal, currentPage, search, keyword);
		
		ArrayList<Knowledge> list = new ArrayList<Knowledge>();
		
		int listCount = Integer.parseInt(jobj.get("totalCount").toString());
		
		NoticePage page = new NoticePage(currentPage, listCount, limit); //현재 페이지와 총 갯수 보내서, startPage, endpage등.. 값 만들기
		
		//검색값 page객체에 넣기
		page.setSearch(search);
		page.setKeyword(keyword);
		
		JSONArray jarr = new JSONArray();
		jarr = (JSONArray)jobj.get("list");

		//목록이 있을 경우
		if(jarr != null) {
			//jsonArray => ArrayList<Knowledge>로 변환 (컨트롤 더 쉽게하려고)
			for(int i = 0; i < jarr.size(); i++) {
				
				JSONObject job = (JSONObject)jarr.get(i);
				
				Knowledge knowledge = new Knowledge();
				
				knowledge.setAnimal(animal);
				knowledge.setNo(job.get("no").toString());
				knowledge.setReadcount(job.get("readcount").toString());
				knowledge.setTitle(job.get("title").toString());
				knowledge.setLink(job.get("link").toString());
				
				list.add(knowledge);
			}
		}
		
		mv.addObject("animal", animal);
		mv.addObject("page", page);
		mv.addObject("list", list);
		mv.setViewName("admin/contents/knowledgeList");
		return mv;
	}
	
	//상식 상세페이지 이동, 출력
	@RequestMapping(value="cknowdetail.ad")
	public ModelAndView contentsKnowledgeDetail(ModelAndView mv, HttpServletRequest request) {
		logger.info("cknowdetail.ad run...");
		
		String link = request.getParameter("link");
		String title = request.getParameter("title");
		String readcount = request.getParameter("readcount");
		
		String content = KnowledgeCrawling.knowledgeDetal(link);
		
		mv.addObject("title", title);
		mv.addObject("content", content);
		mv.addObject("readcount", readcount);
		mv.setViewName("admin/contents/knowledgeView");
		return mv;
	}
	
	
	//이슈 목록페이지 이동, 출력
	@RequestMapping(value="cissuelist.ad")
	public ModelAndView contentsIssueList(ModelAndView mv, HttpServletRequest request) {
		logger.info("cissuelist.ad run...");
		
		int currentPage = 1; //기본 페이지
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		int limit = 15;
		
		//정렬 기본 발행순
		String order = "order";
		
		if(request.getParameter("order") != null) { //정렬 값이 전달왔을 때
			order = request.getParameter("order");
		}
		
		int listCount = 100;
		
		NoticePage page = new NoticePage(currentPage, listCount, limit); //현재 페이지와 총 갯수 보내서, startPage, endpage등.. 값 만들기
		
		page.setSearch(order);
		
		ArrayList<Issue> list = issueService.selectIssueList(page);
		
		mv.addObject("page", page);
		mv.addObject("list", list);
		mv.setViewName("admin/contents/issueList");
		return mv;
	}
	
	
	//이슈 상세페이지 이동, 출력
	@RequestMapping(value="cissuedetail.ad")
	public ModelAndView contentsIssueDetail(ModelAndView mv, @RequestParam("link") String link) {
		logger.info("cissuedetail.ad run...");

		JSONObject jobj = IssueCrawling.issueDetail(link);

		Issue issue = new Issue();
		issue.setPartnerName(jobj.get("partnerName").toString());
		issue.setPartnerImg(jobj.get("partnerImg").toString());
		issue.setIssueThumbnail(jobj.get("thumbnail").toString());
		issue.setIssueTitle(jobj.get("title").toString());
		issue.setIssueDate(jobj.get("date").toString());
		issue.setIssueReadcount(Integer.parseInt(jobj.get("readcount").toString()));
		issue.setIssueLink(jobj.get("url").toString());
		issue.setContent(jobj.get("content").toString());
		
		mv.addObject("issue", issue);
		mv.setViewName("admin/contents/issueView");
		return mv;
	}
}
