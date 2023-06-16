package kr.happyjob.study.selSaD.service;

import kr.happyjob.study.selSaD.dao.SelSaDDao;
import kr.happyjob.study.selSaD.model.SelSaDModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class SelSaDServiceImpl implements SelSaDService {

    @Autowired
    SelSaDDao selSaDDao;

    //제품 목록 리스트 조회
    public List<SelSaDModel> selSaDList(Map<String, Object> paramMap) throws Exception {

        return selSaDDao.selSaDList(paramMap);
    }


    //제품 목록 카운트 조회
    public int countSelSaDList(Map<String, Object> paramMap) throws Exception {

        return selSaDDao.countSelSaDList(paramMap);
    }

    //한건 조회
    public SelSaDModel selSaDSelectOne(Map<String, Object> paramMap) throws Exception {

        return selSaDDao.selSaDSelectOne(paramMap);
    }

    //등록
    public int selSaDInsert(Map<String, Object> paramMap) throws Exception {
        return selSaDDao.selSaDInsert(paramMap);
    }

    //수정
    public int selSaDUpdate(Map<String, Object> paramMap) throws Exception {
        return selSaDDao.selSaDUpdate(paramMap);
    }

    //삭제
    public int selSaDDelete(Map<String, Object> paramMap) throws Exception {
        return selSaDDao.selSaDDelete(paramMap);
    }
}
