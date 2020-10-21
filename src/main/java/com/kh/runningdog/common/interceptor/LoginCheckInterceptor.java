package com.kh.runningdog.common.interceptor;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

/*import com.kh.runningdog.member.model.vo.Member;*/

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	private Logger logger = LoggerFactory.getLogger(LoginCheckInterceptor.class);
	
	/*
	 * @Override public boolean preHandle(HttpServletRequest request,
	 * HttpServletResponse response, Object handler) throws Exception { HttpSession
	 * session = request.getSession(); Member loginMember =
	 * (Member)session.getAttribute("loginMember");
	 * 
	 * if(loginMember != null) { //로그인한 상태라면 logger.debug("로그인 상태로 접근 :" +
	 * request.getRequestURI() + "요청"); }else { //로그인 하지 않았다면
	 * logger.debug("비로그인 상태로 접근 : " + request.getRequestURI() + "요청");
	 * 
	 * 
	 * //Referer 페이지로 돌려보냄 : request 객체에 기록되어 있음 String referer =
	 * request.getHeader("Referer"); logger.debug("Referer : " + referer);
	 * //http://localhost:9876/second/blisst.do?page=1 -->> 예시(출력시) String origin =
	 * request.getHeader("Origin"); logger.debug("Origin : " + origin); //브라우저이름
	 * [전송방식] //http://localhost:9876, chrome[GET], ie[GET/POST], firefox[POST]
	 * =>null String url = request.getRequestURL().toString(); logger.debug("url :"
	 * + url); String uri = request.getRequestURI(); // /second/blist.do
	 * 
	 * if(origin == null) { origin = url.replace(uri, ""); } String location =
	 * referer.replace(origin + request.getContextPath(), "");
	 * 
	 * request.setAttribute("loc", location); request.setAttribute("message",
	 * "로그인하셔야 이용할 수 있는 서비스입니다.");
	 * request.getRequestDispatcher("/WEB-INF/views/common/error.jsp").forward(
	 * request, response);
	 * 
	 * return false; //컨트롤러로 안가고 리턴하면, 뷰를 직접 지정함 }//else : 로그인하지 않았다면
	 * 
	 * return super.preHandle(request, response, handler); //기본이 true 임, 해당
	 * 
	 * }
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
		HttpSession session = request.getSession();
		Object obj = session.getAttribute("loginMember");
		logger.info("obj : " + obj);
		if (obj == null) {
			logger.debug("비로그인 상태 접근");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter printwriter = response.getWriter();
			printwriter.print("<script>alert('로그인한 회원만 접근 가능한 경로입니다.\\n로그인 후 이용해주세요.'); location.href='login.do';</script>");
			printwriter.flush();
			printwriter.close();
			return false;
		}
		return true;
	}
	
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
            ModelAndView modelAndView) throws Exception {
        // TODO Auto-generated method stub
        super.postHandle(request, response, handler, modelAndView);
	}
}

