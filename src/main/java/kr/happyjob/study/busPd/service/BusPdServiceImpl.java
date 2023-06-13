package kr.happyjob.study.busPd.service;

import kr.happyjob.study.busPd.dao.BusPdDao;

import kr.happyjob.study.busPd.model.BusPdModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class BusPdServiceImpl implements BusPdService {

    @Autowired
    BusPdDao busPdDao;

    //급여목록 리스트 조회
    public List<BusPdModel> busPdList(Map<String, Object> paramMap) throws Exception {

        return busPdDao.busPdList(paramMap);
    }


    //급여목록 카운트 조회
    public int countBusPdList(Map<String, Object> paramMap) throws Exception {

        return busPdDao.countBusPdList(paramMap);
    }
}
