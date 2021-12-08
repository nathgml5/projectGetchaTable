package com.hago.getchaTable.searchRestaurant.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.admin.dto.AdditionDTO;
import com.hago.getchaTable.restaurant.dto.MenuDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;
import com.hago.getchaTable.review.dto.ReviewCountDTO;

@Repository
public interface IRestListDAO {

	
	public ArrayList<RestaurantDTO> restTypeList(String type);

	public ArrayList<RestaurantDTO> restTypeEtcList();

	public ArrayList<RestaurantDTO> restLocationList(String type);

	public ArrayList<RestaurantDTO> restLocationEtcList();

	public ArrayList<MenuDTO> selectPriceList(int start, int end);

	public ArrayList<AdditionDTO> guideBookShowList(String guideBook);

	public ArrayList<ReviewCountDTO> reviewCountProc();

	public int restReviewCountProc(int restNum);
}
