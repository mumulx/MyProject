package org.ycit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ycit.entity.Rule;
import org.ycit.service.RuleService;
import org.ycit.util.RespBean;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/25
 *  Time: 20:28
 */
@Controller
@RequestMapping("/Rule")
public class RuleController {


    @Resource
    RuleService ruleService;


    /*获取所有测试规则信息*/
    @GetMapping("/")
    @ResponseBody
    public RespBean getAllRules(HttpSession session){

        Object userId = session.getAttribute("user_id");
        if (userId==null){
            String message="您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        return RespBean.ok("查询成功!",ruleService.getAllRules());
    }
    /*获取所有测试规则信息*/
    @GetMapping("/getRuleByEnglishName")
    @ResponseBody
    public RespBean getRuleByEnglishName(String englishName){

        Rule ruleByEnglishName = ruleService.getRuleByEnglishName(englishName);
        if (ruleByEnglishName == null) {
            return RespBean.error("不存在该英文名");

        }

        return RespBean.ok("查询成功!",ruleByEnglishName);
    }




}
