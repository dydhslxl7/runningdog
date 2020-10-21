package com.kh.runningdog.chatting.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.chatting.model.dao.MessageDao;
import com.kh.runningdog.chatting.model.vo.Message;

@Service("messageService")
public class MessageServiceImpl implements MessageService {
	@Autowired
	private MessageDao messageDao;
	
	@Override
	public int insertChatLog(Message saveMessage) {
		return messageDao.insertChatLog(saveMessage);
	}

	@Override
	public ArrayList<Message> selectChatLog(int roomNo) {
		return messageDao.selectChatLog(roomNo);
	}

	@Override
	public int selectUnread(Message message) {
		return messageDao.selectUnread(message);
	}

	@Override
	public int updateReadcheck(Message message) {
		return messageDao.updateReadcheck(message);
	}

	@Override
	public int selectTotalUnreadCount(int uniqueNum) {
		return messageDao.selectTotalUnreadCount(uniqueNum);
	}

}
