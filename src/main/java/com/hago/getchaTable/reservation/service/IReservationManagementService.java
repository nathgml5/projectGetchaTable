package com.hago.getchaTable.reservation.service;

import org.springframework.ui.Model;

public interface IReservationManagementService {
	public void selectRestReservation(Model model, String searchDate);
}
