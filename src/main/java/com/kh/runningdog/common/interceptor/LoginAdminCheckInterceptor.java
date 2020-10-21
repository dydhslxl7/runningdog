package com.kh.runningdog.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.runningdog.member.model.vo.Member;

public class LoginAdminCheckInterceptor extends HandlerInterceptorAdapter{
	private Logger logger = LoggerFactory.getLogger(LoginAdminCheckInterceptor.class);
	
	//관리자 확인용 인터셉터

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
		HttpSession session = request.getSession();
		Member obj = (Member) session.getAttribute("loginMember");
		logger.info("obj : " + obj);
	
		if (obj == null || obj.getAdminChk().equals("N")) {
			
			logger.debug("일반회원, 비로그인 상태 접근");
			response.setCharacterEncoding("UTF-8");

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter = response.getWriter();
			if(obj == null) {
				printwriter.print("<script>alert('관리자만 이용 가능한 서비스 입니다.'); location.href='login.do';</script>");
			} else {
				printwriter.print("<script>alert('관리자만 이용 가능한 서비스 입니다.'); location.href='main.do';</script>");
			}
			
			printwriter.flush();

			printwriter.close();
			return false;
		}
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
	}

}
