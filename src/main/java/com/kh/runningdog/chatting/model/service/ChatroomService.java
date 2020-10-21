package com.kh.runningdog.chatting.model.service;

import java.util.ArrayList;

import com.kh.runningdog.chatting.model.vo.Chatroom;
import com.kh.runningdog.chatting.model.vo.StartChat;

public interface ChatroomService {

	ArrayList<Chatroom> selectMyChatMember(Chatroom room);
	int selectMyChatCount(Chatroom room);
	ArrayList<Integer> selectMyChatList(Chatroom room);
	int insertStartChat(StartChat startChat);
	int deleteChat(int roomNo);
	int selectExistsRoomNo(StartChat startChat);
	int updateLastResp(Chatroom chatRoom);
}
