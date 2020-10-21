package com.kh.runningdog.protect.model.dao;


import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.protect.model.vo.Protect;
import com.kh.runningdog.volunteer.model.vo.Volunteer;

@Repository("protectDao")
public class ProtectDao {
	
	@Autowired
	private SqlSessionTemplate session;
	public ProtectDao() {}
	
	public int selectListCountPro(Protect protect) {
		return session.selectOne("protectMapper.selectListCountPro", protect);
	}
	public ArrayList<Protect> selectListP(Protect protect) {
		List<Protect> list = session.selectList("protectMapper.selectListP", protect);
		return (ArrayList<Protect>)list;
	}
	public Protect selectProtect(int prono) {
		return session.selectOne("protectMapper.selectProtect", prono);
	}
	public int insertProtect(Protect protect) {
		return session.insert("protectMapper.insertProtect", protect);
	}
	public int updateProtect(Protect protect) {
		return session.update("protectMapper.updateProtect", protect);
	}
	public int deleteProtect() {
		return session.delete("protectMapper.deleteProtect");
	}
	public int selectProtectPre(Protect protect) {
		return session.selectOne("protectMapper.selectProtectPre", protect);
	}
	public int selecProtectNext(Protect protect) {
		return session.selectOne("protectMapper.selecProtectNext", protect);
	}
	

}
