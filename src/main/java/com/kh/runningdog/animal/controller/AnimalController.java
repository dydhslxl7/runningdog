package com.kh.runningdog.animal.controller;


import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.kh.runningdog.animal.model.service.AnimalService;
import com.kh.runningdog.animal.model.vo.Animal;


@Controller
public class AnimalController {
	
	private static final Logger logger = LoggerFactory.getLogger(AnimalController.class);
	
	
	@Autowired
	private AnimalService animalService;
	
	// tag값의 정보를 가져오는 메소드
	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		logger.info("nlList" + nlList);
		Node nValue = (Node) nlList.item(0);
		logger.info("nValue" + nValue);
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}
	
	

	@RequestMapping("animalList.do")
	public String moveAlistPage(HttpServletRequest request, Model model, @ModelAttribute("Animal") Animal animal) {

		int totalCount = animalService.selectListCount(animal);
		
		animal.setTotalCount(totalCount,12); // 페이징 처리를 위한 setter 호출
		
		logger.info("PageSize // 한 페이지에 보여줄 게시글 수 : " + animal.getPageSize());
		logger.info("PageNo // 페이지 번호 : " + animal.getPageNo());
		logger.info("StartRowNo //조회 시작 row 번호 : " + animal.getStartRowNo());
		logger.info("EndRowNo //조회 마지막 now 번호 : " + animal.getEndRowNo());
		logger.info("FirstPageNo // 첫 번째 페이지 번호 : " + animal.getFirstPageNo());
		logger.info("FinalPageNo // 마지막 페이지 번호 : " + animal.getFinalPageNo());
		logger.info("PrevPageNo // 이전 페이지 번호 : " + animal.getPrevPageNo());
		logger.info("NextPageNo // 다음 페이지 번호 : " + animal.getNextPageNo());
		logger.info("StartPageNo // 시작 페이지 (페이징 네비 기준) : " + animal.getStartPageNo());
		logger.info("EndPageNo // 끝 페이지 (페이징 네비 기준) : " + animal.getEndPageNo());
		logger.info("totalCount // 게시 글 전체 수 : " + animal.getTotalCount());
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO" , animal);
		
		ArrayList<Animal> animalList = animalService.selectList(animal);
		
		model.addAttribute("animalList" , animalList);
		model.addAttribute("totalCount", totalCount);
		String url = "";
		
		if(totalCount > 0) {
			url = "animal/animalList";
		}else {
			model.addAttribute("msg", "검색 결과가 존재 하지 않습니다.");
			model.addAttribute("url", "animalList.do");
			url = "common/alertDboard";
		}
		
		return url;
	}
	
	@RequestMapping("animalView.do")
	public String animalView(@RequestParam("desertionNo") String desertionNo, Model model, HttpServletRequest request,Animal animal,
								HttpServletResponse response) {
		
		logger.info("Animal View 유기동물 번호 : "+desertionNo );
		
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO" , animal);
		
		Cookie[] cookies =request.getCookies();
		
		Cookie viewCookie = null;
		
		// cookies가 null이 아닐경우 이름 만들기
		if (cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
				// Cookie의 name이 cookie + reviewNo와 일치하는 쿠키를 viewCookie에 넣어줌
				if (cookies[i].getName().equals("cookie" + desertionNo)) {
					logger.info("처음 쿠키가 생성한 뒤에 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
				
		// 만일 viewCookie 가 null 일 경우 쿠키를 생성해서 조회수 증가 처리함
		if (viewCookie == null) {
			logger.info("cookie 없음");

			// 쿠키 생성(이름 , 값)

			Cookie newCookie = new Cookie("cookie" + desertionNo, "|" + desertionNo + "|");
			// 쿠키추가
			response.addCookie(newCookie);
			// 쿠키를 추가 시키고 조회수 증가처리
			animalService.updateReadCount(desertionNo); // 조회수 1 증가
		} else {
			logger.info("cookie 있음");
			// 쿠키값을 받아옴
			String value = viewCookie.getValue();
			logger.info("cookie 값 : " + value);
		}

		// 조회수 처리 후 게시물에 대한 정보 불러 오기
		animal = animalService.selectOne(desertionNo);
		
		String url = "";

		if (animal != null) {
			model.addAttribute("animal", animal);
			url = "animal/animalView";
		} else {
			model.addAttribute("msg", "게시글 보기 실패");
			model.addAttribute("url", "animalList.do");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("animalNext.do")
	public String animalNext(HttpServletRequest request, Model model, Animal animal) {
		
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO" , animal);
		String animalNextNum = animalService.selectNext(animal);
		
		Animal animalNext = animalService.selectOne(animalNextNum);
		String url="";
		if( !(animal.getDesertionNo().equals(animalNextNum))) {
			model.addAttribute("animal", animalNext);
			url = "animal/animalView";
		}else {
			model.addAttribute("animal" , animal);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	
	
	@RequestMapping("animalPrev.do")
	public String animalPrev(HttpServletRequest request, Model model, Animal animal) {
		
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO" , animal);
		
		String animalPrevNum = animalService.selectPrev(animal);
		Animal animalPrev = animalService.selectOne(animalPrevNum);
		
		String url="";
		if( !(animal.getDesertionNo().equals(animalPrevNum))) {
			model.addAttribute("animal", animalPrev);
			url = "animal/animalView";
		}else {
			model.addAttribute("animal" , animal);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	   //매일 오전 6시에 공공데이터 API 최신 데이터 추가
	   @Scheduled(cron = "0 0 6 * * *")
	   public void animalInsert() throws IOException {

	      Date today = new Date();        
	      SimpleDateFormat date = new SimpleDateFormat("yyyyMMdd");
	      String toDay = date.format(today);
	      
	      Calendar mon = Calendar.getInstance();
	      mon.add(Calendar.MONTH , -1);
	      String beforeMonth = new java.text.SimpleDateFormat("yyyyMMdd").format(mon.getTime());
	      
	      logger.info("오늘날짜 : " + toDay + "한달 전 날짜 " + beforeMonth);
	      logger.info(toDay + beforeMonth);

	      JSONArray jarr = new JSONArray();

	      try {
	         /* while (true) { */
	         // parsing할 url 지정(API 키 포함해서)
	         String url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?"
	               + "serviceKey=O47ZzSBjhdMfvVC0tEcZdGSVGD6teeNcyNNtI0sbA4%2BwpXc%2BDy3Y0OYfDAT9S0gajYoe7yZJ%2Fnq4tcDXQxkksw%3D%3D"
	               + "&bgnde="+beforeMonth+"&endde="+toDay
	               + "&upkind=417000&kind=&upr_cd=&org_cd=&care_reg_no=&state=notice&pageNo=1&numOfRows=200&neuter_yn=&";
	         DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
	         DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
	         Document doc = dBuilder.parse(url);
	         logger.info("doc"+ doc);
	         // root tag
	         doc.getDocumentElement().normalize();
	         logger.info("Root element :" + doc.getDocumentElement().getNodeName());

	         // 파싱할 tag
	         NodeList nList = doc.getElementsByTagName("item");
	         
	         logger.info("파싱할 리스트 수 : " + nList.getLength());
	         
	         for (int temp = 0; temp < nList.getLength(); temp++) {
	            Node nNode = nList.item(temp);
	           
	            if (nNode.getNodeType() == Node.ELEMENT_NODE) {

	               Element eElement = (Element) nNode;

	               // JSONArray에 담을 JSONOBject 객체 생성
	               JSONObject job = new JSONObject();

	               // JSONObject에 값 담기
	               // job.put("값이름", 값); ==> 값은 무조건 스트링이어야함
	               job.put("age", URLEncoder.encode(getTagValue("age", eElement),"utf-8")); // 나이
	               job.put("careAddr", URLEncoder.encode(getTagValue("careAddr", eElement),"utf-8"));// 접수일
	               job.put("careNm", URLEncoder.encode(getTagValue("careNm", eElement),"utf-8")); // 보호소 이름
	               job.put("careTel", URLEncoder.encode(getTagValue("careTel", eElement),"utf-8")); // 보호소전화번호
	               job.put("colorCd", URLEncoder.encode(getTagValue("colorCd", eElement),"utf-8")); // 색상
	               job.put("desertionNo", getTagValue("desertionNo", eElement)); // 유기번호
	               job.put("filename", URLEncoder.encode(getTagValue("filename", eElement),"utf-8")); //썸네일이미지
	               job.put("happenDt", URLEncoder.encode(getTagValue("happenDt", eElement),"utf-8")); //발견일
	               job.put("happenPlace", URLEncoder.encode(getTagValue("happenPlace", eElement),"utf-8")); //발견장소
	               job.put("kindCd", URLEncoder.encode(getTagValue("kindCd", eElement),"utf-8")); //품종
	               job.put("neuterYn", URLEncoder.encode(getTagValue("neuterYn", eElement), "utf-8")); //중성화여부
	               job.put("noticeEdt", URLEncoder.encode(getTagValue("noticeEdt", eElement), "utf-8")); //공고종료일
	               job.put("noticeNo", URLEncoder.encode(getTagValue("noticeNo", eElement), "utf-8"));//공고번호
	               job.put("noticeSdt", URLEncoder.encode(getTagValue("noticeSdt", eElement), "utf-8")); //공고시작일
	               job.put("officetel", URLEncoder.encode(getTagValue("officetel", eElement), "utf-8")); //담당자연락처
	               job.put("orgNm", URLEncoder.encode(getTagValue("orgNm", eElement), "utf-8")); //관할기관
	               job.put("popfile", URLEncoder.encode(getTagValue("popfile", eElement), "utf-8")); // view페이지 이미지
	               job.put("processState", URLEncoder.encode(getTagValue("processState", eElement), "utf-8")); //상태
	               job.put("sexCd", URLEncoder.encode(getTagValue("sexCd", eElement), "utf-8")); //성별
	               job.put("specialMark", URLEncoder.encode(getTagValue("specialMark", eElement), "utf-8")); //특징
	               job.put("weight", URLEncoder.encode(getTagValue("weight", eElement), "utf-8")); // 체중
	               // JSONArray에 JSONObject 담기
	               
	               logger.info("desertionNo : "+ getTagValue("desertionNo", eElement));
	               
	               jarr.add(job);
	               
	               Animal animal = new Animal();
	               
	               //DB에 저장하기 위해 String으로 파싱 후 셋
	               for (int i = 0; i < jarr.size(); i++) {
	            	   JSONObject data = (JSONObject) (JSONObject) jarr.get(i);
	            	   
	            	   String desertionNo = data.get("desertionNo").toString();
	            	   if (animalService.selectOne(desertionNo) == null) {

	            		   animal.setAge(URLDecoder.decode(data.get("age").toString(),"utf-8"));
	            		   animal.setCareAddr(URLDecoder.decode(data.get("careAddr").toString(),"utf-8"));
	            		   animal.setCareNm(URLDecoder.decode(data.get("careNm").toString(),"utf-8"));
	            		   animal.setCareTel(URLDecoder.decode(data.get("careTel").toString(),"utf-8"));
	            		   animal.setColorCd(URLDecoder.decode(data.get("colorCd").toString(),"utf-8"));
	            		   animal.setDesertionNo(URLDecoder.decode(data.get("desertionNo").toString(),"utf-8"));
	            		   animal.setFilename(URLDecoder.decode(data.get("filename").toString(),"utf-8"));
	            		   animal.setHappenDt(URLDecoder.decode(data.get("happenDt").toString(),"utf-8"));
	            		   animal.setHappenPlace(URLDecoder.decode(data.get("happenPlace").toString(),"utf-8"));
	            		   animal.setKindCd(URLDecoder.decode(data.get("kindCd").toString(),"utf-8"));
	            		   animal.setNeuterYn(URLDecoder.decode(data.get("neuterYn").toString(),"utf-8"));
	            		   animal.setNoticeEdt(URLDecoder.decode(data.get("noticeEdt").toString(),"utf-8"));
	            		   animal.setNoticeNo(URLDecoder.decode(data.get("noticeNo").toString(),"utf-8"));
	            		   animal.setNoticeSdt(URLDecoder.decode(data.get("noticeSdt").toString(),"utf-8"));
	            		   animal.setOfficetel(URLDecoder.decode(data.get("officetel").toString(),"utf-8"));
	            		   animal.setOrgNm(URLDecoder.decode(data.get("orgNm").toString(),"utf-8"));
	            		   animal.setPopfile(URLDecoder.decode(data.get("popfile").toString(),"utf-8"));
	            		   animal.setProcessState(URLDecoder.decode(data.get("processState").toString(),"utf-8"));
	            		   animal.setSexCd(URLDecoder.decode(data.get("sexCd").toString(),"utf-8"));
	            		   animal.setSpecialMark(URLDecoder.decode(data.get("specialMark").toString(),"utf-8"));
	            		   animal.setWeight(URLDecoder.decode(data.get("weight").toString(),"utf-8"));
	            		   
	            		   animalService.insertAnimal(animal);
	            	   }
	               }
	            } 
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }
	   }
	private static String getTagValueDetail(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag);

		Node nValue = (Node) nlList.item(0);

		return nValue.getNodeValue();
	}

	
}
