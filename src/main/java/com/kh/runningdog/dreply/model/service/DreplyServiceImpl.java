package com.kh.runningdog.dreply.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.dreply.model.dao.DreplyDao;
import com.kh.runningdog.dreply.model.vo.Dreply;

@Service("dreplyService")
public class DreplyServiceImpl implements DreplyService {

	@Autowired
	private DreplyDao dreplyDao;

	@Override
	public ArrayList<Dreply> selectList(int  dNum) {
		return dreplyDao.selectList(dNum);
	}

	@Override
	public int insertDreply(Dreply dreply) {
		return dreplyDao.insertDreply(dreply);
	}

	@Override
	public int updateDreply(Dreply dreply) {
		return dreplyDao.updateDreply(dreply);
	}

	@Override
	public int updateDreplyDel(Dreply dreply) {
		return dreplyDao.updateDreplyDel(dreply);
	}

	@Override
	public int insertDreplyLevel(Dreply dreply) {
		return dreplyDao.insertDreplyLevel(dreply);
	}

	@Override
	public int seletListCount(int dNum) {
		return dreplyDao.selectListCount(dNum);
	}
	
	

}
