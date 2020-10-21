package com.kh.runningdog.protect.model.service;

import java.util.ArrayList;

import com.kh.runningdog.protect.model.vo.Protect;
import com.kh.runningdog.volunteer.model.vo.Volunteer;



public interface ProtectService {
	int selectListCountPro(Protect protect);
	ArrayList<Protect> selectListP(Protect protect);
	Protect selectProtect(int prono);
	int insertProtect(Protect protect);
	int updateProtect(Protect protect);
	int deleteProtect();
	int selectProtectPre(Protect protect);
	int selecProtectNext(Protect protect);

}
