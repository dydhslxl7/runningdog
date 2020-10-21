package com.kh.runningdog.dboard.model.vo;


public class Dboard extends PageVO implements java.io.Serializable{
	private static final long serialVersionUID = 6L;
	
	private int dNum;  //글번호
	private String userId; //유저Email
	private int uniqueNum; //유저번호
	private String dWriter; //유저닉네임
	private String dTitle; //글 제목pub
	private String dContent; //글 상세설명
	private String dFindDate; //발견날짜
	private String dFindLocal; //발견장소
	private String dGender; //성별
	private String dCategory; //반려동물종류
	private String dLocal; //지역시번호
	private String dPhone; //연락처
	private String dPoint; //특징
	private String dDate; //작성일자
	private String dMdate; //수정일자
	private int dCount; //조회수
	private String mapX; //경도 X
	private String mapY; //위도 Y
	private String dCheck; //게시물 표시 여부
	private String dSuccess; //분양여부
	private String viewImage; //view 이미지
	private String listImage; //list 이미지
	
	public Dboard () {}

	public Dboard(int dNum, String userId, int uniqueNum, String dWriter, String dTitle, String dContent,
			String dFindDate, String dFindLocal, String dGender, String dCategory, String dLocal, String dPhone,
			String dPoint, String dDate, String dMdate, int dCount, String mapX, String mapY, String dCheck,
			String dSuccess, String viewImage, String listImage) {
		super();
		this.dNum = dNum;
		this.userId = userId;
		this.uniqueNum = uniqueNum;
		this.dWriter = dWriter;
		this.dTitle = dTitle;
		this.dContent = dContent;
		this.dFindDate = dFindDate;
		this.dFindLocal = dFindLocal;
		this.dGender = dGender;
		this.dCategory = dCategory;
		this.dLocal = dLocal;
		this.dPhone = dPhone;
		this.dPoint = dPoint;
		this.dDate = dDate;
		this.dMdate = dMdate;
		this.dCount = dCount;
		this.mapX = mapX;
		this.mapY = mapY;
		this.dCheck = dCheck;
		this.dSuccess = dSuccess;
		this.viewImage = viewImage;
		this.listImage = listImage;
	}

	public int getdNum() {
		return dNum;
	}

	public void setdNum(int dNum) {
		this.dNum = dNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getUniqueNum() {
		return uniqueNum;
	}

	public void setUniqueNum(int uniqueNum) {
		this.uniqueNum = uniqueNum;
	}

	public String getdWriter() {
		return dWriter;
	}

	public void setdWriter(String dWriter) {
		this.dWriter = dWriter;
	}

	public String getdTitle() {
		return dTitle;
	}

	public void setdTitle(String dTitle) {
		this.dTitle = dTitle;
	}

	public String getdContent() {
		return dContent;
	}

	public void setdContent(String dContent) {
		this.dContent = dContent;
	}

	public String getdFindDate() {
		return dFindDate;
	}

	public void setdFindDate(String dFindDate) {
		this.dFindDate = dFindDate;
	}

	public String getdFindLocal() {
		return dFindLocal;
	}

	public void setdFindLocal(String dFindLocal) {
		this.dFindLocal = dFindLocal;
	}

	public String getdGender() {
		return dGender;
	}

	public void setdGender(String dGender) {
		this.dGender = dGender;
	}

	public String getdCategory() {
		return dCategory;
	}

	public void setdCategory(String dCategory) {
		this.dCategory = dCategory;
	}

	public String getdLocal() {
		return dLocal;
	}

	public void setdLocal(String dLocal) {
		this.dLocal = dLocal;
	}

	public String getdPhone() {
		return dPhone;
	}

	public void setdPhone(String dPhone) {
		this.dPhone = dPhone;
	}

	public String getdPoint() {
		return dPoint;
	}

	public void setdPoint(String dPoint) {
		this.dPoint = dPoint;
	}

	public String getdDate() {
		return dDate;
	}

	public void setdDate(String dDate) {
		this.dDate = dDate;
	}

	public String getdMdate() {
		return dMdate;
	}

	public void setdMdate(String dMdate) {
		this.dMdate = dMdate;
	}

	public int getdCount() {
		return dCount;
	}

	public void setdCount(int dCount) {
		this.dCount = dCount;
	}

	public String getMapX() {
		return mapX;
	}

	public void setMapX(String mapX) {
		this.mapX = mapX;
	}

	public String getMapY() {
		return mapY;
	}

	public void setMapY(String mapY) {
		this.mapY = mapY;
	}

	public String getdCheck() {
		return dCheck;
	}

	public void setdCheck(String dCheck) {
		this.dCheck = dCheck;
	}

	public String getdSuccess() {
		return dSuccess;
	}

	public void setdSuccess(String dSuccess) {
		this.dSuccess = dSuccess;
	}

	public String getviewImage() {
		return viewImage;
	}

	public void setviewImage(String viewImage) {
		this.viewImage = viewImage;
	}

	public String getlistImage() {
		return listImage;
	}

	public void setlistImage(String listImage) {
		this.listImage = listImage;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Dboard [dNum=" + dNum + ", userId=" + userId + ", uniqueNum=" + uniqueNum + ", dWriter=" + dWriter
				+ ", dTitle=" + dTitle + ", dContent=" + dContent + ", dFindDate=" + dFindDate + ", dFindLocal="
				+ dFindLocal + ", dGender=" + dGender + ", dCategory=" + dCategory + ", dLocal=" + dLocal + ", dPhone="
				+ dPhone + ", dPoint=" + dPoint + ", dDate=" + dDate + ", dMdate=" + dMdate + ", dCount=" + dCount
				+ ", mapX=" + mapX + ", mapY=" + mapY + ", dCheck=" + dCheck + ", dSuccess=" + dSuccess
				+ ", viewImage=" + viewImage + ", listImage=" + listImage + "]";
	}
	
	
	
}
