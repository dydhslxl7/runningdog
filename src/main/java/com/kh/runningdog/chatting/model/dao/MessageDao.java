package com.kh.runningdog.chatting.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.chatting.model.vo.Chatroom;
import com.kh.runningdog.chatting.model.vo.Message;

@Repository("messageDao")
public class MessageDao {
	@Autowired
	private SqlSessionTemplate session;
	public MessageDao() {}
	
	public int insertChatLog(Message saveMessage) {
		return session.insert("messageMapper.insertChatLog", saveMessage);
	}

	public ArrayList<Message> selectChatLog(int roomNo) {
		List<Message> list = session.selectList("messageMapper.selectChatLog", roomNo);
		return (ArrayList<Message>)list;
	}

	public int selectUnread(Message message) {
		return session.selectOne("messageMapper.selectUnread", message);
	}

	public int updateReadcheck(Message message) {
		return session.update("messageMapper.updateReadcheck", message);
	}

	public int selectTotalUnreadCount(int uniqueNum) {
		return session.selectOne("messageMapper.selectTotalUnreadCount", uniqueNum);
	}

}
