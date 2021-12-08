package com.hago.getchaTable.reservation.service;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hago.getchaTable.member.dao.IMemberDAO;
import com.hago.getchaTable.member.dto.MemberDTO;
import com.hago.getchaTable.reservation.dao.IReservationManagementDAO;
import com.hago.getchaTable.reservation.dto.ReservationDTO;


@Service
public class ReservationManagementServiceImpl implements IReservationManagementService{
	@Autowired IReservationManagementDAO reserveDao; 
	@Autowired HttpSession session;
	@Autowired IMemberDAO memberDao;
	
	
	public void selectRestReservation(Model model, String searchDate) {
		int restNum = (Integer)session.getAttribute("restNum");
		
		SimpleDateFormat simpleDateFormat = new SimpleDateFormat("MM/dd/yyyy");
		String today = simpleDateFormat.format(new Date());
		String date = today;
		if(searchDate != null) {
			date = searchDate;
		}
		LocalDate datetime1 = LocalDate.parse(date, DateTimeFormatter.ofPattern("MM/dd/yyyy"));
		String sqlDate = datetime1.format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
		ArrayList<ReservationDTO> reserveList = reserveDao.selectRestReservation(restNum, sqlDate);
		
		for(ReservationDTO reserve : reserveList) {
			
			LocalDate datetime2 = LocalDate.parse(reserve.getResDay(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			reserve.setResDay(datetime2.format(DateTimeFormatter.ofPattern("MM/dd/yyyy")));
			String[] hoursStr = reserve.getHours().split(":");
			reserve.setHours(hoursStr[0]);
			MemberDTO member = memberDao.memberViewProc(reserve.getEmail());
			reserve.setNickname(member.getNickname());
			reserve.setMobile(member.getMobile());
			reserve.setBirth(member.getBirth());
			if(member.getGender().equals("w"))
				reserve.setGender("여성");
			else if(member.getGender().equals("m"))
				reserve.setGender("남성");
		}

		model.addAttribute("reserveList", reserveList);
		model.addAttribute("date", date);
		
	}

	public void reserveConfirmProc(Model model, int resNum) {
		reserveDao.reservationConfirm(resNum);		
	}

	public void reserveCancelProc(Model model, int resNum) {
		reserveDao.reserveCancel(resNum);	
	}

	public void noShowProc(Model model, int resNum) {
		reserveDao.noshow(resNum);
	}

	public void customerSeatedProc(Model model, int resNum) {
		reserveDao.seated(resNum);
		
	}

	public void orderDoneProc(Model model, int resNum) {
		reserveDao.orderDone(resNum);
		
	}
	

}
