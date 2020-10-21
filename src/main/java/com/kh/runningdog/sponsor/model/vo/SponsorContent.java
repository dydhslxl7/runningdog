package com.kh.runningdog.sponsor.model.vo;

public class SponsorContent implements java.io.Serializable{
	private static final long serialVersionUID = 2226L;
	
	private String content;
	
	public SponsorContent() {}

	public SponsorContent(String content) {
		super();
		this.content = content;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "SponsorContent [content=" + content + "]";
	}
	
}
