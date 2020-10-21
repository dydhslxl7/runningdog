package com.kh.runningdog.contents.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.contents.model.dao.IssueDao;
import com.kh.runningdog.contents.model.vo.Issue;
import com.kh.runningdog.notice.model.vo.NoticePage;

@Service("issueService")
public class IssueServiceImpl implements IssueService{
	
	@Autowired
	private IssueDao issueDao;
	
	@Override
	public void deleteIssue() {
		issueDao.deleteIssue();
		
	}

	@Override
	public void insertIssueLatest(ArrayList<Issue> list) {
		issueDao.insertIssueLatest(list);
	}

	@Override
	public void insertIssuePopular(ArrayList<Issue> list) {
		issueDao.insertIssuePopular(list);
	}

	@Override
	public ArrayList<Issue> selectIssueList(NoticePage page) {
		return issueDao.selectIssueList(page);
	}

	@Override
	public ArrayList<Issue> selectMainIssueList() {
		return issueDao.selectMainIssueList();
	}


}
