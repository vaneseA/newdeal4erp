package kr.happyjob.study.selSaM.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.happyjob.study.selSaM.model.SelSaMModel;
import kr.happyjob.study.selSaM.service.SelSaMService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/selSaM/")
public class SelSaMController {
   
   @Autowired
   SelSaMService selSaMService;
   
   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();
   
   
   
   /**
    * 초기화면
    */
   @RequestMapping("saleMonth.do")
   public String saleMonth(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
         HttpServletResponse response, HttpSession session) throws Exception {
      
      logger.info("+ Start " + className + ".saleMonth");
      logger.info("   - paramMap : " + paramMap);
      
      logger.info("+ End " + className + ".saleMonth");

      return "selSaM/saleMonthList";
      
   }
   /**
    * 목록 조회
    */
   @RequestMapping("saleMonthList.do")
   public String productList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                             HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".saleMonthList");
      logger.info("   - paramMap : " + paramMap);

      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;

      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);

      // Controller -> Service -> Dao -> SQL
      List<SelSaMModel> saleMonthSearchList = selSaMService.saleMonthList(paramMap);
      int totalcnt = selSaMService.countSaleMonthList(paramMap);

      model.addAttribute("productSearchList", saleMonthSearchList);
      model.addAttribute("totalcnt", totalcnt);

      logger.info("+ End " + className + ".productList");

      return "selSaM/saleMonthListGrd";
   }






}
   
   
   

	   
	   
      
