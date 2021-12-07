package com.hago.getchaTable.admin.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.admin.dto.AdditionDTO;
import com.hago.getchaTable.admin.dto.ManagerDTO;
import com.hago.getchaTable.restaurant.dto.RestaurantDTO;



@Repository
public interface IAdminDAO {

	public ManagerDTO selectId(String id);

	public void addManager(ManagerDTO managerDto);

	public ArrayList<RestaurantDTO> restList();

	public void addRestNum(String string);

	public void deleteManager(int restNum);

	public void deleteRestaurant(int restNum);

	public ArrayList<AdditionDTO> guideBookList();

	public AdditionDTO selectRestNum(int restNum, String guideBook);

	public void addGuide(int restNum, String guideBook);

	

}
