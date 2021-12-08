package com.hago.getchaTable.reservation.dto;

import java.util.Comparator;

import com.hago.getchaTable.member.dto.MemberDTO;


public class ReservationDTO extends MemberDTO implements Comparator<ReservationDTO>{
	private int restNum;
	private String restName;
	private int resNum;
	private int orderNum;
	private String email;
	private String nickname;
	private String resDay;
	private String week;
	private String hours;
	private int capacity;
	private String status;
	
	public int getOrderNum() {
		return orderNum;
	}
	public void setOrderNum(int orderNum) {
		this.orderNum = orderNum;
	}
	public int getRestNum() {
		return restNum;
	}
	public void setRestNum(int restNum) {
		this.restNum = restNum;
	}
	public String getRestName() {
		return restName;
	}
	public void setRestName(String restName) {
		this.restName = restName;
	}
	public int getResNum() {
		return resNum;
	}
	public void setResNum(int resNum) {
		this.resNum = resNum;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getResDay() {
		return resDay;
	}
	public void setResDay(String resDay) {
		this.resDay = resDay;
	}
	public String getWeek() {
		return week;
	}
	public void setWeek(String week) {
		this.week = week;
	}
	public String getHours() {
		return hours;
	}
	public void setHours(String hours) {
		this.hours = hours;
	}
	public int getCapacity() {
		return capacity;
	}
	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	@Override
	public int compare(ReservationDTO o1, ReservationDTO o2) {
		return o1.getResDay().compareTo(o2.getResDay());
	}
}
