package com.kh.runningdog.contents.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.contents.model.vo.Issue;
import com.kh.runningdog.notice.model.vo.NoticePage;

@Repository("issueDao")
public class IssueDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	public IssueDao() {
	}
	
	public void deleteIssue() {
		session.delete("issueMapper.deleteIssue");
	}
	
	public void insertIssueLatest(ArrayList<Issue> list) {
		session.insert("issueMapper.insertIssueLatest", list);
	}
	
	public void insertIssuePopular(ArrayList<Issue> list) {
		session.insert("issueMapper.insertIssuePopular", list);
	}
	
	public ArrayList<Issue> selectIssueList(NoticePage page){
		List<Issue> list = session.selectList("issueMapper.selectList", page);
		return (ArrayList<Issue>) list;
	}
	
	public ArrayList<Issue> selectMainIssueList() {
		List<Issue> list = session.selectList("issueMapper.selectMainList");
		return (ArrayList<Issue>) list;
	}


}
