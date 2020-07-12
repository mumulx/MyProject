package org.ycit.mapper;

import org.ycit.entity.PageHelp;
import org.ycit.entity.TeamProject;

import java.util.List;

public interface TeamProjectMapper {


    int add(TeamProject teamProject);

    List<TeamProject> queryUserTeamProjectListByUserId(int userId, int startIndex,int pageSize);
    int queryUserTeamProjectListCount(int userId);
}
