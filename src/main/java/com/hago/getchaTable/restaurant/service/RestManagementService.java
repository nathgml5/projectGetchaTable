package com.hago.getchaTable.restaurant.service;


import java.io.File;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hago.getchaTable.restaurant.dao.IRestInfoDAO;
import com.hago.getchaTable.restaurant.dao.IRestModifyDAO;
import com.hago.getchaTable.restaurant.dao.IRestRegisterDAO;
import com.hago.getchaTable.restaurant.dto.FacilitiesDTO;
import com.hago.getchaTable.restaurant.dto.MenuDTO;
import com.hago.getchaTable.restaurant.dto.OpenHourDTO;
import com.hago.getchaTable.restaurant.dto.RestImageDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;
import com.hago.getchaTable.restaurant.dto.WholeMenuDTO;


@Service
public class RestManagementService implements IRestManagementService {
	@Autowired HttpSession session;
	@Autowired IRestInfoDAO infoDao;
	@Autowired IRestModifyDAO modifyDao;
	@Autowired IRestRegisterDAO registerDao;

	@Override
	public void restInfo(Model model) {
		int restNum = (Integer)session.getAttribute("restNum");
		// 식당 정보 가져오기
		RestaurantDTO rest = infoDao.selectRestaurant(restNum);
		rest.setRatePoint(Double.parseDouble(rest.getAvgPoint()));
		// 영업시간 가져오기
		ArrayList<OpenHourDTO> openList = infoDao.selectOpenHour(restNum);
		// 부대시설 가져오기
		ArrayList<FacilitiesDTO> facilityList = infoDao.selectFacilities(restNum);  
		// 식당 사진 가져오기
		ArrayList<RestImageDTO> restImgList = infoDao.selectRestImage(restNum);
		// 메뉴 가져오기
		ArrayList<MenuDTO> menuList = infoDao.selectMenu(restNum);
		// 메뉴판 가져오기
		ArrayList<WholeMenuDTO> wholeMenuList = infoDao.selectWholeMenu(restNum);
		
		model.addAttribute("rest", rest);
		model.addAttribute("openList", openList);
		model.addAttribute("facilityList", facilityList);
		model.addAttribute("restImgList", restImgList);
		model.addAttribute("menuList", menuList);
		DecimalFormat formatter = new DecimalFormat("###,###");
		for(MenuDTO menu : menuList) {
			menu.setPriceStr(formatter.format(menu.getUnitPrice())+" 원");
		}
		model.addAttribute("wholeMenuList", wholeMenuList);
	}

		
	// 파일 삭제 메소드
	public void deleteFile(String location) {
		File oldFile= new File(location);
		if(oldFile.exists())
			oldFile.delete();
	}
	
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
	
