package com.kh.runningdog.chatting.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.chatting.model.dao.ChatroomDao;
import com.kh.runningdog.chatting.model.vo.Chatroom;
import com.kh.runningdog.chatting.model.vo.StartChat;

@Service("chatroomService")
public class ChatroomServiceImpl implements ChatroomService{
	@Autowired
	private ChatroomDao chatroomDao;

	@Override
	public ArrayList<Chatroom> selectMyChatMember(Chatroom room) {
		return chatroomDao.selectMyChatMember(room);
	}

	@Override
	public int selectMyChatCount(Chatroom room) {
		return chatroomDao.selectMyChatCount(room);
	}

	@Override
	public ArrayList<Integer> selectMyChatList(Chatroom room) {
		return chatroomDao.selectMyChatList(room);
	}

	@Override
	public int insertStartChat(StartChat startChat) {
		return chatroomDao.insertStartChat(startChat);
	}

	@Override
	public int deleteChat(int roomNo) {
		return chatroomDao.deleteChat(roomNo);
	}

	@Override
	public int selectExistsRoomNo(StartChat startChat) {
		return chatroomDao.selectExistsRoomNo(startChat);
	}

	public int updateLastResp(Chatroom chatRoom) {
		return chatroomDao.updateLastResp(chatRoom);
	}

}
