package kr.happyjob.study.accAcm.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.accAcm.model.AccManagementModel;

public interface AccAcmDao {

	/** 납품기업 목록 조회 */
	public List<AccManagementModel> accmanagementlist(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 목록 카운트 조회 */
	public int countaccmanagementlist(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 한건 조회 */
	public AccManagementModel accmanagementselectone(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 등록 */
	public int accmanagementinsert(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 수정 */
	public int accmanagementupdate(Map<String, Object> paramMap) throws Exception;
	
	/** 납품기업 삭제 */
	public int accmanagementdelete(Map<String, Object> paramMap) throws Exception;
   
}