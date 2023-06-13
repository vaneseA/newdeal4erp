
package kr.happyjob.study.busPd.controller;
import kr.happyjob.study.busPd.model.BusPdModel;
import kr.happyjob.study.busPd.service.BusPdService;
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
    public String productInfo(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                              HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".productInfo");
        logger.info("   - paramMap: " + paramMap);

        // 모델에 추가할 데이터 설정
        model.addAttribute("productInfoData", "This is product information");

        logger.info("+ End " + className + ".productInfo");

        return "busPd/productInfo";
    }


    @RequestMapping("productInfoList.do")
    public String productList(Model model, @RequestParam Map<String, Object> paramMap, HttpServletRequest request,
                              HttpServletResponse response, HttpSession session) throws Exception {

        logger.info("+ Start " + className + ".productInfoList");
        logger.info("   - paramMap : " + paramMap);

        int pagenum = Integer.parseInt((String) paramMap.get("pagenum"));
        int pageSize = Integer.parseInt((String) paramMap.get("pageSize"));
        int pageindex = (pagenum - 1) * pageSize;

        paramMap.put("pageSize", pageSize);
        paramMap.put("pageindex", pageindex);

        // Controller -> Service -> Dao -> SQL
        List<BusPdModel> busPdSearchList = busPdService.productInfoList(paramMap);

        model.addAttribute("busPdSearchList", busPdSearchList);

        logger.info("+ End " + className + ".productInfoList");

        return "busPd/productInfo";
    }

    // Rest of the controller methods...

}
