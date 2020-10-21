package com.kh.runningdog.protect.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.protect.model.dao.ProtectDao;
import com.kh.runningdog.protect.model.vo.Protect;

@Service("protectService")
public class ProtectServiceImpl implements ProtectService {
	
	@Autowired
	private ProtectDao protectDao;

	@Override
	public int selectListCountPro(Protect protect) {
		return protectDao.selectListCountPro(protect);
	}

	@Override
	public ArrayList<Protect> selectListP(Protect protect) {
		return protectDao.selectListP(protect);
	}

	@Override
	public Protect selectProtect(int prono) {
		return protectDao.selectProtect(prono);
	}

	@Override
	public int insertProtect(Protect protect) {
		return protectDao.insertProtect(protect);
	}

	@Override
	public int updateProtect(Protect protect) {
		return protectDao.updateProtect(protect);
	}

	@Override
	public int deleteProtect( ) {
		return protectDao.deleteProtect();
	}

	@Override
	public int selectProtectPre(Protect protect) {
		return protectDao.selectProtectPre(protect);
	}

	@Override
	public int selecProtectNext(Protect protect) {
		return protectDao.selecProtectNext(protect);
	}

}
