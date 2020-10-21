package com.kh.runningdog.dboard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.kh.runningdog.common.ImageUtil.Image;
import com.kh.runningdog.common.ImageUtil.ImageLoader;
import com.kh.runningdog.dboard.model.service.DboardService;
import com.kh.runningdog.dboard.model.vo.Dboard;
import com.kh.runningdog.dreply.model.service.DreplyService;
import com.kh.runningdog.dreply.model.vo.Dreply;

@Controller
public class DboardController {
	private static final Logger logger = LoggerFactory.getLogger(DboardController.class);
	
	@Autowired
	private DboardService dboardService;
	
	
	//게시물 보기할시에 댓글리스트를 불러오기 위함
	@Autowired
	private DreplyService dreplyService;
	
	
//	@RequestMapping("dlistPage.do")
//	public String moveDlistPage() {
//		return "animal/chooseList";
//	}

	@RequestMapping("dinsertPage.do")
	public String moveDinsertPage() {
		return "animal/chooseWrite";
	}
	
	@RequestMapping(value = "dinsert.do", method = RequestMethod.POST)
	public String insertDboard(Dboard dboard, HttpServletRequest request,
				@RequestParam(name = "upfile", required = false) MultipartFile file, Model model) {
		logger.info("dinsert.do run..." + dboard + "Image file : " + file.getOriginalFilename());

		String viewImage = file.getOriginalFilename();
		dboard.setviewImage(viewImage);
		dboard.setdContent(dboard.getdContent().replace("\r\n", "<br>"));
		Image viewImg = null;
		Image listImg = null;
		// viewImage 가 null아니거나 viewImage크기가 0 이 아니라면
		// viewImage가 공백이 들어온다면 byte 크기가 0이기때문에 byte로 비교
		if (!(viewImage == null || viewImage.getBytes().length == 0)) {
			String savePath = request.getSession().getServletContext().getRealPath("resources/dboard/dboardImage");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
			String viewRename = sdf.format(new java.sql.Date(System.currentTimeMillis()));
			String listRename = viewRename + "l." + viewImage.substring(viewImage.lastIndexOf(".") + 1);
			viewRename += "v." + viewImage.substring(viewImage.lastIndexOf(".") + 1);
			String viewPath = savePath + "\\" + viewRename; // view 이미지 파일 경로
			String listPath = savePath + "\\" + listRename; // list 이미지 파일 경로
			// 하나의 스트림에 파일 연결은 하나 밖에 못함으로
			// 저장한 파일 복사해서 이미지 리사이징 처리

			try {
				file.transferTo(new File(savePath + "\\" + viewRename));
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}

			try (FileInputStream fin= new FileInputStream(viewPath);
					FileOutputStream fout= new FileOutputStream(listPath);){

				int data = -1;
				byte[] buffer = new byte[1024];
				while ((data = fin.read(buffer, 0, buffer.length)) != -1) {
					fout.write(buffer, 0, buffer.length);
				}
				viewImg = ImageLoader.fromFile(viewPath);
				listImg = ImageLoader.fromFile(listPath);
				//리사이징할 이미지의 폭이 주어진 값 보다 작을 경우 에러가 나기 때문에
				//리사이징할 이미지의 크기가 작을경우 그 폭을 유지하며 리사이징 처리 하기 위해 Width값 강제 적용
				int viewWidth = (viewImg.getWidth() > 800)? 800 : viewImg.getWidth();
				int listWidth = (listImg.getWidth() > 300)? 300 : listImg.getWidth();

				// 너비 300으로 리사이징 처리 화질은 최대한 보정
				// 원본 파일을 저장하니 용량이 너무 많아져서 viewImg도 리사이징
				viewImg.getResizedToWidth(viewWidth).soften(0.0f).writeToJPG(new File(viewPath), 0.95f);
				listImg.getResizedToWidth(listWidth).soften(0.0f).writeToJPG(new File(listPath), 0.95f);
			} catch (IllegalStateException | IOException e) {
				e.printStackTrace();
			}
			dboard.setviewImage(viewRename);
			dboard.setlistImage(listRename);
		}
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = "";
		if (dboardService.insertDboard(dboard) > 0) {
			url = "redirect:/dboardList.do";
		} else {
			model.addAttribute("msg", "게시글 등록 실패 다시 확인해 주세요");
			model.addAttribute("url", "dboardList.do");
			url = "common/alertDboard";
		}
		return url;
	}

