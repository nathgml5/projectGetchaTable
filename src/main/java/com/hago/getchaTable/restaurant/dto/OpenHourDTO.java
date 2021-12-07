package com.hago.getchaTable.restaurant.dto;

public class OpenHourDTO {
	private int restNum;
	private String weekSelection;
	private String daySelection;
	private String hours;
	

	public int getRestNum() {
		return restNum;
	}
	public void setRestNum(int restNum) {
		this.restNum = restNum;
	}
	public String getWeekSelection() {
		return weekSelection;
	}
	public void setWeekSelection(String weekSelection) {
		this.weekSelection = weekSelection;
	}
	public String getDaySelection() {
		return daySelection;
	}
	public void setDaySelection(String daySelection) {
		this.daySelection = daySelection;
	}
	public String getHours() {
		return hours;
	}
	public void setHours(String hours) {
		this.hours = hours;
	}
	
	
	
}
