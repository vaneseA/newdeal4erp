package kr.happyjob.study.selSaM.dao;

import kr.happyjob.study.busPd.model.BusPdModel;
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

	//한건 조회
	public SelSaMModel selSaMSelectOne(Map<String, Object> paramMap) throws Exception;

	//등록
	public int selSaMInsert(Map<String, Object> paramMap) throws Exception;

	//수정
	public int selSaMUpdate(Map<String, Object> paramMap) throws Exception;

	//삭제
	public int selSaMDelete(Map<String, Object> paramMap) throws Exception;


}
