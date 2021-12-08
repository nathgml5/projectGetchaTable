package com.hago.getchaTable.collection.dto;

import org.springframework.context.annotation.Configuration;

@Configuration
public class CollectDTO {
	private String email;
	private int restNum;
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public int getRestNum() {
		return restNum;
	}
	public void setRestNum(int restNum) {
		this.restNum = restNum;
	}
}
