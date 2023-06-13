package kr.happyjob.study.empSam.dao;

import java.util.List;
import java.util.Map;

import kr.happyjob.study.empSam.model.SalmanagementModel;


public interface EmpSamDao {

	//급여목록 리스트 조회
	public List<SalmanagementModel> empSamList(Map<String, Object> paramMap) throws Exception;
	
	//급여목록 카운트 조회
	public int countEmpSamList(Map<String, Object> paramMap) throws Exception;	
	
}
