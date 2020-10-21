package com.kh.runningdog.volunteer.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.volunteer.model.vo.Volunteer;
import com.kh.runningdog.volunteer.model.vo.VolunteerPage;
import com.kh.runningdog.volunteer.model.vo.Vreply;

@Repository("volunteerDao")
public class VolunteerDao {
	@Autowired
	private SqlSessionTemplate session;
	public VolunteerDao() {}
	
	public int selectListCount(Volunteer volunteer) {
		return session.selectOne("volunteerMapper.selectListCount", volunteer );
	}
	
	public ArrayList<Volunteer> selectList (Volunteer volunteer){
		List<Volunteer> list = session.selectList("volunteerMapper.selectList", volunteer);
		return (ArrayList<Volunteer>)list;
	}
	
	public Volunteer selectVolunteer(int volno) {
		return session.selectOne("volunteerMapper.selectVolunteer", volno);
	}
	
	public int insertVolunteer( Volunteer volunteer) {
		return session.insert("volunteerMapper.insertVolunteer", volunteer);
	}
	
	public int updateVolunteer( Volunteer volunteer) {
		return session.update("volunteerMapper.updateVolunteer", volunteer);
	}
	
	public int deleteVolunteer( Volunteer volunteer) {
		return session.delete("volunteerMapper.deleteVolunteer", volunteer);
	}
	public int deleteVolunteerAdmin(String[] checkRow) {
		return session.delete("volunteerMapper.deleteVolunteerAdmin", checkRow);
	}
	public ArrayList<Vreply> selectVreplyList(int volno){
		List<Vreply> list = session.selectList("volunteerMapper.selectVreplylist", volno);
		return (ArrayList<Vreply>)list;
	}
	public int insertVreply(Vreply vreply) {
		return session.insert("volunteerMapper.insertVreply", vreply);
	}
	public int updateVreply(Vreply vreply) {
		return session.update("volunteerMapper.updateVreply", vreply);
	}
	public int deleteVreply(int vreply_no) {
		return session.delete("volunteerMapper.deleteVreply", vreply_no);
	}
	public int getListCountVreply(int volno) {
		return session.selectOne("volunteerMapper.getListCountVreply", volno);
	}

	public int selectVolunteerPre(Volunteer volunteer) {
		return session.selectOne("volunteerMapper.selectVolunteerPre", volunteer);
	}

	public int selectVolunteerNext(Volunteer volunteer) {
		return session.selectOne("volunteerMapper.selectVolunteerNext", volunteer);
	}

	public Vreply selectVreply(int vreply_no) {
		return session.selectOne("volunteerMapper.selectVreply", vreply_no);
	}

	public int insertVreplyLevel(Vreply vreply) {
		return session.insert("volunteerMapper.insertVreplyLevel", vreply);
	}

	public int deleteVBreplyAll(int volno) {
		return session.delete("volunteerMapper.deleteVBreplyAll", volno);
	}

	public ArrayList<Volunteer> selectListMypage(Volunteer volunteer) {
		List<Volunteer> list = session.selectList("volunteerMapper.selectListMypage",volunteer);
		return (ArrayList<Volunteer>)list;
	}

	public int selectListCountMypage(Volunteer volunteer) {
		return session.selectOne("volunteerMapper.selectListCountMypage", volunteer );
	}

	public int selectVolunteerPreMypage(Volunteer volunteer) {
		return session.selectOne("volunteerMapper.selectVolunteerPreMypage", volunteer);
	}

	public int selectVolunteerNextMypage(Volunteer volunteer) {
		return session.selectOne("volunteerMapper.selectVolunteerNextMypage", volunteer);
	}
}
