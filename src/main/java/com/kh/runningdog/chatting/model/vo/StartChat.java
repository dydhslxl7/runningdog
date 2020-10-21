package com.kh.runningdog.chatting.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class StartChat implements Serializable {
	private static final long serialVersionUID = 33L;
	
	private int inviterNo;
	private int inviteeNo;
	private String inviterName;
	private String inviteeName;
	private String lastMessage;
	private Date lastDate;
	
	public StartChat() {}

	public StartChat(int inviterNo, int inviteeNo, String inviterName, String inviteeName, String lastMessage,
			Date lastDate) {
		super();
		this.inviterNo = inviterNo;
		this.inviteeNo = inviteeNo;
		this.inviterName = inviterName;
		this.inviteeName = inviteeName;
		this.lastMessage = lastMessage;
		this.lastDate = lastDate;
	}

	public int getInviterNo() {
		return inviterNo;
	}

	public void setInviterNo(int inviterNo) {
		this.inviterNo = inviterNo;
	}

	public int getInviteeNo() {
		return inviteeNo;
	}

	public void setInviteeNo(int inviteeNo) {
		this.inviteeNo = inviteeNo;
	}

	public String getInviterName() {
		return inviterName;
	}

	public void setInviterName(String inviterName) {
		this.inviterName = inviterName;
	}

	public String getInviteeName() {
		return inviteeName;
	}

	public void setInviteeName(String inviteeName) {
		this.inviteeName = inviteeName;
	}

	public String getLastMessage() {
		return lastMessage;
	}

	public void setLastMessage(String lastMessage) {
		this.lastMessage = lastMessage;
	}

	public Date getLastDate() {
		return lastDate;
	}

	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}

	@Override
	public String toString() {
		return "StartChat [inviterNo=" + inviterNo + ", inviteeNo=" + inviteeNo + ", inviterName=" + inviterName
				+ ", inviteeName=" + inviteeName + ", lastMessage=" + lastMessage + ", lastDate=" + lastDate + "]";
	}
	
}
