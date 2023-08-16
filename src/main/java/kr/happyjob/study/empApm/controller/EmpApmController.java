package kr.happyjob.study.empApm.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.empApm.model.EmpApmModel;
import kr.happyjob.study.empApm.service.EmpApmService;

@Controller
@RequestMapping("/empApm/")
public class EmpApmController {

	@Autowired
	EmpApmService empApmService;

	// Set logger
	private final Logger logger = LogManager.getLogger(this.getClass());

	// Get class name for logger
	private final String className = this.getClass().toString();

	/**
	 * 초기화면
	 */
	@RequestMapping("approManagement.do")
	public String approManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
			HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".approManagement");
		logger.info("   - approManagement.do ParamMap :: " + paramMap);
		logger.info("+ End " + className + ".approManagement");

		return "empApm/approManagement";
	}

	@RequestMapping("approManagementList.do")
	public String approManagementList(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".approManagementList");
		logger.info("   - approManagementList.do ParamMap :: " + paramMap);

		int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
		int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
		int pageindex = (pagenum - 1) * pageSize;

		paramMap.put("pageSize", pageSize);
		paramMap.put("pageindex", pageindex);

		List<EmpApmModel> listSearch = empApmService.approManagementList(paramMap);
		logger.info("[approManagementList.do] listSearch getLoginID:: " + listSearch.get(0).getLoginID());
		logger.info("[approManagementList.do] listSearch getLoginid:: " + listSearch.get(0).getLoginid());
		logger.info("[approManagementList.do] listSearch :: getAppro_bos" + listSearch.get(0).getAppro_bos());
		 
	 
		int totalcnt = empApmService.countList(paramMap);
		logger.info("[approManagementList.do] totalcnt :: " + totalcnt);

		model.addAttribute("listSearch", listSearch);
		model.addAttribute("totalcnt", totalcnt);

		logger.info("+ End " + className + ".approManagementList");

		return "empApm/approManagementGrd";
	}

	@RequestMapping("listSelectOneApm.do")
	@ResponseBody
	public Map<String, Object> listSelectOneApm(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listSelectOneApm.do");
		logger.info("   - paramMap : " + paramMap);

		EmpApmModel listSearch = empApmService.listSelectOneApm(paramMap);

		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("listSearch", listSearch);
		logger.info("   - listSearch : " + listSearch);

		logger.info("+ End " + className + ".listSelectOneApm.do");

		return returnmap;
	}

	
	
	@RequestMapping("listSaveApm.do")
	@ResponseBody
	public Map<String, Object> listSaveApm(Model model, @RequestParam Map<String, Object> paramMap,
			HttpServletRequest request, HttpServletResponse response, HttpSession session) throws Exception {

		logger.info("+ Start " + className + ".listSaveApm");
		logger.info("   - paramMap : " + paramMap);

		String action = (String) paramMap.get("action");
		// int expen_price = Integer.parseInt((String)
		// paramMap.get("expen_price"));
		//
		// paramMap.put("expen_price", expen_price);
		paramMap.put("loginID", (String) session.getAttribute("loginID"));

		int returncval = 0;

		if ("U".equals(action)) {
			returncval = empApmService.listUpdateApm(paramMap);
		}
		Map<String, Object> returnmap = new HashMap<String, Object>();

		returnmap.put("returncval", returncval);

		logger.info("+ End " + className + ".listSaveApm");

		return returnmap;
	}

	/*
	 * @RequestMapping("listSaveFileApm.do")
	 * 
	 * @ResponseBody public Map<String, Object> listSaveFileApm(Model
	 * model, @RequestParam Map<String, Object> paramMap, HttpServletRequest
	 * request, HttpServletResponse response, HttpSession session) throws
	 * Exception {
	 * 
	 * logger.info("+ Start " + className + ".listSaveFileApm"); logger.info(
	 * "   - paramMap : " + paramMap);
	 * 
	 * String action = (String) paramMap.get("action");
	 * 
	 * paramMap.put("loginID", (String) session.getAttribute("loginId"));
	 * 
	 * int returncval = 0;
	 * 
	 * if("U".equals(action)) { returncval =
	 * empApmService.listUpdateFileApm(paramMap,request); }
	 * 
	 * Map<String, Object> returnmap = new HashMap<String, Object>();
	 * 
	 * returnmap.put("returncval", returncval);
	 * 
	 * logger.info("+ End " + className + ".listSaveFileApm");
	 * 
	 * return returnmap; }
	 * 
	 * @RequestMapping("downloadListFileApm.do") public void
	 * downloadListFileApm(Model model, @RequestParam Map<String, Object>
	 * paramMap, HttpServletRequest request, HttpServletResponse response,
	 * HttpSession session) throws Exception {
	 * 
	 * logger.info("+ Start " + className + ".downloadListFileApm");
	 * logger.info("   - paramMap : " + paramMap);
	 * 
	 * // 첨부파일 조회 EmpApmModel listSearch =
	 * empApmService.listSelectOneApm(paramMap); // file 이름 , 물리경로
	 * 
	 * byte fileByte[] = FileUtils.readFileToByteArray(new
	 * File(listSearch.getPhysic_path()));
	 * 
	 * response.setContentType("application/octet-stream");
	 * response.setContentLength(fileByte.length);
	 * response.setHeader("Content-Disposition", "attachment; fileName=\"" +
	 * URLEncoder.encode(listSearch.getFile_name(),"UTF-8")+"\";");
	 * response.setHeader("Content-Transfer-Encoding", "binary");
	 * response.getOutputStream().write(fileByte);
	 * 
	 * response.getOutputStream().flush(); response.getOutputStream().close();
	 * 
	 * logger.info("+ End " + className + ".downloadListFileApm"); }
	 */

}