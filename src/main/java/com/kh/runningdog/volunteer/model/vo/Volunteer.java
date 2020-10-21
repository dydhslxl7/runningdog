package com.kh.runningdog.volunteer.model.vo;

import java.sql.Date;

import com.kh.runningdog.dboard.model.vo.PageVO;

public class Volunteer extends PageVO implements java.io.Serializable{
	private static final long serialVersionUID = 8888L;
	
	private int volno;
	private String voltitle;
	private int unique_num;
	private String volwriter;
	private String volcontent;
	private java.sql.Date voldate;
	private String voltel;
	private String volterm1;
	private String volterm2;
	private String volname;
	private String volor1;
	private String volre1;
	private String volor2;
	private String volre2;
	private String volor3;
	private String volre3;
	private String volor4;
	private String volre4;
	private String voladdress;
	private String volche;
	
	public Volunteer() {}

	

	public Volunteer(int volno, String voltitle, int unique_num, String volwriter, String volcontent, Date voldate,
			String voltel, String volterm1, String volterm2, String volname, String volor1, String volre1,
			String volor2, String volre2, String volor3, String volre3, String volor4, String volre4, String voladdress,
			String volche) {
		super();
		this.volno = volno;
		this.voltitle = voltitle;
		this.unique_num = unique_num;
		this.volwriter = volwriter;
		this.volcontent = volcontent;
		this.voldate = voldate;
		this.voltel = voltel;
		this.volterm1 = volterm1;
		this.volterm2 = volterm2;
		this.volname = volname;
		this.volor1 = volor1;
		this.volre1 = volre1;
		this.volor2 = volor2;
		this.volre2 = volre2;
		this.volor3 = volor3;
		this.volre3 = volre3;
		this.volor4 = volor4;
		this.volre4 = volre4;
		this.voladdress = voladdress;
		this.volche = volche;
	}



	public int getVolno() {
		return volno;
	}

	public void setVolno(int volno) {
		this.volno = volno;
	}

	public String getVoltitle() {
		return voltitle;
	}

	public void setVoltitle(String voltitle) {
		this.voltitle = voltitle;
	}
	
	public int getUnique_num() {
		return unique_num;
	}

	public void setUnique_num(int unique_num) {
		this.unique_num = unique_num;
	}

	public String getVolwriter() {
		return volwriter;
	}

	public void setVolwriter(String volwriter) {
		this.volwriter = volwriter;
	}

	public String getVolcontent() {
		return volcontent;
	}

	public void setVolcontent(String volcontent) {
		this.volcontent = volcontent;
	}

	public java.sql.Date getVoldate() {
		return voldate;
	}

	public void setVoldate(java.sql.Date voldate) {
		this.voldate = voldate;
	}

	public String getVoltel() {
		return voltel;
	}

	public void setVoltel(String voltel) {
		this.voltel = voltel;
	}

	public String getVolterm1() {
		return volterm1;
	}

	public void setVolterm1(String volterm1) {
		this.volterm1 = volterm1;
	}

	public String getVolterm2() {
		return volterm2;
	}

	public void setVolterm2(String volterm2) {
		this.volterm2 = volterm2;
	}

	public String getVolname() {
		return volname;
	}

	public void setVolname(String volname) {
		this.volname = volname;
	}

	public String getVolor1() {
		return volor1;
	}

	public void setVolor1(String volor1) {
		this.volor1 = volor1;
	}

	public String getVolre1() {
		return volre1;
	}

	public void setVolre1(String volre1) {
		this.volre1 = volre1;
	}

	public String getVolor2() {
		return volor2;
	}

	public void setVolor2(String volor2) {
		this.volor2 = volor2;
	}

	public String getVolre2() {
		return volre2;
	}

	public void setVolre2(String volre2) {
		this.volre2 = volre2;
	}

	public String getVolor3() {
		return volor3;
	}

	public void setVolor3(String volor3) {
		this.volor3 = volor3;
	}

	public String getVolre3() {
		return volre3;
	}

	public void setVolre3(String volre3) {
		this.volre3 = volre3;
	}

	public String getVolor4() {
		return volor4;
	}

	public void setVolor4(String volor4) {
		this.volor4 = volor4;
	}

	public String getVolre4() {
		return volre4;
	}

	public void setVolre4(String volre4) {
		this.volre4 = volre4;
	}

	public String getVoladdress() {
		return voladdress;
	}

	public void setVoladdress(String voladdress) {
		this.voladdress = voladdress;
	}

	public String getVolche() {
		return volche;
	}

	public void setVolche(String volche) {
		this.volche = volche;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Volunteer [volno=" + volno + ", voltitle=" + voltitle + ", unique_num=" + unique_num + ", volwriter="
				+ volwriter + ", volcontent=" + volcontent + ", voldate=" + voldate + ", voltel=" + voltel
				+ ", volterm1=" + volterm1 + ", volterm2=" + volterm2 + ", volname=" + volname + ", volor1=" + volor1
				+ ", volre1=" + volre1 + ", volor2=" + volor2 + ", volre2=" + volre2 + ", volor3=" + volor3
				+ ", volre3=" + volre3 + ", volor4=" + volor4 + ", volre4=" + volre4 + ", voladdress=" + voladdress
				+ ", volche=" + volche + "]";
	}
	
	

}
