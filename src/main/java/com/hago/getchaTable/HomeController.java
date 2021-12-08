package com.hago.getchaTable;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;


@Controller
public class HomeController {
	final static Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired HttpSession session;
	@RequestMapping(value = "/")
	public String home() {
		return "forward:mainPath?formpath=home";
	}
	
	@RequestMapping(value = "/home")
	public String main() {
		return "home";
	}
	
	@RequestMapping(value="/mainPath")
	public String mainPath(Model model, @RequestParam String formpath) {
		model.addAttribute("formpath", formpath);
		return "common/mainPath";
	}
	
	@RequestMapping(value="/indexPath")
	public String indexPath(Model model, @RequestParam String formpath) {
		model.addAttribute("formpath", formpath);
		return "common/indexPath";
	}
	
	@RequestMapping(value="/admin")
	public String admin(Model model, @RequestParam String formpath) {
		model.addAttribute("formpath", formpath);
		return "admin/admin";
	}
	
	@RequestMapping(value="/restIndex")
	public String restIndex(Model model, @RequestParam String formpath) {
		model.addAttribute("formpath", formpath);
		return "restManagement/restIndex";
	}

	
	@RequestMapping(value="/member")
	public String member() {
		return "member/member";
	}
	
	@RequestMapping(value="/memberView")
	public String memberView() {
		return "member/memberView";
	}
	@RequestMapping(value="/memberModi")
	public String memberModi() {
		return "member/memberModi";
	}
	
	@RequestMapping(value="/deleteForm")
	public String deleteForm() {
		return "member/deleteForm";
	}
	
	@RequestMapping(value="/reservationView")
	public String reservationView() {
		return "reservation/reservationView";
	}
	
	@RequestMapping(value="/calendar")
	public String calendar() {
		return "reservation/calendar";
	}

	@RequestMapping(value = "/deleteReservation")
	public String deleteReservation(int resNum, HttpSession session) {
		return "reservation/deleteReservation";
	}
	
	@RequestMapping(value="restMain")
	public String restMain() {
		return "restManagement/restMain";
	}
	
	@RequestMapping(value="restRegister")
	public String restRegister() {
		return "restManagement/restRegisterForm";
	}
	
	@RequestMapping(value="menuRegister")
	public String menuRegister() {
		return "restManagement/menuRegisterForm";
	}

	@RequestMapping(value="restInfo")
	public String restInfo() {
		return "restManagement/restInfo";
	}
	
	@RequestMapping(value="/write")
	public String write(Model model, @RequestParam String restNum, @RequestParam String restName) {
		model.addAttribute("restNum", restNum);
		model.addAttribute("restName", restName);
		return "review/writeForm";
	}
	
	@RequestMapping(value="/review")
	public String review() {
		return "review/reviewForm";
	}
	
	@RequestMapping(value = "/update")
	public String update() {
		return "review/updateForm";
	}
	
	@RequestMapping("/login")
	public String login() {
		return "member/login";
	}

	@RequestMapping("/adminLogin")
	public String adminLoginForm() {
		return "admin/adminLoginForm";
	}

	@RequestMapping("/managerList")
	public String managerList() {
		return "admin/managerList";
	}
	
	@RequestMapping("/managerRegister")
	public String managerRegister() {
		return "admin/managerRegisterForm";
	}
	
	@RequestMapping("/reservationManagement")
	public String reservationManagement() {
		return "reservation/reservationManagement";
	}
	
	@RequestMapping("/guideBookList")
	public String guideBookList() {
		return "admin/guideBookList";
	}
	
	@RequestMapping("/restList")
	public String restList() {
		return "restaurant/restList";
	}
	
	@RequestMapping(value="/restView")
	public String restView() {
		return "restaurant/restView";
	}
	
	@RequestMapping(value = "/myCollection")
	public String myCollection() {
		return "mypage/collectionForm";
	}

}
