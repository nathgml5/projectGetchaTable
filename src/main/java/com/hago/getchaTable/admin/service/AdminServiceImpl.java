package com.hago.getchaTable.admin.service;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hago.getchaTable.admin.config.PageCon;
import com.hago.getchaTable.admin.dao.IAdminDAO;
import com.hago.getchaTable.admin.dto.AdditionDTO;
import com.hago.getchaTable.admin.dto.ManagerDTO;
import com.hago.getchaTable.restaurant.dao.IRestInfoDAO;
import com.hago.getchaTable.restaurant.dto.RestSumDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;


@Service
public class AdminServiceImpl implements IAdminService{
	@Autowired IAdminDAO adminDao;
	@Autowired IRestInfoDAO infoDao;
	@Autowired HttpSession session;
	@Autowired PageCon page;

	// properties파일에 있는 관리자 아이디와 비밀번호 가져와서 사용
	@Value("#{prop['adminId']}")	private String adminId;
	@Value("#{prop['adminPw']}")	private String adminPw;
	
	final static Logger logger = LoggerFactory.getLogger(AdminServiceImpl.class);
	
	public String checkSession(Model model) {
		if(session.getAttribute("adminId") != null) {
			if(session.getAttribute("adminId").equals(adminId)) {
				return "admin";
			}else {
				return "restManager";
			}
		}else {
			return "loginForm";
		}
	}

	@Override
	public int adminLoginProc(Model model, String id, String pw) {		
		//최고 관리자는 properties파일에 있는 값과 비교
		if(id.equals(adminId)) {
			logger.warn(adminId);
			if(pw.equals(adminPw)) {
				logger.warn(adminPw);
				session.setAttribute("adminId", adminId);
				model.addAttribute("msg", "로그인 성공.");
				return 2;
			}else{
				model.addAttribute("msg", "비밀번호가 틀렸습니다.");
				return 1;
			}
		}else {
			ManagerDTO managerDto = adminDao.selectId(id);
			if(managerDto!=null && managerDto.getRestId().equals(id)) {
				BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
				if(encoder.matches(pw, managerDto.getRestPw())) {
					session.setAttribute("adminId", id);
					session.setAttribute("restNum", managerDto.getRestNum());
					return 3;					
				}else {
					model.addAttribute("msg", "비밀번호가 틀렸습니다.");
					return 1;
				}
			}else {
				model.addAttribute("msg", "없는 아이디 입니다.");
				return 0;				
			}
			
		}
		
	}

	@Override
	public void adminLogoutProc(Model model) {
		session.invalidate();
	}

	@Override
	public void managerListProc(Model model, String pageNumber) {

		ArrayList<RestaurantDTO> restList= adminDao.restList();
		if(pageNumber != null) {
			page.setPageNumber(pageNumber);
		}
		if(restList != null) {
			page.setRecord(restList.size());
		}
		model.addAttribute("restList", restList);
		model.addAttribute("page", page);
		
	}

	public HashMap<String, String> isExistId(HashMap<String, String> map) {
		ManagerDTO managerDto = adminDao.selectId(map.get("id"));
		if(managerDto == null) {
			map.put("id", map.get("id"));
			map.put("idMsg", "사용 가능한 아이디입니다.");
			return map;
		}else {
			map.put("id", map.get("id"));
			map.put("idMsg", "중복된 아이디입니다.");
			return map;
		}
		
	}
	

	

	public int managerRegisterProc(Model model, ManagerDTO managerDto, String pwOk, String[] phoneStr1, String[] phoneStr2) {
		
		if(managerDto.getRestId()==null || managerDto.getRestPw()==null || pwOk == null) {
			model.addAttribute("msg", "입력값 확인하십시오.");
			return 0;
		}else if(!managerDto.getRestPw().equals(pwOk)) {
			model.addAttribute("msg", "입력된 비밀번호가 일치하지 않습니다.");
			return 0;
		}else {
			if(!phoneStr1[1].equals("") && !phoneStr1[2].equals("")) {
				managerDto.setPhone1(phoneStr1[0] +"-"+ phoneStr1[1] +"-"+ phoneStr1[2]);				
			}else {
				managerDto.setPhone1("");
			}
			if(!phoneStr2[1].equals("") && !phoneStr2[2].equals("")) {
				managerDto.setPhone2(phoneStr2[0] +"-"+ phoneStr2[1] +"-"+ phoneStr2[2]);				
			}else {
				managerDto.setPhone2("");
			}
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			String securePw = encoder.encode(managerDto.getRestPw());
			managerDto.setRestPw(securePw);
			adminDao.addManager(managerDto);
			adminDao.addRestNum(managerDto.getRestId());
			model.addAttribute("msg", "식당 관리자가 등록되었습니다.");
			return 1;
		}
		
	}

	@Override
	public void deleteManagerProc(String restNum) {
		int num = Integer.parseInt(restNum);
		adminDao.deleteRestaurant(num);
		System.out.println("식당 삭제");
		adminDao.deleteManager(num);
		System.out.println("매니저 삭제");
	}

	@Override
	public void guideBookListProc(Model model) {
		ArrayList<AdditionDTO> guideList = adminDao.guideBookList();
		for(AdditionDTO guide : guideList) {
			RestaurantDTO rest = infoDao.selectRestaurant(guide.getRestNum());
			guide.setRestName(rest.getRestName());
			guide.setDong(rest.getDong());
			guide.setAvgPoint(rest.getAvgPoint());
		}
		int size = guideList.size();
		model.addAttribute("guideList", guideList);
		model.addAttribute("max", guideList.get(0).getGuideBook());
		model.addAttribute("min", guideList.get(size-1).getGuideBook());
		
	}

	public String addGuideBookProc(String[] add) {
		LocalDate now = LocalDate.now();
		String guideBook = Integer.toString(now.getYear());
		for(String restStr : add) {
			int restNum = Integer.parseInt(restStr); 
			AdditionDTO addit = adminDao.selectRestNum(restNum, guideBook);
			if(addit == null) {
				adminDao.addGuide(restNum, guideBook);
			}
		}
		return "추가되었습니다.";
		
	}

	public HashMap<String, Object> findRestaurant(HashMap<String, Object> map) {
		String key = (String)map.get("key");
		ArrayList<RestSumDTO> restList = infoDao.searchProc(key);
		if(restList.isEmpty()) {
			String resultMsg = "검색 결과가 없습니다.";
			map.put("resultMsg", resultMsg);
			return map;
		}else {
			map.put("restList", restList);	
			return map;
		}
	}

	
	

	
	
	
}
