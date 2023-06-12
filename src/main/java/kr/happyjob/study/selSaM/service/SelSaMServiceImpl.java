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

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SelSaMDao selSaMDao;

	@Value("${fileUpload.rootPath}")
	private String rootPath;    // W:\\FileRepository

	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;  // /serverfile

	@Value("${fileUpload.noticePath}")
	private String noticePath;   // notice


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

	/** 한건 조회 */
	public SelSaMModel selSaMSelectOne(Map<String, Object> paramMap) throws Exception {

		return selSaMDao.selSaMSelectOne(paramMap);
	}

	/** 등록 */
	public int selSaMInsert(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSaMDao.selSaMInsert(paramMap);
	}

	/** 수정 */
	public int selSaMUpdate(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSaMDao.selSaMUpdate(paramMap);
	}

	/** 삭제 */
	public int selSaMDelete(Map<String, Object> paramMap) throws Exception {
		return selSaMDao.selSaMDelete(paramMap);
	}

}
