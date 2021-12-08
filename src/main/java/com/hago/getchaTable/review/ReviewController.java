package com.hago.getchaTable.review;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.hago.getchaTable.review.service.ReviewService;


@Controller
public class ReviewController {
	
	final static Logger logger = LoggerFactory.getLogger(ReviewController.class);
	@Autowired ReviewService service;
	
	@RequestMapping(value = "writeProc")
	public String writeProc(MultipartHttpServletRequest req) {
		service.writeProc(req);
		return "redirect:reviewProc";
	}
	
	@RequestMapping(value = "reviewProc")
	public String reviewProc(Model model) {
		service.reviewProc(model);
		return "forward:indexPath?formpath=review";
	}
	
	
	  @RequestMapping(value = "updateProc") 
	  public String  updateProc(HttpServletRequest req, Model model) { 
		  service.updateProc(req,model); 
		  return "forward:indexPath?formpath=update"; 
	  }
	 
	
	@RequestMapping(value = "modifyProc")
	public String modifyProc(MultipartHttpServletRequest req) {
		service.modifyProc(req);
		return "redirect:reviewProc";
	}
	
	@ResponseBody
	@RequestMapping(value = "delFileProc")
	public Map<String, String> delFileProc(HttpServletRequest req) {
		String reviewNum = req.getParameter("reviewNum");
		String delFile = req.getParameter("fileName");
		logger.warn(reviewNum);
		logger.warn(delFile);
		int result = service.delFileProc(reviewNum, delFile, req);
		Map<String, String> data = new HashMap<>();
		if(result == 1) 
			data.put("result", "success");
		else
			data.put("result", "fail");
		return data;
	}
	
	@ResponseBody
	@RequestMapping(value = "deleteProc")
	public Map<String, String> deleteProc(HttpServletRequest req) {
		String delNum = req.getParameter("reviewNum");
		String fileNames = req.getParameter("fileNames");
		int deletedRow = service.deleteProc(delNum, fileNames, req);
		Map<String, String> result = new HashMap<>();
		if(deletedRow > 0) 
			result.put("result", "success");
		else
			result.put("reslut", "fail");
		return result;
	}
}
