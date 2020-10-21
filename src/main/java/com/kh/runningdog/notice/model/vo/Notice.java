package com.kh.runningdog.notice.model.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable{

	private static final long serialVersionUID = 5111L;
	
	private int noticeNo;
	private String noticeWriter;
	private String noticeTitle; 
	private String noticeContent;
	private java.sql.Date noticeDate;
	private int noticeReadcount;
	private String noticeState;
	private String noticeOriginalFilename1;
	private String noticeRenameFilename1;
	private String noticeOriginalFilename2;
	private String noticeRenameFilename2;
	private String noticeOriginalFilename3;
	private String noticeRenameFilename3;

	public Notice() {
	}

	public Notice(int noticeNo, String noticeWriter, String noticeTitle, String noticeContent, Date noticeDate,
			int noticeReadcount, String noticeState, String noticeOriginalFilename1, String noticeRenameFilename1,
			String noticeOriginalFilename2, String noticeRenameFilename2, String noticeOriginalFilename3,
			String noticeRenameFilename3) {
		super();
		this.noticeNo = noticeNo;
		this.noticeWriter = noticeWriter;
		this.noticeTitle = noticeTitle;
		this.noticeContent = noticeContent;
		this.noticeDate = noticeDate;
		this.noticeReadcount = noticeReadcount;
		this.noticeState = noticeState;
		this.noticeOriginalFilename1 = noticeOriginalFilename1;
		this.noticeRenameFilename1 = noticeRenameFilename1;
		this.noticeOriginalFilename2 = noticeOriginalFilename2;
		this.noticeRenameFilename2 = noticeRenameFilename2;
		this.noticeOriginalFilename3 = noticeOriginalFilename3;
		this.noticeRenameFilename3 = noticeRenameFilename3;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeWriter() {
		return noticeWriter;
	}

	public void setNoticeWriter(String noticeWriter) {
		this.noticeWriter = noticeWriter;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public java.sql.Date getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(java.sql.Date noticeDate) {
		this.noticeDate = noticeDate;
	}

	public int getNoticeReadcount() {
		return noticeReadcount;
	}

	public void setNoticeReadcount(int noticeReadcount) {
		this.noticeReadcount = noticeReadcount;
	}

	public String getNoticeState() {
		return noticeState;
	}

	public void setNoticeState(String noticeState) {
		this.noticeState = noticeState;
	}

	public String getNoticeOriginalFilename1() {
		return noticeOriginalFilename1;
	}

	public void setNoticeOriginalFilename1(String noticeOriginalFilename1) {
		this.noticeOriginalFilename1 = noticeOriginalFilename1;
	}

	public String getNoticeRenameFilename1() {
		return noticeRenameFilename1;
	}

	public void setNoticeRenameFilename1(String noticeRenameFilename1) {
		this.noticeRenameFilename1 = noticeRenameFilename1;
	}

	public String getNoticeOriginalFilename2() {
		return noticeOriginalFilename2;
	}

	public void setNoticeOriginalFilename2(String noticeOriginalFilename2) {
		this.noticeOriginalFilename2 = noticeOriginalFilename2;
	}

	public String getNoticeRenameFilename2() {
		return noticeRenameFilename2;
	}

	public void setNoticeRenameFilename2(String noticeRenameFilename2) {
		this.noticeRenameFilename2 = noticeRenameFilename2;
	}

	public String getNoticeOriginalFilename3() {
		return noticeOriginalFilename3;
	}

	public void setNoticeOriginalFilename3(String noticeOriginalFilename3) {
		this.noticeOriginalFilename3 = noticeOriginalFilename3;
	}

	public String getNoticeRenameFilename3() {
		return noticeRenameFilename3;
	}

	public void setNoticeRenameFilename3(String noticeRenameFilename3) {
		this.noticeRenameFilename3 = noticeRenameFilename3;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeWriter=" + noticeWriter + ", noticeTitle=" + noticeTitle
				+ ", noticeContent=" + noticeContent + ", noticeDate=" + noticeDate + ", noticeReadcount="
				+ noticeReadcount + ", noticeState=" + noticeState + ", noticeOriginalFilename1="
				+ noticeOriginalFilename1 + ", noticeRenameFilename1=" + noticeRenameFilename1
				+ ", noticeOriginalFilename2=" + noticeOriginalFilename2 + ", noticeRenameFilename2="
				+ noticeRenameFilename2 + ", noticeOriginalFilename3=" + noticeOriginalFilename3
				+ ", noticeRenameFilename3=" + noticeRenameFilename3 + "]";
	}
	

}
//NOTICE_NO	NUMBER
//NOTICE_WRITER	VARCHAR2(30 BYTE)
//NOTICE_TITLE	VARCHAR2(100 BYTE)
//NOTICE_CONTENT	VARCHAR2(4000 BYTE)
//NOTICE_DATE	DATE
//NOTICE_READCOUNT	NUMBER
//NOTICE_STATE	VARCHAR2(10 BYTE)
//NOTICE_ORIGINAL_FILENAME1	VARCHAR2(260 BYTE)
//NOTICE_RENAME_FILENAME1	VARCHAR2(50 BYTE)
//NOTICE_ORIGINAL_FILENAME2	VARCHAR2(260 BYTE)
//NOTICE_RENAME_FILENAME2	VARCHAR2(50 BYTE)
//NOTICE_ORIGINAL_FILENAME3	VARCHAR2(260 BYTE)
//NOTICE_RENAME_FILENAME3	VARCHAR2(50 BYTE)