package com.kh.runningdog.sponsor.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import com.kh.runningdog.sponsor.model.vo.Sponsor;
import com.kh.runningdog.sponsor.model.vo.SponsorContent;
import com.kh.runningdog.sponsor.model.vo.SponsorImage;
import com.kh.runningdog.sponsor.model.vo.SponsorList;

public interface SponsorService {
	public abstract int insertSponsor(Sponsor sponsor);
	int selectListCount();
	public abstract int selectListCount(String flag);
	public abstract int selectListCount(HashMap<String, Object> key);
	ArrayList<Sponsor> selectList(int currentPage, int countList);
	public abstract Sponsor selectOne(int sNum);
	public abstract int selectSNum();
	public abstract ArrayList<Sponsor> selectThumb(String[] checkRow);
	public abstract int deleteSponsor(String[] checkRow);
	public abstract ArrayList<Sponsor> selectSearch(HashMap<String, Object> key, int currentPage, int countList);
	int updateSponsor(Sponsor sponsor);
	public abstract int updateSponsorCash(Sponsor sponsor);
	public abstract String selectContent(int sNum);
	public abstract ArrayList<Sponsor> selectProgress(int currentPage, int countList);
	public abstract ArrayList<Sponsor> selectComple(int currentPage, int countList);
	public abstract void updateSponsorComplete(int sNum);
	
	//sponsorImage
	int insertSContentImage(ArrayList<String> clist, int sNum);
	public abstract ArrayList<SponsorImage> selectImageList(String[] checkRow);
	int deleteSponsorImage(ArrayList<String> mlist, int sNum);
	public abstract ArrayList<SponsorImage> selectImageList();
	
	//sponsorList
	public abstract int insertSponsorList(SponsorList slist);
	public abstract SponsorList selectSponsorListOne(String date);
	public abstract void updateSponsorReadCount(int sNum);
	public abstract Integer selectSponsorPre(int sNum);
	public abstract Integer selectSponsorNext(int sNum);
	
}
