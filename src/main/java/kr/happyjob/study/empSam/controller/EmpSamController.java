package kr.happyjob.study.empSam.controller;

import java.util.List;
import java.util.Map;
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
import kr.happyjob.study.empSam.model.SalmanagementModel;
import kr.happyjob.study.empSam.service.EmpSamService;


@Controller
@RequestMapping("/empSam/")
public class EmpSamController {
   
   @Autowired
   EmpSamService empSamService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 초기화면
    */
   @RequestMapping("salManagement.do")
   public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".salManagement");
      logger.info("   - paramMap : " + paramMap); //println으로 값이 들어왔는지 확인하는거ㄴ
      
      logger.info("+ End " + className + ".salManagement");

      return "empSam/salManagement";
   }
       
   @RequestMapping("salManagementList.do")
   public String noticelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + "salManagementList");
      logger.info("   - paramMap : " + paramMap);
      
      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;
      
      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);
      
      // Controller  Service  Dao  SQL
      List<SalmanagementModel> empSamSearchList = empSamService.empSamList(paramMap);
      int totalcnt = empSamService.countEmpSamList(paramMap);
      
      model.addAttribute("empSamSearchList", empSamSearchList);
      model.addAttribute("totalcnt", totalcnt);
      
      
      logger.info("+ End " + className + ".salManagementList");

      return "empSam/salManagementList";
   }
   
   	   
	   
	   
      
}