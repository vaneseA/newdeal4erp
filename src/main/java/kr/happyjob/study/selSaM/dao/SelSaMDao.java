package kr.happyjob.study.selSaM.dao;

import kr.happyjob.study.selSaM.model.SelSaMModel;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.Map;
@Component
public interface SelSaMDao {

	//리스트 조회
	public List<SelSaMModel> selSaMList(Map<String, Object> paramMap) throws Exception;

	//카운트 조회
	public int countSelSaMList(Map<String, Object> paramMap) throws Exception;

}
