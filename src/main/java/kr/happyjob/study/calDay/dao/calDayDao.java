package kr.happyjob.study.calDay.dao;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.calDay.model.calDayModel;


public interface calDayDao {

	List<calDayModel> accountSearchList(Map<String, Object> paramMap);
	
	int countactlist(Map<String, Object> paramMap);

	calDayModel accountSearchSelectone(Map<String, Object> paramMap);
	
	
}
