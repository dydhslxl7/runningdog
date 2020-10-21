package com.kh.runningdog.chatting.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.chatting.model.vo.Chatroom;
import com.kh.runningdog.chatting.model.vo.StartChat;

@Repository("chatroomDao")
public class ChatroomDao {
	@Autowired
	private SqlSessionTemplate session;
	public ChatroomDao() {}
	public ArrayList<Chatroom> selectMyChatMember(Chatroom room) {
		List<Chatroom> list = session.selectList("chatroomMapper.selectMyChatMember", room);
		return (ArrayList<Chatroom>)list;
	}
	public int selectMyChatCount(Chatroom room) {
		return session.selectOne("chatroomMapper.selectMyChatCount", room);
	}
	public ArrayList<Integer> selectMyChatList(Chatroom room) {
		List<Integer> list = session.selectList("chatroomMapper.selectMyChatList", room);
		return (ArrayList<Integer>)list;
	}
	public int insertStartChat(StartChat startChat) {
		return session.insert("chatroomMapper.insertStartChat", startChat);
	}
	public int deleteChat(int roomNo) {
		return session.delete("chatroomMapper.deleteChat", roomNo);
	}
	public int selectExistsRoomNo(StartChat startChat) {
		if (session.selectOne("chatroomMapper.selectExistsRoomNo", startChat) != null) {
			return session.selectOne("chatroomMapper.selectExistsRoomNo", startChat);
		} else {
			return 0;
		}
	}
	public int updateLastResp(Chatroom chatRoom) {
		return session.update("chatroomMapper.updateLastResp", chatRoom);
	}
}
