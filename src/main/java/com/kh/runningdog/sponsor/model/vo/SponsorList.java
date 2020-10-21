package com.kh.runningdog.sponsor.model.vo;

public class SponsorList implements java.io.Serializable{
	private static final long serialVersionUID = 2225L;
	
	private String spDate;
	private String spName;
	private String spEmail;
	private String spPhone;
	private String spSnumber;
	private int spCash;
	private String spEch;
	private String spPch;
	private String spWay;
	private String spBankbook;
	private int spRealCash;
	private int sNum;
	
	public SponsorList() {}

	public SponsorList(String spDate, String spName, String spEmail, String spPhone, String spSnumber, int spCash,
			String spEch, String spPch, String spWay, String spBankbook, int spRealCash, int sNum) {
		super();
		this.spDate = spDate;
		this.spName = spName;
		this.spEmail = spEmail;
		this.spPhone = spPhone;
		this.spSnumber = spSnumber;
		this.spCash = spCash;
		this.spEch = spEch;
		this.spPch = spPch;
		this.spWay = spWay;
		this.spBankbook = spBankbook;
		this.spRealCash = spRealCash;
		this.sNum = sNum;
	}

	public String getSpDate() {
		return spDate;
	}

	public void setSpDate(String spDate) {
		this.spDate = spDate;
	}

	public String getSpName() {
		return spName;
	}

	public void setSpName(String spName) {
		this.spName = spName;
	}

	public String getSpEmail() {
		return spEmail;
	}

	public void setSpEmail(String spEmail) {
		this.spEmail = spEmail;
	}

	public String getSpPhone() {
		return spPhone;
	}

	public void setSpPhone(String spPhone) {
		this.spPhone = spPhone;
	}

	public String getSpSnumber() {
		return spSnumber;
	}

	public void setSpSnumber(String spSnumber) {
		this.spSnumber = spSnumber;
	}

	public int getSpCash() {
		return spCash;
	}

	public void setSpCash(int spCash) {
		this.spCash = spCash;
	}

	public String getSpEch() {
		return spEch;
	}

	public void setSpEch(String spEch) {
		this.spEch = spEch;
	}

	public String getSpPch() {
		return spPch;
	}

	public void setSpPch(String spPch) {
		this.spPch = spPch;
	}

	public String getSpWay() {
		return spWay;
	}

	public void setSpWay(String spWay) {
		this.spWay = spWay;
	}

	public String getSpBankbook() {
		return spBankbook;
	}

	public void setSpBankbook(String spBankbook) {
		this.spBankbook = spBankbook;
	}

	public int getSpRealCash() {
		return spRealCash;
	}

	public void setSpRealCash(int spRealCash) {
		this.spRealCash = spRealCash;
	}

	public int getsNum() {
		return sNum;
	}

	public void setsNum(int sNum) {
		this.sNum = sNum;
	}

	@Override
	public String toString() {
		return "SponsorList [spDate=" + spDate + ", spName=" + spName + ", spEmail=" + spEmail + ", spPhone=" + spPhone
				+ ", spSnumber=" + spSnumber + ", spCash=" + spCash + ", spEch=" + spEch + ", spPch=" + spPch
				+ ", spWay=" + spWay + ", spBankbook=" + spBankbook + ", spRealCash=" + spRealCash + ", sNum=" + sNum
				+ "]";
	}
	
}
