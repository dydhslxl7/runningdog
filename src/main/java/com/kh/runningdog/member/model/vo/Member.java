package com.kh.runningdog.member.model.vo;

import java.sql.Date;
import org.springframework.stereotype.Service;

@Service
public class Member implements java.io.Serializable {
	private static final long serialVersionUID = 1111L;

	private int uniqueNum;
	private String userId;
	private String userPwd;
	private String nickname;
	private String phone;
	private String originProfile;
	private String renameProfile;
	private java.sql.Date joinDate;
	private java.sql.Date lastAccessDate;
	private String loginType;
	private String adminChk;
	private String loginLimit;

	private String newUserPwd;
	private String newUserPwd2;
	
	public Member() {}

	public Member(int uniqueNum, String userId, String userPwd, String nickname, String phone, String originProfile,
			String renameProfile, Date joinDate, Date lastAccessDate, String loginType, String adminChk,
			String loginLimit, String newUserPwd, String newUserPwd2) {
		super();
		this.uniqueNum = uniqueNum;
		this.userId = userId;
		this.userPwd = userPwd;
		this.nickname = nickname;
		this.phone = phone;
		this.originProfile = originProfile;
		this.renameProfile = renameProfile;
		this.joinDate = joinDate;
		this.lastAccessDate = lastAccessDate;
		this.loginType = loginType;
		this.adminChk = adminChk;
		this.loginLimit = loginLimit;
		this.newUserPwd = newUserPwd;
		this.newUserPwd2 = newUserPwd2;
	}

	public int getUniqueNum() {
		return uniqueNum;
	}

	public void setUniqueNum(int uniqueNum) {
		this.uniqueNum = uniqueNum;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getOriginProfile() {
		return originProfile;
	}

	public void setOriginProfile(String originProfile) {
		this.originProfile = originProfile;
	}

	public String getRenameProfile() {
		return renameProfile;
	}

	public void setRenameProfile(String renameProfile) {
		this.renameProfile = renameProfile;
	}

	public java.sql.Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(java.sql.Date joinDate) {
		this.joinDate = joinDate;
	}

	public java.sql.Date getLastAccessDate() {
		return lastAccessDate;
	}

	public void setLastAccessDate(java.sql.Date lastAccessDate) {
		this.lastAccessDate = lastAccessDate;
	}

	public String getLoginType() {
		return loginType;
	}

	public void setLoginType(String loginType) {
		this.loginType = loginType;
	}

	public String getAdminChk() {
		return adminChk;
	}

	public void setAdminChk(String adminChk) {
		this.adminChk = adminChk;
	}

	public String getLoginLimit() {
		return loginLimit;
	}

	public void setLoginLimit(String loginLimit) {
		this.loginLimit = loginLimit;
	}

	public String getNewUserPwd() {
		return newUserPwd;
	}

	public void setNewUserPwd(String newUserPwd) {
		this.newUserPwd = newUserPwd;
	}

	public String getNewUserPwd2() {
		return newUserPwd2;
	}

	public void setNewUserPwd2(String newUserPwd2) {
		this.newUserPwd2 = newUserPwd2;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Member [uniqueNum=" + uniqueNum + ", userId=" + userId + ", userPwd=" + userPwd + ", nickname="
				+ nickname + ", phone=" + phone + ", originProfile=" + originProfile + ", renameProfile="
				+ renameProfile + ", joinDate=" + joinDate + ", lastAccessDate=" + lastAccessDate + ", loginType="
				+ loginType + ", adminChk=" + adminChk + ", loginLimit=" + loginLimit + ", newUserPwd=" + newUserPwd
				+ ", newUserPwd2=" + newUserPwd2 + "]";
	}

}
