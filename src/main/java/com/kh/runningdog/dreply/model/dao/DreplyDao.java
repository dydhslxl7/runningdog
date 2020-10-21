package com.kh.runningdog.dreply.model.dao;

import java.util.ArrayList;
import java.util.List;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.dreply.model.vo.Dreply;

@Repository("dreplyDao")
public class DreplyDao {
	public DreplyDao() {}

	
	@Autowired
	private SqlSessionTemplate session;


	public ArrayList<Dreply> selectList(int dNum) {
		List<Dreply> list = session.selectList("dreplyMapper.selectDreplyList",dNum);
		return (ArrayList<Dreply>)list;
	}


	public int insertDreply(Dreply dreply) {
		return session.insert("dreplyMapper.insertDreply", dreply);
	}


	public int updateDreply(Dreply dreply) {
		return session.update("dreplyMapper.updateDreply", dreply);
	}


	public int updateDreplyDel(Dreply dreply) {
		return session.update("dreplyMapper.updateDreplyDel", dreply);
	}


	public int insertDreplyLevel(Dreply dreply) {
		return session.insert("dreplyMapper.insertDreplyLevel",dreply);
	}


	public int selectListCount(int dNum) {
		return session.selectOne("dreplyMapper.selectListCount", dNum);
	}
	
	
	
	
}
