package com.kh.runningdog.protect.controller;

import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.ObjectOutputStream;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.xpath.XPath;
import javax.xml.xpath.XPathConstants;
import javax.xml.xpath.XPathExpressionException;
import javax.xml.xpath.XPathFactory;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import com.kh.runningdog.protect.model.service.ProtectService;
import com.kh.runningdog.protect.model.vo.Protect;
import com.kh.runningdog.volunteer.controller.VolunteerController;
import com.kh.runningdog.volunteer.model.vo.Volunteer;
import com.kh.runningdog.volunteer.model.vo.Vreply;

@Controller
public class ProtectController {
	private static final Logger logger = LoggerFactory.getLogger(ProtectController.class);
	
	//DI
	@Autowired
	private ProtectService protectService;

	//리스트페이징처리
	@RequestMapping("movePlist.do")
	public String movePlist(HttpServletRequest request, Model model, @ModelAttribute("Protect") Protect protect) {
		protect.setSearchFiled(request.getParameter("searchFiled"));
		protect.setSearchValue(request.getParameter("searchValue"));
		logger.info("SearchFiled : " + protect.getSearchFiled());
		logger.info("SearchValue : " + protect.getSearchValue());
		int totalCount = protectService.selectListCountPro(protect); // 게시물 총갯수를 구한다
		
		
		//게시물 총횟수랑 첫 페이지에 몇개의 리스트를 보여줄지 체크,
		//pageVO에 makePaing 메소드에 페이지리스트 갯수를 넣어줌
		protect.setTotalCount(totalCount,6); // 페이징 처리를 위한 setter 호출

		model.addAttribute("pageVO", protect);
		logger.info("PageSize // 한 페이지에 보여줄 게시글 수 : " + protect.getPageSize());
		logger.info("PageNo // 페이지 번호 : " + protect.getPageNo());
		logger.info("StartRowNo //조회 시작 row 번호 : " + protect.getStartRowNo());
		logger.info("EndRowNo //조회 마지막 now 번호 : " + protect.getEndRowNo());
		logger.info("FirstPageNo // 첫 번째 페이지 번호 : " + protect.getFirstPageNo());
		logger.info("FinalPageNo // 마지막 페이지 번호 : " + protect.getFinalPageNo());
		logger.info("PrevPageNo // 이전 페이지 번호 : " + protect.getPrevPageNo());
		logger.info("NextPageNo // 다음 페이지 번호 : " + protect.getNextPageNo());
		logger.info("StartPageNo // 시작 페이지 (페이징 네비 기준) : " + protect.getStartPageNo());
		logger.info("EndPageNo // 끝 페이지 (페이징 네비 기준) : " + protect.getEndPageNo());
		logger.info("totalCount // 게시 글 전체 수 : " + totalCount);

		ArrayList<Protect> plist = protectService.selectListP(protect);
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("plist", plist);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = " ";
		if (totalCount > 0) {
			url = "protect/protectList";
		} else {
			model.addAttribute("msg", "검색 결과가 존재 하지 않습니다");
			model.addAttribute("url", "movePlist.do");
			url = "common/errorDboard";
		}
		
		return url;
	}

	// tag값의 정보를 가져오는 메소드
	private static String getTagValue(String tag, Element eElement) {
		NodeList nlList = eElement.getElementsByTagName(tag).item(0).getChildNodes();
		Node nValue = (Node) nlList.item(0);
		if (nValue == null)
			return null;
		return nValue.getNodeValue();
	}
	
