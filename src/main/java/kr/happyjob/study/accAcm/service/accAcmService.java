package kr.happyjob.study.accAcm.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Service;

import kr.happyjob.study.accAcm.model.accAcmModel;
import kr.happyjob.study.accAcs.model.accAcsModel;
import kr.happyjob.study.mngNot.model.NoticeModel;
import kr.happyjob.study.system.model.ComnCodUtilModel;
import kr.happyjob.study.system.model.ComnDtlCodModel;
import kr.happyjob.study.system.model.ComnGrpCodModel;

@Service
public interface accAcmService {

	List<accAcmModel> accAcmSearchList(Map<String, Object> paramMap);

	int countactlist(Map<String, Object> paramMap);


	
	
	
}
