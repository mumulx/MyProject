package org.ycit.service.impl;/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/13
 *  Time: 20:50
 */

import org.springframework.stereotype.Service;
import org.ycit.entity.PageHelp;
import org.ycit.entity.TeamProject;
import org.ycit.mapper.TeamProjectMapper;
import org.ycit.service.TeamProjectService;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@Service("teamProjectService")
public class TeamProjectServiceImpl implements TeamProjectService {

    @Resource
    TeamProjectMapper teamProjectMapper;


    @Override
    public int add(TeamProject teamProject) {
        LocalDateTime localDateTime = LocalDateTime.now();

        String date = localDateTime.format(DateTimeFormatter.ISO_DATE);
        teamProject.setTpDate(date);
        int tpId = teamProjectMapper.add(teamProject);

        if (tpId==0){
            return -1;
        }

        return tpId;
    }

    @Override
    public List<TeamProject> queryUserTeamProjectListByUserId(int userId,int currentPage) {
        //currentPage-->startIndex
        int pageSize = PageHelp.pageSize;
        int startIndex = (currentPage-1) * pageSize;
        return teamProjectMapper.queryUserTeamProjectListByUserId(userId,startIndex, pageSize);
    }

    @Override
    public int queryUserTeamProjectListCount(int userId) {
        return teamProjectMapper.queryUserTeamProjectListCount(userId);
    }
}