	//리스트저장
	@Scheduled(cron = "0 1 11 * * *")
	public void main() throws IOException {
		
		protectService.deleteProtect(); 
		
		int page = 1; // 페이지 초기값


		// 보낼 JSONObject 객체 생성
		JSONObject sendJSON = new JSONObject();
		JSONArray jarr = new JSONArray();

		try {
			 while (true) { 
			// parsing할 url 지정(API 키 포함해서)
			String url = "http://openapi.animal.go.kr/openapi/service/rest/animalShelterSrvc/shelterInfo?"
					+ "serviceKey=YgF%2FE21cBZu1OA4fg6TwWCjymj%2Fl%2Bku%2BnH8%2F0U7KpmsgWw%2B%2BY687zdy%2FxpbgbaNaLpxQMUIkmOodkAa1Q%2BRZgw%3D%3D&care_reg_no=&care_nm=&pageNo="
					+ page;
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
					job.put("careNm", URLEncoder.encode(getTagValue("careNm", eElement), "utf-8")); // 센터이름 :
					job.put("careTel", getTagValue("careTel", eElement)); // 전화번호 :
					job.put("orgNm", URLEncoder.encode(getTagValue("orgNm", eElement), "utf-8")); // 관리기관명 :
					job.put("divisionNm", URLEncoder.encode(getTagValue("divisionNm", eElement), "utf-8")); // 동물보호센터유형
					job.put("careAddr", URLEncoder.encode(getTagValue("careAddr", eElement), "utf-8")); // 도로명 주소 : new
					job.put("jibunAddr", URLEncoder.encode(getTagValue("jibunAddr", eElement), "utf-8")); // 소재지번주소 : old
					
					// JSONArray에 JSONObject 담기
					jarr.add(job);
					
				} // if end
			} // for end
			  page += 1; 
			  if (page > 33) 
				  break; 
			  //if -page
			  
		 } // while end
			 
			 Protect protect = new  Protect();
				
				for(int i = 0; i < jarr.size(); i ++) {
					JSONObject data = (JSONObject) (JSONObject) jarr.get(i);
					
					protect.setProname(URLDecoder.decode(data.get("careNm").toString(),"utf-8"));
					protect.setProtel(URLDecoder.decode(data.get("careTel").toString(),"utf-8"));
					protect.setProorgnm(URLDecoder.decode(data.get("orgNm").toString(),"utf-8"));
					protect.setProtype(URLDecoder.decode(data.get("divisionNm").toString(),"utf-8"));
					protect.setProaddressnew(URLDecoder.decode(data.get("careAddr").toString(),"utf-8"));
					protect.setProaddressold(URLDecoder.decode(data.get("jibunAddr").toString(),"utf-8"));
					
					logger.info("protect"+ protect);
				 protectService.insertProtect(protect); 
				}//for문 String
			 
		}catch (Exception e) {
			e.printStackTrace();
		} // try~catch end
	} // main end
	
   //상세보기
	@RequestMapping(value = "pdetail.do")
	public String selectProtect(@RequestParam("prono") int prono,  HttpServletRequest request, Model model) {
		Protect protect = protectService.selectProtect(prono);
		
		protect.setSearchFiled(request.getParameter("searchFiled"));
		protect.setSearchValue(request.getParameter("searchValue"));
		
		model.addAttribute("searchFiled", protect.getSearchFiled());
		model.addAttribute("searchValue", protect.getSearchValue());
		
		String url = "";
		if(protect != null) {
			request.setAttribute("protect", protect);
			url =  "protect/protectView";
		}else {
			model.addAttribute("msg", "게시글을 볼 수 없습니다.");
			model.addAttribute("url", "movePlist.do");
			url = "common/errorDboard";
		}
		return url;
	}
	
	//이전글
		@RequestMapping("ppre.do")
		public String selectPpre(HttpServletRequest request, Model model, @ModelAttribute("Protect") Protect protect) {
			//다음글 번호조회
			protect.setSearchFiled(request.getParameter("searchFiled"));
			protect.setSearchValue(request.getParameter("searchValue"));
					
			int PboardPreNum = protectService.selectProtectPre(protect);
			//다음글번호를 받고 다음글로 조회
			Protect PboardPre = protectService.selectProtect(PboardPreNum);
					
			// 리턴은 한번 하기 위해 url 값 받고 리턴
							
			model.addAttribute("searchFiled", protect.getSearchFiled());
			model.addAttribute("searchValue",protect.getSearchValue());
					
			String url = "";
			if (protect.getProno() != PboardPreNum) {
				model.addAttribute("protect", PboardPre);
			url = "protect/protectView";
		 } else {
			model.addAttribute("protect", protect);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/errorDboard";
		}
			return url;
		}
		//다음글
		@RequestMapping("pnext.do")
		public String selectPnext(HttpServletRequest request, Model model, @ModelAttribute("Protect") Protect protect) {
			
			//다음글 번호조회
			protect.setSearchFiled(request.getParameter("searchFiled"));
			protect.setSearchValue(request.getParameter("searchValue"));
			
			int PboardNextNum = protectService.selecProtectNext(protect);
			//다음글번호를 받고 다음글로 조회
			Protect PboardNext = protectService.selectProtect(PboardNextNum);
			
			// 리턴은 한번 하기 위해 url 값 받고 리턴
					
			model.addAttribute("searchFiled", protect.getSearchFiled());
			model.addAttribute("searchValue",protect.getSearchValue());
			
			String url = "";
			if (protect.getProno() != PboardNextNum) {
				model.addAttribute("protect", PboardNext);
				url = "protect/protectView";
			} else {
				model.addAttribute("protect",protect);
				model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
				model.addAttribute("url", "javascript:history.back()");
				url = "common/errorDboard";
			}
			return url;
		}


	// 상세보기
	//@RequestMapping(value = "pdetail.do")
