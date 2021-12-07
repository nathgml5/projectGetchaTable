package com.hago.getchaTable.restaurant.service;

import javax.servlet.http.HttpServletRequest;

import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hago.getchaTable.restaurant.dto.RestaurantDTO;


public interface IRestManagementService {
	String FILE_LOCATION_PROMOTION = "/upload/promotion/";
	String FILE_LOCATION_RESTAURANT = "/upload/restaurant/";
	String FILE_LOCATION_MENU = "/upload/menu/";
	String FILE_LOCATION_WHOLEMENU = "/upload/wholeMenu/";
	
	public void restInfo(Model model);
	
	public void modifyBasicInfoProc(MultipartHttpServletRequest req);
	
	public void modifyDetailProc(RestaurantDTO restDto, String[] address, String[] facilities, String[] openHour);
	
	public void modifyPromotionProc(MultipartHttpServletRequest req);
	
	public void deletePromotionProc(HttpServletRequest req);
	
	public void menuModifyProc(MultipartHttpServletRequest req);
	
	public void deleteWholeMenuProc();
}
