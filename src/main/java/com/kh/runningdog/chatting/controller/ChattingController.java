package com.kh.runningdog.chatting.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kh.runningdog.chatting.model.service.ChatroomService;
import com.kh.runningdog.chatting.model.service.MessageService;
import com.kh.runningdog.chatting.model.vo.Chatroom;
import com.kh.runningdog.chatting.model.vo.Message;
import com.kh.runningdog.chatting.model.vo.StartChat;
import com.kh.runningdog.member.model.service.MemberService;
import com.kh.runningdog.member.model.vo.Member;

@Controller
public class ChattingController {
	@Autowired
	private ChatroomService chatroomService;
	@Autowired
	private MessageService messageService;
	@Autowired
	private MemberService memberService;
	
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("moveChatting.do")
	public String moveMyChatting(Model model, HttpSession session, Chatroom room) {
		logger.info("moveChatting.do run...");
		Member member = (Member) session.getAttribute("loginMember");
		ArrayList<Integer> myChatList = null;
		if (member != null) {
			logger.info(Integer.toString(member.getUniqueNum()));
			logger.info(member.getNickname());
			room.setMemberNo(member.getUniqueNum());
			room.setNickname(member.getNickname());
			ArrayList<Chatroom> list = chatroomService.selectMyChatMember(room);
			int listcount = chatroomService.selectMyChatCount(room);
			model.addAttribute("list", list);
			model.addAttribute("listcount", listcount);
			
			room.setMemberNo(member.getUniqueNum());
			/*참여한 채팅방 리스트 불러온 후 세션에 저장*/
			myChatList = chatroomService.selectMyChatList(room);
			session.setAttribute("myChatList", myChatList);
		}
		return "mypage/myChatting";
	}
	
	@RequestMapping("moveChattingView.do")
	public String moveChattingView(@RequestParam("roomNo") int roomNo, @RequestParam("receiver") String receiver, @RequestParam("receiverNo") int uniqueNum, Model model){
		logger.info("moveChattingView.do run...");
		Message message = new Message();
		message.setRoomNo(roomNo);
		message.setSender(uniqueNum);
		messageService.updateReadcheck(message);
		
		ArrayList<Message> logList = messageService.selectChatLog(roomNo);
		model.addAttribute("roomNo", roomNo);
		model.addAttribute("receiver", receiver);
		model.addAttribute("receiverNo", uniqueNum);
		model.addAttribute("logList", logList);
		return "mypage/myChattingView";
	}
	
	@RequestMapping(value = "startChat.do", produces = "application/text; charset=utf-8")

	public String startChat(HttpSession session, Model model, @RequestParam("receiver") String name, @RequestParam("receiverNo") int uniqueNum) throws UnsupportedEncodingException{
		logger.info("startChat.do run...");
		Member member = (Member) session.getAttribute("loginMember");
		Chatroom room = new Chatroom();
		StartChat startChat = new StartChat();
		ArrayList<Integer> myChatList = null;
		String url = null;
		
		startChat.setInviterName(name);
		startChat.setInviterNo(uniqueNum);
		startChat.setInviteeName(member.getNickname());
		startChat.setInviteeNo(member.getUniqueNum());
		
		int exstRoomno = chatroomService.selectExistsRoomNo(startChat);
		logger.info("방 번호 존재 : " + exstRoomno);
		
		
		String receiver = URLEncoder.encode(name, "UTF-8");
		if (exstRoomno != 0) {
			url = "redirect:moveChattingView.do?roomNo=" + exstRoomno + "&receiver=" + receiver + "&receiverNo=" + uniqueNum;
		} else {
			int result = chatroomService.insertStartChat(startChat);
			if (result > 0) {
				room.setMemberNo(member.getUniqueNum());
				/*참여한 채팅방 리스트 불러온 후 세션에 저장*/
				myChatList = chatroomService.selectMyChatList(room);
				session.setAttribute("myChatList", myChatList);
				int roomNo = myChatList.get(myChatList.size() - 1);
				url = "redirect:moveChattingView.do?roomNo=" + roomNo + "&receiver=" + receiver + "&receiverNo=" + uniqueNum;
			}
		}
		
		return url;
	}
	
	@RequestMapping("deleteChat.do")
	public String deleteChat(@RequestParam("roomNo") int roomNo) {
		chatroomService.deleteChat(roomNo);
		return "forward:moveChatting.do";
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping("chatList.do")
	@ResponseBody
	public String chatList(HttpSession session) throws UnsupportedEncodingException {
		logger.info("chatList.do run...");
		Member member = (Member) session.getAttribute("loginMember");
		Chatroom chatRoom = new Chatroom();
		chatRoom.setMemberNo(member.getUniqueNum());

		ArrayList<Integer> myChatList = chatroomService.selectMyChatList(chatRoom);
		session.setAttribute("myChatList", myChatList);
		
		ArrayList<Chatroom> roomList = chatroomService.selectMyChatMember(chatRoom);
		
		int unread = 0;
		
		Message message = new Message();
		
		JSONObject sendJson = new JSONObject();
		
		JSONArray jarr = new JSONArray();
		
		for (Chatroom room : roomList) {
			if (myChatList.contains(room.getRoomNo())) {
				JSONObject job = new JSONObject();
				message.setRoomNo(room.getRoomNo());
				message.setReceiver(room.getMemberNo());
				unread = messageService.selectUnread(message);
				job.put("roomNo", room.getRoomNo());
				job.put("receiver", URLEncoder.encode(room.getNickname(), "utf-8"));
				job.put("receiverNo", room.getMemberNo());
				job.put("lastdate", room.getLastDate().toString());
				job.put("lastmessage", URLEncoder.encode((room.getLastMessage() == null ? "" : room.getLastMessage()), "utf-8"));
				job.put("unread", unread);
				job.put("profile", memberService.selectRenameProfile(room.getMemberNo()));
				jarr.add(job);
			}
		}
		sendJson.put("list", jarr);
		return sendJson.toJSONString();
	}
	
	@RequestMapping("totalUnread.do")
	@ResponseBody
	public String totalUnreadCount(HttpSession session) {
		Member member = (Member) session.getAttribute("loginMember");
		int uniqueNum = 0;
		if (member != null) {
			uniqueNum = member.getUniqueNum();
		}
		
		int count = messageService.selectTotalUnreadCount(uniqueNum);
		
		JSONObject job = new JSONObject();
		job.put("count", count);
		return job.toJSONString();
	}
}
