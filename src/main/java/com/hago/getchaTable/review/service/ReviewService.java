package com.hago.getchaTable.review.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hago.getchaTable.restaurant.dao.IRestModifyDAO;
import com.hago.getchaTable.review.config.AvgPointCon;
import com.hago.getchaTable.review.dao.IReviewDAO;
import com.hago.getchaTable.review.dto.AllDTO;
import com.hago.getchaTable.review.dto.FileDTO;
import com.hago.getchaTable.review.dto.ReviewDTO;

@Service
public class ReviewService {
	final static Logger logger = LoggerFactory.getLogger(ReviewService.class);
	@Autowired HttpSession session;
	@Autowired IReviewDAO dao;
	@Autowired IRestModifyDAO rmDao;
	
	static String FILE_LOCATION = "/upload/";
	private String deleteFile = "";
	SimpleDateFormat sdf;

	public void writeProc(MultipartHttpServletRequest req) {
		String email = (String) session.getAttribute("email");
		String content = req.getParameter("content");
		String restNo = req.getParameter("restNum");
		String points = req.getParameter("point");
		logger.warn("content : " + content);
		logger.warn("restNum : " + restNo);
		logger.warn("point : " + points);
		int restNum = Integer.parseInt(restNo);
		int point = Integer.parseInt(points);

		ReviewDTO dto = new ReviewDTO();
		dto.setEmail(email);
		dto.setContent(content);
		dto.setRestNum(restNum);
		dto.setPoint(point);
		Date date = new Date();
		sdf = getDateForm("yyyy-MM-dd");
		dto.setWriteDate(sdf.format(date));

		StringBuilder builder = new StringBuilder();
		String fileName = "";
		Iterator<String> files = req.getFileNames();
		while (files.hasNext()) {
			String uploadFile = files.next();

			MultipartFile mFile = req.getFile(uploadFile);
			if (mFile.getSize() != 0) {
				Calendar cal = Calendar.getInstance();
				sdf = getDateForm("yyyyMMddHHmmss-");
				fileName = sdf.format(cal.getTime()) + mFile.getOriginalFilename();
				System.out.println("파일 이름: " + fileName);
				String realPath = req.getServletContext().getRealPath(FILE_LOCATION);
				File folder = new File(realPath);
				if (!folder.exists()) {
					folder.mkdir();
				}
				File save = new File(realPath + fileName);
				System.out.println(save);
				try {
					mFile.transferTo(save);
				} catch (Exception e) {
					e.printStackTrace();
				}
				builder.append(fileName);
				builder.append(",");
			} else
				continue;
		}
		if (builder.length() != 0) {
			builder.delete(builder.length() - 1, builder.length());
			dto.setFileNames(builder.toString());
		} else {
			dto.setFileNames("파일없음");
		}
		dao.writeProc(dto);
		
		int[] pointList = dao.selectPoints(restNum);
		String avgPoint = AvgPointCon.getAvgPoint(pointList);
		logger.warn("평점: " + avgPoint);
		rmDao.updateAvgPoint(avgPoint, restNum);
	}

	public void reviewProc(Model model) {
		String email = (String) session.getAttribute("email");
		ArrayList<AllDTO> reviewList = dao.reviewProc(email);
		model.addAttribute("reviewList", reviewList);
	}
	
	public void updateProc(HttpServletRequest req, Model model) {
		String reviewNum = req.getParameter("reviewNum");
		String restNum = req.getParameter("restNum");
		String restName = req.getParameter("restName");
		String content = req.getParameter("content");
		String fileNames = req.getParameter("fileNames");
		if(restNum != null) {
			logger.warn("수정페이지 식당번호: " + restNum);
			logger.warn("수정페이지 리뷰번호: " + reviewNum);
			logger.warn("수정페이지 파일이름: " + fileNames);
			model.addAttribute("reviewNum", reviewNum);
			model.addAttribute("restNum", restNum);
			model.addAttribute("restName", restName);
			model.addAttribute("content", content);
			model.addAttribute("fileNames", fileNames);			
		}
	}

