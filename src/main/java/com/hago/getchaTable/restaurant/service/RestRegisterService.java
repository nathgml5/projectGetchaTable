package com.hago.getchaTable.restaurant.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hago.getchaTable.restaurant.dao.IRestInfoDAO;
import com.hago.getchaTable.restaurant.dao.IRestRegisterDAO;
import com.hago.getchaTable.restaurant.dto.FacilitiesDTO;
import com.hago.getchaTable.restaurant.dto.MenuDTO;
import com.hago.getchaTable.restaurant.dto.OpenHourDTO;
import com.hago.getchaTable.restaurant.dto.RestImageDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;
import com.hago.getchaTable.restaurant.dto.WholeMenuDTO;

@Service
public class RestRegisterService implements IRestRegisterService {
	@Autowired IRestRegisterDAO rrDao;
	@Autowired IRestInfoDAO infoDao;
	@Autowired HttpSession session;
	
	public String saveFile(int restNum, MultipartFile file, String realPath) {
		Calendar cal = Calendar.getInstance(); 	
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		String fileName = restNum+ "-"+sdf.format(cal.getTime()) + "-" + file.getOriginalFilename();
		File folder = new File(realPath);
		if (!folder.exists()) {
			folder.mkdir();
		}
		File save = new File(realPath + fileName);	//경로 지정 + 저장할 파일명 넣어줌
		try {
			file.transferTo(save);				// 그 위치에 저장해줌
		} catch (Exception e) {
			e.printStackTrace();
		} 	
		return fileName;
	}
	
	
	public void restRegisterProc(Model model, String[] facilities, String[] openHour, MultipartHttpServletRequest req)  {
		int restNum = (Integer)session.getAttribute("restNum");
		
		// 멀티파트으로 가져온 식당 정보를 테이블에 저장
		RestaurantDTO restDto = new RestaurantDTO();
		restDto.setRestNum(restNum);
		restDto.setRestName(req.getParameter("restName"));
		restDto.setRestIntro(req.getParameter("restIntro"));
		restDto.setZipcode(req.getParameter("zipcode"));
		
		String[] addrStr = req.getParameterValues("address");
		restDto.setAddress(addrStr[0] + " ," + addrStr[1]);
		restDto.setDong(req.getParameter("dong"));
		
		String[] typeStr = req.getParameterValues("type");
		if(typeStr[0].equals("direct")) 
			restDto.setType(typeStr[1]);
		else
			restDto.setType(typeStr[0]);
		restDto.setCapacity(Integer.parseInt(req.getParameter("capacity")));
		
		// 프로모션 파일 가져와서 저장
		MultipartFile file = req.getFile("promotion");
		if(file.getSize() != 0) {	
			String realPath = req.getServletContext().getRealPath(FILE_LOCATION_PROMOTION);
			String fileName = saveFile(restNum, file, realPath);
			restDto.setPromotion(fileName);   
		}else {
			restDto.setPromotion("파일 없음");
		}
		rrDao.addRestaurant(restDto);
		
		
		// 부대 시설 저장
		if(facilities != null) {
			for(String facility : facilities) {
				FacilitiesDTO facilDto = new FacilitiesDTO();
				facilDto.setRestNum(restDto.getRestNum());
				facilDto.setFacility(facility);
			rrDao.addFacilities(facilDto);
			}			
		}
		
		// 운영 시간 저장
		for(String openStr : openHour) {
			OpenHourDTO openDto = new OpenHourDTO();
			String[] open = openStr.split(" ");
			openDto.setRestNum(restDto.getRestNum());
			if(open.length == 2) {
				openDto.setWeekSelection(open[0]);
				openDto.setDaySelection("");
				openDto.setHours(open[1]);
			}else {
				openDto.setWeekSelection(open[0]);
				openDto.setDaySelection(open[1]);
				openDto.setHours(open[2]);				
			}
			rrDao.addOpenHour(openDto);
		}
		
		// 넘어온 식당 사진들 저장
		List<MultipartFile> files = req.getFiles("restImage");
		if(!files.isEmpty()) {
			int i = 1;
			for(MultipartFile f : files) {
				String contentType = f.getContentType();
				if(contentType.contains("image/jpeg") || contentType.contains("image/png") || contentType.contains("image/gif")) {
					RestImageDTO imgDto = new RestImageDTO();
					if(f.getSize() != 0) {		
						String realPath = req.getServletContext().getRealPath(FILE_LOCATION_RESTAURANT);
						String fileName = saveFile(restNum, f, realPath);
						imgDto.setRestNum(restNum);
						imgDto.setRestImage(fileName);   
					}else {
						imgDto.setRestImage("파일 없음");
					}
					rrDao.addRestImage(imgDto);
					if(f.getSize() != 0 && i==1) {
						rrDao.addRepresentImage(imgDto);
					}					
				}else {
					model.addAttribute("파일 없음");
				}
				i++;
			}
		}
	}

	
	
	public void menuRegisterProc(MultipartHttpServletRequest req) {	
		int restNum = (Integer)session.getAttribute("restNum");
		String[] menuNameStr = req.getParameterValues("menuName");
		String[] categoryStr = req.getParameterValues("category");  
		String[] unitPriceStr = req.getParameterValues("unitPrice"); 
		List<MultipartFile> files = req.getFiles("menuImage");
		if(!menuNameStr.equals(null)) {			
			int i= 0;
			for(String menuName : menuNameStr) {
				if(menuName != null) {
					MenuDTO menuDto = new MenuDTO();
					menuDto.setRestNum(restNum);
					menuDto.setCategory(categoryStr[i]);	
					menuDto.setMenuName(menuName);
					int price = Integer.parseInt(unitPriceStr[i]);
					menuDto.setUnitPrice(price);
					if(!files.get(i).isEmpty()) { 
						String realPath = req.getServletContext().getRealPath(FILE_LOCATION_MENU);
						String fileName = saveFile(restNum, files.get(i), realPath);
						menuDto.setMenuImage(fileName); 
					}else { 
						menuDto.setMenuImage("파일 없음"); 
					}
					
					rrDao.addMenu(menuDto);
					
					i++;					
				}
			}
		}
	    
	    List<MultipartFile> files2 = req.getFiles("wholeMenu");
		if(files2.size() > 1) {
			for(MultipartFile f : files2) {
				String contentType = f.getContentType();
				if(contentType.contains("image/jpeg") || contentType.contains("image/png") || contentType.contains("image/gif")) {
					WholeMenuDTO menuDto = new WholeMenuDTO();
					if(f.getSize() != 0) { 
						String realPath2 = req.getServletContext().getRealPath(FILE_LOCATION_WHOLEMENU);
						String fileName2 = saveFile(restNum, f, realPath2);
						menuDto.setRestNum(restNum);
					    menuDto.setWholeMenu(fileName2);   
					}else {
						menuDto.setWholeMenu("파일 없음");   
					}
					rrDao.addWholeMenu(menuDto);
				}
			}
		}
		
	}


	public int restMainProc(Model model) {
		int restNum = (Integer)session.getAttribute("restNum");
		RestaurantDTO restDto = infoDao.selectRestaurant(restNum);
		if(restDto.getRestName() == null || restDto.getRestName().equals("")) {
			model.addAttribute("msg", "식당 정보를 먼저 등록하세요.");
			return 0;			
		}else {
			model.addAttribute("restDto", restDto);
			return 1;
		}
	}


}
