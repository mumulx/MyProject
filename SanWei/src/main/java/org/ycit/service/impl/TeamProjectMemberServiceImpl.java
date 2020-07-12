package org.ycit.service.impl;

import org.springframework.stereotype.Service;
import org.ycit.entity.TeamProjectMember;
import org.ycit.mapper.TeamProjectMemberMapper;
import org.ycit.service.TeamProjectMemberService;
import org.ycit.util.TpmIdentity;

import javax.annotation.Resource;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/14
 *  Time: 17:09
 */
@Service("teamProjectMemberService")
public class TeamProjectMemberServiceImpl implements TeamProjectMemberService {


    @Resource
    TeamProjectMemberMapper teamProjectMemberMapper;



    @Override
    public Boolean add(TeamProjectMember teamProjectMember){

       int rs = teamProjectMemberMapper.add(teamProjectMember);
       if (rs==0){
           return false;
       }
       return true;
    }


}
