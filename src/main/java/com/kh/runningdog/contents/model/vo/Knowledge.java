package com.kh.runningdog.contents.model.vo;

public class Knowledge {
	String animal;
	String keyfield;
	String keyword;
	String no;
	String readcount;
	String title;
	String link;
	int page;
	
	public Knowledge() {
		
	}
	
	
	public Knowledge(String animal, String keyfield, String keyword, String no, String readcount, String title,
			String link, int page) {
		super();
		this.animal = animal;
		this.keyfield = keyfield;
		this.keyword = keyword;
		this.no = no;
		this.readcount = readcount;
		this.title = title;
		this.link = link;
		this.page = page;
	}


	public String getAnimal() {
		return animal;
	}
	public void setAnimal(String animal) {
		this.animal = animal;
	}
	public String getKeyfield() {
		return keyfield;
	}
	public void setKeyfield(String keyfield) {
		this.keyfield = keyfield;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getNo() {
		return no;
	}
	public void setNo(String no) {
		this.no = no;
	}
	public String getReadcount() {
		return readcount;
	}
	public void setReadcount(String readcount) {
		this.readcount = readcount;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLink() {
		return link;
	}
	public void setLink(String link) {
		this.link = link;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	
	
	@Override
	public String toString() {
		return "Knowledge [animal=" + animal + ", keyfield=" + keyfield + ", keyword=" + keyword + ", no=" + no
				+ ", readcount=" + readcount + ", title=" + title + ", link=" + link + ", page=" + page + "]";
	}
	
	
}
