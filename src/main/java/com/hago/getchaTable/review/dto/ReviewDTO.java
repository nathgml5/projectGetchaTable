package com.hago.getchaTable.review.dto;

public class ReviewDTO {
	private int reviewNum;
	private String email;
	private int restNum;
	private String content;
	private String writeDate;
	private int point;
	private String fileNames;
	
	public int getReviewNum() {
		return reviewNum;
	}
	public void setReviewNum(int reviewNum) {
		this.reviewNum = reviewNum;
	}
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(String writeDate) {
		this.writeDate = writeDate;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	public String getFileNames() {
		return fileNames;
	}
	public void setFileNames(String fileNames) {
		this.fileNames = fileNames;
	}
}
