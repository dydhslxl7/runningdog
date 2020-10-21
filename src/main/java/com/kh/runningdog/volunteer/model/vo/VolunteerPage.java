package com.kh.runningdog.volunteer.model.vo;

public class VolunteerPage implements java.io.Serializable{
	private static final long SerialVersionUID = 8881L;
	
	private int startRow;
	private int endRow;
	private String keyword;
	private String type;

	
	public VolunteerPage() {}

	

	public VolunteerPage(int startRow, int endRow, String keyword, String type) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
		this.keyword = keyword;
		this.type = type;
	}



	public int getStartRow() {
		return startRow;
	}



	public void setStartRow(int startRow) {
		this.startRow = startRow;
	}



	public int getEndRow() {
		return endRow;
	}



	public void setEndRow(int endRow) {
		this.endRow = endRow;
	}



	public String getKeyword() {
		return keyword;
	}



	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}



	public String getType() {
		return type;
	}



	public void setType(String type) {
		this.type = type;
	}



	public static long getSerialversionuid() {
		return SerialVersionUID;
	}



	@Override
	public String toString() {
		return "VolunteerPage [startRow=" + startRow + ", endRow=" + endRow + ", keyword=" + keyword + ", type=" + type
				+ "]";
	}
	

}
