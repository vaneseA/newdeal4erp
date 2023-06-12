package kr.happyjob.study.selSaM.controller;

import kr.happyjob.study.selSaM.model.SelSaMModel;
import kr.happyjob.study.selSaM.service.SelSaMService;
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
    public String notice(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                         HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".sel");
        logger.info("   - paramMap : " + paramMap);

        logger.info("+ End " + className + ".sel");

        return "/selSaM/saleMonthList";
    }

    @RequestMapping("/selSaM/saleMonth.do")
    public String selSaMList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                             HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".selSaMList");
        logger.info("   - paramMap : " + paramMap);

        int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
        int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
        int pageindex = (pagenum - 1) * pageSize;

        paramMap.put("pageSize", pageSize);
        paramMap.put("pageindex", pageindex);

        // Controller  Service  Dao  SQL
        List<SelSaMModel> noticesearchlist = selSaMService.selSaMList(paramMap);
        int totalcnt = selSaMService.countSelSaMList(paramMap);

        model.addAttribute("noticesearchlist", noticesearchlist);
        model.addAttribute("totalcnt", totalcnt);

        logger.info("+ End " + className + ".selSaMList");

        return "selSaM/saleMonthListGrd";
    }

}