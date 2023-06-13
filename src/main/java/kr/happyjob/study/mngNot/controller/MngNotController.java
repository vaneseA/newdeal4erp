package kr.happyjob.study.mngNot.controller;

import java.io.File;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
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


import kr.happyjob.study.common.comnUtils.ComnCodUtil;
import kr.happyjob.study.mngNot.model.NoticeModel;
import kr.happyjob.study.mngNot.service.MngNotService;

@Controller
@RequestMapping("/mngNot/")
public class MngNotController {

   @Autowired
   MngNotService mngNotService;

   // Set logger
   private final Logger logger = LogManager.getLogger(this.getClass());

   // Get class name for logger
   private final String className = this.getClass().toString();



   /**
    * 초기화면
    */
//   @RequestMapping("notice.do")는 "/notice.do"라는 URL에 대한 요청을 처리하는 메서드임을 나타냅니다. 즉, 클라이언트가 "/notice.do"에 대한 요청을 보내면 이 메서드가 실행됩니다.
   @RequestMapping("notice.do")
//   Model model: Spring의 Model 객체로, 뷰에 데이터를 전달하는 데 사용됩니다.
//   @RequestParam Map<String, Object> paramMap: HTTP 요청에서 전달된 파라미터들을 담는 맵 객체입니다.
//   HttpServletRequest request: 현재 요청에 대한 정보를 가지고 있는 HttpServletRequest 객체입니다.
//   HttpServletResponse response: 클라이언트로의 응답을 다루기 위한 HttpServletResponse 객체입니다.
//   HttpSession session: 현재 세션을 나타내는 HttpSession 객체입니다.
   public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                        HttpServletResponse response, HttpSession session) throws Exception {
//      logger.info 메서드를 사용하여 로깅 정보를 출력합니다. 이는 디버깅이나 추적 목적으로 사용됩니다.
      logger.info("+ Start " + className + ".notice");
      logger.info("   - paramMap : " + paramMap);

      logger.info("+ End " + className + ".notice");
//      "mngNot/noticelist"라는 문자열을 반환합니다.
//      이는 뷰의 이름을 나타내며, Spring은 이를 찾아 해당하는 뷰를 렌더링하여 클라이언트에게 응답으로 보냅니다.

      return "mngNot/noticelist";
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
      List<NoticeModel> noticesearchlist = mngNotService.noticelist(paramMap);

      //총 개수는 totalcnt 변수에 저장됩니다.
      int totalcnt = mngNotService.countnoticelist(paramMap);

      //model 객체에 noticesearchlist 변수를 "noticesearchlist"라는 이름으로 추가합니다.
      //이렇게 함으로써 noticesearchlist 변수의 값을 뷰(템플릿)에서 사용할 수 있게 됩니다.
      model.addAttribute("noticesearchlist", noticesearchlist);

      //model 객체에 totalcnt 변수를 "totalcnt"라는 이름으로 추가합니다.
      //이렇게 함으로써 totalcnt 변수의 값을 뷰(템플릿)에서 사용할 수 있게 됩니다.
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
      NoticeModel noticesearch = mngNotService.noticeselectone(paramMap);

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("noticesearch", noticesearch);

      logger.info("+ End " + className + ".noticeselectone");

      return returnmap;
   }

   @RequestMapping("noticesave.do")
   @ResponseBody
   public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                         HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".noticesave");
      logger.info("   - paramMap : " + paramMap);

      String action = (String) paramMap.get("action");

      paramMap.put("loginid", (String) session.getAttribute("loginId"));


      int returncval = 0;

      if("I".equals(action)) {
         returncval = mngNotService.noticeinsert(paramMap);
      } else if("U".equals(action)) {
         returncval = mngNotService.noticeupdate(paramMap);
      } else if("D".equals(action)) {
         returncval = mngNotService.noticedelete(paramMap);
      }

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returncval", returncval);

      logger.info("+ End " + className + ".noticesave");

      return returnmap;
   }


   @RequestMapping("noticesavefile.do")
   @ResponseBody
   public Map<String, Object> noticesavefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                             HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".noticesavefile");
      logger.info("   - paramMap : " + paramMap);

      String action = (String) paramMap.get("action");

      paramMap.put("loginid", (String) session.getAttribute("loginId"));

      int returncval = 0;

      if("I".equals(action)) {
         returncval = mngNotService.noticeinsertfile(paramMap,request);
      } else if("U".equals(action)) {
         returncval = mngNotService.noticeupdatefile(paramMap,request);
      } else if("D".equals(action)) {
         returncval = mngNotService.noticedeletefile(paramMap);
      }

      Map<String, Object> returnmap = new HashMap<String, Object>();

      returnmap.put("returncval", returncval);

      logger.info("+ End " + className + ".noticesavefile");

      return returnmap;
   }

   @RequestMapping("downloadnoticefile.do")
   public void downloadBbsAtmtFil(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                  HttpServletResponse response, HttpSession session) throws Exception {

      logger.info("+ Start " + className + ".downloadBbsAtmtFil");
      logger.info("   - paramMap : " + paramMap);

      // 첨부파일 조회
      NoticeModel noticesearch = mngNotService.noticeselectone(paramMap);  // file 이름    , 물리경로

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