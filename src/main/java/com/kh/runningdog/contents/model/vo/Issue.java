package com.kh.runningdog.contents.model.vo;

public class Issue implements java.io.Serializable{
	
	private static final long serialVersionUID = 5876L;
	
	private String issueOrder;
	private String partnerName;
	private String partnerImg;
	private String issueTitle;
	private String issueDate;
	private int issueReadcount;
	private String issueThumbnail;
	private String issueLink;
	private String content;
	private int page;

	public Issue() {
		
	}

	public Issue(String issueOrder, String partnerName, String partnerImg, String issueTitle, String issueDate,
			int issueReadcount, String issueThumbnail, String issueLink, String content, int page) {
		super();
		this.issueOrder = issueOrder;
		this.partnerName = partnerName;
		this.partnerImg = partnerImg;
		this.issueTitle = issueTitle;
		this.issueDate = issueDate;
		this.issueReadcount = issueReadcount;
		this.issueThumbnail = issueThumbnail;
		this.issueLink = issueLink;
		this.content = content;
		this.page = page;
	}


	public String getIssueOrder() {
		return issueOrder;
	}

	public void setIssueOrder(String issueOrder) {
		this.issueOrder = issueOrder;
	}

	public String getPartnerName() {
		return partnerName;
	}

	public void setPartnerName(String partnerName) {
		this.partnerName = partnerName;
	}

	public String getPartnerImg() {
		return partnerImg;
	}

	public void setPartnerImg(String partnerImg) {
		this.partnerImg = partnerImg;
	}

	public String getIssueTitle() {
		return issueTitle;
	}

	public void setIssueTitle(String issueTitle) {
		this.issueTitle = issueTitle;
	}

	public String getIssueDate() {
		return issueDate;
	}

	public void setIssueDate(String issueDate) {
		this.issueDate = issueDate;
	}

	public int getIssueReadcount() {
		return issueReadcount;
	}

	public void setIssueReadcount(int issueReadcount) {
		this.issueReadcount = issueReadcount;
	}

	public String getIssueThumbnail() {
		return issueThumbnail;
	}

	public void setIssueThumbnail(String issueThumbnail) {
		this.issueThumbnail = issueThumbnail;
	}

	public String getIssueLink() {
		return issueLink;
	}

	public void setIssueLink(String issueLink) {
		this.issueLink = issueLink;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		this.page = page;
	}

	
	@Override
	public String toString() {
		return "Issue [issueOrder=" + issueOrder + ", partnerName=" + partnerName + ", partnerImg=" + partnerImg
				+ ", issueTitle=" + issueTitle + ", issueDate=" + issueDate + ", issueReadcount=" + issueReadcount
				+ ", issueThumbnail=" + issueThumbnail + ", issueLink=" + issueLink + ", content=" + content + ", page="
				+ page + "]";
	}


}


