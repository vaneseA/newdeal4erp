package kr.happyjob.study.selSaM.dao;

import kr.happyjob.study.selSaD.model.SelSaDModel;

import java.util.List;
import java.util.Map;

public interface SelSaMDao {

	/**  목록 조회 */
	public List<SelSaDModel> selSaMList(Map<String, Object> paramMap) throws Exception;

	/** 목록 카운트 조회 */
	public int countSelSaMList(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 */
	public SelSaDModel selSaMSelectOne(Map<String, Object> paramMap) throws Exception;

	/** 등록 */
	public int selSaMInsert(Map<String, Object> paramMap) throws Exception;

	/** 수정 */
	public int selSaMUpdate(Map<String, Object> paramMap) throws Exception;

	/** 삭제 */
	public int selSaMDelete(Map<String, Object> paramMap) throws Exception;


}