	@RequestMapping("dboardList.do")
	public String dboardList(HttpServletRequest request, Model model, @ModelAttribute("Dboard") Dboard dboard){


		logger.info("SearchFiled : " + dboard.getSearchFiled());
		logger.info("SearchValue : " + dboard.getSearchValue());
		logger.info("Category : " + dboard.getCategory());
		logger.info("Local : " + dboard.getLocal());
		int totalCount = dboardService.selectListCount(dboard); // 게시물 총갯수를 구한다
		
		
		//게시물 총횟수랑 첫 페이지에 몇개의 리스트를 보여줄지 체크,
		//pageVO에 makePaing 메소드에 페이지리스트 갯수를 넣어줌
		dboard.setTotalCount(totalCount,12); // 페이징 처리를 위한 setter 호출
		
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO", dboard);
		logger.info("PageSize // 한 페이지에 보여줄 게시글 수 : " + dboard.getPageSize());
		logger.info("PageNo // 페이지 번호 : " + dboard.getPageNo());
		logger.info("StartRowNo //조회 시작 row 번호 : " + dboard.getStartRowNo());
		logger.info("EndRowNo //조회 마지막 now 번호 : " + dboard.getEndRowNo());
		logger.info("FirstPageNo // 첫 번째 페이지 번호 : " + dboard.getFirstPageNo());
		logger.info("FinalPageNo // 마지막 페이지 번호 : " + dboard.getFinalPageNo());
		logger.info("PrevPageNo // 이전 페이지 번호 : " + dboard.getPrevPageNo());
		logger.info("NextPageNo // 다음 페이지 번호 : " + dboard.getNextPageNo());
		logger.info("StartPageNo // 시작 페이지 (페이징 네비 기준) : " + dboard.getStartPageNo());
		logger.info("EndPageNo // 끝 페이지 (페이징 네비 기준) : " + dboard.getEndPageNo());
		logger.info("totalCount // 게시 글 전체 수 : " + totalCount);

		ArrayList<Dboard> dboardList = dboardService.selectList(dboard); 
		
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("dboardList", dboardList);
		
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = "";
		if (totalCount > 0) {
			url = "animal/chooseList";
		} else {
			model.addAttribute("msg", "검색 결과가 존재 하지 않습니다");
			model.addAttribute("url", "dboardList.do");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping(value="dboardNew4.do" , method = RequestMethod.POST)
	@ResponseBody
	public String selectDboardNew4(HttpServletResponse response) throws IOException{
		ArrayList<Dboard> list = dboardService.selectNew4();
		
		JSONObject sendJson = new JSONObject();
		
		JSONArray jarr = new JSONArray();
		
		for(Dboard dboard : list) {
			JSONObject job = new JSONObject();
			job.put("dNum", dboard.getdNum());
			job.put("dWriter", URLEncoder.encode(dboard.getdWriter(), "utf-8"));
			job.put("dTitle", URLEncoder.encode(dboard.getdTitle(),"utf-8"));
			job.put("dFindDate", dboard.getdFindDate());
			job.put("dFindLocal",URLEncoder.encode(dboard.getdFindLocal(),"utf-8"));
			job.put("dDate", dboard.getdDate());
			job.put("listImage", dboard.getlistImage());
		
			jarr.add(job);
		}
		//전송용 객체에 배열 저장
		sendJson.put("list", jarr);
		
		return sendJson.toJSONString();
	}
	
	@RequestMapping("dboardView.do")
	public String selectOne(@RequestParam("dNum") int dNum, Dreply dreply, Dboard dboard,Model model,
												HttpServletRequest request,HttpServletResponse response) {
				
		logger.info("dboard View게시글 번호" + dNum);
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO", dboard);
		
		Cookie[] cookies =request.getCookies();
		
		Cookie viewCookie = null;
		
		//cookies가 null이 아닐경우 이름 만들기
		if(cookies != null && cookies.length > 0) {
			for (int i = 0; i < cookies.length; i++) {
			// Cookie의 name이 cookie + 게시물 번호와 일치하는 쿠키를 viewCookie에 넣어줌 
				if(cookies[i].getName().equals("cookie" + dNum)) {
					logger.info("처음 쿠키가 생성한 뒤에 들어옴.");
					viewCookie = cookies[i];
				}
			}
		}
		// 만일 viewCookie 가 null 일 경우 쿠키를 생성해서 조회수 증가 처리함
		if (viewCookie == null) {
			logger.info("cookie 없음");
			// 쿠키 생성(이름 , 값)
			Cookie newCookie = new Cookie("cookie" + dNum, "|" + dNum + "|");
			// 쿠키추가
			response.addCookie(newCookie);
			// 쿠키를 추가 시키고 조회수 증가처리
			dboardService.updateReadCount(dNum); // 조회수 1 증가
		} else {
			logger.info("cookie 있음");
			// 쿠키값을 받아옴
			String value = viewCookie.getValue();
			logger.info("cookie 값 : " + value);
		}
		
		//조회수 처리 후 게시물에 대한 정보 불러오기
		
		dboard = dboardService.selectOne(dNum); //게시물 하나의 정보를 가져옴
		int dreplyCount = dreplyService.seletListCount(dNum); // 게시물의 댓글 갯수를 구한다
		ArrayList<Dreply> dreplyList = dreplyService.selectList(dNum); //댓글 리스트 
		
		model.addAttribute("dreplyCount" , dreplyCount);
		model.addAttribute("dreplyList", dreplyList);
		String url = "";
		
		if (dboard != null) {
			model.addAttribute("dboard", dboard);
			url = "animal/chooseView";
		} else {
			model.addAttribute("msg", "게시글 보기 실패");
			model.addAttribute("url", "dboardList.do");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dupView.do")
	public String dboardUpdateView(@RequestParam("dNum") int dNum, Model model) {
		Dboard dboard = dboardService.selectOne(dNum);
		
		dboard.setdContent(dboard.getdContent().replaceAll("<br>", "\r\n"));
		logger.info("업데이트 view board 값 :" + dboard);
		logger.info("업데이트 view dNum 값 :" + dNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = "";
		if (dboard != null) {
			model.addAttribute("dboard", dboard);
			url = "animal/chooseUpdate";
		} else {
			model.addAttribute("msg", "수정 게시글 이동 실패");
			model.addAttribute("url", "dboarView.do");
			url = "common/alertDboard";
		}
		return url;
	}

	@RequestMapping(value = "dupdate.do", method = RequestMethod.POST)
	public String updateDboard(Dboard dboard, HttpServletRequest request,
			@RequestParam(name = "upfile", required = false) MultipartFile file, Model model) throws IOException {
		logger.info("dupdate.do run..." + dboard + "Image file : " + file.getOriginalFilename());
		// 상세설명에 엔터키와 띄어쓰기 적용
		dboard.setdContent(dboard.getdContent().replace("\r\n", "<br>"));
		// 새로운 이미지를 업로드 했을 경우
		if (file != null && file.getBytes().length > 0) {
			String viewImage = file.getOriginalFilename();
			dboard.setviewImage(viewImage);
			
			Image viewImg = null;
			Image listImg = null;
			// viewImage 가 null아니거나 viewImage크기가 0 이 아니라면
			// viewImage가 공백이 들어온다면 byte 크기가 0이기때문에 byte로 비교
			if (!(viewImage == null || viewImage.getBytes().length == 0)) {
				String savePath = request.getSession().getServletContext().getRealPath("resources/dboard/dboardImage");
				// update 페이지에 파일을 업로드 했을경우 기존에 있던 파일 삭제
				new File(savePath + "\\" + dboard.getviewImage()).delete();
				new File(savePath + "\\" + dboard.getlistImage()).delete();

				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
				String viewRename = sdf.format(new java.sql.Date(System.currentTimeMillis()));
				String listRename = viewRename + "l." + viewImage.substring(viewImage.lastIndexOf(".") + 1);
				viewRename += "v." + viewImage.substring(viewImage.lastIndexOf(".") + 1);
				String viewPath = savePath + "\\" + viewRename; // view 이미지 파일 경로
				String listPath = savePath + "\\" + listRename; // list 이미지 파일 경로
				// 하나의 스트림에 파일 연결은 하나 밖에 못함으로
				// 저장한 파일 복사해서 이미지 리사이징 처리
				try {
					file.transferTo(new File(savePath + "\\" + viewRename));
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				
				try (FileInputStream fin= new FileInputStream(viewPath);
						FileOutputStream fout= new FileOutputStream(listPath);){
					
					int data = -1;
					byte[] buffer = new byte[1024];
					while ((data = fin.read(buffer, 0, buffer.length)) != -1) {
						fout.write(buffer, 0, buffer.length);
					}
					viewImg = ImageLoader.fromFile(viewPath);
					listImg = ImageLoader.fromFile(listPath);
					//리사이징할 이미지의 폭이 주어진 값 보다 작을 경우 에러가 나기 때문에
					//리사이징할 이미지의 크기가 작을경우 그 폭을 유지하며 리사이징 처리 하기 위해 Width값 강제 적용
					int viewWidth = (viewImg.getWidth() > 800)? 800 : viewImg.getWidth();
					int listWidth = (listImg.getWidth() > 300)? 300 : listImg.getWidth();

					// 너비 300으로 리사이징 처리 화질은 최대한 보정
					// 원본 파일을 저장하니 용량이 너무 많아져서 viewImg도 리사이징
					viewImg.getResizedToWidth(viewWidth).soften(0.0f).writeToJPG(new File(viewPath), 0.95f);
					listImg.getResizedToWidth(listWidth).soften(0.0f).writeToJPG(new File(listPath), 0.95f);
					
				} catch (IllegalStateException | IOException e) {
					e.printStackTrace();
				}
				dboard.setviewImage(viewRename);
				dboard.setlistImage(listRename);
			}
		}
		
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = "";
		if (dboardService.updateDboard(dboard) > 0) {
			//업데이트 후 detail 페이지 이동시 정보 전부 보여주게 하기 위함
			Dboard dboardView = dboardService.selectOne(dboard.getdNum());
			model.addAttribute("dboard",dboardView);
			url = "animal/chooseView";
		} else {
			model.addAttribute("msg", "게시글 수정 실패 다시 확인해 주세요");
			model.addAttribute("url", "dboardView.do");
			url = "common/alertDboard";
		}
		return url;
	}
	
	//게시물숨기기
	@RequestMapping("dHide.do")
	public String updateDboardHide(@RequestParam("dNum") int dNum, Dboard dboard,Model model) {
		//게시물을 삭제 하지 않고 표시 여부에 업데이트 하여
		//3개월 후 스케줄러 이용하여 게시물 삭제
		 
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url ="";
		if (dboardService.updateDboardHide(dboard) > 0) {
			model.addAttribute("msg", "게시물을 삭제 했습니다.");
			model.addAttribute("url", "dboardList.do");
			url = "common/alertDboard";
		} else {
			model.addAttribute("msg", "게시물 삭제에 실패 했습니다.");
			model.addAttribute("url", "dboardList.do");
			url = "common/alertDboard";
		}
		return url;
	}
	
    @RequestMapping("dUpSuccess.do")
    public String updateDboardSuc(@RequestParam("dNum") int dNum,@RequestParam("dSuccess") String dSuccess,
                                Dboard dboard,Model model) {
    	//분양여부
        dboard.setdSuccess(dSuccess);
        logger.info("게시물 분양 여부 체크 : "+dboard.getdSuccess());
    
        
        String url="";
        if (dboardService.updateDboardSuc(dboard) > 0) {
            model.addAttribute("msg", "분양 여부를 업데이트 했습니다");
            model.addAttribute("url", "dboardView.do"+"?dNum="+dboard.getdNum());
            url = "common/alertDboard";
        } else {
            model.addAttribute("dNum", dboard.getdNum());
            model.addAttribute("msg", "분양 여부 업데이트 실패");
            model.addAttribute("url", "dboardView.do"+"?dNum="+dboard.getdNum());
            url = "common/alertDboard";
        }
        return url;
    }
	
	@RequestMapping("dboardnext.do")
	public String dboardNext(HttpServletRequest request,Model model,Dboard dboard) {
		
		logger.info("SearchFiled : " + dboard.getSearchFiled());
		logger.info("SearchValue : " + dboard.getSearchValue());
		logger.info("Category : " + dboard.getCategory());
		logger.info("Local : " + dboard.getLocal());
		
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO", dboard);
		
		//이전게시글번호 저장
		int beforeNum = dboard.getdNum();
		//다음게시글 번호 조회
		int dboardNextNum = dboardService.selectNext(dboard);
		//다음글번호를 받고 다음글로 조회
		dboard = dboardService.selectOne(dboardNextNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		
		
		String url = "";
		if (beforeNum != dboardNextNum) {
			model.addAttribute("dboard", dboard);
			url = "animal/chooseView";
		} else {
			model.addAttribute("dboard",dboard);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dboardprev.do")
	public String dboardPrev(HttpServletRequest request,Model model, Dboard dboard) {
		
		logger.info("SearchFiled : " + dboard.getSearchFiled());
		logger.info("SearchValue : " + dboard.getSearchValue());
		logger.info("Category : " + dboard.getCategory());
		logger.info("Local : " + dboard.getLocal());
		
		//pageVO 로 페이징처리, 검색값 유지
		model.addAttribute("pageVO", dboard);
		
		//이전게시글 번호 저장
		int beforeNum = dboard.getdNum();
		//이전 번호조회
		int dboardPrevNum = dboardService.selectPrev(dboard);
		//이전글번호를 받고 다음글로 조회
		dboard = dboardService.selectOne(dboardPrevNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		
		String url = "";
		if (beforeNum != dboardPrevNum) {
			model.addAttribute("dboard", dboard);
			url = "animal/chooseView";
		} else {
			model.addAttribute("dboard",dboard);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
}
