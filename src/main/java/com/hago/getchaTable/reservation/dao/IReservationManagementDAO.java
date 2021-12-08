package com.hago.getchaTable.reservation.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.reservation.dto.ReservationDTO;


@Repository
public interface IReservationManagementDAO {

	public ArrayList<ReservationDTO> selectRestReservation(int restNum, String sqlDate);

	public void reservationConfirm(int resNum);

	public void reserveCancel(int resNum);

	public void noshow(int resNum);

	public void seated(int resNum);

	public void orderDone(int resNum);

}
