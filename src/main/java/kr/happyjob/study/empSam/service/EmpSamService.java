package kr.happyjob.study.empSam.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.empSam.model.SalmanagementModel;
import kr.happyjob.study.mngNot.model.NoticeModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

public interface EmpSamService {

	//급여목록 리스트 조회
	public List<SalmanagementModel> empSamList(Map<String, Object> paramMap) throws Exception;
	
	//급여목록 카운트 조회
	public int countEmpSamList(Map<String, Object> paramMap) throws Exception;

	
	
	
}
