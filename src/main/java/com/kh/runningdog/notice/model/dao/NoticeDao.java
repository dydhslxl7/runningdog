package com.kh.runningdog.notice.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.notice.model.vo.Notice;
import com.kh.runningdog.notice.model.vo.NoticePage;

@Repository("noticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public NoticeDao() {
	}

	public ArrayList<Notice> selectNoticeList(NoticePage noticePage){
		List<Notice> list = session.selectList("noticeMapper.selectList", noticePage);
		return (ArrayList<Notice>)list;
	}
	
	public int selectNoticeListCount(NoticePage noticeSearch) {
		return session.selectOne("noticeMapper.getListCount", noticeSearch);
	}
	
	public Notice selectNoticeOne(int noticeNo) {
		return session.selectOne("noticeMapper.selectNotice", noticeNo);
	}
	
	public void updateNoticeReadCount(int noticeNo) {
		session.update("noticeMapper.updateReadCount", noticeNo);
	}

	public Integer selectNoticePre(NoticePage noticePage) {
		return session.selectOne("noticeMapper.selectNoticePre", noticePage);
	}

	public Integer selectNoticeNext(NoticePage noticePage) {
		return session.selectOne("noticeMapper.selectNoticeNext", noticePage);
	}
	
	public int insertNotice(Notice notice) {
		return session.insert("noticeMapper.insertNotice", notice);
	}
	
	public int updateNotice(Notice notice) {
		return session.update("noticeMapper.updateNotice", notice);
	}
	
	public int deleteNotice(int noticeNo) {
		return session.delete("noticeMapper.deleteNotice", noticeNo);
	}
	
	public ArrayList<Notice> selectNoticeStateList(){
		List<Notice> list = session.selectList("noticeMapper.selectStateList");
		return (ArrayList<Notice>)list;
	}
	

}
