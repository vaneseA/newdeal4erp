package kr.happyjob.study.login.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import kr.happyjob.study.login.model.LgnInfoModel;
import kr.happyjob.study.login.model.UsrMnuAtrtModel;
import kr.happyjob.study.login.model.UsrMnuChildAtrtModel;



public interface LoginService {
	
	/** 사용자 로그인 체크*/
	//해당 메서드는 주어진 paramMap을 사용하여 로그인 검증을 수행하고, 그 결과에 따라 적절한 String 값을 반환합니다.
	public String checkLogin(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 로그인 */
	public LgnInfoModel loginProc(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 메뉴 권한 */
	public List<UsrMnuAtrtModel> listUsrMnuAtrt(Map<String, Object> paramMap) throws Exception;
	
	/**  사용자 자식 메뉴 권한 */
	public List<UsrMnuChildAtrtModel> listUsrChildMnuAtrt(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 회원가입*/
	public int registerUser(Map<String, Object> paramMap) throws Exception;
	
	/*loginID 중복체크*/
	public int check_loginID(LgnInfoModel model) throws Exception;
	
	/*이메일 중복체크*/
	public int check_email(LgnInfoModel model) throws Exception;
	
	/** 사용자 ID 찾기 */
	public LgnInfoModel selectFindId(Map<String, Object> paramMap) throws Exception;

	/** 사용자 PW 찾기 */
	public LgnInfoModel selectFindPw(Map<String, Object> paramMap) throws Exception;
	
	/** 사용자 PW 찾기 ID 체크*/
	public LgnInfoModel registerIdCheck(Map<String, Object> paraMap) throws Exception;
	
	/* 이력서 파일 업로드 */
	void insertFile(Map<String, Object> paramMap, HttpServletRequest request) throws Exception;
	
	void insertResume(Map<String, Object> paramMap);
	
/*	*//** select 박스 은행 목록*//*
	List<LgnInfoModel> selectBankList();*/

}
