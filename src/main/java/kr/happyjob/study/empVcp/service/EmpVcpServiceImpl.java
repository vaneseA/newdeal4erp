package kr.happyjob.study.empVcp.service;

import java.io.File;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.happyjob.study.empVcp.dao.EmpVcpDao;
import kr.happyjob.study.empVcp.model.VacaPersonalModel;
import kr.happyjob.study.empVcp.model.VacaPersonalRemainModel;






@Service
public class EmpVcpServiceImpl implements EmpVcpService {
	
	@Autowired
	EmpVcpDao empVcpDao;
	
	//휴가신청 리스트
	public List<VacaPersonalModel> empVcpList (Map<String, Object> paramMap) throws Exception{
		return empVcpDao.empVcpList(paramMap);
	}
	
	//휴가신청 리스트 카운트
	public int countEmpVcpList (Map<String, Object> paramMap) throws Exception{
		return empVcpDao.countEmpVcpList(paramMap);
	}

	//휴가신청 insert
	public int vacaApplication (Map<String, Object> paramMap) throws Exception{
		return empVcpDao.vacaApplication(paramMap);
	}
	
	//휴가신청 결재올리기
	public int approIn (Map<String, Object> paramMap) throws Exception{
		return empVcpDao.approIn(paramMap);
	}
	
	//휴가신청 결재번호 update
	public int vacaApproUpdate () throws Exception{
		return empVcpDao.vacaApproUpdate();
	}
	
	//반려사유 조회
	public String rejDetail(Map<String, Object> paramMap) throws Exception{
		return empVcpDao.rejDetail(paramMap);
	}
	
	//잔여연차 조회
	public List<VacaPersonalRemainModel> vacaRemain(Map<String, Object> paramMap) throws Exception{
		return empVcpDao.vacaRemain(paramMap);
	}
}
