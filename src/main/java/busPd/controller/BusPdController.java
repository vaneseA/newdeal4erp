package busPd.controller;

import busPd.model.BusPdModel;
import busPd.service.BusPdService;
import org.apache.commons.io.FileUtils;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/busPd/")
public class BusPdController {

   @Autowired
   BusPdService busPdService;

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();



   /**
    * 초기화면
    */
   @RequestMapping("productInfo.do")
   public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                        HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".notice");
      logger.info("   - paramMap : " + paramMap);

      logger.info("+ End " + className + ".notice");

      return "mngNot/productList";
   }

   @RequestMapping("noticelist.do")
   public String noticelist(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                            HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".noticelist");
      logger.info("   - paramMap : " + paramMap);

      int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
      int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
      int pageindex = (pagenum - 1) * pageSize;

      paramMap.put("pageSize", pageSize);
      paramMap.put("pageindex", pageindex);

      // Controller  Service  Dao  SQL
      List<BusPdModel> noticesearchlist = busPdService.noticelist(paramMap);
      int totalcnt = busPdService.countnoticelist(paramMap);

      model.addAttribute("noticesearchlist", noticesearchlist);
      model.addAttribute("totalcnt", totalcnt);


      logger.info("+ End " + className + ".noticelist");

      return "mngNot/noticelistgrd";
   }

   @RequestMapping("noticeselectone.do")
   @ResponseBody
   public Map<String, Object> noticeselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                              HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".noticeselectone");
      logger.info("   - paramMap : " + paramMap);

      // Controller  Service  Dao  SQL
      BusPdModel noticesearch = busPdService.noticeselectone(paramMap);

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("noticesearch", noticesearch);

      logger.info("+ End " + className + ".noticeselectone");

      return returnmap;
   }

   @RequestMapping("productSave.do")
   @ResponseBody
   public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".noticesave");
      logger.info("   - paramMap : " + paramMap);

      String action = (String) paramMap.get("action");

      paramMap.put("loginid", (String) session.getAttribute("loginId"));


      int returncval = 0;

      if("I".equals(action)) {
         returncval = busPdService.noticeinsert(paramMap);
      } else if("U".equals(action)) {
         returncval = busPdService.noticeupdate(paramMap);
      } else if("D".equals(action)) {
         returncval = busPdService.noticedelete(paramMap);
      }

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returncval", returncval);

      logger.info("+ End " + className + ".noticesave");

      return returnmap;
   }


   @RequestMapping("productSaveFile.do")
   @ResponseBody
   public Map<String, Object> noticesavefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                             HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".noticesavefile");
      logger.info("   - paramMap : " + paramMap);

      String action = (String) paramMap.get("action");

      paramMap.put("loginid", (String) session.getAttribute("loginId"));

      int returncval = 0;

      if("I".equals(action)) {
         returncval = busPdService.noticeinsertfile(paramMap,request);
      } else if("U".equals(action)) {
         returncval = busPdService.noticeupdatefile(paramMap,request);
      } else if("D".equals(action)) {
         returncval = busPdService.noticedeletefile(paramMap);
      }

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returncval", returncval);

      logger.info("+ End " + className + ".noticesavefile");

      return returnmap;
   }

   @RequestMapping("downloadproductFile.do")
   public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                  HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".downloadBbsAtmtFil");
      logger.info("   - paramMap : " + paramMap);

      // 첨부파일 조회
      BusPdModel noticesearch = busPdService.noticeselectone(paramMap);  // file 이름    , 물리경로

      byte fileByte[] = FileUtils.readFileToByteArray(new File(noticesearch.getPhysic_path()));

      response.setContentType("application/octet-stream");
      response.setContentLength(fileByte.length);
      response.setHeader("Content-Disposition", "attachment; fileName=\"" + URLEncoder.encode(noticesearch.getFile_name(),"UTF-8")+"\";");
      response.setHeader("Content-Transfer-Encoding", "binary");
      response.getOutputStream().write(fileByte);

      response.getOutputStream().flush();
      response.getOutputStream().close();

      logger.info("+ End " + className + ".downloadBbsAtmtFil");
   }




}