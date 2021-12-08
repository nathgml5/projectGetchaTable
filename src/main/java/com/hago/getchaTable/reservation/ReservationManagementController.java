package com.hago.getchaTable.reservation;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hago.getchaTable.reservation.service.ReservationManagementServiceImpl;

@Controller
public class ReservationManagementController {
	@Autowired ReservationManagementServiceImpl reserveService;
	
	@RequestMapping(value="selectRestReservationProc")
	public String selectRestReservationProc(Model model, String searchDate) {
		reserveService.selectRestReservation(model, searchDate);
		return "forward:indexPath?formpath=reservationManagement";
	}
	
	@RequestMapping(value="reserveConfirmProc")
	public String reserveConfirmProc(Model model, String resNum, String searchDate) {
		reserveService.reserveConfirmProc(model, Integer.parseInt(resNum));
		return "forward:selectRestReservationProc?searchDate"+searchDate;
	}

	@RequestMapping(value="reserveCancelProc")
	public String reserveCancelProc(Model model, String resNum, String searchDate) {
		reserveService.reserveCancelProc(model, Integer.parseInt(resNum));
		return "forward:selectRestReservationProc?searchDate"+searchDate;
	}

	@RequestMapping(value="noShowProc")
	public String noShowProc(Model model, String resNum, String searchDate) {
		reserveService.noShowProc(model, Integer.parseInt(resNum));
		return "forward:selectRestReservationProc?searchDate"+searchDate;
	}
	@RequestMapping(value="customerSeatedProc")
	public String customerSeatedProc(Model model, String resNum, String searchDate) {
		reserveService.customerSeatedProc(model, Integer.parseInt(resNum));
		return "forward:selectRestReservationProc?searchDate"+searchDate;
	}
	@RequestMapping(value="orderDoneProc")
	public String orderDoneProc(Model model, String resNum, String searchDate) {
		reserveService.orderDoneProc(model, Integer.parseInt(resNum));
		return "forward:selectRestReservationProc?searchDate"+searchDate;
	}
	
}
