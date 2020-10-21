package com.kh.runningdog.notice.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.notice.model.dao.NoticeDao;
import com.kh.runningdog.notice.model.vo.Notice;
import com.kh.runningdog.notice.model.vo.NoticePage;

@Service("noticeService")
public class NoticeServiceImpl implements NoticeService{

	@Autowired
	private NoticeDao noticeDao;

	@Override
	public ArrayList<Notice> selectNoticeList(NoticePage noticePage) {
		return noticeDao.selectNoticeList(noticePage);
	}
	
	@Override
	public int selectNoticeListCount(NoticePage noticeSearch) {
		return noticeDao.selectNoticeListCount(noticeSearch);
	}
	
	@Override
	public Notice selectNoticeOne(int noticeNo) {
		return noticeDao.selectNoticeOne(noticeNo);
	}
	
	@Override
	public void updateNoticeReadCount(int noticeNo) {
		noticeDao.updateNoticeReadCount(noticeNo);
	}
	
	@Override
	public Integer selectNoticePre(NoticePage noticePage) {
		return noticeDao.selectNoticePre(noticePage);
	}

	@Override
	public Integer selectNoticeNext(NoticePage noticePage) {
		return noticeDao.selectNoticeNext(noticePage);
	}

	@Override
	public int insertNotice(Notice notice) {
		return noticeDao.insertNotice(notice);
	}

	@Override
	public int updateNotice(Notice notice) {
		return noticeDao.updateNotice(notice);
	}

	@Override
	public int deleteNotice(int noticeNo) {
		return noticeDao.deleteNotice(noticeNo);
	}


	@Override
	public ArrayList<Notice> selectNoticeStateList() {
		return noticeDao.selectNoticeStateList();
	}





	
	
	
}
