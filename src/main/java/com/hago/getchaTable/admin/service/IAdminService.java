package com.hago.getchaTable.admin.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.springframework.ui.Model;

import com.hago.getchaTable.admin.dto.ManagerDTO;


public interface IAdminService {
	
	public int adminLoginProc(Model model, String adminId, String adminPw);
	
	public void adminLogoutProc(Model model);
	
	public void managerListProc(Model model, String pageNumber);
	
	public HashMap<String, String> isExistId(HashMap<String, String> map); 
	
	public int managerRegisterProc(Model model, ManagerDTO managerDto, String pwOk, String[] phoneStr1, String[] phoneStr2);

	public void deleteManagerProc(String restNum);
	
	public void guideBookListProc(Model model);
	
	// public HashMap<String, String> findRestaurant(HashMap<String, String> map);
}
