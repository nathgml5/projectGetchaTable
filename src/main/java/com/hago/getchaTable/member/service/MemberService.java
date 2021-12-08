package com.hago.getchaTable.member.service;


import java.util.Random;
import java.util.regex.Pattern;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hago.getchaTable.member.dao.IMemberDAO;
import com.hago.getchaTable.member.dto.MemberDTO;


@Service
public class MemberService implements IMemberService{
	@Autowired IMemberDAO dao;
	@Autowired HttpSession session;
	final static Logger logger = LoggerFactory.getLogger(MemberService.class);
	
	@Override
	public int memberProc(MemberDTO member,Model model) {
		String birth=member.getBirth1()+"년" + member.getBirth2()+"월"+member.getBirth3()+"일";
		member.setBirth(birth);
		logger.warn("Birth : " + member.getBirth());
		logger.warn("pw : " + member.getPw());
		logger.warn("pwCheck : " + member.getPwCheck());
		logger.warn("memberPwCheck:" + memberPwChk(member));
		if(member.getEmail()==null||member.getPw()==null||member.getEmail()==""||member.getPw()=="") {
			model.addAttribute("msg", "정보를 입력해주세요.");
			return 3;
		}
		if(memberPwChk(member) == 0) {
			model.addAttribute("msg", "비밀번호를 확인해주세요.");
			return 0;
		}
		if(dao.CheckEmail(member.getEmail()) > 0) {
			model.addAttribute("msg", "중복 아이디입니다.");
			return 1;
		}
			
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(member.getPw());
		member.setPw(securePw);
		if("m".equals(member.getGender()) || "w".equals(member.getGender()) || member.getEmail() != null)
			dao.insertMember(member);
		model.addAttribute("msg", "가입완료되었습니다.");
		return 2;
	}
	
	public int memberPwChk(MemberDTO member) {
		String pw = member.getPw();
		String pwCheck = member.getPwCheck();
		String pattern1 = "^[A-Za-z0-9]{8,40}$";	//숫자+영문, 8~40자
		String pattern2 ="^.*(?=^.{8,40}$)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$";	//영문+특수문자, 8~40자
		String pattern3 = "^.*(?=^.{8,40}$)(?=.*\\d)(?=.*[!@#$%^&+=]).*$";	//숫자+특수문자, 8~40자
		boolean match1 = Pattern.matches(pattern1, pw);
		boolean match2 = Pattern.matches(pattern2, pw);
		boolean match3 = Pattern.matches(pattern3, pw);
		if(pw.equals(pwCheck)==true) {
			logger.warn("일치 체크:"+pw.equals(pwCheck));
			return 1;
		}
			
		if(match1 == true&&match2 == true || match1==true&&match3 == true|| match3 == true&&match2 == true) {
			logger.warn("match check:"+ match1+ match2 + match3 );
			return 1;
		}
		return 0;
	}

	public int pwCheck(MemberDTO member) {
		logger.warn("service pwCheck");
		logger.warn("이메일 : " + member.getEmail());
		if(member.getPw().equals(member.getPwCheck()) == false) {
			logger.warn("pw 불일치" + member.getPw() + member.getPwCheck());
			return 0;
		}
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		MemberDTO check = dao.userPassword(member.getEmail());
		logger.warn("service pwCheck2");
		if(check != null && encoder.matches(member.getPw(), check.getPw())) {
			if(dao.memberDeleteProc(check) == 1) {
				logger.warn("dao:"+Integer.toString(dao.memberDeleteProc(check)));
				return 1;
			}
		}
		if(check == null) {
			logger.warn("check=null");
			return 2;
		}
		if(encoder.matches(member.getPw(), check.getPw())==false) {
			logger.warn("match false");
			return 2;
		}
		return 2;
	}
	
	@Override
	public int memberDeleteProc(MemberDTO member) {
		logger.warn("service");
		int result = pwCheck(member);
		String r = String.valueOf(result);
		logger.warn("result : " + r);
		return result;
	}
	

	@Override
	public void memberViewProc(String email, Model model) {
		logger.warn("email:"+email);
		MemberDTO memberView = dao.memberViewProc(email);
		if(memberView != null) {
			model.addAttribute("memberView",memberView);
		}
	}
	

	@Override
	public int memberModiProc(MemberDTO member, Model model) {
		logger.warn("pw: " + member.getPw());
		logger.warn("pwCheck: " + member.getPwCheck());
		logger.warn("birth : " + member.getBirth());
		logger.warn("gender:" + member.getGender());
		logger.warn("nickname:"+member.getNickname());
		logger.warn("email:"+member.getEmail());
		if(memberPwChk(member) == 0) {
			model.addAttribute("msg", "비밀번호를 확인해주세요.");
			logger.warn("pWChk=0");
			return 0;
		}if(member.getNickname().isEmpty()|| member.getNickname()==null) {
			model.addAttribute("msg", "내용을 입력해주세요.");
			return 3;
		}
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		String securePw = encoder.encode(member.getPw());
		member.setPw(securePw);
		if(dao.memberModiProc(member) == 1) {
			model.addAttribute("msg", "수정되었습니다.");
			return 1;
		}
		else {
			model.addAttribute("msg", "수정실패.");
			return 2;
		}
	}

	@Override
	public String CheckEmail(String email) {
		int count = dao.CheckEmail(email);
		if(count == 0)
			return "사용가능한 이메일";
		return "중복 이메일";
	}


	@Override
	public MemberDTO memberLogin(MemberDTO member){
		  return dao.memberLogin(member);
	
	}
	@Autowired MailService mailService;
	@Override
	public void sendAuth(String email) {
		String authNum = (String)session.getAttribute("authNum");
		if(authNum == null) {
			Random r = new Random();
			String randNum = String.format("%06d", r.nextInt(1000000));
			session.setAttribute("authNum", randNum);
			session.setMaxInactiveInterval(10);
			mailService.sendMail(email, "Getcha Table 이메일 인증 번호", randNum);
			logger.warn(randNum);
		}else
			logger.warn("인증번호 생성되어 있음");
	}
	
	@Override
	public int authConfirm(String authNum, Model model) {
		String sessionAuthNum = (String)session.getAttribute("authNum");
		logger.warn("sessionAuthNum: " + sessionAuthNum);
		logger.warn("authNum:"+authNum);
		if(authNum.equals(sessionAuthNum)) {
			return 1;
		}else {
			return 0;
		}
	}
}
