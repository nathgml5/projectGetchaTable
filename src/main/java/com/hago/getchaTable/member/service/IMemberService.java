package com.hago.getchaTable.member.service;

import org.springframework.ui.Model;

import com.hago.getchaTable.member.dto.MemberDTO;


public interface IMemberService {
	public String CheckEmail(String email);
	public int memberProc(MemberDTO member,Model model);
	public int memberDeleteProc(MemberDTO check);
	public void memberViewProc(String email, Model model);
	public int memberModiProc(MemberDTO member, Model model);
	public MemberDTO memberLogin(MemberDTO member) throws Exception;
	public void sendAuth(String email);
	//public String authConfirm(String authNum);
	public int authConfirm(String authNum, Model model);
}
