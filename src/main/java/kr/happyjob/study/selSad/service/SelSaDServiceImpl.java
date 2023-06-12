package kr.happyjob.study.selSad.service;

import kr.happyjob.study.selSad.dao.SelSaDDao;
import kr.happyjob.study.selSad.model.SelSaDModel;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;


@Service
public class SelSaDServiceImpl implements SelSaDService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SelSaDDao selSaDDao;

	@Value("${fileUpload.rootPath}")
	private String rootPath;    // W:\\FileRepository

	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;  // /serverfile

	@Value("${fileUpload.noticePath}")
	private String noticePath;   // notice


	/** 목록 조회 */
	public List<SelSaDModel> selSaDList(Map<String, Object> paramMap) throws Exception {

		return selSaDDao.selSaDList(paramMap);
	}

	/** 목록 카운트 조회 */
	public int countSelSaDList(Map<String, Object> paramMap) throws Exception {

		return selSaDDao.countSelSaDList(paramMap);
	}

	/** 한건 조회 */
	public SelSaDModel selSaDSelectOne(Map<String, Object> paramMap) throws Exception {

		return selSaDDao.selSaDSelectOne(paramMap);
	}

	/** 등록 */
	public int selSaDInsert(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSaDDao.selSaDInsert(paramMap);
	}

	/** 수정 */
	public int selSaDUpdate(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSaDDao.selSaDUpdate(paramMap);
	}

	/** 삭제 */
	public int selSaDDelete(Map<String, Object> paramMap) throws Exception {
		return selSaDDao.selSaDDelete(paramMap);
	}
}
