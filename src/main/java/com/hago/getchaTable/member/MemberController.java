package com.hago.getchaTable.member;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hago.getchaTable.member.dao.IMemberDAO;
import com.hago.getchaTable.member.dto.MemberDTO;
import com.hago.getchaTable.member.service.MemberService;


@Controller
public class MemberController {
	@Autowired IMemberDAO dao;
	@Autowired MemberService service;
	@Autowired HttpSession session;
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	

	@RequestMapping(value="loginProc", method=RequestMethod.POST)
	public String loginProc(Model model, MemberDTO member){

		String rawPw = "";
		String encodePw = "";
		MemberDTO lvo = service.memberLogin(member);	
		if(lvo != null) {			
			rawPw = member.getPw();		
			encodePw = lvo.getPw();		
			
			if(true == pwEncoder.matches(rawPw, encodePw) || rawPw.equals(encodePw)) {		
				session.setAttribute("email", lvo.getEmail());	
				session.setAttribute("nickName", lvo.getNickname()); 			
				model.addAttribute("msg", "로그인 성공");
				return "forward:/";					
			} else {
				model.addAttribute("msg", "이메일과 비밀번호를 확인하십시오.");
				return "forward:indexPath?formpath=login";					
			}			
		} else {				
			model.addAttribute("msg", "이메일과 비밀번호를 확인하십시오.");
			return "forward:indexPath?formpath=login";
		}
	}
	
    @RequestMapping(value="logout", method=RequestMethod.GET)
    
    public String logoutMainGET(HttpServletRequest request) throws Exception{
    	HttpSession session = request.getSession();
    	session.invalidate();
    	 return "forward:/";
    }
	@RequestMapping(value = "CheckEmail", produces="application/json;charset=utf-8")
	@ResponseBody
	public Map<String, String>CheckEmail(@RequestBody Map<String, String> map){
		String email = (String)map.get("email");
		String result = service.CheckEmail(email);
		map.put("msg", result);
		return map;
	}
	@RequestMapping(value = "memberProc")
	public String memberProc(MemberDTO member, Model model) {
		int result = service.memberProc(member,model);
		if(result == 0) {
			return "forward:indexPath?formpath=member";
		}else if(result == 1) {
			return "forward:indexPath?formpath=member";
		}else if(result == 3){
			return "forward:indexPath?formpath=member";
		}else {
			return "forward:indexPath?formpath=login";
		}
	}
	@RequestMapping(value = "memberViewProc")
	public String memberViewProc(String email, Model model) {
		email = (String) session.getAttribute("email");
		String sessionEmail = (String)session.getAttribute("email");
		if(email==""||email==null||sessionEmail==""||sessionEmail==null) {
			return "forward:indexPath?formpath=login";
		}
		if(sessionEmail.equals(email)) {
			service.memberViewProc(email,model);
			return "forward:indexPath?formpath=memberView";
		}
		return "forward:/";
	}
	
	@RequestMapping(value="memberModiView", method = {RequestMethod.POST, RequestMethod.GET})
	public String memberModiView(String email, Model model) {
		email = (String)session.getAttribute("email");
		logger.warn("email:"+email);
		service.memberViewProc(email,model);
		return "forward:indexPath?formpath=memberModi";
	}
	
	final static Logger logger = LoggerFactory.getLogger(MemberController.class);
	@RequestMapping(value = "memberModiProc", method = {RequestMethod.POST, RequestMethod.GET})
	public String memberModiProc(MemberDTO member, Model model, HttpSession session) {
		member.setEmail((String)session.getAttribute("email"));
		MemberDTO memberView = dao.memberViewProc(member.getEmail());
		String birth = memberView.getBirth();
		String gender=memberView.getGender();
		String mobile = memberView.getMobile();
		member.setMobile(mobile);
		member.setBirth(birth);
		member.setGender(gender);
		
		int result = service.memberModiProc(member, model);
		logger.warn("result:"+result);
		if(result == 0) {
			return "forward:memberModiView";
		}else if(result == 1) {
			return "forward:memberViewProc";
		}else if(result==3) {
			return "forward:memberModiView";
		}else {
			model.addAttribute("msg", "수정실패.");
			return "forward:memberModiView";
		}
	}
	@RequestMapping(value = "memberDeleteProc")
	public String memberDeleteProc(MemberDTO member, Model model) {
		String email = (String) session.getAttribute("email");
		member.setEmail(email);
		int result = service.memberDeleteProc(member);
		if(result == 0) {
			model.addAttribute("msg", "입력한 두 비밀번호가 일치하지 않습니다.");
			//model.addAttribute("url","/");
			return "forward:indexPath?formpath=deleteForm";
		}else if(result == 1) {
			model.addAttribute("msg","삭제되었습니다.");
			session.invalidate();
			//model.addAttribute("url","/");
			return "forward:/";
		}else {
			model.addAttribute("msg", "비밀번호가 일치하지 않습니다.");
			//model.addAttribute("url","/");
			return "forward:indexPath?formpath=deleteForm";
		}
	}
	
	@RequestMapping(value = "sendAuth")
	public Map<String, String> sendAuth(@RequestBody Map<String, String>map){
		logger.warn(map.get("email"));
		Boolean check = (Boolean)session.getAttribute("authState");
		if(check != null && check ==true) {
			map.put("msg", "인증 완료");
			return map;
		}
		service.sendAuth((String)map.get("email"));
		map.put("msg", "이메일을 확인하세요.");
		return map;
	}
	
	@ResponseBody
	@RequestMapping(value="authConfirm")
	public Map<String, String> authConfirm(Model model, @RequestBody Map<String, String>map){
		logger.warn("controller");
		Map<String, String> resultmap = new HashMap<String, String>();
		String authNum = (String)map.get("inputAuthNum");
		logger.warn("authNum:"+authNum);
		int result = service.authConfirm(authNum,model);
		logger.warn("result:"+result);
		if(result == 1) {
			resultmap.put("msg", "이메일이 인증되었습니다.");
			return resultmap;
		}else {
			resultmap.put("msg", "이메일 인증번호를 확인해주세요.");
			return resultmap;
		}
	}
}
