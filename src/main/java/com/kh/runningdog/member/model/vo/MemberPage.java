package com.kh.runningdog.member.model.vo;

public class MemberPage {
	
	private int currentPage = 1; //기본 페이지, 현재 해당 페이지
	private int listLimit; //한 페이지당 출력할 목록 갯수 지정
	private int listCount; //전체 목록 갯수 조회
	private int maxPage;	//마지막 페이지
	private int startPage;	//해당 페이지 시작수
	private int endPage;	//해당 페이지 마지막 수
	private int startRow;	//DB에서 해당 페이지 시작되는 행
	private int endRow;		//DB에서 해당 페이지 마지막 행
	private String keyword; //검색키워드
	private String search;
	
	public MemberPage() {}
	
	
	public MemberPage(int currentPage,int listCount, int listLimit) {
		super();
		this.currentPage = currentPage;
		this.listCount = listCount;
		this.listLimit = listLimit;
		this.maxPage = (int)((double)listCount / listLimit + 0.9);	// 59/8+0.9=8.2 => 8페이지
		this.startPage = (((int)((double)currentPage / 5 + 0.9)) - 1) * 5 + 1;	// 1/8+0.9= 0*6 + 1 = 1 => 페이지 시작 수
		this.endPage = (startPage + 5 ) - 1; // (59/10) + 1 = 6 페이지 마지막 수
		if( this.maxPage < this.endPage) {
			this.endPage = this.maxPage;
		}
		this.startRow = (currentPage -1) * listLimit + 1;
		this.endRow = this.startRow + listLimit - 1;
	}
	
	public MemberPage(int currentPage, int listLimit, int listCount, int maxPage, int startPage, int endPage, int startRow, int endRow) {
		super();
		this.currentPage = currentPage;
		this.listLimit = listLimit;
		this.listCount = listCount;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.startRow = startRow;
		this.endRow = endRow;
	}
	
	public MemberPage(int currentPage, int listLimit, int listCount, int maxPage, int startPage, int endPage,
			int startRow, int endRow, String keyword, String search) {
		super();
		this.currentPage = currentPage;
		this.listLimit = listLimit;
		this.listCount = listCount;
		this.maxPage = maxPage;
		this.startPage = startPage;
		this.endPage = endPage;
		this.startRow = startRow;
		this.endRow = endRow;
		this.keyword = keyword;
		this.search = search;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getListLimit() {
		return listLimit;
	}
	public void setListLimit(int listLimit) {
		this.listLimit = listLimit;
	}
	public int getListCount() {
		return listCount;
	}
	public void setListCount(int listCount) {
		this.listCount = listCount;
	}
	public int getMaxPage() {
		return maxPage;
	}
	public void setMaxPage(int maxPage) {
		this.maxPage = maxPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
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
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}


	@Override
	public String toString() {
		return "MemberPage [currentPage=" + currentPage + ", listLimit=" + listLimit + ", listCount=" + listCount
				+ ", maxPage=" + maxPage + ", startPage=" + startPage + ", endPage=" + endPage + ", startRow="
				+ startRow + ", endRow=" + endRow + ", keyword=" + keyword + ", search=" + search + "]";
	}
	
	
	
}
