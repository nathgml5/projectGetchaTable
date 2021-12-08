package com.hago.getchaTable.member.dao;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.member.dto.MemberDTO;


@Repository
public interface IMemberDAO {

	public void insertMember(MemberDTO member);

	public int CheckEmail(String email);

	public MemberDTO userPassword(String email);

	public int memberDeleteProc(MemberDTO check);
	
	//public int memberChilDelete(MemberDTO check);

	public MemberDTO memberViewProc(String email);

	public int memberModiProc(MemberDTO member);
	
	public MemberDTO memberLogin(MemberDTO member);

	public int collectProc(String email, int restNum);

	public int collChck(String email, int restNum);


}
