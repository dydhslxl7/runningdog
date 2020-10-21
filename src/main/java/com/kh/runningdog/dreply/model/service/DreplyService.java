package com.kh.runningdog.dreply.model.service;

import java.util.ArrayList;

import com.kh.runningdog.dreply.model.vo.Dreply;

public interface DreplyService {

	ArrayList<Dreply> selectList(int dNum);

	int insertDreply(Dreply dreply);

	int updateDreply(Dreply dreply);

	int updateDreplyDel(Dreply dreply);

	int insertDreplyLevel(Dreply dreply);

	int seletListCount(int dNum);


}
