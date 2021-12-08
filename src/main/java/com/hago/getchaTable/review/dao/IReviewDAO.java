package com.hago.getchaTable.review.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import com.hago.getchaTable.review.dto.AllDTO;
import com.hago.getchaTable.review.dto.FileDTO;
import com.hago.getchaTable.review.dto.ReviewDTO;
import com.hago.getchaTable.review.dto.ReviewsDTO;


@Repository
public interface IReviewDAO {
	public void writeProc(ReviewDTO dto);
	public ArrayList<AllDTO> reviewProc(String email);
	public ArrayList<ReviewsDTO> selectAll(@Param("b")int begin, @Param("e")int end, @Param("restNum")int restNum);
	public ReviewDTO selectOne(int revieNum);
	public int deleteProc(int reviewNum);
	public String selectFile(int reviewNum);
	public void updateProc(ReviewDTO origin);
	public void updateFile(FileDTO fDto);
	public int reviewCount(int restNum);
	public int[] selectPoints(int restNum);
}