	public void modifyProc(MultipartHttpServletRequest req) {
		String rewNo = req.getParameter("reviewNum");
		String restNo = req.getParameter("restNum");
		String content = req.getParameter("content");
		String points = req.getParameter("point");
		int reviewNum = Integer.parseInt(rewNo);
		int restNum = Integer.parseInt(restNo);
		int point = Integer.parseInt(points);
		
		
		ReviewDTO origin = dao.selectOne(reviewNum);
		if(content !="" && content.equals(origin.getContent()) == false)
			origin.setContent(content);
		if(point != origin.getPoint()) {
			int[] pointList = dao.selectPoints(restNum);
			String avgPoint = AvgPointCon.getAvgPoint(pointList);
			logger.warn("평점: " + avgPoint);
			rmDao.updateAvgPoint(avgPoint, restNum);
			origin.setPoint(point);
		}
		
		StringBuilder builder = new StringBuilder();
		if(!origin.getFileNames().equals("파일없음")) {
			builder.append(origin.getFileNames());
			builder.append(",");
		}
		//신규 추가 파일이 있는 경우
		String fileName="";
		Iterator<String> files = req.getFileNames();
		while(files.hasNext()) {
			String uploadFile = files.next();
			MultipartFile mFile = req.getFile(uploadFile);
			if(mFile.getSize() != 0) {
				Calendar cal = Calendar.getInstance();
				sdf = getDateForm("yyyyMMddHHmmss-");
				fileName = sdf.format(cal.getTime()) + mFile.getOriginalFilename();
				logger.warn("신규 추가 파일: " + fileName);
				String realPath = req.getServletContext().getRealPath(FILE_LOCATION);
				File folder = new File(realPath);
				if (!folder.exists()) {
					folder.mkdir();
				}
				File save = new File(realPath + fileName);
				System.out.println(save);
				try {
					mFile.transferTo(save);
				} catch (Exception e) {
					e.printStackTrace();
				}
				builder.append(fileName);
				builder.append(",");
			}else continue;
		}
		if(builder.length() != 0) {
			builder.delete(builder.length()-1, builder.length());
			origin.setFileNames(builder.toString());
		}

		dao.updateProc(origin);
	}

	public int deleteProc(String delNum, String fileNames, HttpServletRequest req) {
		int reviewNum = Integer.parseInt(delNum);
		String[] fileName = fileNames.split(",");
		int len = fileName.length;
		for (int i = 0; i <= len - 1; i++) {
			deleteFile = fileName[i];
			delete(deleteFile, req);
		}
		return dao.deleteProc(reviewNum);
	}

	public int delFileProc(String rwNum, String delFile, HttpServletRequest req) {
		FileDTO fDto = new FileDTO();
		int reviewNum = Integer.parseInt(rwNum);
		fDto.setReviewNum(reviewNum);
		String fileNames = dao.selectFile(reviewNum);
		StringBuilder builder = new StringBuilder();
		if (!fileNames.equals("파일없음")) {
			String[] fileName = fileNames.split(",");
			int len = fileName.length;
			for (int i = 0; i <= len - 1; i++) {
				if (!fileName[i].equals(delFile)) {
					builder.append(fileName[i]);
					builder.append(',');
				} else continue;
			}
			if (builder.length() != 0) {
				builder.delete(builder.length() - 1, builder.length());
				fDto.setFileNames(builder.toString());
				dao.updateFile(fDto);
			} else {
				fDto.setFileNames("파일없음");
				dao.updateFile(fDto);
			}
			if(delete(delFile, req))
				return 1;
		}
		return 0;
	}

	public static boolean delete(String deleteFile, HttpServletRequest req) {
		String savePath = getRealPath(FILE_LOCATION + deleteFile, req);
		logger.warn("삭제된 파일: " + savePath);
		return getFile(savePath).delete();
	}

	public static File getFile(String fileName) {
		return new File(fileName);
	}

	public static String getRealPath(String path, HttpServletRequest req) {
		return req.getServletContext().getRealPath(path);
	}

	public static SimpleDateFormat getDateForm(String type) {
		return new SimpleDateFormat(type);
	}

}
