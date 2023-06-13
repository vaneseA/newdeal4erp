package kr.happyjob.study.selSaM.service;



import kr.happyjob.study.selSaM.dao.SelSaMDao;
import kr.happyjob.study.selSaM.model.SelSaMModel;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class SelSaMServiceImpl implements SelSaMService {

	@Autowired
	SelSaMDao selSaMDao;

	/**
	 * 목록 조회
	 */
	public List<SelSaMModel> selSaMList(Map<String, Object> paramMap) throws Exception {

		return selSaMDao.selSaMList(paramMap);
	}

	/** 목록 카운트 조회 */
	public int countSelSaMList(Map<String, Object> paramMap) throws Exception {

		return selSaMDao.countSelSaMList(paramMap);
	}
}
