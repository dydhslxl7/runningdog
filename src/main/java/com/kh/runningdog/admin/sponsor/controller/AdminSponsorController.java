package com.kh.runningdog.admin.sponsor.controller;

import java.awt.Graphics;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.filefilter.TrueFileFilter;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.sponsor.model.service.SponsorService;
import com.kh.runningdog.sponsor.model.vo.Sponsor;
import com.kh.runningdog.sponsor.model.vo.SponsorImage;

@Controller
public class AdminSponsorController {
	private Logger logger = LoggerFactory.getLogger(AdminSponsorController.class);

	@Autowired
	private SponsorService sponsorService;

	@RequestMapping("aslist.ad")
	public ModelAndView moveAdminSponsorList(ModelAndView mv, HttpServletRequest request) {
		int currentPage = 1;
		if(request.getParameter("page") != null)
			currentPage = Integer.parseInt(request.getParameter("page"));

		int countList = 6;
		int countPage = 5;

		int totalList = sponsorService.selectListCount();
		int totalPage = (int)(((double)totalList / countList) + 0.9);

		if(totalPage < currentPage && totalPage != 0)
			currentPage = totalPage;

		int startPage = ((int)(((double)currentPage / countPage) + 0.9) - 1) * countPage + 1;
		int endPage = startPage + countPage - 1;
		if(endPage > totalPage)
			endPage = totalPage;

		ArrayList<Sponsor> list = sponsorService.selectList(currentPage, countList);

		if(list.size() > -1) {
			mv.addObject("list", list);
			mv.addObject("page", currentPage);
			mv.addObject("totalList", totalList);
			mv.addObject("totalPage", totalPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.setViewName("admin/userBoard/sponsorList");
		}
		return mv;
	}

	@RequestMapping("aswrite.ad")
	public String moveSponsorWrite() {
		return "admin/userBoard/sponsorWrite";
	}

	@RequestMapping("asdetial.ad")
	public ModelAndView moveAdminSponsorDetail(ModelAndView mv, @RequestParam() int page, @RequestParam() int sNum,
													HttpServletRequest request, HttpServletResponse response) {
		Sponsor sponsor = sponsorService.selectOne(sNum);
		sponsor.setsContent(sponsorService.selectContent(sNum));
    	
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
         mv.addObject("page", page);
         mv.addObject("sponsor", sponsor);
         mv.setViewName("admin/userBoard/sponsorView");
    	}
		return mv;
	}

	@RequestMapping("asupview.ad")
	public ModelAndView moveSponsorUpdateView(ModelAndView mv, Sponsor sponsor, HttpServletResponse response, @RequestParam() int page) {
		sponsor = sponsorService.selectOne(sponsor.getsNum());
		sponsor.setsContent(sponsorService.selectContent(sponsor.getsNum()).replaceAll("'", "\\\\'"));
		DecimalFormat formatter = new DecimalFormat("###,###");
		String amount = formatter.format(sponsor.getsAmount());
		logger.info("sContent : " + sponsor.getsContent());
		mv.addObject("page", page);
		mv.addObject("amount", amount);
		mv.addObject("sponsor", sponsor);
		mv.setViewName("admin/userBoard/sponsorUpdateView");
		return mv;
	}

	@RequestMapping("sfileDel.ad")
	public void sUpFileDelete(@RequestParam() int snum, HttpServletRequest request, HttpServletResponse response, Sponsor sponsor) {
		String savePath = savePath(request) + "/thumbnail";
		String[] sNum = new String[]{Integer.toString(snum)};
		ArrayList<Sponsor> list = sponsorService.selectThumb(sNum);
		new File(savePath + "\\" + list.get(0).getsOriginal()).delete();
		new File(savePath + "\\" + list.get(0).getsRename()).delete();

		sponsor = sponsorService.selectOne(snum);
		sponsor.setsOriginal(null);
		sponsor.setsRename(null);
		if(sponsorService.updateSponsor(sponsor) > 0) {
			PrintWriter out = null;
			try {
				out = response.getWriter();
				out.append("ok");
				out.flush();
			} catch (IOException e) {
				e.printStackTrace();
			} finally {
				out.close();
			}
		}
	}

