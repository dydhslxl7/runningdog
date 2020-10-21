package com.kh.runningdog.animal.model.service;

import java.util.ArrayList;

import com.kh.runningdog.animal.model.vo.Animal;

public interface AnimalService {
	
	int insertAnimal(Animal animal);
	
	ArrayList<Animal> selectList(Animal animal);
	
	Animal selectOne(String desertionNo);

	int selectListCount(Animal animal);

	void updateReadCount(String desertionNo);

	String selectNext(Animal animal);

	String selectPrev(Animal animal);
}
