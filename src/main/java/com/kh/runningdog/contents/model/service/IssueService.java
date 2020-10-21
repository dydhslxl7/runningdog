package com.kh.runningdog.contents.model.service;

import java.util.ArrayList;

import com.kh.runningdog.contents.model.vo.Issue;
import com.kh.runningdog.notice.model.vo.NoticePage;

public interface IssueService {

	void deleteIssue();
	
	void insertIssueLatest(ArrayList<Issue> list);
	void insertIssuePopular(ArrayList<Issue> list);
	
	ArrayList<Issue> selectIssueList(NoticePage page);
	ArrayList<Issue> selectMainIssueList();
}
