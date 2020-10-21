package com.kh.runningdog.animal.model.vo;

import com.kh.runningdog.dboard.model.vo.PageVO;

public class Animal extends PageVO implements java.io.Serializable{
	private static final long serialVersionUID = 61L;
	
	
	private String age; //나이
	private String careAddr; //보호소 주소
	private String careNm; //보호소 이름
	private String careTel; //보호소 전화번호
	private String chargeNm; //담당자
	private String colorCd; //색상
	private String desertionNo; //유기번호
	private String filename; //썸네일이미지
	private String happenDt; //발견일
	private String happenPlace; //발견장소
	private String kindCd; //품종
	private String neuterYn; //중성화여부
	private String noticeEdt; //공고종료일
	private String noticeNo; //공고번호
	private String noticeSdt; //공고시작일
	private String officetel; //담당자연락처
	private String orgNm; //관할기관
	private String popfile; //클릭시 큰 이미지 출력
	private String processState; //상태
	private String sexCd; //성별
	private String specialMark; // 특징
	private String weight; //무게
	private int aCount; //조회수
	
	
	public Animal () {}


	public Animal(String age, String careAddr, String careNm, String careTel, String chargeNm, String colorCd,
			String desertionNo, String filename, String happenDt, String happenPlace, String kindCd, String neuterYn,
			String noticeEdt, String noticeNo, String noticeSdt, String officetel, String orgNm, String popfile,
			String processState, String sexCd, String specialMark, String weight, int aCount) {
		super();
		this.age = age;
		this.careAddr = careAddr;
		this.careNm = careNm;
		this.careTel = careTel;
		this.chargeNm = chargeNm;
		this.colorCd = colorCd;
		this.desertionNo = desertionNo;
		this.filename = filename;
		this.happenDt = happenDt;
		this.happenPlace = happenPlace;
		this.kindCd = kindCd;
		this.neuterYn = neuterYn;
		this.noticeEdt = noticeEdt;
		this.noticeNo = noticeNo;
		this.noticeSdt = noticeSdt;
		this.officetel = officetel;
		this.orgNm = orgNm;
		this.popfile = popfile;
		this.processState = processState;
		this.sexCd = sexCd;
		this.specialMark = specialMark;
		this.weight = weight;
		this.aCount = aCount;
	}


	public String getAge() {
		return age;
	}


	public void setAge(String age) {
		this.age = age;
	}


	public String getCareAddr() {
		return careAddr;
	}


	public void setCareAddr(String careAddr) {
		this.careAddr = careAddr;
	}


	public String getCareNm() {
		return careNm;
	}


	public void setCareNm(String careNm) {
		this.careNm = careNm;
	}


	public String getCareTel() {
		return careTel;
	}


	public void setCareTel(String careTel) {
		this.careTel = careTel;
	}


	public String getChargeNm() {
		return chargeNm;
	}


	public void setChargeNm(String chargeNm) {
		this.chargeNm = chargeNm;
	}


	public String getColorCd() {
		return colorCd;
	}


	public void setColorCd(String colorCd) {
		this.colorCd = colorCd;
	}


	public String getDesertionNo() {
		return desertionNo;
	}


	public void setDesertionNo(String desertionNo) {
		this.desertionNo = desertionNo;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}


	public String getHappenDt() {
		return happenDt;
	}


	public void setHappenDt(String happenDt) {
		this.happenDt = happenDt;
	}


	public String getHappenPlace() {
		return happenPlace;
	}


	public void setHappenPlace(String happenPlace) {
		this.happenPlace = happenPlace;
	}


	public String getKindCd() {
		return kindCd;
	}


	public void setKindCd(String kindCd) {
		this.kindCd = kindCd;
	}


	public String getNeuterYn() {
		return neuterYn;
	}


	public void setNeuterYn(String neuterYn) {
		this.neuterYn = neuterYn;
	}


	public String getNoticeEdt() {
		return noticeEdt;
	}


	public void setNoticeEdt(String noticeEdt) {
		this.noticeEdt = noticeEdt;
	}


	public String getNoticeNo() {
		return noticeNo;
	}


	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}


	public String getNoticeSdt() {
		return noticeSdt;
	}


	public void setNoticeSdt(String noticeSdt) {
		this.noticeSdt = noticeSdt;
	}


	public String getOfficetel() {
		return officetel;
	}


	public void setOfficetel(String officetel) {
		this.officetel = officetel;
	}


	public String getOrgNm() {
		return orgNm;
	}


	public void setOrgNm(String orgNm) {
		this.orgNm = orgNm;
	}


	public String getPopfile() {
		return popfile;
	}


	public void setPopfile(String popfile) {
		this.popfile = popfile;
	}


	public String getProcessState() {
		return processState;
	}


	public void setProcessState(String processState) {
		this.processState = processState;
	}


	public String getSexCd() {
		return sexCd;
	}


	public void setSexCd(String sexCd) {
		this.sexCd = sexCd;
	}


	public String getSpecialMark() {
		return specialMark;
	}


	public void setSpecialMark(String specialMark) {
		this.specialMark = specialMark;
	}


	public String getWeight() {
		return weight;
	}


	public void setWeight(String weight) {
		this.weight = weight;
	}


	public int getaCount() {
		return aCount;
	}


	public void setaCount(int aCount) {
		this.aCount = aCount;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}


	@Override
	public String toString() {
		return "Animal [age=" + age + ", careAddr=" + careAddr + ", careNm=" + careNm + ", careTel=" + careTel
				+ ", chargeNm=" + chargeNm + ", colorCd=" + colorCd + ", desertionNo=" + desertionNo + ", filename="
				+ filename + ", happenDt=" + happenDt + ", happenPlace=" + happenPlace + ", kindCd=" + kindCd
				+ ", neuterYn=" + neuterYn + ", noticeEdt=" + noticeEdt + ", noticeNo=" + noticeNo + ", noticeSdt="
				+ noticeSdt + ", officetel=" + officetel + ", orgNm=" + orgNm + ", popfile=" + popfile
				+ ", processState=" + processState + ", sexCd=" + sexCd + ", specialMark=" + specialMark + ", weight="
				+ weight + ", aCount=" + aCount + "]";
	}
	
	
	
	
}
