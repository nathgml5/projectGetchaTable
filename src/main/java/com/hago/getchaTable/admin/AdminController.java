package com.hago.getchaTable.admin;


import java.util.HashMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hago.getchaTable.admin.dto.ManagerDTO;
import com.hago.getchaTable.admin.service.AdminServiceImpl;


@Controller
public class AdminController {
	@Autowired AdminServiceImpl adminService;
	
	
	@RequestMapping(value="adminLoginProc")
	public String adminLoginProc(String adminId, String adminPw, Model model) {
		int result = adminService.adminLoginProc(model, adminId, adminPw);
		if(result == 0 || result == 1) {
			return "forward:adminLogin";
		}else if(result == 3){
			return "forward:restMainProc";
		}else {
			return "forward:managerListProc";
		}
	}

	@RequestMapping(value="adminLogoutProc")
	public String adminLogoutProc(Model model) {
		adminService.adminLogoutProc(model);
		return "redirect:main";
	}

	@RequestMapping(value="managerListProc")
	public String managerListProc(Model model, String pageNumber) {
		adminService.managerListProc(model, pageNumber);
		return "forward:indexPath?formpath=managerList";
	}
		
	@RequestMapping(value = "isExistId", produces = "application/json;charset=utf-8")
	@ResponseBody
	public HashMap<String, String> isExistId(@RequestBody HashMap<String, String> map) {
		return adminService.isExistId(map);
	}

//	
//	@RequestMapping(value = "findRestaurant", produces = "application/json;charset=utf-8")
//	@ResponseBody
//	public HashMap<String, Object> findRestaurant(@RequestBody HashMap<String, Object> map) {
//		return adminService.findRestaurant(map);
//	}
	
	@RequestMapping(value="managerRegisterProc")
	public String managerRegisterProc(Model model, ManagerDTO managerDto, String pwOk, String[] phoneStr1, String[] phoneStr2) {
		int result = adminService.managerRegisterProc(model, managerDto, pwOk, phoneStr1, phoneStr2);
		if(result == 0) {
			return "forward:indexPath?formpath=managerRegister";			
		}else {
			return "forward:managerListProc";			
		}
	}
	@RequestMapping(value="deleteManagerProc")
	public String deleteManagerProc(Model model, String restNum) {
		adminService.deleteManagerProc(restNum);
		return "forward:managerListProc";
	}
	
	@RequestMapping(value="guideBookListProc")
	public String guideBookListProc(Model model, String msg) {
		adminService.guideBookListProc(model);
		model.addAttribute("msg", msg);
		return "forward:indexPath?formpath=guideBookList";
	}
	
	@RequestMapping(value="addGuideBookProc")
	public String addGuideBookProc(String[] add) {
		String msg = adminService.addGuideBookProc(add);
		return "forward:guideBookListProc?msg="+msg;
	}
	
	
	
}
