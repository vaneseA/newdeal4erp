package kr.happyjob.study.accAcm.service;

import java.util.List;
import java.util.Map;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.accAcm.dao.AccAcmDao;
import kr.happyjob.study.accAcm.model.AccManagementModel;


@Service
public class AccAcmServiceImpl implements AccAcmService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());
	
	// Get class name for logger
	private final String className = this.getClass().toString();
	
	@Autowired
	AccAcmDao accAcmDao;
	
	/** 계정과목 목록 조회 */
	public List<AccManagementModel> accmanagementlist(Map<String, Object> paramMap) throws Exception {
		
		return accAcmDao.accmanagementlist(paramMap);
	}
	
//** 납품기업 목록 카운트 조회 */
	public int countaccmanagementlist(Map<String, Object> paramMap) throws Exception {
				
		return accAcmDao.countaccmanagementlist(paramMap);
	}
	
   /**한 건 조회*/
	public AccManagementModel accmanagementselectone(Map<String, Object> paramMap) throws Exception {
		
		return accAcmDao.accmanagementselectone(paramMap);
	}
	
/** 납품기업 등록 */
	public int accmanagementinsert(Map<String, Object> paramMap) throws Exception {
		return accAcmDao.accmanagementinsert(paramMap);
	}
	
/** 납품기업 수정 */
	public int accmanagementupdate(Map<String, Object> paramMap) throws Exception {
		return accAcmDao.accmanagementupdate(paramMap);
	}
	
/** 납품기업 삭제 */
	public int accmanagementdelete(Map<String, Object> paramMap) throws Exception {
		return accAcmDao.accmanagementdelete(paramMap);
	}

}