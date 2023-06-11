package kr.happyjob.study.selSad.service;

import kr.happyjob.study.selSad.dao.SelSadDao;
import kr.happyjob.study.selSad.model.SelSadModel;
import kr.happyjob.study.common.comnUtils.FileUtilCho;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;


@Service
public class SelSadServiceImpl implements SelSadService {

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	@Autowired
	SelSadDao selSadDao;

	@Value("${fileUpload.rootPath}")
	private String rootPath;    // W:\\FileRepository

	@Value("${fileUpload.virtualRootPath}")
	private String virtualrootPath;  // /serverfile

	@Value("${fileUpload.noticePath}")
	private String noticePath;   // notice


	/** 목록 조회 */
	public List<SelSadModel> noticelist(Map<String, Object> paramMap) throws Exception {

		return selSadDao.noticelist(paramMap);
	}

	/** 목록 카운트 조회 */
	public int countnoticelist(Map<String, Object> paramMap) throws Exception {

		return selSadDao.countnoticelist(paramMap);
	}

	/** 한건 조회 */
	public SelSadModel noticeselectone(Map<String, Object> paramMap) throws Exception {

		return selSadDao.noticeselectone(paramMap);
	}

	/** 등록 */
	public int noticeinsert(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSadDao.noticeinsert(paramMap);
	}

	/** 수정 */
	public int noticeupdate(Map<String, Object> paramMap) throws Exception {
		paramMap.put("fileprc", "N");
		return selSadDao.noticeupdate(paramMap);
	}

	/** 삭제 */
	public int noticedelete(Map<String, Object> paramMap) throws Exception {
		return selSadDao.noticedelete(paramMap);
	}

	/** 등록 파일 */
	public int noticeinsertfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {

		MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;

		// private String rootPath;    // W:\\FileRepository
		// private String virtualrootPath;  // /serverfile
		// private String noticePath;   // notice

		String noticedir = File.separator + noticePath + File.separator;
		FileUtilCho fileup = new FileUtilCho(multipartHttpServletRequest,rootPath, virtualrootPath, noticedir);
		Map filereturn = fileup.uploadFiles();

		//map.put("file_nm", file_nm);
		//map.put("file_size", file_Size);
		//map.put("file_loc", file_loc);
		//map.put("vrfile_loc", vrfile_loc);
		//map.put("fileExtension", fileExtension);

		String upfile = (String) filereturn.get("file_nm");
		paramMap.put("fileprc", "Y");

		if(upfile == "" || upfile == null) {
			paramMap.put("fileexist", "N");
		} else {
			paramMap.put("filereturn", filereturn);
			paramMap.put("fileexist", "Y");

			selSadDao.fileinsert(paramMap);
		}

		return selSadDao.noticeinsert(paramMap);
	}

	/** 수정 파일 */
	public int noticeupdatefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception {


		return 1;
	}

	/** 삭제  파일*/
	public int noticedeletefile(Map<String, Object> paramMap) throws Exception {

		return 1;
	}
}
