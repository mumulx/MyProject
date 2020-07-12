package org.ycit.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.ycit.service.TeamProjectMemberService;

import javax.annotation.Resource;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/14
 *  Time: 17:08
 */
@Controller
@RequestMapping("/TeamProjectMember")
public class TeamProjectMemberController {

    @Resource
    TeamProjectMemberService teamProjectMemberService;
    //实现参数绑定，前端传来的参数的前缀等，参数绑定
    @InitBinder("teamProjectMember")
    public void initBinderUserInfo(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("teamProjectMember.");
    }
















}
