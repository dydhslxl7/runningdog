package com.kh.runningdog.admin.dboard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.kh.runningdog.common.ImageUtil.Image;
import com.kh.runningdog.common.ImageUtil.ImageLoader;
import com.kh.runningdog.dboard.controller.DboardController;
import com.kh.runningdog.dboard.model.service.DboardService;
import com.kh.runningdog.dboard.model.vo.Dboard;



@Controller
public class AdminDboardController {

	private static final Logger logger = LoggerFactory.getLogger(DboardController.class);
	
	@Autowired
	private DboardService dboardService;
	
	//게시물작성 페이지로 이동
	@RequestMapping("dinsertPage.ad")
	public String moveDinsertPage() {
		return "admin/userBoard/chooseAdminWrite";
	}
	
	@RequestMapping("dboardList.ad")
	public String adminDboardList (HttpServletRequest request, Model model,Dboard dboard) {

		logger.info("SearchFiled : " + dboard.getSearchFiled());
		logger.info("SearchValue : " + dboard.getSearchValue());
		logger.info("Category : " + dboard.getCategory());
		logger.info("Local : " + dboard.getLocal());
		int totalCount = dboardService.selectAdminCount(dboard); // 게시물 총갯수를 구한다
		
		
		//게시물 총횟수랑 첫 페이지에 몇개의 리스트를 보여줄지 체크,
		//pageVO에 makePaing 메소드에 페이지리스트 갯수를 넣어줌
		dboard.setTotalCount(totalCount,10); // 페이징 처리를 위한 setter 호출
		
		//관리자 페이지 썸네일 때문에 한페이지에 보여줄 게시물 줄임
		//검색 값 유지 및 페이징 처리
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

		ArrayList<Dboard> dboardList = dboardService.selectAdminList(dboard);
		
		
		model.addAttribute("totalCount", totalCount);
		model.addAttribute("dboardList", dboardList);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = "";
		if (totalCount > 0) {
			url = "admin/userBoard/chooseAdminList";
		} else {
			model.addAttribute("msg", "검색 결과가 존재 하지 않습니다");
			model.addAttribute("url", "dboardList.ad");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dboardView.ad")
	public String selectOne(@RequestParam("dNum") int dNum,Model model,Dboard dboard) {
		//검색 값 유지 
		model.addAttribute("pageVO", dboard);
		
		dboard = dboardService.selectOne(dNum);
		logger.info("dboard View게시글 번호" + dNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴

		String url = "";
		if (dboard != null) {
			model.addAttribute("dboard", dboard);
			url = "admin/userBoard/chooseAdminView";
		} else {
			model.addAttribute("msg", "게시글 보기 실패");
			model.addAttribute("url", "chooseAdminList.ad");
			url = "common/alertDboard";
		}
		return url;
	}
	
	
	@RequestMapping("dboardnext.ad")
	public String dboardNext(HttpServletRequest request,Model model, Dboard dboard) {
		//검색값 유지
		model.addAttribute("pageVO", dboard);
				
		//이전게시글번호 저장
		int beforeNum = dboard.getdNum();
		//다음게시글 번호 조회
		int dboardNextNum = dboardService.selectNext(dboard);
		//다음글번호를 받고 다음글로 조회
		dboard = dboardService.selectOne(dboardNextNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		
		String url = "";
		if ( beforeNum != dboardNextNum) {
			model.addAttribute("dboard", dboard);
			url = "admin/userBoard/chooseAdminView";
		} else {
			model.addAttribute("dboard",dboard);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dboardprev.ad")
	public String dboardPrev(HttpServletRequest request,Model model,Dboard dboard) {

		
		//검색값 유지
		model.addAttribute("pageVO", dboard);
		
		//이전게시글 번호 저장
		int beforeNum = dboard.getdNum();
		//이전 번호조회
		int dboardPrevNum = dboardService.selectPrev(dboard);
		//이전글번호를 받고 다음글로 조회
		dboard = dboardService.selectOne(dboardPrevNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		
		String url = "";
		if ( beforeNum != dboardPrevNum) {
			model.addAttribute("dboard", dboard);
			url = "admin/userBoard/chooseAdminView";
		} else {
			model.addAttribute("dboard",dboard);
			model.addAttribute("msg", "현재 글이 마지막 글 입니다.");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping(value = "dinsert.ad", method = RequestMethod.POST)
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
			url = "redirect:/dboardList.ad";
		} else {
			model.addAttribute("msg", "게시글 등록 실패 다시 확인해 주세요");
			model.addAttribute("url", "javascript:history.back()");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dupView.ad")
	public String dboardUpdateView(@RequestParam("dNum") int dNum, Model model) {
		Dboard dboard = dboardService.selectOne(dNum);
		
		dboard.setdContent(dboard.getdContent().replaceAll("<br>", "\r\n"));
		logger.info("업데이트 view board 값 :" + dboard);
		logger.info("업데이트 view dNum 값 :" + dNum);
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url = "";
		if (dboard != null) {
			model.addAttribute("dboard", dboard);
			url = "admin/userBoard/chooseAdminUpdate";
		} else {
			model.addAttribute("msg", "수정 게시글 이동 실패");
			model.addAttribute("url", "dboarView.ad");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping(value = "dupdate.ad", method = RequestMethod.POST)
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
					//view이미지 너비가 800보다 작을경우 이미지 너비변경 없음
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
			Dboard dboardView = dboardService.selectOne(dboard.getdNum());
			model.addAttribute("dboard",dboardView);
			url = "admin/userBoard/chooseAdminView";
		} else {
			model.addAttribute("msg", "게시글 수정 실패 다시 확인해 주세요");
			model.addAttribute("url", "dboardView.ad");
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dUpSuccess.ad")
    public String updateDboardSuc(@RequestParam("dNum") int dNum,@RequestParam("dSuccess") String dSuccess,
                                Dboard dboard,Model model) {
        dboard.setdSuccess(dSuccess);
        logger.info("게시물 분양 여부 체크 : "+dboard.getdSuccess());
        int result = dboardService.updateDboardSuc(dboard);
        
        
        String url="";
        if (result > 0) {
            model.addAttribute("msg", "분양 여부를 업데이트 했습니다");
            model.addAttribute("url", "dboardView.ad"+"?dNum="+dboard.getdNum());
            url = "common/alertDboard";
        } else {
            model.addAttribute("dNum", dboard.getdNum());
            model.addAttribute("msg", "분양 여부 업데이트 실패");
            model.addAttribute("url", "dboardView.ad"+"?dNum="+dboard.getdNum());
            url = "common/alertDboard";
        }
        return url;
    }
	
	
	@RequestMapping("dListHide.ad")
	public String updateDboardHide(@RequestParam("page") int page, Dboard dboard, 
			HttpServletRequest request, Model model, @RequestParam(value="checkRow", required=false) String checkRow) {
		//게시물을 삭제 하지 않고 표시 여부에 업데이트 하여
		//3개월 후 프로시저 등록 후 스케줄러 이용하여 게시물 삭제
		logger.info("어드민 게시물 숨기기 체크"+checkRow + "page 값 : " + page);
		
		
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url ="";
		if (dboardService.updateAdminHide(checkRow.split(",")) > 0) {
			model.addAttribute("msg", "게시물 표시 업데이트 완료");
			model.addAttribute("url", "dboardList.ad?pageNo=" + page);
			url = "common/alertDboard";
		} else {
			model.addAttribute("msg", "게시물 표시 업데이트 실패");
			model.addAttribute("url", "dboardList.ad?pageNo=" + page);
			url = "common/alertDboard";
		}
		return url;
	}
	
	@RequestMapping("dHide.ad")
	public String updateDboardHide(@RequestParam("dNum") int dNum, Dboard dboard,Model model) {
		//게시물을 삭제 하지 않고 표시 여부에 업데이트 하여
		//3개월 후 프로시저 등록 후 스케줄러 이용하여 게시물 삭제
		 
		// 리턴은 한번 하기 위해 url 값 받고 리턴
		String url ="";
		if (dboardService.updateDboardHide(dboard) > 0) {
			model.addAttribute("msg", "게시물을 숨겼습니다.");
			model.addAttribute("url", "dboardList.ad");
			url = "common/alertDboard";
		} else {
			model.addAttribute("msg", "게시물 숨김 처리에 실패 했습니다.");
			model.addAttribute("url", "dboardList.ad");
			url = "common/alertDboard";
		}
		return url;
	}
	//매일 7시 숨김처리 한지 3개월 된 게시물 삭제처리
	@Scheduled(cron = "0 0 7 * * *")
	public void deleteDboard() {
		//숨김 처리한지 3개월 된 게시물 번호 리스트 조회
		logger.info("게시물 삭제 처리 구동");
		ArrayList<Dboard> selectDboardNumList = dboardService.selectDboardNumList();
		//파일 위치
		String savePath = "c:\\gaenasona_workspace/runningdog/src/main/webapp/resources/dboard/dboardImage";
		// 번호 리스트 조회후 삭제 처리
		for (Dboard dboard : selectDboardNumList) {
			logger.info("삭제할 게시물 정보 : " + dboard);
			
			int result =dboardService.deleteDboard(dboard);
			//삭제한 데이터가 있을경우 이미지도 삭제 처리
			if (result > 0) {
				new File(savePath + "\\" + dboard.getviewImage()).delete();
				new File(savePath + "\\" + dboard.getlistImage()).delete();
			}
		}
	}
}