//	public static void SelectProtect(String[] args, HttpServletResponse response, HttpServletRequest request) throws SAXException, IOException, ParserConfigurationException, XPathExpressionException, TransformerException {
//
//		String careNm = request.getParameter("careNm");
//		System.out.println("careNm"+careNm);
//		
//			String url = "http://openapi.animal.go.kr/openapi/service/rest/animalShelterSrvc/shelterInfo?"
//					+ "serviceKey=YgF%2FE21cBZu1OA4fg6TwWCjymj%2Fl%2Bku%2BnH8%2F0U7KpmsgWw%2B%2BY687zdy%2FxpbgbaNaLpxQMUIkmOodkAa1Q%2BRZgw%3D%3D&care_reg_no=&care_nm=&pageNo=";
//			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
//			DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
//			Document doc = dBuilder.parse(url);
//			
//			TransformerFactory tf = TransformerFactory.newInstance();
//			Transformer transformer = tf.newTransformer();
//			transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
//			StringWriter writer = new StringWriter();
//			transformer.transform(new DOMSource(doc), new StreamResult(writer));
//			String output = writer.getBuffer().toString();
//			System.out.println(output);
//			
//			InputSource is = new InputSource(new StringReader(output));
//	        Document document = DocumentBuilderFactory.newInstance().newDocumentBuilder().parse(is);
//	        XPath xpath = XPathFactory.newInstance().newXPath(); // xpath 생성
//
//	        // NodeList 가져오기 : bookstore 아래에 있는 모든 book 을 선택
//	        NodeList list = (NodeList) xpath.evaluate("//items/item", document, XPathConstants.NODESET);
//			
//	      //책 리스트 출력
//	        for(int i = 0 ; i < list.getLength() ; i++){
//	            String contents = list.item(i).getTextContent();
//	            System.out.println(contents);
//	     }
//	        String savePath = request.getSession().getServletContext().getRealPath("resources/ProtectXml");
//	      
//	        Properties prop = new Properties();
//	        for(int i = 0 ; i < list.getLength() ; i++){
//	        //	prop.setProperty(URLEncoder.encode((Node)(list.item(i). .getNodeName("careNm")).getNodeValue(), "utf-8"), list.item(i).getTextContent());
//	     }
//
//	} // main end
	
	
}// class end

