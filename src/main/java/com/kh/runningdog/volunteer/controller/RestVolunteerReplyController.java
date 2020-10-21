package com.kh.runningdog.volunteer.controller;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.kh.runningdog.volunteer.model.service.VolunteerService;
import com.kh.runningdog.volunteer.model.vo.Vreply;

@RestController
public class RestVolunteerReplyController {
	private static final Logger logger = LoggerFactory.getLogger(VolunteerController.class);
	
	@Inject
	private VolunteerService volunteerService;
	//목록
	@RequestMapping(value = "vreplylist.do")
	public List<Vreply> SelectVreplyList(@RequestParam("volno") int volno, HttpServletRequest request) throws Exception {
		
		return volunteerService.selectVreplyList(volno);
	}
	//댓글추가
	@RequestMapping(value="vrinsert.do", method = RequestMethod.POST)
	public Map<String, Object> insertVreply(@RequestBody Vreply vreply)throws Exception{
		Map<String, Object> result = new HashMap<>();
		
		try {
			volunteerService.insertVreply(vreply);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
	//수정
	@RequestMapping(value="vrupdate.do", method = RequestMethod.POST)
	public Map<String, Object> updateVreply(@RequestBody Vreply vreply)throws Exception{
		Map<String, Object> result = new HashMap<>();
		
		try {
			volunteerService.updateVreply(vreply);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}
	//삭제
	@RequestMapping(value = "vrdelete.do")
	public String deleteVreply (@RequestParam(value="vreply_no") int vreply_no, Vreply vreply) throws Exception{
        
	volunteerService.deleteVreply(vreply_no);
	
	return "forward:/vdetail.do";
	}
	//대댓글 저장
	@RequestMapping(value="vrinsertlevel.do", method = RequestMethod.POST)
	public Map<String, Object> insertVreplyLevel(@RequestBody Vreply vreply)throws Exception{
		Map<String, Object> result = new HashMap<>();
		
		try {
			volunteerService.insertVreplyLevel(vreply);
			result.put("status", "OK");
		} catch (Exception e) {
			e.printStackTrace();
			result.put("status", "False");
		}
		return result;
	}

}
