//package busPd.service;
//
//import busPd.model.BusPdModel;
//
//import javax.servlet.http.HttpServletRequest;
//import java.util.List;
//import java.util.Map;
//
//public interface BusPdService {
//
//	/**  목록 조회 */
//	public List<BusPdModel> noticelist(Map<String, Object> paramMap) throws Exception;
//
//	/** 목록 카운트 조회 */
//	public int countnoticelist(Map<String, Object> paramMap) throws Exception;
//
//	/** 한건 조회 */
//	public BusPdModel noticeselectone(Map<String, Object> paramMap) throws Exception;
//
//	/** 등록 */
//	public int noticeinsert(Map<String, Object> paramMap) throws Exception;
//
//	/** 수정 */
//	public int noticeupdate(Map<String, Object> paramMap) throws Exception;
//
//	/** 삭제 */
//	public int noticedelete(Map<String, Object> paramMap) throws Exception;
//
//	/** 등록 파일 */
//	public int noticeinsertfile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
//
//	/** 수정 파일 */
//	public int noticeupdatefile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
//
//	/** 삭제  파일*/
//	public int noticedeletefile(Map<String, Object> paramMap) throws Exception;
//
//
//
//}
