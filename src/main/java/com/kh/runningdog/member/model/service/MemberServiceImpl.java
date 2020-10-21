package com.kh.runningdog.member.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.runningdog.member.model.dao.MemberDao;
import com.kh.runningdog.member.model.vo.Member;
import com.kh.runningdog.member.model.vo.LeaveMember;
import com.kh.runningdog.member.model.vo.MemberPage;

@Service("memberService")
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDao memberDao;

	
	//사용자
	@Override
	public Member selectMember(String userId) {
		return memberDao.selectMember(userId);
	}
	
	@Override
	public Member selectLogin(Member member) {
		return memberDao.selectLogin(member);
	}
	
	@Override
	public Member selectUserIdCheck(Member member) {
		return memberDao.selectUserIdCheck(member);
	}
	
	@Override
	public Member selectNicknameCheck(Member member) {
		return memberDao.selectNicknameCheck(member);
	}
	
	@Override
	public Member selectPhoneCheck(Member member) {
		return memberDao.selectPhoneCheck(member);
	}

	@Override
	public Member selectUserIdPhoneCheck(Member member) {
		return memberDao.selectUserIdPhoneCheck(member);
	}

	@Override
	public Member selectUserPwdCheck(Member member) {
		return memberDao.selectUserPwdCheck(member);
	}
	
	@Override
	public int updateMemberPwd(Member member) {
		return memberDao.updateMemberPwd(member);
	}
	
	@Override
	public int updatemyinfo(Member member) {
		return memberDao.updatemyinfo(member);
	}
	
	@Override
	public int deleteMember(Member member) {
		return memberDao.deleteMember(member);
	}

	
	//간편로그인, 회원가입, 소셜마이페이지
	@Override
	public int insertFacabookMember(Member member) {
		return memberDao.insertFacabookMember(member);
	}

	@Override
	public int updateSocialMyinfo(Member member) {
		return memberDao.updateSocialMyinfo(member);
	}

	@Override
	public int updateLastAccessDate(Member loginMember) {
		return memberDao.updateLastAccessDate(loginMember);
	}

	
	
	
	//공용
	@Override
	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}
	
	@Override
	public int updateMember(Member member) {
		return memberDao.updateMember(member);
	}
	
	@Override
	public int insertLeaveMember(Member member) {
		return memberDao.insertLeaveMember(member);
	}
	
	
	
	
	//관리자
	@Override
	public ArrayList<Member> selectMemberList(MemberPage memberPage) {
		return memberDao.selectMemberList(memberPage);
	}
	
	@Override
	public int selectMemberCount(MemberPage memberSerch) {
		return memberDao.selectMemberCount(memberSerch);
	}
	
	@Override
	public Member selectUserOne(int uniqueNum) {
		return memberDao.selectUserOne(uniqueNum);
	}
	
	@Override
	public int adminInsertMember(Member member) {
		return memberDao.adminInsertMember(member);
	}
	
	@Override
	public int adminUpdateMember(Member member) {
		return memberDao.adminUpdateMember(member);
	}
	
	@Override
	public int adminLeaveMember(Member selectUser) {
		return memberDao.adminLeaveMember(selectUser);
	}

	@Override
	public int insertLeaveMemberChk(int temp) {
		return memberDao.insertLeaveMemberChk(temp);
	}

	@Override
	public int leaveMemberChk(int temp) {
		return memberDao.leaveMemberChk(temp);
	}
	

	@Override
	public ArrayList<LeaveMember> selectMemberLeaveList(MemberPage memberPage) {
		return memberDao.selectMemberLeaveList(memberPage);
	}

	@Override
	public int selectMemberLeaveCount(MemberPage memberSerch) {
		return memberDao.selectMemberLeaveCount(memberSerch);
	}

	@Override
	public LeaveMember selectLeaveUserOne(int leaveUniqueNum) {
		return memberDao.selectLeaveUserOne(leaveUniqueNum);
	}

	@Override
	public int deleteChk(int temp) {
		return memberDao.deleteChk(temp);
	}

	
	
	
	// 채팅에서 유저검색
	@Override
	public ArrayList<Member> selectNicknameCheckList(Member member) {
		return memberDao.selectNicknameCheckList(member);
	}

	@Override
	public int selectNicknameCount(Member member) {
		return memberDao.selectNicknameCount(member);
	}

	@Override
	public String selectRenameProfile(int memberNo) {
		return memberDao.selectRenameProfile(memberNo);
	}

}
