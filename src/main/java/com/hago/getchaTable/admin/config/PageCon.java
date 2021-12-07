package com.hago.getchaTable.admin.config;

import org.springframework.context.annotation.Configuration;

@Configuration
public class PageCon {
	private int pageNumber;
	private int record;
	private int scroll;
	private int totalPage;
	private int start;
	private int end;
	
	public PageCon() {
		setScroll();
	}
	
	public void setPageNumber(String pn) {
		if(pn == "" || pn == null)
			this.pageNumber = 1;
		else
			this.pageNumber = Integer.parseInt(pn);
		setStart();
	}
	
	private void setStart() {
		start = (pageNumber - 1) * scroll;
	}
	
	public void setRecord(int record) {
		this.record = record;
		setEnd();
		setTotalPage();
	}

	public void setScroll() {
		this.scroll = 10;
	}
	
	private void setTotalPage() {
		if(record > 0) {
			if(record % scroll == 0)
				totalPage = record / scroll;
			else 
				totalPage = (int)Math.ceil(record / (double)scroll);
		}
		
	}
	public int getPageNumber() {
		return pageNumber;
	}
	public int getRecord() {
		return record;
	}
	public int getScroll() {
		return scroll;
	}
	public int getTotalPage() {
		return totalPage;
	}
	public int getStart() {
		return start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd() {
		for(int i= start; i <= (scroll+start) && i <= record; i++)
			this.end = i;
	}
	
}
