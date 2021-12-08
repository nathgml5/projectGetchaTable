package com.hago.getchaTable.collection.service;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.hago.getchaTable.collection.dao.ICollectionDAO;
import com.hago.getchaTable.collection.dto.AllCollectDTO;
import com.hago.getchaTable.collection.dto.CollectDTO;


@Service
public class CollectionService {
	final static Logger logger = LoggerFactory.getLogger(CollectionService.class);
	@Autowired ICollectionDAO cDao;
	@Autowired CollectDTO cDto;
	@Autowired HttpSession session;
	
	public int colletProc(String restNo) {
		String email = (String) session.getAttribute("email");
		int restNum = Integer.parseInt(restNo);
		cDto.setEmail(email);
		cDto.setRestNum(restNum);
		int check = cDao.collChck(cDto);
		int result;
		if(check == 0) { // 중복이 없는 경우 db 저장
			result = cDao.collectProc(cDto);
		}
		else result = 0; // 저장 실패
		return result;
	}

	public void myCollectProc(Model model) {
		String email = (String) session.getAttribute("email");
		logger.warn("email : " + email);
		ArrayList<AllCollectDTO> collectionList = cDao.myCollectProc(email);
		model.addAttribute("collectionList", collectionList);
	}

	public int delCollect(String restNo) {
		String email = (String) session.getAttribute("email");
		int restNum = Integer.parseInt(restNo);
		cDto.setEmail(email);
		cDto.setRestNum(restNum);
		return cDao.delCollect(cDto);
	}
}
