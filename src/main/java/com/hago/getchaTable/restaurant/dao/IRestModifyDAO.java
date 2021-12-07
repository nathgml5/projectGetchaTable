package com.hago.getchaTable.restaurant.dao;


import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hago.getchaTable.restaurant.dto.RestaurantDTO;


@Repository
public interface IRestModifyDAO {

	public void modifyBasicInfo(RestaurantDTO restDto);

	public void deleteRestImage(int restNum);

	public void modifyDetail(RestaurantDTO restDto);

	public void deleteFacilities(int restNum);

	public void deleteOpenHour(int restNum);

	public void modifyPromotion(RestaurantDTO restDto);

	public void deleteWholeMenu(int restNum);

	public void deleteMenu(int restNum);

	public void updateAvgPoint(@Param("avgPoint")String avgPoint,@Param("restNum")int restNum);
}