	@RequestMapping(value="supdate.ad", method=RequestMethod.POST)
	public String sUpdate(Sponsor sponsor, HttpServletRequest request, @RequestParam(name = "upfile", required = false) MultipartFile upfile) {
		int sNum = sponsor.getsNum();
		sponsor.setsAmount(Integer.parseInt(request.getParameter("amount").replaceAll(",", "")));

		if(!upfile.getOriginalFilename().equals("")) {
			String savePath = savePath(request) + "/thumbnail";
			String thumbName = upfile.getOriginalFilename();
			sponsor.setsOriginal(thumbName);
			File ofile = new File(savePath + "\\" + thumbName);
			try {
				upfile.transferTo(ofile);
				sponsor.setsRename(makeThumnail(savePath, thumbName, ofile));
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		int result = sponsorService.updateSponsor(sponsor);

		//--------------------------------------------------
		//1. 사진이 변경되지 않은 경우 : 테이블, sContent 양쪽 다 존재
		//2. 사진이 변경된 경우
		//	- sContent에서 삭제 : 테이블에도 삭제해야함
		//	- sContent에서 전부 삭제 : 테이블에서 전부 삭제
		//	- sContent에서 추가된 경우 : 테이블에도 추가되어야함
		//	- sContent에 전부 추가 : 테이블에 전부 추가
		if(result > 0) {
			//스케쥴러를 이용하기 위해 컨텐츠 이미지 테이블에 저장

			//테이블에 저장되어 있는 내용 이미지 파일명
			ArrayList<SponsorImage> keepImg = sponsorService.selectImageList(new String[]{Integer.toString(sNum)});
			ArrayList<String> ilist = new ArrayList<>();
			for(SponsorImage i : keepImg) {
				ilist.add(i.getSiName());
			}
			//sContent 내용에 존재하는 이미지 파일명 읽어 저장
			ArrayList<String> clist = new ArrayList<>();
			Pattern pattern = Pattern.compile("t/(.*?)\"");
			Matcher matcher = pattern.matcher(sponsor.getsContent());
			while(matcher.find()) {
				clist.add(matcher.group(1));
			}

			if(ilist.size() == 0 && (ilist.size() != clist.size()))
				sponsorService.insertSContentImage(clist, sNum);
			else if(clist.size() == 0 && (ilist.size() != clist.size())) {
				sponsorService.deleteSponsorImage(ilist, sNum);
				for(String s : ilist) {
					new File(savePath(request) + "/summernoteContent" + "\\" + s).delete();
				}
			}
			else if(!ilist.containsAll(clist) || !clist.contains(ilist)) {
				ArrayList<String> plist = new ArrayList<>(); //추가된 이미지 저장용
				ArrayList<String> mlist = new ArrayList<>(); //삭제된 이미지 저장용

				for(String s : clist) {
					if(!ilist.contains(s))
						plist.add(s);
					}
				for(String s : ilist) {
					if(!clist.contains(s))
						mlist.add(s);
				}
				if(plist.size() > 0) {
					sponsorService.insertSContentImage(plist, sNum);}
				if(mlist.size() > 0) {
					sponsorService.deleteSponsorImage(mlist, sNum);
					for(String s : mlist) {
						new File(savePath(request) + "/summernoteContent" + "\\" + s).delete();
					}
				}
			}

		}
		return "redirect:asdetial.ad?sNum=" + sNum + "&page=1";
	}

	//파일 경로
	private String savePath(HttpServletRequest request) {
		return request.getSession().getServletContext().getRealPath("resources/sponsor");
	}

	//썸네일 생성 & 저장
	private String makeThumnail(String savePath, String thumbName, File ofile) {

		SimpleDateFormat sdf = new SimpleDateFormat("yyMMdd");
		String ofileName = thumbName.substring(0, thumbName.lastIndexOf("."));
		String fileExt = thumbName.substring(thumbName.lastIndexOf(".") + 1);
		String refileName = ofileName + "-" + sdf.format(new java.sql.Date(System.currentTimeMillis())) + "." + fileExt;

		//변경할 파일 넒이, 높이
		int newWidth = 560, newHeight = 400;
		//W:넓이중싱, H:높이중심, X:설정한 수치로(비율무시)
		String mainPosition = "X";

		Image image;
		int imageWidth;
		int imageHeight;
		double ratio;
		int w;
		int h;

		try {
			//원본 이미지 가져오기
			image = ImageIO.read(ofile);

			//원본 이미지 사이즈 가져오기
			imageWidth = image.getWidth(null);
			imageHeight = image.getHeight(null);

			if(mainPosition.equals("W")){    // 넓이기준

				ratio = (double)newWidth/(double)imageWidth;
				w = (int)(imageWidth * ratio);
				h = (int)(imageHeight * ratio);

			}else if(mainPosition.equals("H")){ // 높이기준

				ratio = (double)newHeight/(double)imageHeight;
				w = (int)(imageWidth * ratio);
				h = (int)(imageHeight * ratio);

			}else{ //설정값 (비율무시) {

				w = newWidth;
				h = newHeight;

			}

			// 이미지 리사이즈
			// Image.SCALE_DEFAULT : 기본 이미지 스케일링 알고리즘 사용
			// Image.SCALE_FAST    : 이미지 부드러움보다 속도 우선
			// Image.SCALE_REPLICATE : ReplicateScaleFilter 클래스로 구체화 된 이미지 크기 조절 알고리즘
			// Image.SCALE_SMOOTH  : 속도보다 이미지 부드러움을 우선
			// Image.SCALE_AREA_AVERAGING  : 평균 알고리즘 사용

			Image resizeImage = image.getScaledInstance(w, h, Image.SCALE_SMOOTH);

			//새 이미지 저장하기
			BufferedImage newImage = new BufferedImage(w, h, BufferedImage.TYPE_INT_RGB);
			Graphics g = newImage.getGraphics();
			g.drawImage(resizeImage, 0, 0, null);
			g.dispose();
			ImageIO.write(newImage, fileExt, new File(savePath + "\\" + refileName));


		} catch (IOException e) {
			e.printStackTrace();
		}

		return refileName;

	}

	@RequestMapping(value="sinsert.ad", method=RequestMethod.POST)
	public String insertSponsor(ModelAndView mv, Sponsor sponsor, 
			HttpServletRequest request, @RequestParam(name = "upfile", required = false) MultipartFile upfile) {
		sponsor.setsAmount(Integer.parseInt(request.getParameter("amount").replaceAll(",", "")));

		String savePath = savePath(request) + "/thumbnail";
		String thumbName = upfile.getOriginalFilename();
		sponsor.setsOriginal(thumbName);
		File ofile = new File(savePath + "\\" + thumbName);

		try {
			upfile.transferTo(ofile);
			sponsor.setsRename(makeThumnail(savePath, thumbName, ofile));
		} catch (Exception e) {
			e.printStackTrace();
		}

		int result = sponsorService.insertSponsor(sponsor);
		int sNum = sponsorService.selectSNum();

		if(result > 0) {
			//스케쥴러를 이용하기 위해 컨텐츠 이미지 테이블에 저장
			ArrayList<String> clist = new ArrayList<>();
			Pattern pattern = Pattern.compile("t/(.*?)\"");
			Matcher matcher = pattern.matcher(sponsor.getsContent());

			while(matcher.find()) {
				clist.add(matcher.group(1));
			}
			if(clist.size() > 0)
				sponsorService.insertSContentImage(clist, sNum);
		}
		return "redirect:asdetial.ad?sNum=" + sNum + "&page=1";
	}

	// 썸머노트 이미지 업로드 메서드
	@ResponseBody
	@RequestMapping(value="summer_image.ad", method=RequestMethod.POST)
	public void summer_image(MultipartFile file, HttpServletRequest request, HttpServletResponse response) {
		response.setContentType("text/html; charset=utf-8");

		try {
			PrintWriter out = response.getWriter();
			String ofileName = file.getOriginalFilename();
			String savePath = savePath(request) + "/summernoteContent";

			Calendar c= Calendar.getInstance();
			int year = c.get(Calendar.YEAR);
			int month = c.get(Calendar.MONTH);
			int date = c.get(Calendar.DATE);

			int index = ofileName.lastIndexOf(".");
			String fileExt = ofileName.substring(index + 1).replaceAll("(\\p{Z}+|\\p{Z}+$)", "");
			ofileName = ofileName.substring(0, index);
			String refileName = ofileName + "-" + year + month + date + "." + fileExt;

			file.transferTo(new File(savePath + "/" + refileName));
			out.print("resources/sponsor/summernoteContent" + "/" + refileName);
			out.close();

		} catch(IOException e) {
			e.printStackTrace();
		}
	}

	//스케쥴러
	@Scheduled(cron = "0 0 14 * * *") //매일 오후 2시
	public void checkContentFile() {
		logger.info("스케줄링 테스트");
		String cFolder = "C:\\gaenasona_workspace\\runningdog\\src\\main\\webapp\\resources\\sponsor\\summernoteContent";

		ArrayList<SponsorImage> list = sponsorService.selectImageList();
		ArrayList<String> del = new ArrayList<String>();
		
		//하위의 모든 파일
		for(File info : FileUtils.listFiles(new File(cFolder), TrueFileFilter.INSTANCE, TrueFileFilter.INSTANCE)) {
			String inFolder = info.getName(); //서버폴더에 저장된 파일명
			if(list.size() > 0) {
				for(int i=0; i<list.size(); i++) {
					String realFile = list.get(i).getSiName(); //테이블에 저장된 파일명
					if(realFile.equals(inFolder))
						break;
					else if(!realFile.equals(inFolder) && i == list.size()-1)
						del.add(inFolder);
				}
			}else {
				del.add(inFolder);
			}
		}

		for(String d : del) {
			if(new File(cFolder + "\\" + d).delete())
				logger.info(d + "파일 삭제 완료");
			else logger.info(d + "파일 삭제 실패");
		}
	}

	@RequestMapping("sdelete.ad")
	public String deleteSponsor(@RequestParam() int page, HttpServletRequest request, ArrayList<String> list, @RequestParam(value="ck", required=false) String ck) {

		String[] checkRow = null;
		if(ck == null)
			checkRow = request.getParameter("checkRow").split(",");
		else checkRow = request.getParameterValues("ck");

		ArrayList<Sponsor> delTh = sponsorService.selectThumb(checkRow);
		ArrayList<SponsorImage> delIm = sponsorService.selectImageList(checkRow);

		String savePathTh = savePath(request) + "\\thumbnail";
		String savePathIm = savePath(request) + "\\summernoteContent";

		int result = sponsorService.deleteSponsor(checkRow);

		if(delTh.size() > 0) {
			for(Sponsor image : delTh) {
				new File(savePathTh + "\\" + image.getsOriginal()).delete();
				new File(savePathTh + "\\" + image.getsRename()).delete();
			}
		}
		if(delIm.size() > 0 ) {
			for(SponsorImage image : delIm) {
				new File(savePathIm + "\\" + image.getSiName()).delete();
			}
		}
		return "redirect:aslist.ad?page=" + page;
	}

	@RequestMapping("ssearch.ad")
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
			//mv.addObject("flag", "1");
			mv.addObject("list", list);
			mv.addObject("page", currentPage);
			mv.addObject("totalList", totalList);
			mv.addObject("totalPage", totalPage);
			mv.addObject("startPage", startPage);
			mv.addObject("endPage", endPage);
			mv.setViewName("admin/userBoard/sponsorList");
		}
		return mv;
	}


}
