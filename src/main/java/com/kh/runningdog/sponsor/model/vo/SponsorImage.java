package com.kh.runningdog.sponsor.model.vo;

public class SponsorImage implements java.io.Serializable{
	private static final long serialVersionUID = 2223L;
	
	private int siNum;
	private String siName;
	private int sNum;
	
	public SponsorImage() {}

	public SponsorImage(int siNum, String siName, int sNum) {
		super();
		this.siNum = siNum;
		this.siName = siName;
		this.sNum = sNum;
	}

	public int getSiNum() {
		return siNum;
	}

	public void setSiNum(int siNum) {
		this.siNum = siNum;
	}

	public String getSiName() {
		return siName;
	}

	public void setSiName(String siName) {
		this.siName = siName;
	}

	public int getsNum() {
		return sNum;
	}

	public void setsNum(int sNum) {
		this.sNum = sNum;
	}

	@Override
	public String toString() {
		return "SponsorImage [siNum=" + siNum + ", siName=" + siName + ", sNum=" + sNum + "]";
	}
	
}
