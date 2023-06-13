package kr.happyjob.study.busPd.service;

import kr.happyjob.study.busPd.model.BusPdModel;
import java.util.List;
import java.util.Map;

public interface BusPdService {

    //급여목록 리스트 조회
    public List<BusPdModel> busPdList(Map<String, Object> paramMap) throws Exception;

    //급여목록 카운트 조회
    public int countBusPdList(Map<String, Object> paramMap) throws Exception;





}