	@Override
	public void modifyBasicInfoProc(MultipartHttpServletRequest req) {
		int restNum = (Integer)session.getAttribute("restNum");
		/*기본 정보 수정*/
		RestaurantDTO restDto = new RestaurantDTO();
		restDto.setRestNum(restNum);
		restDto.setRestName(req.getParameter("restName"));
		restDto.setRestIntro(req.getParameter("restIntro"));
		String[] typeStr = req.getParameterValues("type");
		if(typeStr != null) {
			if(typeStr[0].equals("direct")) 
				restDto.setType(typeStr[1]);
			else
				restDto.setType(typeStr[0]);			
		}
		modifyDao.modifyBasicInfo(restDto);
		
		/*식당 사진 수정 : 전체 삭제 후 다시 추가하는 방식*/
		List<MultipartFile> files = req.getFiles("restImage");
		
		if(files != null) {
			ArrayList<RestImageDTO> restImgList = infoDao.selectRestImage(restNum);
			for(RestImageDTO delImgDto : restImgList) {
				String realPath = req.getServletContext().getRealPath(FILE_LOCATION_RESTAURANT+delImgDto.getRestImage());
				deleteFile(realPath);
			}
			modifyDao.deleteRestImage(restNum);
			
			
			int i = 1;				
			for(MultipartFile f : files) {
				RestImageDTO imgDto = new RestImageDTO();
				imgDto.setRestNum(restNum);
				if(f.getSize() != 0) {
					String realPath = req.getServletContext().getRealPath(FILE_LOCATION_RESTAURANT);
					String fileName = saveFile(restNum, f, realPath);
					imgDto.setRestImage(fileName);   	
				}
				registerDao.addRestImage(imgDto);
				if(i==1) {
					registerDao.addRepresentImage(imgDto);
				}
				i++;
			}
		}		
	}

	
	public void modifyDetailProc(RestaurantDTO restDto, String[] address, String[] facilities, String[] openHour ) {
		restDto.setRestNum((Integer)session.getAttribute("restNum"));
		if(!address[0].equals("")) {
			restDto.setAddress(address[0] +","+ address[1]);			
		}
		modifyDao.modifyDetail(restDto);
		
		//부대시설 삭제 후 추가
		if(facilities != null) {
			modifyDao.deleteFacilities(restDto.getRestNum());
			for(String facility : facilities) {
				FacilitiesDTO facilDto = new FacilitiesDTO();
				facilDto.setRestNum(restDto.getRestNum());
				facilDto.setFacility(facility);
				registerDao.addFacilities(facilDto);
			}			
		}
		
		// 영업시간 전체 삭제 후 추가
		if(openHour != null) {
			modifyDao.deleteOpenHour(restDto.getRestNum());
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
				registerDao.addOpenHour(openDto);
			}
		}
		
	}

	public void modifyPromotionProc(MultipartHttpServletRequest req) {
		int restNum = (Integer)session.getAttribute("restNum");
		RestaurantDTO restDto = infoDao.selectRestaurant(restNum);
		if(restDto.getPromotion() != null) {
			String realPath = req.getServletContext().getRealPath(FILE_LOCATION_PROMOTION+restDto.getPromotion());
			deleteFile(realPath);
			
		}

		MultipartFile file = req.getFile("promotion");
		if(file.getSize() != 0) {	
			String realPath = req.getServletContext().getRealPath(FILE_LOCATION_PROMOTION);
			String fileName = saveFile(restNum, file, realPath);
			restDto.setPromotion(fileName);   
		}else {
			restDto.setPromotion("파일 없음");
		}
		modifyDao.modifyPromotion(restDto);		
	}

	
	
	public void deletePromotionProc(HttpServletRequest req) {
		int restNum = (Integer)session.getAttribute("restNum");
		RestaurantDTO restDto = infoDao.selectRestaurant(restNum);
		String promotion = restDto.getPromotion();
		if(promotion != null) {
			String realPath = req.getServletContext().getRealPath(FILE_LOCATION_PROMOTION+promotion);
			deleteFile(realPath);
			restDto.setPromotion("파일 없음");
		}
		modifyDao.modifyPromotion(restDto);
	}

	
	
	public void menuModifyProc(MultipartHttpServletRequest req) {
	    int restNum = (Integer)session.getAttribute("restNum");
		List<MultipartFile> wholeMenuFiles = req.getFiles("wholeMenu");
		if(wholeMenuFiles.size()>1) {
			ArrayList<WholeMenuDTO> wholeMenuList = infoDao.selectWholeMenu(restNum);
			if(wholeMenuList != null) {
				for(WholeMenuDTO wholeMenuDto : wholeMenuList) {
					String realPath = req.getServletContext().getRealPath(FILE_LOCATION_WHOLEMENU+wholeMenuDto.getWholeMenu());
					deleteFile(realPath);
				}				
			}
			modifyDao.deleteWholeMenu(restNum);
					
			for(MultipartFile f : wholeMenuFiles) {
				WholeMenuDTO menuDto = new WholeMenuDTO();
				menuDto.setRestNum(restNum);
				if(f.getSize() != 0) {
					String realPath = req.getServletContext().getRealPath(FILE_LOCATION_WHOLEMENU);
					String fileName = saveFile(restNum, f, realPath);
					menuDto.setWholeMenu(fileName);   	
				}else {
					menuDto.setWholeMenu("파일 없음");
				}
				registerDao.addWholeMenu(menuDto);
			}
		}
		
		
		String[] categoryStr = req.getParameterValues("category"); 
		String[] menuNameStr = req.getParameterValues("menuName");  
		String[] unitPriceStr = req.getParameterValues("unitPrice"); 
		List<MultipartFile> menuFiles = req.getFiles("menuImage");
		ArrayList<MenuDTO>menuList = infoDao.selectMenu(restNum);
		if(menuList != null) {
			for(MenuDTO menuDto : menuList) {
				String realPath = req.getServletContext().getRealPath(FILE_LOCATION_MENU+menuDto.getMenuImage());
				deleteFile(realPath);
			}				
		}
		modifyDao.deleteMenu(restNum);
		
		int i= 0;
		if(menuNameStr != null) {
			for(String menuName : menuNameStr) {
				MenuDTO menuDto = new MenuDTO();
				menuDto.setRestNum((Integer)session.getAttribute("restNum"));
				menuDto.setCategory(categoryStr[i]);	
				menuDto.setMenuName(menuName);
				menuDto.setUnitPrice(Integer.parseInt(unitPriceStr[i]));
				if(!menuFiles.get(i).isEmpty()) { 
					String realPath = req.getServletContext().getRealPath(FILE_LOCATION_MENU);
					String fileName = saveFile(restNum, menuFiles.get(i), realPath);
					menuDto.setMenuImage(fileName); 
				}else { 
					menuDto.setMenuImage("파일 없음"); 
				}
				registerDao.addMenu(menuDto);
				
				i++;
			}				
		}
	}

	public void deleteWholeMenuProc() {
		int restNum = (Integer)session.getAttribute("restNum");
		modifyDao.deleteWholeMenu(restNum);
		
	}

}
