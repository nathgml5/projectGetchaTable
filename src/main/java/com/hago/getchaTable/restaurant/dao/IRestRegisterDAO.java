package com.hago.getchaTable.restaurant.dao;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.restaurant.dto.MenuDTO;
import com.hago.getchaTable.restaurant.dto.FacilitiesDTO;
import com.hago.getchaTable.restaurant.dto.OpenHourDTO;
import com.hago.getchaTable.restaurant.dto.RestImageDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;
import com.hago.getchaTable.restaurant.dto.WholeMenuDTO;


@Repository
public interface IRestRegisterDAO {
	public void addRestaurant(RestaurantDTO restDto);

	public void addFacilities(FacilitiesDTO facilDto);

	public void addOpenHour(OpenHourDTO openDto);

	public void addRestImage(RestImageDTO imgDto);

	public void addMenu(MenuDTO menuDto);

	public void addWholeMenu(WholeMenuDTO menuDto);

	public void addRepresentImage(RestImageDTO imgDto);


}
