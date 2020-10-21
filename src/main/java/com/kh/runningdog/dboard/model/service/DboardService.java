package com.kh.runningdog.dboard.model.service;

import java.util.ArrayList;

import com.kh.runningdog.dboard.model.vo.Dboard;

public interface DboardService {
	ArrayList<Dboard> selectNew4();

	int insertDboard(Dboard dboard);

	int selectListCount(Dboard dboard);
	
	int selectAdminCount(Dboard dboard);
	
	ArrayList<Dboard> selectList(Dboard dboard);

	ArrayList<Dboard> selectAdminList(Dboard dboard);
	
	Dboard selectOne(int dNum);

	int updateDboard(Dboard dboard);

	int updateDboardHide(Dboard dboard);

	int updateDboardSuc(Dboard dboard);

	int selectPrev(Dboard dboard);

	int selectNext(Dboard dboard);

	int selectAdminNext(Dboard dboard);
	
	int selectAdminPrev(Dboard dboard);

	int updateAdminHide(String[] checkRow);

	void updateReadCount(int dNum);

	ArrayList<Dboard> selectDboardNumList();

	int deleteDboard(Dboard dboard);
	
}
