package com.kh.runningdog.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.kh.runningdog.member.model.vo.Member;
import com.kh.runningdog.member.model.vo.LeaveMember;
import com.kh.runningdog.member.model.vo.MemberPage;

public interface MemberService {
	
	//사용자
	Member selectUserIdCheck(Member member);
	Member selectNicknameCheck(Member member);
	Member selectPhoneCheck(Member member);
	ArrayList<Member> selectNicknameCheckList(Member member);
	
	Member selectMember(String Member);
	Member selectLogin(Member member);

	Member selectUserIdPhoneCheck(Member member);
	Member selectUserPwdCheck(Member member);
	
	int selectNicknameCount(Member member);
	int updateMemberPwd(Member member);
	int updatemyinfo(Member member);
	int deleteMember(Member member);
	int updateLastAccessDate(Member loginMember);
	
	//간편로그인, 회원가입, 소셜마이페이지
	int insertFacabookMember(Member member);
	int updateSocialMyinfo(Member member);
	
	
	
	
	//공용
	int insertMember(Member member);
	int updateMember(Member member);
	int insertLeaveMember(Member member);
	String selectRenameProfile(int memberNo);
	
	
	//관리자
	ArrayList<Member> selectMemberList(MemberPage memberPage);
	int selectMemberCount(MemberPage memberSerch);
	Member selectUserOne(int uniqueNum);
	int adminInsertMember(Member member);
	int adminUpdateMember(Member member);
	int adminLeaveMember(Member selectUser);
	int insertLeaveMemberChk(int temp);
	int leaveMemberChk(int temp);
	
	//관리자 탈퇴회원
	ArrayList<LeaveMember> selectMemberLeaveList(MemberPage memberPage);
	int selectMemberLeaveCount(MemberPage memberSerch);
	LeaveMember selectLeaveUserOne(int leaveUniqueNum);
	int deleteChk(int temp);
	
	

}
