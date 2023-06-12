package kr.happyjob.study.selSay.dao;

import kr.happyjob.study.mngNot.model.NoticeModel;
import kr.happyjob.study.selSay.model.SelSayModel;

import java.util.List;
import java.util.Map;

public interface SelSayDao {

	/**  목록 조회 */
	public List<SelSayModel> noticelist(Map<String, Object> paramMap) throws Exception;

	/** 목록 카운트 조회 */
	public int countnoticelist(Map<String, Object> paramMap) throws Exception;

	/** 한건 조회 */
	public SelSayModel noticeselectone(Map<String, Object> paramMap) throws Exception;

	/** 등록 */
	public int noticeinsert(Map<String, Object> paramMap) throws Exception;

	/** 수정 */
	public int noticeupdate(Map<String, Object> paramMap) throws Exception;

	/** 삭제 */
	public int noticedelete(Map<String, Object> paramMap) throws Exception;

	/** 등록 파일 */
	public int noticeinsertfile(Map<String, Object> paramMap) throws Exception;

	/** 수정 파일 */
	public int noticeupdatefile(Map<String, Object> paramMap) throws Exception;

	/** 삭제  파일*/
	public int noticedeletefile(Map<String, Object> paramMap) throws Exception;

	/** 파일 등록 */
	public int fileinsert(Map<String, Object> paramMap) throws Exception;

}
