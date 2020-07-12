package org.ycit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.ycit.service.SubmitRuleRecordService;

import javax.annotation.Resource;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:45
 */
@Controller
@RequestMapping("/submitRuleRecord")
public class SubmitRuleRecordController {

    @Resource
    SubmitRuleRecordService submitRuleRecordService;
}
