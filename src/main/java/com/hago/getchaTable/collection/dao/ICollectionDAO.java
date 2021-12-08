package com.hago.getchaTable.collection.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.hago.getchaTable.collection.dto.AllCollectDTO;
import com.hago.getchaTable.collection.dto.CollectDTO;


@Repository
public interface ICollectionDAO {
	public int collChck(CollectDTO cDto);
	public int collectProc(CollectDTO cDto);
	public int collCount(int restNum);
	public ArrayList<AllCollectDTO> myCollectProc(String email);
	public int delCollect(CollectDTO cDto);
}