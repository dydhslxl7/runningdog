package com.kh.runningdog.protect.model.vo;

import com.kh.runningdog.dboard.model.vo.PageVO;

public class Protect extends PageVO implements java.io.Serializable {
	private static final long serialVersionUID = 8885L;
	
	private int prono;
	private String proname;
	private String protel;
	private String proorgnm;
	private String protype;
	private String proaddressnew;
	private String proaddressold;
	private String prowstime;
	private String prowetime;
	
	public Protect() {}

	public Protect(int prono, String proname, String protel, String proorgnm, String protype, String proaddressnew,
			String proaddressold, String prowstime, String prowetime) {
		super();
		this.prono = prono;
		this.proname = proname;
		this.protel = protel;
		this.proorgnm = proorgnm;
		this.protype = protype;
		this.proaddressnew = proaddressnew;
		this.proaddressold = proaddressold;
		this.prowstime = prowstime;
		this.prowetime = prowetime;
	}

	public int getProno() {
		return prono;
	}

	public void setProno(int prono) {
		this.prono = prono;
	}

	public String getProname() {
		return proname;
	}

	public void setProname(String proname) {
		this.proname = proname;
	}

	public String getProtel() {
		return protel;
	}

	public void setProtel(String protel) {
		this.protel = protel;
	}

	public String getProorgnm() {
		return proorgnm;
	}

	public void setProorgnm(String proorgnm) {
		this.proorgnm = proorgnm;
	}

	public String getProtype() {
		return protype;
	}

	public void setProtype(String protype) {
		this.protype = protype;
	}

	public String getProaddressnew() {
		return proaddressnew;
	}

	public void setProaddressnew(String proaddressnew) {
		this.proaddressnew = proaddressnew;
	}

	public String getProaddressold() {
		return proaddressold;
	}

	public void setProaddressold(String proaddressold) {
		this.proaddressold = proaddressold;
	}

	public String getProwstime() {
		return prowstime;
	}

	public void setProwstime(String prowstime) {
		this.prowstime = prowstime;
	}

	public String getProwetime() {
		return prowetime;
	}

	public void setProwetime(String prowetime) {
		this.prowetime = prowetime;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Protect [prono=" + prono + ", proname=" + proname + ", protel=" + protel + ", proorgnm=" + proorgnm
				+ ", protype=" + protype + ", proaddressnew=" + proaddressnew + ", proaddressold=" + proaddressold
				+ ", prowstime=" + prowstime + ", prowetime=" + prowetime + "]";
	}
	
	

}
