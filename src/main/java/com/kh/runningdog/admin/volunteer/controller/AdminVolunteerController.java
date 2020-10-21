package com.kh.runningdog.admin.volunteer.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.volunteer.model.service.VolunteerService;
import com.kh.runningdog.volunteer.model.vo.Volunteer;

@Controller
public class AdminVolunteerController {
	private static final Logger logger = LoggerFactory.getLogger(AdminVolunteerController.class);
	
	//DI
	@Autowired
	private VolunteerService volunteerService;
	
	//자원봉사게시판 전체목록 출력(관리자용)
		@RequestMapping("vlist.ad")
		public String selectListVolunteerAdmin(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
			volunteer.setSearchFiled(request.getParameter("searchFiled"));
			volunteer.setSearchValue(request.getParameter("searchValue"));
			volunteer.setVolche(request.getParameter("volche"));
			logger.info("SearchFiled : " + volunteer.getSearchFiled());
			logger.info("SearchValue : " + volunteer.getSearchValue());
			logger.info("SearchValue : " + request.getParameter("volche"));
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
				url = "admin/userBoard/serviceList";
			} else {
				model.addAttribute("msg", "검색 결과가 존재 하지 않습니다");
				model.addAttribute("url", "vlist.ad");
				url = "common/errorDboard";
			}
			
			return url;
		}
		//상세보기 페이지 출력(관리자용)
		@RequestMapping(value = "vdetail.ad")
		public String detailVolunteerAdmin(HttpServletRequest request, Model model, @RequestParam("volno") int volno) {
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
				//request.setAttribute("listCountVreply", listCountVreply);
				//request.setAttribute("vrlist", vrlist);
				//request.setAttribute("vreply", vreply);
				url =  "admin/userBoard/serviceView";
			}else {
				model.addAttribute("msg", "게시글을 볼 수 없습니다.");
				model.addAttribute("url", "vlist.do");
				url = "common/errorDboard";
			}
			return url;
		}
		//글삭제하기체크박스로삭제(관리자용)
		@RequestMapping(value="vdeleteche.ad") 
		public String deleteVolunteerAdminChe(HttpServletRequest request, Volunteer volunteer, Model model) {
			
			String[] checkRow = null;
			checkRow = request.getParameter("checkRow").split(",");

			String url = "";
			if(volunteerService.deleteVolunteerAdmin(checkRow) > 0) {
				for (int i = 1; i < 5; i++) {
					String renameFileName = request.getParameter("rfile"+ i);
					if(renameFileName != null) {
						String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles");
						new File(savePath + "\\" + renameFileName).delete();
				}
			}
				url = "redirect:/vlist.ad";
			}else {
				model.addAttribute("message", "글 삭제 실패!");
				model.addAttribute("msg", "해당글은 삭제되지않으므로 관리자에게 문의바랍니다.");
				model.addAttribute("url", "javascript:history.back()");
				url =  "common/errorDboard";
			}
			return url;
		}
		//이전글(관리자용)
		@RequestMapping("vpre.ad")
		public String selectVpreAdmin(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
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
			url = "admin/userBoard/serviceView";
		 } else {
			model.addAttribute("volunteer",volunteer);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/errorDboard";
		}
			return url;
		}
		//다음글(관리자용)
		@RequestMapping("vnext.ad")
		public String selectVnextAdmin(HttpServletRequest request, Model model, @ModelAttribute("Volunteer") Volunteer volunteer) {
			
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
				url = "admin/userBoard/serviceView";
			} else {
				model.addAttribute("volunteer",volunteer);
				model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
				model.addAttribute("url", "javascript:history.back()");
				url = "common/errorDboard";
			}
			return url;
		}
		
		//글삭제하기
		@RequestMapping(value="vdelete.ad") 
		public String deleteVolunteerAdmin(HttpServletRequest request, Volunteer volunteer, Model model) {
			int volno = Integer.parseInt(request.getParameter("volno"));
			
			volunteer.setVolno(volno);
			String url = " ";
			if(volunteerService.deleteVolunteer(volunteer) > 0) {
				for (int i = 1; i < 5; i++) {
					String renameFileName = request.getParameter("rfile"+ i);
					if(renameFileName != null) {
						String savePath = request.getSession().getServletContext().getRealPath("resources/vfiles");
						new File(savePath + "\\" + renameFileName).delete();
				}
			}
				volunteerService.deleteVBreplyAll(volno);
				url = "redirect:/vlist.ad";
			}else {
				model.addAttribute("msg", "글이 삭제되지않았습니다.");
				model.addAttribute("url", "vlist.ad");
				url = "common/errorDboard";
			}
			return url;
			
		}
		
	

}
