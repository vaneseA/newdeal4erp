package kr.happyjob.study.selSaD.controller;

import kr.happyjob.study.selSaD.model.SelSaDModel;
import kr.happyjob.study.selSaD.service.SelSaDService;
import org.apache.log4j.LogManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/selSaD/")
public class SelSaDController {

    @Autowired
    SelSaDService selSaDService;

    // Set logger
    private final Logger logger = LogManager.getLogger(this.getClass());

    // Get class name for logger
    private final String className = this.getClass().toString();


    /**
     * 초기화면
     */
    @RequestMapping("saleDay.do")
    public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                         HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".sel");
        logger.info("   - paramMap : " + paramMap);

        logger.info("+ End " + className + ".sel");

        return "/selSaD/saleDayList";
    }

    @RequestMapping("/selSaD/saleDay.do")
    public String selSaDList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                             HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".selSaDList");
        logger.info("   - paramMap : " + paramMap);

        int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
        int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
        int pageindex = (pagenum - 1) * pageSize;

        paramMap.put("pageSize", pageSize);
        paramMap.put("pageindex", pageindex);

        // Controller  Service  Dao  SQL
        List<SelSaDModel> noticesearchlist = selSaDService.selSaDList(paramMap);
        int totalcnt = selSaDService.countSelSaDList(paramMap);

        model.addAttribute("noticesearchlist", noticesearchlist);
        model.addAttribute("totalcnt", totalcnt);

        logger.info("+ End " + className + ".selSaDList");

        return "selSaD/saleDayListGrd";
    }


    //데이터를 조회하는 곳??
    //일단 놔두자.
//    @RequestMapping("noticeselectone.do")
//    @ResponseBody
//    public Map<String, Object> noticeselectone(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//                                               HttpServletResponse response, HttpSession session) throws Exception {
//
//        logger.info("+ Start " + className + ".noticeselectone");
//        logger.info("   - paramMap : " + paramMap);
//
//        // Controller  Service  Dao  SQL
//        SelSadModel noticesearch = selSadService.noticeselectone(paramMap);
//
//        Map<String, Object> returnmap = new HashMap<String, Object>();
//
//        returnmap.put("noticesearch", noticesearch);
//
//        logger.info("+ End " + className + ".noticeselectone");
//
//        return returnmap;
//    }
//
//    //공지사항 입력 수정 삭제 하는 곳
//    //일단 놔두자.
//    @RequestMapping("noticesave.do")
//    @ResponseBody
//    public Map<String, Object> noticesave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//                                          HttpServletResponse response, HttpSession session) throws Exception {
//
//        logger.info("+ Start " + className + ".noticesave");
//        logger.info("   - paramMap : " + paramMap);
//
//        String action = (String) paramMap.get("action");
//
//        paramMap.put("loginid", (String) session.getAttribute("loginId"));
//
//
//        int returncval = 0;
//
//        if ("I".equals(action)) {
//            returncval = selSadService.noticeinsert(paramMap);
//        } else if ("U".equals(action)) {
//            returncval = selSadService.noticeupdate(paramMap);
//        } else if ("D".equals(action)) {
//            returncval = selSadService.noticedelete(paramMap);
//        }
//
//        Map<String, Object> returnmap = new HashMap<String, Object>();
//
//        returnmap.put("returncval", returncval);
//
//        logger.info("+ End " + className + ".noticesave");
//
//        return returnmap;
//    }
//
//    //공지사항 파일 입력 수정 삭제 하는 곳
//    //일단 놔두자.
//    @RequestMapping("noticesavefile.do")
//    @ResponseBody
//    public Map<String, Object> noticesavefile(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
//                                              HttpServletResponse response, HttpSession session) throws Exception {
//
//        logger.info("+ Start " + className + ".noticesavefile");
//        logger.info("   - paramMap : " + paramMap);
//
//        String action = (String) paramMap.get("action");
//
//        paramMap.put("loginid", (String) session.getAttribute("loginId"));
//
//        int returncval = 0;
//
//        if ("I".equals(action)) {
//            returncval = selSadService.noticeinsertfile(paramMap, request);
//        } else if ("U".equals(action)) {
//            returncval = selSadService.noticeupdatefile(paramMap, request);
//        } else if ("D".equals(action)) {
//            returncval = selSadService.noticedeletefile(paramMap);
//        }
//
//        Map<String, Object> returnmap = new HashMap<String, Object>();
//
//        returnmap.put("returncval", returncval);
//
//        logger.info("+ End " + className + ".noticesavefile");
//
//        return returnmap;
//    }


}