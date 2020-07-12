package org.ycit.controller;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.ycit.entity.PageHelp;
import org.ycit.entity.TeamProject;
import org.ycit.entity.TeamProjectMember;
import org.ycit.entity.UserInfo;
import org.ycit.service.TeamProjectMemberService;
import org.ycit.service.TeamProjectService;
import org.ycit.service.UserInfoService;
import org.ycit.util.RespBean;
import org.ycit.util.TpmIdentity;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/13
 *  Time: 20:51
 */
@Controller
@RequestMapping("/TeamProject")
public class TeamProjectController{

    //private final static Logger logger = LoggerFactory.getLogger(TeamProjectController.class);

    @Resource
    TeamProjectService teamProjectService;
    @Resource
    UserInfoService userInfoService;

    @Resource
    TeamProjectMemberService teamProjectMemberService;
    //实现参数绑定，前端传来的参数的前缀等，参数绑定
    @InitBinder("teamProject")
    public void initBinderUserInfo(WebDataBinder binder) {
        binder.setFieldDefaultPrefix("teamProject.");
    }


    @GetMapping("/teamList")
    @ResponseBody
    public RespBean teamList(Integer currentPage, HttpServletRequest request, HttpServletResponse response, HttpSession session){
        Object userId = session.getAttribute("user_id");
        if (userId==null){
            String message="您还没有登录，请先登录！";
            return RespBean.error(message);
        }

        int user_id = (int)userId;
        //System.out.println(user_id);
        List<TeamProject> teamProjects = teamProjectService.queryUserTeamProjectListByUserId(user_id,currentPage);

        int recordNumber = teamProjectService.queryUserTeamProjectListCount(user_id);

        PageHelp pageHelp = new PageHelp();
        pageHelp.setCurrentPage(currentPage);
        pageHelp.setRecordNumber(recordNumber);
        pageHelp.computeTotalPag();


        Map<String, Object> maps = new HashMap<>();
        maps.put("page", pageHelp);
        maps.put("obj", teamProjects);
        return RespBean.ok("创建成功!",maps);
    }

    @PostMapping("/add")
    @ResponseBody
    @Transactional
    public RespBean add(@Valid TeamProject teamProject, BindingResult result, HttpServletRequest request, HttpServletResponse response, HttpSession session){

        Object userId = session.getAttribute("user_id");
        if (userId==null){
            String message="您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        int user_id = (int)userId;

        UserInfo userInfo = userInfoService.getUserInfoByUserId(user_id);

        int rs = teamProjectService.add(teamProject);
        if (rs==0){
            RespBean.error("创建错误");
        }
        int tpId = teamProject.getTpId();
        TeamProjectMember teamProjectMember=new TeamProjectMember();
        teamProjectMember.setTpmUserId(user_id);//管理员默认为创建者
        teamProjectMember.setTpmTpId(tpId);//项目id为创建的项目的id
        teamProjectMember.setTpmName(userInfo.getUserName());//管理员在项目中的昵称默认为管理员昵称
        teamProjectMember.setTpmIdentity(TpmIdentity.ADMIN.getIdentity());//设置身份
        Boolean aBoolean = teamProjectMemberService.add(teamProjectMember);
        if (aBoolean==false){
            RespBean.error("创建错误");

        }
        return RespBean.ok("创建成功!");
    }


}
