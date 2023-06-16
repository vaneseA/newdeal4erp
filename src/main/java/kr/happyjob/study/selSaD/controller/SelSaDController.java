
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
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
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
    public String saleDay(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                              HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".saleDay");
        logger.info("   - paramMap: " + paramMap);


        logger.info("+ End " + className + ".saleDay");

        return "selSaD/selSaDList";
    }
    /**
     * 목록 조회
     */
    @RequestMapping("selSaDListList.do")
    public String selSaDListList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                              HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".selSaDListList");
        logger.info("   - paramMap : " + paramMap);

        int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
        int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
        int pageindex = (pagenum - 1) * pageSize;

        paramMap.put("pageSize", pageSize);
        paramMap.put("pageindex", pageindex);

        // Controller -> Service -> Dao -> SQL
        List<SelSaDModel> selSaDListSearchList = selSaDService.selSaDList(paramMap);
        int totalcnt = selSaDService.countSelSaDList(paramMap);

        model.addAttribute("selSaDListSearchList", selSaDListSearchList);
        model.addAttribute("totalcnt", totalcnt);

        logger.info("+ End " + className + ".selSaDListList");

        return "selSaD/selSaDListListGrd";
    }

    /**
     * 한건 조회
     */
    @RequestMapping("selSaDListSelectOne.do")
    @ResponseBody
    public Map<String, Object> selSaDListSelectOne(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                             HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".selSaDListSelectOne");
        logger.info("   - paramMap : " + paramMap);

        // Controller  Service  Dao  SQL
        SelSaDModel selSaDListSearch = selSaDService.selSaDSelectOne(paramMap);

        Map<String, Object> returnmap = new HashMap<String, Object>();

        returnmap.put("selSaDListSearch", selSaDListSearch);

        logger.info("+ End " + className + ".selSaDListSelectOne");

        return returnmap;
    }

    /**
     * 생성, 수정, 삭제
     */
    @RequestMapping("selSaDListSave.do")
    @ResponseBody
    public Map<String, Object> selSaDListSave(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                                        HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".selSaDListSave");
        logger.info("   - paramMap : " + paramMap);

        String action = (String) paramMap.get("action");

        paramMap.put("loginid", (String) session.getAttribute("loginId"));


        int returncval = 0;

        if("I".equals(action)) {
            returncval = selSaDService.selSaDInsert(paramMap);
        } else if("U".equals(action)) {
            returncval = selSaDService.selSaDUpdate(paramMap);
        } else if("D".equals(action)) {
            returncval = selSaDService.selSaDDelete(paramMap);
        }

        Map<String, Object> returnmap = new HashMap<String, Object>();

        returnmap.put("returncval", returncval);

        logger.info("+ End " + className + ".selSaDListSave");

        return returnmap;
    }
}
