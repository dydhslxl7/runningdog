package com.kh.runningdog.volunteer.controller;

import java.awt.Graphics;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.DuplicateFormatFlagsException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.common.ImageUtil.Image;
import com.kh.runningdog.common.ImageUtil.ImageLoader;
import com.kh.runningdog.dboard.model.vo.Dboard;
import com.kh.runningdog.volunteer.model.service.VolunteerService;
import com.kh.runningdog.volunteer.model.vo.Volunteer;
import com.kh.runningdog.volunteer.model.vo.Vreply;
import com.sun.imageio.plugins.common.ImageUtil;

@Controller
public class VolunteerController {
	private static final Logger logger = LoggerFactory.getLogger(VolunteerController.class);
	
	//DI
	@Autowired
	private VolunteerService volunteerService;
	
	//뷰페이지로 이동 처리용 메소드 ------------
	@RequestMapping("vWriteFormView.do")
	public String moveVolunteerWriteForm() {
		return "protect/serviceWrite";
	}
	
	//자원봉사게시판 전체목록 출력
	@RequestMapping("vlist.do")
	public String selectListVolunteer(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
		
		volunteer.setSearchFiled(request.getParameter("searchFiled"));
		volunteer.setSearchValue(request.getParameter("searchValue"));
		volunteer.setVolche(request.getParameter("volche"));

		
		logger.info("SearchFiled : " + volunteer.getSearchFiled());
		logger.info("SearchValue : " + volunteer.getSearchValue());
		logger.info("volche : " + volunteer.getVolche());
		int totalCount = volunteerService.selectListCount(volunteer); // 게시물 총갯수를 구한다
		
		
		//게시물 총횟수랑 첫 페이지에 몇개의 리스트를 보여줄지 체크,
		//pageVO에 makePaing 메소드에 페이지리스트 갯수를 넣어줌
		volunteer.setTotalCount(totalCount,6); // 페이징 처리를 위한 setter 호출

		model.addAttribute("pageVO", volunteer);
		logger.info("PageSize // 한 페이지에 보여줄 게시글 수 : " + volunteer.getPageSize());
		logger.info("PageNo // 페이지 번호 : " + volunteer.getPageNo());
		logger.info("StartRowNo //조회 시작 row 번호 : " + volunteer.getStartRowNo());
		logger.info("EndRowNo //조회 마지막 now 번호 : " + volunteer.getEndRowNo());
		logger.info("FirstPageNo // 첫 번째 페이지 번호 : " + volunteer.getFirstPageNo());
		logger.info("FinalPageNo // 마지막 페이지 번호 : " + volunteer.getFinalPageNo());
		logger.info("PrevPageNo // 이전 페이지 번호 : " + volunteer.getPrevPageNo());
		logger.info("NextPageNo // 다음 페이지 번호 : " + volunteer.getNextPageNo());
		logger.info("StartPageNo // 시작 페이지 (페이징 네비 기준) : " + volunteer.getStartPageNo());
		logger.info("EndPageNo // 끝 페이지 (페이징 네비 기준) : " + volunteer.getEndPageNo());
		logger.info("totalCount // 게시 글 전체 수 : " + totalCount);

		ArrayList<Volunteer> Vlist = volunteerService.selectList(volunteer);
		
		model.addAttribute("volche", volunteer.getVolche());
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("Vlist", Vlist);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = " ";
		if (totalCount > 0) {
			url = "protect/serviceList";
		} else {
			model.addAttribute("msg", "검색 결과가 존재 하지 않습니다");
			model.addAttribute("url", "vlist.do");
			url = "common/alertDboard";
		}
		
		return url;
	}
	//상세보기 페이지 출력
	@RequestMapping(value = "vdetail.do")
	public String selectVolunteer(@RequestParam("volno") int volno, HttpServletRequest request, Model model, Vreply vreply) {
		
			
		Volunteer volunteer = volunteerService.selectVolunteer(volno);
		
		volunteer.setSearchFiled(request.getParameter("searchFiled"));
		volunteer.setSearchValue(request.getParameter("searchValue"));
		volunteer.setVolche(request.getParameter("volche"));
		
		
		model.addAttribute("volche", volunteer.getVolche());
		model.addAttribute("searchFiled", volunteer.getSearchFiled());
		model.addAttribute("searchValue", volunteer.getSearchValue());
		
		String url = "";
		if(volunteer != null) {
			request.setAttribute("volunteer", volunteer);
			url =  "protect/serviceView";
		}else {
			model.addAttribute("msg", "게시글을 볼 수 없습니다.");
			model.addAttribute("url", "vlist.do");
			url = "common/alertDboard";
		}
		return url;
	}
	 //글등록하기
	@RequestMapping(value = "vinsert.do", method = RequestMethod.POST) 
	public String insertVolunteer(Volunteer volunteer, HttpServletRequest request, Model model,
			@RequestParam Map<String, MultipartFile> fileMap) {
		      logger.info("vinsert.do run...");
		      String returnView = null;
		      int i = 1;
		      
		      volunteer.setVolcontent(volunteer.getVolcontent().replace("\r\n", "<br>"));
		      Image img = null;
		      
		      
		      String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles"); //파일 저장할 폴더 위치
		      
		      for(String key : fileMap.keySet()) {
		         if(fileMap.get(key).getOriginalFilename() != "") {
		         String originalFilename = fileMap.get(key).getOriginalFilename();
		         SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
		         String renamefilename = sdf.format(new java.sql.Date(System.currentTimeMillis())); //현재시간
		         renamefilename += "." + originalFilename.substring(originalFilename.lastIndexOf(".") + 1); //확장자명
		         String resizePath = savePath + "\\" + renamefilename;
		         
		         try {
		            fileMap.get(key).transferTo(new File(savePath + "\\" + renamefilename));
		            img = ImageLoader.fromFile(resizePath);
		            
		            // 너비 300으로 리사이징 처리 화질은 최대한 보정
					img.getResizedToWidth(300).soften(0.0f).writeToJPG(new File(resizePath), 0.95f);
		            
		         } catch (Exception e) {
		            e.printStackTrace();
		         }
		            switch (i) {
		            case 1 : volunteer.setVolor1(originalFilename);
		                     volunteer.setVolre1(renamefilename); break;
		            case 2 : volunteer.setVolor2(originalFilename);
                    		 volunteer.setVolre2(renamefilename); break;
		            case 3 : volunteer.setVolor3(originalFilename);
                    		 volunteer.setVolre3(renamefilename); break;
		            case 4 : volunteer.setVolor4(originalFilename);
		            		 volunteer.setVolre4(renamefilename); break;
		         }
		            i++;
		         }
		      }
		      //return은 한번만 하기위해~ return
		      if(volunteerService.insertVolunteer(volunteer) > 0) {
		         returnView = "redirect:/vlist.do";
		      } else {
		    	  model.addAttribute("msg", "게시글 등록 실패 다시 확인해 주세요");
				  model.addAttribute("url", "vlist.do");
				  returnView = "common/alertDboard";
		      }
		      
		      return returnView;
		   }
	//수정페이지로 이동
	@RequestMapping(value = "vUpdateView.do")
	public String moveVolunteerUpdateView(HttpServletRequest request, Model model) {
		int volno = Integer.parseInt(request.getParameter("volno"));
		
		Volunteer volunteer = volunteerService.selectVolunteer(volno);
		logger.info("업데이트 view  값 :" + volunteer);
		
		String url = "";
		if(volunteer != null) {
			model.addAttribute("volunteer", volunteer);
			url = "protect/serviceUpdate";
		}else {
			model.addAttribute("msg", volno + "번 글 수정페이지로 이동 실패!");
			model.addAttribute("url", "vdetail.do");
			url = "common/error";
		}
		return url;
		
	}
	//글수정하기
	@RequestMapping(value = "vupdate.do", method = RequestMethod.POST) 
	public String updateVolunteer(Volunteer volunteer, HttpServletRequest request, 
			@RequestParam Map<String, MultipartFile> fileMap) {
	      logger.info("vupdate.do run...");
	      String returnView = null;
	      int i = 1;
	      Image img = null;
	      
	      String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles"); //파일 저장할 폴더 위치
	      
	      
		  String deleteFilename1 = request.getParameter("deleteFilename1");
		  String deleteFilename2 = request.getParameter("deleteFilename2");
		  String deleteFilename3 = request.getParameter("deleteFilename3");
		  String deleteFilename4 = request.getParameter("deleteFilename4");
	      
		//삭제할 파일이 넘겨져왔을 때 삭제하기
			if(!(deleteFilename1 == null || deleteFilename1.length() == 0)) {
				new File(savePath + "\\" + volunteer.getVolre1()).delete();
				volunteer.setVolor1(null);
				volunteer.setVolre1(null);
			}
			if(!(deleteFilename2 == null || deleteFilename2.length() == 0)) {
				new File(savePath + "\\" + volunteer.getVolre2()).delete();
				volunteer.setVolor2(null);
				volunteer.setVolre2(null);
			}
			if(!(deleteFilename3 == null || deleteFilename3.length() == 0)) {
				new File(savePath + "\\" + volunteer.getVolre3()).delete();
				volunteer.setVolor3(null);
				volunteer.setVolre3(null);
			}
			if(!(deleteFilename4 == null || deleteFilename4.length() == 0)) {
				new File(savePath + "\\" + volunteer.getVolre4()).delete();
				volunteer.setVolor4(null);
				volunteer.setVolre4(null);
			}
			//새로 첨부된 파일 있을 경우 파일 추가하기
		for (String key : fileMap.keySet()) {
			if (fileMap.get(key).getOriginalFilename() != "") {
				String originalFilename = fileMap.get(key).getOriginalFilename();
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String renamefilename = sdf.format(new java.sql.Date(System.currentTimeMillis())); // 현재시간
				renamefilename += "." + originalFilename.substring(originalFilename.lastIndexOf(".") + 1); // 확장자명
				String resizePath = savePath + "\\" + renamefilename;

				try {
					fileMap.get(key).transferTo(new File(savePath + "\\" + renamefilename));
					img = ImageLoader.fromFile(resizePath);
		            
		            // 너비 300으로 리사이징 처리 화질은 최대한 보정
					img.getResizedToWidth(300).soften(0.0f).writeToJPG(new File(resizePath), 0.95f);
				} catch (Exception e) {
					e.printStackTrace();
				}
				switch (i) {
				case 1:
					if (volunteer.getVolor1().length() == 0) { // 1번 파일이 없을 때
						volunteer.setVolor1(originalFilename);
						volunteer.setVolre1(renamefilename);
					} else { // 1번파일이 있을 때
						if (volunteer.getVolor2().length() == 0) { // 2번파일이 없을 때
							volunteer.setVolor2(originalFilename);
							volunteer.setVolre2(renamefilename);
						} else {
							if (volunteer.getVolor3().length() == 0) { // 3번파일이 없을 때
								volunteer.setVolor3(originalFilename);
								volunteer.setVolre3(renamefilename);
							} else {
								volunteer.setVolor4(originalFilename);
								volunteer.setVolre4(renamefilename);
							}
						}
					}
					break;
				case 2:
					if (volunteer.getVolor2().length() == 0) { // 2번파일이 없을 때
						volunteer.setVolor2(originalFilename);
						volunteer.setVolre2(renamefilename);
					} else {
						if (volunteer.getVolor3().length() == 0) { // 3번파일이 없을 때
							volunteer.setVolor3(originalFilename);
							volunteer.setVolre3(renamefilename);
						} else {
							volunteer.setVolor4(originalFilename);
							volunteer.setVolre4(renamefilename);
						}
					}
					break;
				case 3:
					if (volunteer.getVolor3().length() == 0) { // 3번파일이 없을 때
						volunteer.setVolor3(originalFilename);
						volunteer.setVolre3(renamefilename);
					} else {
						volunteer.setVolor4(originalFilename);
						volunteer.setVolre4(renamefilename);
					}
					break;
				case 4:
					volunteer.setVolor4(originalFilename);
					volunteer.setVolre4(renamefilename);
					break;
				}

				i++;
			} // if문
		} // for문
	      
	      if(volunteerService.updateVolunteer(volunteer) > 0) {
	         returnView = "redirect:/vlist.do";
	      } else {
	         request.setAttribute("message", volunteer.getVolno() + "번 글 수정 처리 실패");
	         returnView = "common/error";
	      }
	      
	      return returnView;
	   } 
	//글삭제하기
	@RequestMapping(value="vdelete.do") 
	public String deleteVolunteer(HttpServletRequest request, Volunteer volunteer, Model model) {
		int volno = Integer.parseInt(request.getParameter("volno"));
		
		volunteer.setVolno(volno);
		
		if(volunteerService.deleteVolunteer(volunteer) > 0) {
			for (int i = 1; i < 5; i++) {
				String renameFileName = request.getParameter("rfile"+ i);
				if(renameFileName != null) {
					String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles");
					new File(savePath + "\\" + renameFileName).delete();
			}
		}
			return "redirect:/vlist.do";
		}else {
			model.addAttribute("message", volno + "번 글 삭제 실패!");
			return  "common/error";
		}
		
	}
	//이전글
	@RequestMapping("vpre.do")
	public String selectVpre(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
		//다음글 번호조회
		volunteer.setSearchFiled(request.getParameter("searchFiled"));
		volunteer.setSearchValue(request.getParameter("searchValue"));
		volunteer.setVolche(request.getParameter("volche"));
				
		int vboardPreNum = volunteerService.selectVolunteerPre(volunteer);
		//다음글번호를 받고 다음글로 조회
		Volunteer vboardPre = volunteerService.selectVolunteer(vboardPreNum);
				
		// 리턴은 한번 하기 위해 url 값 받고 리턴
						
		model.addAttribute("volche", volunteer.getVolche());
		model.addAttribute("searchFiled", volunteer.getSearchFiled());
		model.addAttribute("searchValue",volunteer.getSearchValue());
				
		String url = "";
		if (volunteer.getVolno() != vboardPreNum) {
			model.addAttribute("volunteer", vboardPre);
		url = "protect/serviceView";
	 } else {
		model.addAttribute("volunteer",volunteer);
		model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
		model.addAttribute("url", "javascript:history.back()");
		url = "common/alertDboard";
	}
		return url;
	}
	//다음글
	@RequestMapping("vnext.do")
	public String selectVnext(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
		
		//다음글 번호조회
		volunteer.setSearchFiled(request.getParameter("searchFiled"));
		volunteer.setSearchValue(request.getParameter("searchValue"));
		volunteer.setVolche(request.getParameter("volche"));
		
		int vboardNextNum = volunteerService.selectVolunteerNext(volunteer);
		//다음글번호를 받고 다음글로 조회
		Volunteer vboardNext = volunteerService.selectVolunteer(vboardNextNum);
		
		// 리턴은 한번 하기 위해 url 값 받고 리턴
				
		model.addAttribute("volche", volunteer.getVolche());
		model.addAttribute("searchFiled", volunteer.getSearchFiled());
		model.addAttribute("searchValue",volunteer.getSearchValue());
		
		String url = "";
		if (volunteer.getVolno() != vboardNextNum) {
			model.addAttribute("volunteer", vboardNext);
			url = "protect/serviceView";
		} else {
			model.addAttribute("volunteer",volunteer);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	
	//자원봉사 mypage 전체목록 출력
		@RequestMapping("vlistmy.do")
		public String selectListVolunteerMy(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
			volunteer.setSearchFiled(request.getParameter("searchFiled"));
			volunteer.setSearchValue(request.getParameter("searchValue"));
			volunteer.setVolche(request.getParameter("volche"));
			//volunteer.setUnique_num(Integer.parseInt(request.getParameter("unique_num")));
			logger.info("SearchFiled : " + volunteer.getSearchFiled());
			logger.info("SearchValue : " + volunteer.getSearchValue());
			logger.info("SearchValue : " + volunteer.getUnique_num());
			int totalCount = volunteerService.selectListCountMypage(volunteer); // 게시물 총갯수를 구한다
			
			
			//게시물 총횟수랑 첫 페이지에 몇개의 리스트를 보여줄지 체크,
			//pageVO에 makePaing 메소드에 페이지리스트 갯수를 넣어줌
			volunteer.setTotalCount(totalCount,6); // 페이징 처리를 위한 setter 호출

			model.addAttribute("pageVO", volunteer);
			logger.info("PageSize // 한 페이지에 보여줄 게시글 수 : " + volunteer.getPageSize());
			logger.info("PageNo // 페이지 번호 : " + volunteer.getPageNo());
			logger.info("StartRowNo //조회 시작 row 번호 : " + volunteer.getStartRowNo());
			logger.info("EndRowNo //조회 마지막 now 번호 : " + volunteer.getEndRowNo());
			logger.info("FirstPageNo // 첫 번째 페이지 번호 : " + volunteer.getFirstPageNo());
			logger.info("FinalPageNo // 마지막 페이지 번호 : " + volunteer.getFinalPageNo());
			logger.info("PrevPageNo // 이전 페이지 번호 : " + volunteer.getPrevPageNo());
			logger.info("NextPageNo // 다음 페이지 번호 : " + volunteer.getNextPageNo());
			logger.info("StartPageNo // 시작 페이지 (페이징 네비 기준) : " + volunteer.getStartPageNo());
			logger.info("EndPageNo // 끝 페이지 (페이징 네비 기준) : " + volunteer.getEndPageNo());
			logger.info("totalCount // 게시 글 전체 수 : " + totalCount);

			ArrayList<Volunteer> list = volunteerService.selectListMypage(volunteer);
			
			model.addAttribute("volche", volunteer.getVolche());
			model.addAttribute("totalCount", totalCount);
			model.addAttribute("list", list);
			// 리턴은 한번 하기 위해 url 값 받고 리턴
			String url = " ";
			
				url = "mypage/myServiceList";
			
			return url;
		}
		
		//상세보기 페이지 출력
		@RequestMapping(value = "vdetailmy.do")
		public String selectVolunteerMypage(@RequestParam("volno") int volno, HttpServletRequest request, Model model) {
			
				
			Volunteer volunteer = volunteerService.selectVolunteer(volno);
			
			volunteer.setSearchFiled(request.getParameter("searchFiled"));
			volunteer.setSearchValue(request.getParameter("searchValue"));
			volunteer.setVolche(request.getParameter("volche"));
			volunteer.setUnique_num(Integer.parseInt(request.getParameter("unique_num")));
			
			
			model.addAttribute("volche", volunteer.getVolche());
			model.addAttribute("searchFiled", volunteer.getSearchFiled());
			model.addAttribute("searchValue", volunteer.getSearchValue());
			
			String url = "";
			if(volunteer != null) {
				request.setAttribute("volunteer", volunteer);
				url =  "mypage/myServiceView";
			}else {
				model.addAttribute("msg", "게시글을 볼 수 없습니다.");
				model.addAttribute("url", "vlistmy.do");
				url = "common/alertDboard";
			}
			return url;
		}
		//수정페이지로 이동(mypage)
		@RequestMapping(value = "vUpdateViewMy.do")
		public String moveVolunteerUpdateViewMypage(HttpServletRequest request, Model model) {
			int volno = Integer.parseInt(request.getParameter("volno"));
			
			Volunteer volunteer = volunteerService.selectVolunteer(volno);
			logger.info("업데이트 view  값 :" + volunteer);
			
			String url = "";
			if(volunteer != null) {
				model.addAttribute("volunteer", volunteer);
				url = "mypage/myServiceUpdate";
			}else {
				model.addAttribute("msg", volno + "번 글 수정페이지로 이동 실패!");
				model.addAttribute("url", "vdetailmy.do");
				url = "common/error";
			}
			return url;
			
		}
		
		//글수정하기(mypage)
		@RequestMapping(value = "vupdatemypage.do", method = RequestMethod.POST) 
		public String updateVolunteerMypage(Volunteer volunteer, HttpServletRequest request, 
				@RequestParam Map<String, MultipartFile> fileMap) {
		      logger.info("vupdate.do run...");
		      int uniquenum = Integer.parseInt(request.getParameter("unique_num"));
		      String returnView = null;
		      int i = 1;
		      Image img = null;
		      
		      String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles"); //파일 저장할 폴더 위치
		      
		      
			  String deleteFilename1 = request.getParameter("deleteFilename1");
			  String deleteFilename2 = request.getParameter("deleteFilename2");
			  String deleteFilename3 = request.getParameter("deleteFilename3");
			  String deleteFilename4 = request.getParameter("deleteFilename4");
		      
			//삭제할 파일이 넘겨져왔을 때 삭제하기
				if(!(deleteFilename1 == null || deleteFilename1.length() == 0)) {
					new File(savePath + "\\" + volunteer.getVolre1()).delete();
					volunteer.setVolor1(null);
					volunteer.setVolre1(null);
				}
				if(!(deleteFilename2 == null || deleteFilename2.length() == 0)) {
					new File(savePath + "\\" + volunteer.getVolre2()).delete();
					volunteer.setVolor2(null);
					volunteer.setVolre2(null);
				}
				if(!(deleteFilename3 == null || deleteFilename3.length() == 0)) {
					new File(savePath + "\\" + volunteer.getVolre3()).delete();
					volunteer.setVolor3(null);
					volunteer.setVolre3(null);
				}
				if(!(deleteFilename4 == null || deleteFilename4.length() == 0)) {
					new File(savePath + "\\" + volunteer.getVolre4()).delete();
					volunteer.setVolor4(null);
					volunteer.setVolre4(null);
				}
				//새로 첨부된 파일 있을 경우 파일 추가하기
			for (String key : fileMap.keySet()) {
				if (fileMap.get(key).getOriginalFilename() != "") {
					String originalFilename = fileMap.get(key).getOriginalFilename();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
					String renamefilename = sdf.format(new java.sql.Date(System.currentTimeMillis())); // 현재시간
					renamefilename += "." + originalFilename.substring(originalFilename.lastIndexOf(".") + 1); // 확장자명
					String resizePath = savePath + "\\" + renamefilename;

					try {
						fileMap.get(key).transferTo(new File(savePath + "\\" + renamefilename));
						img = ImageLoader.fromFile(resizePath);
			            
			            // 너비 300으로 리사이징 처리 화질은 최대한 보정
						img.getResizedToWidth(300).soften(0.0f).writeToJPG(new File(resizePath), 0.95f);
					} catch (Exception e) {
						e.printStackTrace();
					}
					switch (i) {
					case 1:
						if (volunteer.getVolor1().length() == 0) { // 1번 파일이 없을 때
							volunteer.setVolor1(originalFilename);
							volunteer.setVolre1(renamefilename);
						} else { // 1번파일이 있을 때
							if (volunteer.getVolor2().length() == 0) { // 2번파일이 없을 때
								volunteer.setVolor2(originalFilename);
								volunteer.setVolre2(renamefilename);
							} else {
								if (volunteer.getVolor3().length() == 0) { // 3번파일이 없을 때
									volunteer.setVolor3(originalFilename);
									volunteer.setVolre3(renamefilename);
								} else {
									volunteer.setVolor4(originalFilename);
									volunteer.setVolre4(renamefilename);
								}
							}
						}
						break;
					case 2:
						if (volunteer.getVolor2().length() == 0) { // 2번파일이 없을 때
							volunteer.setVolor2(originalFilename);
							volunteer.setVolre2(renamefilename);
						} else {
							if (volunteer.getVolor3().length() == 0) { // 3번파일이 없을 때
								volunteer.setVolor3(originalFilename);
								volunteer.setVolre3(renamefilename);
							} else {
								volunteer.setVolor4(originalFilename);
								volunteer.setVolre4(renamefilename);
							}
						}
						break;
					case 3:
						if (volunteer.getVolor3().length() == 0) { // 3번파일이 없을 때
							volunteer.setVolor3(originalFilename);
							volunteer.setVolre3(renamefilename);
						} else {
							volunteer.setVolor4(originalFilename);
							volunteer.setVolre4(renamefilename);
						}
						break;
					case 4:
						volunteer.setVolor4(originalFilename);
						volunteer.setVolre4(renamefilename);
						break;
					}

					i++;
				} // if문
			} // for문
		      
		      if(volunteerService.updateVolunteer(volunteer) > 0) {
		         returnView = "redirect:/vlistmy.do?unique_num="+ uniquenum ;
		      } else {
		         request.setAttribute("message", volunteer.getVolno() + "번 글 수정 처리 실패");
		         returnView = "common/error";
		      }
		      
		      return returnView;
		   } 
		
		//이전글(mypage)
		@RequestMapping("vpreMypage.do")
		public String selectVpreMypage(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
			//다음글 번호조회
			volunteer.setSearchFiled(request.getParameter("searchFiled"));
			volunteer.setSearchValue(request.getParameter("searchValue"));
			volunteer.setVolche(request.getParameter("volche"));
			volunteer.setUnique_num(Integer.parseInt(request.getParameter("unique_num")));
					
			int vboardPreNum = volunteerService.selectVolunteerPreMypage(volunteer);
			//다음글번호를 받고 다음글로 조회
			Volunteer vboardPre = volunteerService.selectVolunteer(vboardPreNum);
					
			// 리턴은 한번 하기 위해 url 값 받고 리턴
							
			model.addAttribute("volche", volunteer.getVolche());
			model.addAttribute("searchFiled", volunteer.getSearchFiled());
			model.addAttribute("searchValue",volunteer.getSearchValue());
					
			String url = "";
			if (volunteer.getVolno() != vboardPreNum) {
				model.addAttribute("volunteer", vboardPre);
			url = "mypage/myServiceView";
		 } else {
			model.addAttribute("volunteer",volunteer);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
			return url;
		}
		//다음글(mypage)
		@RequestMapping("vnextMypage.do")
		public String selectVnextMypage(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
			
			//다음글 번호조회
			volunteer.setSearchFiled(request.getParameter("searchFiled"));
			volunteer.setSearchValue(request.getParameter("searchValue"));
			volunteer.setVolche(request.getParameter("volche"));
			volunteer.setUnique_num(Integer.parseInt(request.getParameter("unique_num")));
			
			int vboardNextNum = volunteerService.selectVolunteerNextMypage(volunteer);
			//다음글번호를 받고 다음글로 조회
			Volunteer vboardNext = volunteerService.selectVolunteer(vboardNextNum);
			
			// 리턴은 한번 하기 위해 url 값 받고 리턴
					
			model.addAttribute("volche", volunteer.getVolche());
			model.addAttribute("searchFiled", volunteer.getSearchFiled());
			model.addAttribute("searchValue",volunteer.getSearchValue());
			
			String url = "";
			if (volunteer.getVolno() != vboardNextNum) {
				model.addAttribute("volunteer", vboardNext);
				url = "mypage/myServiceView";
			} else {
				model.addAttribute("volunteer",volunteer);
				model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
				model.addAttribute("url", "javascript:history.back()");
				url = "common/alertDboard";
			}
			return url;
		}
		//글삭제하기
		@RequestMapping(value="vdeletemy.do") 
		public String deleteVolunteerMypage(HttpServletRequest request, Volunteer volunteer, Model model) {
			int uniquenum = Integer.parseInt(request.getParameter("unique_num"));
			int volno = Integer.parseInt(request.getParameter("volno"));
			
			volunteer.setVolno(volno);
			
			if(volunteerService.deleteVolunteer(volunteer) > 0) {
				for (int i = 1; i < 5; i++) {
					String renameFileName = request.getParameter("rfile"+ i);
					if(renameFileName != null) {
						String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles");
						new File(savePath + "\\" + renameFileName).delete();
				}
			}
				return "redirect:/vlistmy.do?unique_num="+ uniquenum ;
			}else {
				model.addAttribute("message", volno + "번 글 삭제 실패!");
				return  "common/error";
			}
			
		}
		
}
