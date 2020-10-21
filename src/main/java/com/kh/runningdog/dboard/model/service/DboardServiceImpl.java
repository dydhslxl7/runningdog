package com.kh.runningdog.dboard.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.dboard.model.dao.DboardDao;
import com.kh.runningdog.dboard.model.vo.Dboard;

@Service("dboardService")
public class DboardServiceImpl implements DboardService{
	
	@Autowired
	private DboardDao dboardDao;
	
	@Override
	public ArrayList<Dboard> selectNew4(){
		return dboardDao.selectNew4();
	}
	
	@Override
	public int insertDboard(Dboard dboard) {
	    return dboardDao.insertDboard(dboard);
	}
	@Override
	public int selectListCount(Dboard dboard) {
		return dboardDao.selectListCount(dboard);
	}

	@Override
	public ArrayList<Dboard> selectList(Dboard dboard) {
		return dboardDao.selectList(dboard);
	}

	@Override
	public Dboard selectOne(int dNum) {
		return dboardDao.selectOne(dNum);
	}

	@Override
	public int updateDboard(Dboard dboard) {
		return dboardDao.updateDboard(dboard);
	}

	@Override
	public int updateDboardHide(Dboard dboard) {
		return dboardDao.updateDboardHide(dboard);
	}

	@Override
	public int updateDboardSuc(Dboard dboard) {
		return dboardDao.updateDboardSuc(dboard);
	}

	@Override
	public int selectNext(Dboard dboard) {
		return dboardDao.selectNext(dboard);
	}

	@Override
	public int selectPrev(Dboard dboard) {
		return dboardDao.selectPrev(dboard);
	}

	@Override
	public int selectAdminCount(Dboard dboard) {
		return dboardDao.selectAdminCount(dboard);
	}

	@Override
	public ArrayList<Dboard> selectAdminList(Dboard dboard) {
		return dboardDao.selectAdminList(dboard);
	}

	@Override
	public int selectAdminNext(Dboard dboard) {
		return dboardDao.selectAdminNext(dboard);
	}
	
	@Override
	public int selectAdminPrev(Dboard dboard) {
		return dboardDao.selectAdminPrev(dboard);
	}

	@Override
	public int updateAdminHide(String[] checkRow) {
		return dboardDao.updateAdminHide(checkRow);
	}

	@Override
	public void updateReadCount(int dNum) {
		dboardDao.updateReadCount(dNum);
	}

	@Override
	public ArrayList<Dboard> selectDboardNumList() {
		return dboardDao.selectDboardNumList();
	}

	@Override
	public int deleteDboard(Dboard dboard) {
		return dboardDao.deleteDboard(dboard);
	}
}
