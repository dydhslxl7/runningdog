package com.kh.runningdog.dboard.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.dboard.model.vo.Dboard;

@Repository("dboardDao")
public class DboardDao {
	public DboardDao (){}
	
	@Autowired
	private SqlSessionTemplate session;
	

	public ArrayList<Dboard> selectNew4() {
		List<Dboard> list = session.selectList("dboardMapper.selectNew4");
		return (ArrayList<Dboard>)list;
	}


	public int insertDboard(Dboard dboard) {
		return session.insert("dboardMapper.insertDboard", dboard);
	}



	public int selectListCount(Dboard dboard) {
		return session.selectOne("dboardMapper.selectListCount", dboard);
	}


	public ArrayList<Dboard> selectList(Dboard dboard) {
		List<Dboard> list = session.selectList("dboardMapper.selectList", dboard);
		return (ArrayList<Dboard>)list;
	}
	
	public ArrayList<Dboard> selectAdminList(Dboard dboard) {
		List<Dboard> list = session.selectList("dboardMapper.selectAdminList", dboard);
		return (ArrayList<Dboard>)list;
	}

	public Dboard selectOne(int dNum) {
		return session.selectOne("dboardMapper.selectOne", dNum);
	}


	public int updateDboard(Dboard dboard) {
		return session.update("dboardMapper.updateDboard", dboard);
	}


	public int updateDboardHide(Dboard dboard) {
		return session.update("dboardMapper.updateDboardHide", dboard);
	}


	public int updateDboardSuc(Dboard dboard) {
		return session.update("dboardMapper.updateDboardSuc", dboard);
	}


	public int selectNext(Dboard dboard) {
		return session.selectOne("dboardMapper.selectNext",dboard);
	}


	public int selectPrev(Dboard dboard) {
		return session.selectOne("dboardMapper.selectPrev",dboard);
	}


	public int selectAdminCount(Dboard dboard) {
		return session.selectOne("dboardMapper.selectAdminCount", dboard);
	}


	public int selectAdminNext(Dboard dboard) {
		return session.selectOne("dboardMapper.selectAdminNext", dboard);
	}
	
	public int selectAdminPrev(Dboard dboard) {
		return session.selectOne("dboardMapper.selectAdminPrev", dboard);
	}


	public int updateAdminHide(String[] checkRow) {
		return session.update("dboardMapper.updateAdminHide", checkRow);
	}


	public void updateReadCount(int dNum) {
		session.update("dboardMapper.updateReadCount" , dNum);
	}


	public ArrayList<Dboard> selectDboardNumList() {
		List<Dboard> list = session.selectList("dboardMapper.selectDboardNumList");
		return (ArrayList<Dboard>)list;
	}


	public int deleteDboard(Dboard dboard) {
		return session.delete("dboardMapper.deleteDboard", dboard);
	}

}
