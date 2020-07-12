package org.ycit.service;

import org.ycit.entity.TeamProject;

import java.util.List;

public interface TeamProjectService {


    //添加项目
    int add(TeamProject teamProject);



    List<TeamProject> queryUserTeamProjectListByUserId(int userId,int currentPage);

    int queryUserTeamProjectListCount(int userId);



}
