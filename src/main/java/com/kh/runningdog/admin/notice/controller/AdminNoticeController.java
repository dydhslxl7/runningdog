package com.kh.runningdog.admin.notice.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.notice.model.service.NoticeService;
import com.kh.runningdog.notice.model.vo.Notice;
import com.kh.runningdog.notice.model.vo.NoticePage;

@Controller
public class AdminNoticeController {
	private static final Logger logger = LoggerFactory.getLogger(AdminNoticeController.class);
	
	@Autowired
	private NoticeService noticeService;
	
	//관리자용 공지사항 목록 페이지 이동, 출력
	@RequestMapping(value="nlist.ad")
	public ModelAndView selectAdminNoticeList(HttpServletRequest request, ModelAndView mv) {
		logger.info("nlist.ad run...");
		
		//검색값 받기
		String search = request.getParameter("searchNotice");
		String keyword = request.getParameter("keyword");
		
		//키워드 있을경우 앞뒤 공백제거
		if(!(keyword == null || keyword == "")) {	
			//keyword.replaceAll("\\p{Z}", ""); //사이 공백
			keyword = keyword.replaceAll("(^\\p{Z}+|\\p{Z}+$)", "");  //앞뒤 공백 제거
		}
		
		int currentPage = 1; //기본 현재 페이지
		if(request.getParameter("page") != null) {
			currentPage = Integer.parseInt(request.getParameter("page"));
		}
		
		//list 개수 받기 용 객체 생성
		NoticePage noticeSearch = new NoticePage();
		noticeSearch.setSearch(search);
		noticeSearch.setKeyword(keyword);
		
		int listCount = noticeService.selectNoticeListCount(noticeSearch);	//목록 갯수
		int limit = 10;
		
		NoticePage noticePage = new NoticePage(currentPage, listCount, limit); //현재 페이지와 총 갯수 보내서, startPage, endpage등.. 값 만들기

		//검색값 NoticePage 에 넣기 (mybatis mapper로 보낼때 파라메타값 하나만 보낼 수 있어서)
		noticePage.setSearch(search);
		noticePage.setKeyword(keyword);	

		ArrayList<Notice> list = noticeService.selectNoticeList(noticePage);
		
		mv.addObject("list", list);
		mv.addObject("noticePage", noticePage);
		mv.setViewName("admin/userBoard/noticeList");
		return mv;
	}
	
	
	//관리자용 공지사항 상세 페이지 이동, 출력
	@RequestMapping(value="ndetail.ad")
	public ModelAndView selectAdminNoticeDatail(NoticePage noticePage, HttpServletRequest request, ModelAndView mv) {
		logger.info("ndetail.ad run...");
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		
		Notice notice = noticeService.selectNoticeOne(noticeNo);
		
		if(notice != null) {
			//noticeService.updateNoticeReadCount(noticeNo);	//조회수 증가
			noticePage.setNoticeNo(noticeNo);	//이전, 다음글 번호 조회할 때 객체 하나로 보내야해서 추가
			
			Integer preNo = noticeService.selectNoticePre(noticePage); //이전글 번호 조회, int는 null값을 못 받아서 integer사용
			Integer nextNo = noticeService.selectNoticeNext(noticePage); //다음글 번호 조회
			if(preNo == null){ preNo = 0;}	//이전글이 없을 때 0으로 설정
			if(nextNo == null){ nextNo = 0;}	//다음글이 없울 때 0으로 설정 
			
			mv.addObject("preNo", preNo);
			mv.addObject("nextNo", nextNo);
			mv.addObject("notice", notice);
			mv.addObject("noticePage", noticePage);
			mv.setViewName("admin/userBoard/noticeView");
		} else {
			mv.addObject("message", "관리자용 공지사항 상세페이지 이동 실패");
			mv.setViewName("common/error");
		}
		return mv;

	}
	
	
	//관리자용 공지사항 등록 페이지 이동
	@RequestMapping(value="ninview.ad")
	public ModelAndView moveAdminNoticeInsert(HttpServletRequest request, ModelAndView mv) {
		logger.info("ninview.ad run...");
		mv.setViewName("admin/userBoard/noticeWrite");
		return mv;
	}
	
	
	//관리자용 공지사항 수정 페이지 이동
	@RequestMapping(value="nupview.ad")
	public ModelAndView moveAdminNoticeUpdate(HttpServletRequest request, ModelAndView mv) {
		logger.info("nupview.ad run...");
		int noticeNo = Integer.parseInt(request.getParameter("noticeNo"));
		Notice notice = noticeService.selectNoticeOne(noticeNo);
		if(notice != null) {
			mv.addObject("notice", notice);
			mv.setViewName("admin/userBoard/noticeUpdate");
		} else {
			mv.addObject("message", "공지사항 수정페이지 이동 실패");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
		
	
	//공지사항 등록
	@RequestMapping(value="ninsert.ad", method=RequestMethod.POST)
	public String insertAdminNotice(Notice notice, HttpServletRequest request, @RequestParam Map<String, MultipartFile> fileMap) {
		logger.info("ninsert.ad run...");
		String returnView = null;
		String getReturnView = request.getParameter("returnView");
		int i = 1;
		
		String savePath = request.getSession().getServletContext().getRealPath("resources/nupfiles"); //파일 저장할 폴더 위치
		
		for(String key : fileMap.keySet()) {
			if(fileMap.get(key).getOriginalFilename() != "") {
			String originalFilename = fileMap.get(key).getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String renamefilename = sdf.format(new java.sql.Date(System.currentTimeMillis())); //현재시간
			renamefilename += "." + originalFilename.substring(originalFilename.lastIndexOf(".") + 1); //확장자명
			
			try {
				fileMap.get(key).transferTo(new File(savePath + "\\" + renamefilename));
			} catch (Exception e) {
				e.printStackTrace();
			}
				switch (i) {
				case 1 : notice.setNoticeOriginalFilename1(originalFilename);
					     notice.setNoticeRenameFilename1(renamefilename); break;
				case 2 : notice.setNoticeOriginalFilename2(originalFilename);
						 notice.setNoticeRenameFilename2(renamefilename); break;
				case 3 : notice.setNoticeOriginalFilename3(originalFilename);
						 notice.setNoticeRenameFilename3(renamefilename); break;
			}
				i++;
			}
		}
		
		if(noticeService.insertNotice(notice) > 0) {
			if(getReturnView.equals("user")) {
				returnView = "redirect:/nlist.do";
			} else {
				returnView = "redirect:/nlist.ad";
			}
			
		} else {
			request.setAttribute("message", "새 공지사항 등록 처리 실패");
			returnView = "common/error";
		}
		
		return returnView;
	}
	
	
	//공지사항 수정
	@RequestMapping(value="nupdate.ad")
	public String updateAdminNotice(Notice notice, HttpServletRequest request, @RequestParam Map<String, MultipartFile> fileMap) {
		logger.info("nupdate.ad run...");
		String returnView = null;
		String savePath = request.getSession().getServletContext().getRealPath("resources/nupfiles"); //파일 저장할 폴더 위치
		int i = 1;
		
		String getReturnView = request.getParameter("returnView");
		String deleteFilename1 = request.getParameter("deleteFilename1");
		String deleteFilename2 = request.getParameter("deleteFilename2");
		String deleteFilename3 = request.getParameter("deleteFilename3");
		
		//삭제할 파일이 넘겨져왔을 때 삭제하기
		if(!(deleteFilename1 == null || deleteFilename1.length() == 0)) {
			new File(savePath + "\\" + notice.getNoticeRenameFilename1()).delete();
			notice.setNoticeOriginalFilename1(null);
			notice.setNoticeRenameFilename1(null);
		}
		if(!(deleteFilename2 == null || deleteFilename2.length() == 0)) {
			new File(savePath + "\\" + notice.getNoticeRenameFilename2()).delete();
			notice.setNoticeOriginalFilename2(null);
			notice.setNoticeRenameFilename2(null);
		}
		if(!(deleteFilename3 == null || deleteFilename3.length() == 0)) {
			new File(savePath + "\\" + notice.getNoticeRenameFilename3()).delete();
			notice.setNoticeOriginalFilename3(null);
			notice.setNoticeRenameFilename3(null);
		}
		
		//파일 저장순서 변경하기 (1이 삭제되고 2, 3이 남으면 1, 2 이렇게 변경)
		if(notice.getNoticeOriginalFilename1() == null) {	//1번이 없는 경우(삭제된 경우)
			if(notice.getNoticeOriginalFilename2() != null) {	//2번이 있는 경우
				notice.setNoticeOriginalFilename1(notice.getNoticeOriginalFilename2());
				notice.setNoticeRenameFilename1(notice.getNoticeRenameFilename2());
				if(notice.getNoticeOriginalFilename3() != null) {	//3번이 있는 경우
					notice.setNoticeOriginalFilename2(notice.getNoticeOriginalFilename3());
					notice.setNoticeRenameFilename2(notice.getNoticeRenameFilename3());
					notice.setNoticeOriginalFilename3(null);
					notice.setNoticeRenameFilename3(null);
				} else {	//3번이 없는 경우
					notice.setNoticeOriginalFilename2(null);
					notice.setNoticeRenameFilename2(null);
				}
			} else {	//2번도 없는 경우
				if(notice.getNoticeOriginalFilename3() != null) {	//3번만 있는 경우
					notice.setNoticeOriginalFilename1(notice.getNoticeOriginalFilename3());
					notice.setNoticeRenameFilename1(notice.getNoticeRenameFilename3());
					notice.setNoticeOriginalFilename3(null);
					notice.setNoticeRenameFilename3(null);
				}
			}
		} else {	//1번이 있는 경우
			if(notice.getNoticeOriginalFilename2() == null) {	//2번이 없는 경우
				if(notice.getNoticeOriginalFilename3() != null) {	//3번이 있는 경우
					notice.setNoticeOriginalFilename2(notice.getNoticeOriginalFilename3());
					notice.setNoticeRenameFilename2(notice.getNoticeRenameFilename3());
					notice.setNoticeOriginalFilename3(null);
					notice.setNoticeRenameFilename3(null);
				}
			}
		}
		
		//새로 첨부된 파일 있을 경우 파일 추가하기
		for(String key : fileMap.keySet()) {
			if(fileMap.get(key).getOriginalFilename() != "") {
			String originalFilename = fileMap.get(key).getOriginalFilename();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
			String renamefilename = sdf.format(new java.sql.Date(System.currentTimeMillis())); //현재시간
			renamefilename += "." + originalFilename.substring(originalFilename.lastIndexOf(".") + 1); //확장자명
			
			try {
				fileMap.get(key).transferTo(new File(savePath + "\\" + renamefilename));
			} catch (Exception e) {
				e.printStackTrace();
			}
				switch (i) {
				case 1 : 
					if(notice.getNoticeOriginalFilename1().length() == 0) {	//1번 파일이 없을 때
						notice.setNoticeOriginalFilename1(originalFilename);
						notice.setNoticeRenameFilename1(renamefilename);
					} else { //1번파일이 있을 때
						if(notice.getNoticeOriginalFilename2().length() == 0) {	//2번파일이 없을 때
							notice.setNoticeOriginalFilename2(originalFilename);
							notice.setNoticeRenameFilename2(renamefilename);							
						} else {
							notice.setNoticeOriginalFilename3(originalFilename);
							notice.setNoticeRenameFilename3(renamefilename);							
						}
					}
					break;
				case 2 :
					if(notice.getNoticeOriginalFilename2().length() == 0) {	//2번파일이 없을 때
						notice.setNoticeOriginalFilename2(originalFilename);
						notice.setNoticeRenameFilename2(renamefilename);						
					} else {
						notice.setNoticeOriginalFilename3(originalFilename);
						notice.setNoticeRenameFilename3(renamefilename); 						
					}
					break;
				case 3 : 
						notice.setNoticeOriginalFilename3(originalFilename);
						notice.setNoticeRenameFilename3(renamefilename); 
					break;
			}
				i++;
			}//if문
		} //for문
		
		if(noticeService.updateNotice(notice) > 0) {
			if(getReturnView.equals("user")) {
				returnView = "redirect:/nlist.do";
			} else {
				returnView = "redirect:/nlist.ad";
			}
		} else {
			request.setAttribute("message", notice.getNoticeNo() + "번 공지사항 수정 실패");
			returnView = "common/error";
		}
		
		return returnView;
	}	
	
	
	//관리자용 공지사항 삭제 (관리자페이지에서 전체삭제, 선택삭제 했을 경우)
	@RequestMapping(value="ndelete.ad")
	@ResponseBody
	public int deleteAdminNotice(@RequestParam(value = "checkDel[]") List<String> chArr, HttpServletRequest request) {
		logger.info("ndelete.ad run...");
		int result = 0;
		Notice notice = new Notice();
		
		//String savePath = request.getSession().getServletContext().getRealPath("resources/nupfiles"); //저장된 파일 위치
		
		for(String i : chArr) {
			int noticeNo = Integer.parseInt(i);
			notice = noticeService.selectNoticeOne(noticeNo);
			
			result = noticeService.deleteNotice(noticeNo);
			
			if(result > 0) {
				//첨부파일 삭제하기
				String deleteFilename1 = (notice.getNoticeOriginalFilename1() == null) ? null : notice.getNoticeRenameFilename1();
				String deleteFilename2 = (notice.getNoticeOriginalFilename2() == null) ? null : notice.getNoticeRenameFilename2();
				String deleteFilename3 = (notice.getNoticeOriginalFilename3() == null) ? null : notice.getNoticeRenameFilename3();
				String savePath = request.getSession().getServletContext().getRealPath("resources/nupfiles"); //저장된 파일 위치
				if(deleteFilename1 != null) {
					new File(savePath + "\\" + deleteFilename1).delete();
					if(deleteFilename2 != null) {
						new File(savePath + "\\" + deleteFilename2).delete();
						if(deleteFilename3 != null) { 
							new File(savePath + "\\" + deleteFilename3).delete();	
						}
					}
				}
			} 
			
		} //for문
		
		return result;
	}	
	
}
