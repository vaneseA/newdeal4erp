package kr.happyjob.study.selSad.controller;

import kr.happyjob.study.selSad.model.SelSaDModel;
import kr.happyjob.study.selSad.service.SelSaDService;
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

}