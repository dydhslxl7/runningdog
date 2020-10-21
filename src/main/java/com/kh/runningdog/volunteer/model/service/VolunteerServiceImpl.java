package com.kh.runningdog.volunteer.model.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.volunteer.model.dao.VolunteerDao;
import com.kh.runningdog.volunteer.model.vo.Volunteer;
import com.kh.runningdog.volunteer.model.vo.Vreply;

@Service("volunteerService")
public class VolunteerServiceImpl implements VolunteerService{
	@Autowired
	private VolunteerDao volunteerDao;

	@Override
	public int selectListCount(Volunteer volunteer) {
		return volunteerDao.selectListCount(volunteer);
	}

	@Override
	public ArrayList<Volunteer> selectList(Volunteer volunteer) {
		return volunteerDao.selectList(volunteer);
	}

	@Override
	public Volunteer selectVolunteer(int volno) {
		return volunteerDao.selectVolunteer(volno);
	}

	@Override
	public int insertVolunteer(Volunteer volunteer) {
		return volunteerDao.insertVolunteer(volunteer);
	}

	@Override
	public int updateVolunteer(Volunteer volunteer) {
		return volunteerDao.updateVolunteer(volunteer);
	}

	@Override
	public int deleteVolunteer(Volunteer volunteer) {
		return volunteerDao.deleteVolunteer(volunteer);
	}
	
	@Override
	public int getListCountVreply(int volno) {
		return volunteerDao.getListCountVreply(volno);
	}

	@Override
	public ArrayList<Vreply> selectVreplyList(int volno) {
		return volunteerDao.selectVreplyList(volno);
	}

	@Override
	public int insertVreply(Vreply vreply) {
		return volunteerDao.insertVreply(vreply);
	}

	@Override
	public int updateVreply(Vreply vreply) {
		return volunteerDao.updateVreply(vreply);
	}

	@Override
	public int deleteVreply(int vreply_no) {
		return volunteerDao.deleteVreply(vreply_no);
	}

	@Override
	public int selectVolunteerPre(Volunteer volunteer) {
		return volunteerDao.selectVolunteerPre(volunteer);
	}

	@Override
	public int selectVolunteerNext(Volunteer volunteer) {
		return volunteerDao.selectVolunteerNext(volunteer);
	}

	@Override
	public int deleteVolunteerAdmin(String[] checkRow) {
		return volunteerDao.deleteVolunteerAdmin(checkRow);
	}

	@Override
	public Vreply selectVreply(int vreply_no) {
		return volunteerDao.selectVreply(vreply_no);
	}

	@Override
	public int insertVreplyLevel(Vreply vreply) {
		return volunteerDao.insertVreplyLevel(vreply);
	}

	@Override
	public int deleteVBreplyAll(int volno) {
		return volunteerDao.deleteVBreplyAll(volno);
	}

	@Override
	public ArrayList<Volunteer> selectListMypage(Volunteer volunteer) {
		return volunteerDao.selectListMypage(volunteer);
	}

	@Override
	public int selectListCountMypage(Volunteer volunteer) {
		return volunteerDao.selectListCountMypage(volunteer);
	}

	@Override
	public int selectVolunteerPreMypage(Volunteer volunteer) {
		return volunteerDao.selectVolunteerPreMypage(volunteer);
	}

	@Override
	public int selectVolunteerNextMypage(Volunteer volunteer) {
		return volunteerDao.selectVolunteerNextMypage(volunteer);
	}

	
	
	

}
