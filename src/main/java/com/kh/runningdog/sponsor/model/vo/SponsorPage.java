package com.kh.runningdog.sponsor.model.vo;

public class SponsorPage implements java.io.Serializable{
	private static final long serialVersionUID = 2224L;
	
	private int startRow;
	private int endRow;
	
	public SponsorPage() {}

	public SponsorPage(int startRow, int endRow) {
		super();
		this.startRow = startRow;
		this.endRow = endRow;
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

	@Override
	public String toString() {
		return "SponsorPage [startRow=" + startRow + ", endRow=" + endRow + "]";
	}
	
}
