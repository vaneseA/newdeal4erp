package kr.happyjob.study.selSad.service;

import kr.happyjob.study.selSad.model.SelSaDModel;

import java.util.List;
import java.util.Map;

public interface SelSaDService {

	/**  목록 조회 */
	public List<SelSaDModel> selSaDList(Map<String, Object> paramMap) throws Exception;

	/** 목록 카운트 조회 */
	public int countSelSaDList(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 */
	public SelSaDModel selSaDSelectOne(Map<String, Object> paramMap) throws Exception;

	/** 등록 */
	public int selSaDInsert(Map<String, Object> paramMap) throws Exception;

	/** 수정 */
	public int selSaDUpdate(Map<String, Object> paramMap) throws Exception;

	/** 삭제 */
	public int selSaDDelete(Map<String, Object> paramMap) throws Exception;


}
