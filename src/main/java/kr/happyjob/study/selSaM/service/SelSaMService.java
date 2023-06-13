package kr.happyjob.study.selSaM.service;


import kr.happyjob.study.selSaM.model.SelSaMModel;

import java.util.List;
import java.util.Map;

public interface SelSaMService {
	/**
	 * 목록 조회
	 */
	public List<SelSaMModel> selSaMList(Map<String, Object> paramMap) throws Exception;

	/** 목록 카운트 조회 */
	public int countSelSaMList(Map<String, Object> paramMap) throws Exception;


}