package com.kh.runningdog.animal.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.runningdog.animal.model.vo.Animal;


@Repository("animalDao")
public class AnimalDao {
	
	public AnimalDao() {}
	
	@Autowired
	private SqlSessionTemplate session;
	
	public int insertAnimal(Animal animal) {
		return session.insert("animalMapper.insertAnimal", animal);
	}

	public ArrayList<Animal> selectList(Animal animal) {
		List<Animal> list = session.selectList("animalMapper.selectList", animal);
		return (ArrayList<Animal>)list;
	}

	public Animal selectOne(String desertionNo) {
		return session.selectOne("animalMapper.selectOne" , desertionNo);
	}

	public Animal selectAnimal(String desertionNo) {
		return session.selectOne("animalMapper.selectOne", desertionNo);
	}

	public int selectListCount(Animal animal) {
		return session.selectOne("animalMapper.selectListCount", animal);
	}

	public void updateReadCount(String desertionNo) {
		session.update("animalMapper.updateReadCount",desertionNo);
		
	}

	public String selectNext(Animal animal) {
		return session.selectOne("animalMapper.selectNext", animal);
	}

	public String selectPrev(Animal animal) {
		return session.selectOne("animalMapper.selectPrev", animal);
	}

}
