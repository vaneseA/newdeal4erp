package kr.happyjob.study.selSaY.service;



import kr.happyjob.study.selSaY.model.SelSaYModel;

import java.util.List;
import java.util.Map;

public interface SelSaYService {

	/**  목록 조회 */
	public List<SelSaYModel> selSaYList(Map<String, Object> paramMap) throws Exception;

	/** 목록 카운트 조회 */
	public int countSelSaYList(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 */
	public SelSaYModel selSaYSelectOne(Map<String, Object> paramMap) throws Exception;

	/** 등록 */
	public int selSaYInsert(Map<String, Object> paramMap) throws Exception;

	/** 수정 */
	public int selSaYUpdate(Map<String, Object> paramMap) throws Exception;

	/** 삭제 */
	public int selSaYDelete(Map<String, Object> paramMap) throws Exception;


}
