package com.kh.runningdog.member.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.chatting.model.service.ChatroomService;
import com.kh.runningdog.chatting.model.vo.Chatroom;
import com.kh.runningdog.member.model.service.MemberService;
import com.kh.runningdog.member.model.vo.FindUtil;
import com.kh.runningdog.member.model.vo.MailUtil;
import com.kh.runningdog.member.model.vo.Member;

@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService memberService;
	@Autowired
	private ChatroomService chatroomService;
	

	@Autowired
	private BCryptPasswordEncoder bcryptoPasswordEncoder;
	
	@Autowired
	private MailUtil mailUtil;

	@Autowired
	private FindUtil findUtil;


/**************** user controller start ******************/
	@RequestMapping("login.do")
	public String loginPage() {
		return "member/login";
	}
	
	@RequestMapping("join.do")
	public String joinPage() {
		return "member/join";
	}
	
	@RequestMapping("accountFind.do")
	public String accountFindPage() {
		return "member/accountFind";
	}
	
	@RequestMapping("idFindComplete.do")
	public String idFindCompletePage() {
		return "member/idFindComplete";
	}
	
	@RequestMapping("mypage.do")
	public String myInfoPage() {
		return "mypage/myInfo";
	}
	
	//세션 만료로 인한 자동로그아웃
	public void logoutMethod(HttpSession session, HttpServletResponse response, HttpServletRequest request) throws IOException {
		//세션 이용해서 로그아웃 처리
		session=request.getSession(false); //이미 세션이 있다면 그 세션을 돌려주고, 세션이 없으면 null을 돌려준다.
		
		if(session != null) {
			session.invalidate();
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('세션 만료로 인해 자동 로그아웃 되었습니다.\\n다시 로그인해주세요.'); history.go(-1);</script>");
            out.flush();
		}
	}
	
	
	//로그인컨트롤러
	@RequestMapping(value="loginAction.do", method=RequestMethod.POST)
	public String loginMethod(Member member, Chatroom room, Model model, HttpSession session, HttpServletResponse response, SessionStatus status) throws IOException {
		logger.info("loginAction run...");
		Member loginMember = memberService.selectLogin(member);
		ArrayList<Integer> myChatList = null;
		
		String url = null;
		
		if(loginMember != null && loginMember.getLoginLimit().equals("N")) {
			if (bcryptoPasswordEncoder.matches(member.getUserPwd(), loginMember.getUserPwd()) && memberService.updateLastAccessDate(loginMember) > 0) {
				// 나의 채팅방 정보 세션 저장
				room.setMemberNo(loginMember.getUniqueNum());
				myChatList = chatroomService.selectMyChatList(room);
				session.setAttribute("myChatList", myChatList);
				
				session.setAttribute("loginMember", loginMember);
				status.setComplete(); // 요청성공, 200 전송
				url = "main/main";
			} else {
	            response.setContentType("text/html; charset=UTF-8");
	            PrintWriter out = response.getWriter();
	            out.println("<script>alert('비밀번호가 일치하지 않습니다.\\n다시 입력해주세요.'); history.go(-1);</script>");
	            out.flush();
			}
		}else if(loginMember != null && bcryptoPasswordEncoder.matches(member.getUserPwd(), loginMember.getUserPwd()) && loginMember.getLoginLimit().equals("Y")) {
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('로그인이 제한된 계정입니다.\\n관리자에게 문의주세요.'); history.go(-1);</script>");
            out.flush();
		}else{
            response.setContentType("text/html; charset=UTF-8");
            PrintWriter out = response.getWriter();
            out.println("<script>alert('가입되지 않은 계정입니다.\\n다시 입력해주세요.'); history.go(-1);</script>");
            out.flush();
		}
		return url;
	}
	

	//로그아웃컨트롤러	
	@RequestMapping("logout.do")
	public String logoutMethod(HttpSession session, HttpServletRequest request) {
		logger.info("logout run...");
		
		session = request.getSession(true); //이미 세션이 있다면 그 세션을 돌려주고, 세션이 없으면 null을 돌려준다.
		
		//세션 로그아웃 처리
		if(session != null) {
			session.invalidate();
			return "main/main";
		}else{
			session.setAttribute("message", "로그아웃 실패");
			return "common/error";
		}
	}
	
	
	//회원가입컨트롤러
	@RequestMapping(value="joinAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String joinMethod(Member member, Model model, HttpServletRequest request, HttpServletResponse response, @RequestParam(name = "profilImage", required = false) MultipartFile profilImg) throws IOException {
		logger.info("joinAction run...");
		logger.info("member : " + member);
		
		//암호화 처리
		member.setUserPwd(bcryptoPasswordEncoder.encode(member.getUserPwd()));
		
		//아이디(이메일), 닉네임, 핸드폰 번호 유효성검사
		Member userIdChk = memberService.selectUserIdCheck(member);
		Member nicknameChk = memberService.selectNicknameCheck(member);
		Member phoneChk = memberService.selectPhoneCheck(member);
				
		String url = null;
		
		logger.info("확인1");
		logger.info("확인2 : " + userIdChk + nicknameChk + phoneChk);
		
		if(userIdChk != null) {
			logger.info("userIdChk : " + userIdChk);
			url = "notUserId";
		} else if(nicknameChk != null) {
			logger.info("nicknameChk : " + nicknameChk);
			url = "notNickname";
		} else if(phoneChk != null) {
			logger.info("phoneChk : " + phoneChk);
			url = "notPhone";
		} else {

			logger.info("확인3");
			
			if(profilImg.getOriginalFilename() != "") {

				//해당 유저의 프로필 파일이름
				String originProfile = member.getOriginProfile();
				String renameProfile = member.getRenameProfile();
				
				String deleteFlag = request.getParameter("deleteFlag"); //삭제버튼

				//오늘 날짜의 디렉토리 만들기
				Calendar cal = Calendar.getInstance();
				String dateString;
				dateString = String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));

				//이미지 저장 경로 / 오늘날짜 폴더
				String savePath = request.getSession().getServletContext().getRealPath("resources/images/memberImg/"+ dateString);
				File folder = new File(savePath);
				//오늘 날짜의 디렉토리가 없으면 생성
				if (!folder.exists()) { // 디렉토리 없으면 생성.
					folder.mkdirs();
				}

				//오늘 날짜 파일명 변경
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String newOriginProfile = profilImg != null ? profilImg.getOriginalFilename() : null;
				
				String newRenameProfile = null;
				
				if (newOriginProfile != null) {
					newRenameProfile = sdf.format(new java.sql.Date(System.currentTimeMillis()));
					newRenameProfile += "." + newOriginProfile.substring(newOriginProfile.lastIndexOf(".") + 1);
					
					try {
						profilImg.transferTo(new File(savePath + "\\" + newRenameProfile));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					if (renameProfile != null) {
						new File(savePath + "\\" + renameProfile).delete();
					}
					member.setOriginProfile(dateString+ "/" + newOriginProfile);
					member.setRenameProfile(dateString+ "/" + newRenameProfile);
					
				} else if (!(originProfile.isEmpty()) && deleteFlag != null && deleteFlag.equals("yes")) {
					
					member.setOriginProfile(null);
					member.setRenameProfile(null);
					new File(savePath + "\\" + renameProfile).delete();
					
				} else if (!originProfile.isEmpty() && (newOriginProfile == null || originProfile.equals(newOriginProfile) &&
						new File(savePath+ "\\" + renameProfile).length() == new File(savePath + "\\" + newRenameProfile).length())) {
					member.setOriginProfile(originProfile);
					member.setRenameProfile(renameProfile);
				}
				if(memberService.insertMember(member) > 0) {
					logger.info("확인4");
					url = "joinOk";
				}
			} else {
				if(memberService.insertMember(member) > 0) {
					logger.info("확인5");
					url = "joinOk";
				}
			}
		}
		logger.info("url : " + url);
		return url;
	}
		
		
	
	
	//아이디(이메일) 찾기 컨트롤러
		@RequestMapping(value="idFindAction.do", method=RequestMethod.POST)
		@ResponseBody
		public String idFindMethod(Member member, HttpServletResponse response, HttpSession session, SessionStatus status) throws IOException {
			logger.info("idFindAction run...");
			
			Member phoneChk = memberService.selectPhoneCheck(member);
			String url = null;
					
			if(phoneChk != null) {
				if(phoneChk.getUserId() != null) {
					session.setAttribute("selectId", phoneChk.getUserId());
					url = "selectId";
				}
			} else {
				url = "notSelectId";
			}
			return url;
		}
		
		
		//비밀번호 찾기 컨트롤러
		@RequestMapping(value="pwdFindAction.do", method=RequestMethod.POST)
		@ResponseBody
		public String pwdFindMethod(Member member, HttpServletResponse response, HttpSession session) throws IOException {
			logger.info("pwdFindAction run...");
			
			Member userIdPhoneChk = memberService.selectUserIdPhoneCheck(member);
			
			String url = null;
			
			if(userIdPhoneChk != null) {
				if(userIdPhoneChk.getLoginType() == null){
					String keyCode = FindUtil.createKey();
					session.setAttribute("keyCode", keyCode);
					
					String subject = "'지금 달려갈 개' 임시 비밀번호 전송";
					
					String msg = "";
					msg += "<div style='float: left; text-align:center; font-weight:700; border: 2px solid #ff92a8; color:#ff92a8; font-size:14px; padding:80px 50px; margin:50px 0; font-family: 'Noto Sans KR', 'Malgun Gothic', '맑은 고딕', '돋움', sans-serif !important;'>";
					msg += "<h1 style='margin: 0 0 10px;'><img src='http://127.0.0.1:9392/runningdog/resources/images/common/logo_over.png'></h1>";
					msg += "<h3 style=' margin-bottom:5px;'>안녕하세요. " + userIdPhoneChk.getNickname() + " 님.</h3>";
					msg += "<p>";
					msg += "지금 달려갈게 로그인 임시 비밀번호는 <b style='color:#333'>" + keyCode + "</b> 입니다.<br/>";
					msg += "로그인 후 꼭 마이페이지 프로필변경에서 비밀번호를 변경하시기 바랍니다.</p></div>";
					
					MailUtil.sendMail(member.getUserId(), subject, msg);

					//member.setUserPwd(keyCode);
					member.setUserPwd(bcryptoPasswordEncoder.encode(keyCode));

					if(memberService.updateMemberPwd(member) > 0) {
						url = "selectIdPhoneChk";
					}
				} else {
					url = "socialUser";
				}			
			} else {
				url = "notSelectIdPhoneChk";
			}
			return url;
		}
	
	
	
	//나의프로필 컨트롤러
	@RequestMapping(value="myinfoAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String myinfoMethod(Member member, Model model, HttpServletRequest request, HttpServletResponse response, HttpSession session, @RequestParam(name = "profilImage", required = false) MultipartFile profilImg) throws IOException {
		logger.info("myinfoAction run...");
		logger.info("member : " + member);
		
		Member loginMember = memberService.selectLogin(member);
		
		//닉네임, 핸드폰 번호, 비밀번호 유효성검사
		Member nicknameChk = memberService.selectNicknameCheck(member);
		Member phoneChk = memberService.selectPhoneCheck(member);
		Member userPwdChk = memberService.selectUserPwdCheck(member);
		
		String url = null;
		int myNickname = 0, newNickname = 0, myPhone = 0, newPhone = 0;

		myNickname = (loginMember.getNickname().equals(member.getNickname())) ? 1 : 0;
		newNickname = (loginMember.getNickname().equals(member.getNickname())) ? 1 : 0;
		myPhone = (member.getPhone().equals(loginMember.getPhone())) ? 1 : 0;
		newPhone = (member.getPhone().equals(loginMember.getPhone())) ? 1 : 0;

		
		if(nicknameChk != null && myNickname != 1 && newNickname != 0) {
			url = "notNickname";
		} else if(phoneChk != null && myPhone != 1 && newPhone != 0) {
			url = "notPhone";
		} else {
			logger.info("member2 : " + member);
			if(bcryptoPasswordEncoder.matches(member.getUserPwd(), userPwdChk.getUserPwd())) {
				//해당 유저의 프로필 파일이름
				String originProfile = loginMember.getOriginProfile();
				String renameProfile = loginMember.getRenameProfile();
				
				String deleteFlag = request.getParameter("deleteFlag"); //삭제버튼
		
				//오늘 날짜의 디렉토리 만들기
				Calendar cal = Calendar.getInstance();
				String dateString;
				dateString = String.format("%04d%02d%02d", cal.get(Calendar.YEAR), cal.get(Calendar.MONTH) + 1, cal.get(Calendar.DAY_OF_MONTH));
		
				//이미지 저장 경로 / 오늘날짜 폴더
				String savePath = request.getSession().getServletContext().getRealPath("resources/images/memberImg/" + dateString);
				File folder = new File(savePath);
				//오늘 날짜의 디렉토리가 없으면 생성
				if (!folder.exists()) { // 디렉토리 없으면 생성.
					folder.mkdirs();
				}
		
				//오늘 날짜 파일명 변경
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmssSSS");
				String newOriginProfile = profilImg != null ? profilImg.getOriginalFilename() : null;
				
				String newRenameProfile = null;
				
				if (newOriginProfile != null) {
					
					newRenameProfile = sdf.format(new java.sql.Date(System.currentTimeMillis()));
					newRenameProfile += "." + newOriginProfile.substring(newOriginProfile.lastIndexOf(".") + 1);
					
					try {
						profilImg.transferTo(new File(savePath + "\\" + newRenameProfile));
					} catch (IllegalStateException | IOException e) {
						e.printStackTrace();
					}
					
					if (renameProfile != null) {
						new File(savePath + "\\" + renameProfile).delete();
					}
					
					member.setOriginProfile(dateString+ "/" + newOriginProfile);
					member.setRenameProfile(dateString+ "/" + newRenameProfile);
		
				} else if (!(originProfile.isEmpty()) && deleteFlag != null && deleteFlag.equals("yes")) {
					
					member.setOriginProfile(null);
					member.setRenameProfile(null);
					new File(savePath + "\\" + renameProfile).delete();
					
				} else if (!originProfile.isEmpty() && (newOriginProfile == null || originProfile.equals(newOriginProfile) &&
						new File(savePath+ "\\" + renameProfile).length() == new File(savePath + "\\" + newRenameProfile).length())) {
		
					member.setOriginProfile(originProfile);
					member.setRenameProfile(renameProfile);
				}
		
				if(memberService.updatemyinfo(member) > 0) {

					
					model.addAttribute("loginMember", loginMember);
					session.setAttribute("loginMember", memberService.selectLogin(member));
					url = "myinfoOk";
				}
			} else {
				url = "notUserPwd";
			}
				
		}
		logger.info(url);
		return url;
	}
		
		
	
	//나의 프로필 비밀번호 변경 컨트롤러
	@RequestMapping(value="pwdChangeAction.do", method=RequestMethod.POST)
	@ResponseBody
	public String pwdChangeMethod(Member member, HttpServletResponse response, HttpSession session) throws IOException {

		Member userPwdChk = memberService.selectUserPwdCheck(member);
		String url = null;
		
		if(bcryptoPasswordEncoder.matches(member.getUserPwd(), userPwdChk.getUserPwd())) {

			member.setUserPwd(bcryptoPasswordEncoder.encode(member.getNewUserPwd()));

			if(memberService.updateMemberPwd(member) > 0) {
				url = "myinfoOk";
			}
		} else {
			url = "notUserPwd";
		}
		return url;
	}

	
	
	//회원탈퇴 컨트롤러
	@RequestMapping(value="leaveMember.do", method=RequestMethod.POST)
	@ResponseBody
	public String leaveMemberMethod(Member member, HttpSession session) throws IOException {
		String url = null;
		logger.info("leaveMember run...");
		Member userPwdChk = memberService.selectUserPwdCheck(member);
		
		logger.info("member.getUniqueNum() : " + member.getUniqueNum());
		
		if (bcryptoPasswordEncoder.matches(member.getUserPwd(), userPwdChk.getUserPwd())) {
			if (memberService.insertLeaveMember(member) > 0) {
				if (memberService.deleteMember(member) > 0) {
					url = "myinfoOk";
				} else {
					session.setAttribute("message", "회원탈퇴 실패");
					url = "common/error";
				}
			} else {
				session.setAttribute("message", "회원탈퇴 목록으로 insert 실패");
				url = "common/error";
			}
		} else {
			url = "notUserPwd";
		}
		logger.info("url : " + url);
		return url;
	}
	
	
	
	
	
	
	/*채팅방 관련 코드*/
	/*나의 채팅에서 유저검색*/
	@RequestMapping("searchChatUser.do")
	public String searchChatUser(HttpSession session, Member member, Model model) {
		int uniqueNum = ((Member) session.getAttribute("loginMember")).getUniqueNum();
		member.setUniqueNum(uniqueNum);
		ArrayList<Member> list = memberService.selectNicknameCheckList(member);
		int userCount = memberService.selectNicknameCount(member);
		
		if (list != null) {
			model.addAttribute("list", list);
		}
		model.addAttribute("usercount", userCount);
		return "mypage/findUser";
	}
	/*나의 채팅에서 유저검색 끝*/
	/*채팅방 관련 코드 끝*/

/**************** user controller end ******************/

	
}
