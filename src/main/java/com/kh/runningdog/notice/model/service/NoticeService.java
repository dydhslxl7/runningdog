package com.kh.runningdog.notice.model.service;

import java.util.ArrayList;

import com.kh.runningdog.notice.model.vo.Notice;
import com.kh.runningdog.notice.model.vo.NoticePage;

public interface NoticeService {
	ArrayList<Notice> selectNoticeList(NoticePage noticePage);
	int selectNoticeListCount(NoticePage noticeSearch);
	Notice selectNoticeOne(int noticeNo);
	void updateNoticeReadCount(int noticeNo);
	Integer selectNoticePre(NoticePage noticePage);
	Integer selectNoticeNext(NoticePage noticePage);
	int insertNotice(Notice notice);
	int updateNotice(Notice notice);
	int deleteNotice(int noticeNo);
	ArrayList<Notice> selectNoticeStateList();

	
}
