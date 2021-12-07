package com.hago.getchaTable.restaurant.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.restaurant.dto.MenuDTO;
import com.hago.getchaTable.restaurant.dto.FacilitiesDTO;
import com.hago.getchaTable.restaurant.dto.RestImageDTO;
import com.hago.getchaTable.restaurant.dto.RestSumDTO;
import com.hago.getchaTable.restaurant.dto.OpenHourDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;
import com.hago.getchaTable.restaurant.dto.WholeMenuDTO;


@Repository
public interface IRestInfoDAO {

	public RestaurantDTO selectRestaurant(int restNum);

	public ArrayList<OpenHourDTO> selectOpenHour(int restNum);

	public ArrayList<FacilitiesDTO> selectFacilities(int restNum);

	public ArrayList<RestImageDTO> selectRestImage(int restNum);

	public ArrayList<MenuDTO> selectMenu(int restNum);

	public ArrayList<WholeMenuDTO> selectWholeMenu(int restNum);

	public ArrayList<RestSumDTO> searchProc(String keyword);
}
