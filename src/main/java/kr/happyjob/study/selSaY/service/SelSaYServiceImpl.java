package kr.happyjob.study.selSaY.service;


import kr.happyjob.study.selSaY.dao.SelSaYDao;
import kr.happyjob.study.selSaY.model.SelSaYModel;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class SelSaYServiceImpl implements SelSaYService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SelSaYDao selSaYDao;

	@Value("${fileUpload.rootPath}")
	private String rootPath;    // W:\\FileRepository

	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;  // /serverfile

	@Value("${fileUpload.noticePath}")
	private String noticePath;   // notice


	/** 목록 조회 */
	public List<SelSaYModel> selSaYList(Map<String, Object> paramMap) throws Exception {

		return selSaYDao.selSaYList(paramMap);
	}

	/** 목록 카운트 조회 */
	public int countSelSaYList(Map<String, Object> paramMap) throws Exception {

		return selSaYDao.countSelSaYList(paramMap);
	}

	/** 한건 조회 */
	public SelSaYModel selSaYSelectOne(Map<String, Object> paramMap) throws Exception {

		return selSaYDao.selSaYSelectOne(paramMap);
	}

	/** 등록 */
	public int selSaYInsert(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSaYDao.selSaYInsert(paramMap);
	}

	/** 수정 */
	public int selSaYUpdate(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSaYDao.selSaYUpdate(paramMap);
	}

	/** 삭제 */
	public int selSaYDelete(Map<String, Object> paramMap) throws Exception {
		return selSaYDao.selSaYDelete(paramMap);
	}

}
