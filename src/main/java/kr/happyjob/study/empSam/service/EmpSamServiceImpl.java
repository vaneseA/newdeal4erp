package kr.happyjob.study.empSam.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.happyjob.study.empSam.dao.EmpSamDao;
import kr.happyjob.study.empSam.model.SalmanagementModel;


@Service
public class EmpSamServiceImpl implements EmpSamService {
	
	@Autowired
	EmpSamDao empSamDao;
	
	//급여목록 리스트 조회
	public List<SalmanagementModel> empSamList(Map<String, Object> paramMap) throws Exception {
		
		return empSamDao.empSamList(paramMap);
	}
		
	//급여목록 카운트 조회
	public int countEmpSamList(Map<String, Object> paramMap) throws Exception{
		
		return empSamDao.countEmpSamList(paramMap);
	}
	
}
