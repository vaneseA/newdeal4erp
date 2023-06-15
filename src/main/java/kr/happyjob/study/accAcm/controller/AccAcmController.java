package kr.happyjob.study.accAcm.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.accAcm.model.AccManagementModel;
import kr.happyjob.study.accAcm.service.AccAcmService;


@Controller
@RequestMapping("/accAcm/")
public class AccAcmController {
   
   @Autowired
   AccAcmService accAcmService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 납품기업 관리 초기화면
    */
   @RequestMapping("accManagement.do")
   public String accManagement(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".accManagement");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".accManagement");

      return "accAcm/accmanagementlist";
   }
   
   /**
    * 납품기업 관리 목록 조회
    */
   @RequestMapping("accmanagementlist.do")
   public String accmanagementlist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".accmanagementlist");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<AccManagementModel> accmanagementsearchlist = accAcmService.accmanagementlist(paramMap);
      int totalcnt = accAcmService.countaccmanagementlist(paramMap);
      
      model.addAttribute("splrsearchlist", accmanagementsearchlist);
      model.addAttribute("totalcnt", totalcnt);
      
      
      logger.info("+ End " + className + ".splrlist");

      return "busSpm/splrlistgrd";
   }
   
   /**
    * 납품기업 관리 한건 조회
    */
   @RequestMapping("splrselectone.do")
   @ResponseBody
   public Map<String, Object> accmanagementselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                              HttpServletResponse response, HttpSession session) throws Exception {

       logger.info("+ Start " + className + ".accmanagementselectone");
       logger.info("   - paramMap : " + paramMap);

       // Controller  Service  Dao  SQL
       AccManagementModel accmanagementsearch = accAcmService.accmanagementselectone(paramMap);

       Map<String, Object> returnmap = new HashMap<String, Object>();

       returnmap.put("accmanagementsearch", accmanagementsearch);

       logger.info("+ End " + className + ".accmanagementselectone");

       return returnmap;
   }
   
   /**
    * 납품기업 관리 생성, 수정, 삭제
    */
   @RequestMapping("splrsave.do")
   @ResponseBody
   public Map<String, Object> accmanagementsave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                         HttpServletResponse response, HttpSession session) throws Exception {

       logger.info("+ Start " + className + ".accmanagementsave");
       logger.info("   - paramMap : " + paramMap);

       String action = (String) paramMap.get("action");

       paramMap.put("loginid", (String) session.getAttribute("loginId"));


       int returncval = 0;

       if("I".equals(action)) {
           returncval = accAcmService.accmanagementinsert(paramMap);
       } else if("U".equals(action)) {
           returncval = accAcmService.accmanagementupdate(paramMap);
       } else if("D".equals(action)) {
           returncval = accAcmService.accmanagementdelete(paramMap);
       }      

       Map<String, Object> returnmap = new HashMap<String, Object>();

       returnmap.put("returncval", returncval);

       logger.info("+ End " + className + ".accmanagementsave");

       return returnmap;
   }  
     
      
      
}