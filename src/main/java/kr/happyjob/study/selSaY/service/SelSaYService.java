package kr.happyjob.study.selSaY.service;



import kr.happyjob.study.selSaY.model.SelSaYModel;

import java.util.List;
import java.util.Map;

public interface SelSaYService {

	/**  목록 조회 */
	public List<SelSaYModel> saleYearList(Map<String, Object> paramMap) throws Exception;

	/** 목록 카운트 조회 */
	public int countSaleYearList(Map<String, Object> paramMap) throws Exception;



}
