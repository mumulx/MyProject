package org.ycit.mapper;

import org.ycit.entity.UserInfo;

public interface UserInfoMapper {
	

/*客户端ajax方式提交添加用户信息*/
    void addUserInfo(UserInfo userInfo );
    /*根据手机号获取用户信息*/
    UserInfo getUserInfoByUserTel(String userTel);

    /*根据用户id获取用户信息*/
    UserInfo getUserInfoByUserId(int userId);
    /* 前台用户登录检查用户信息 */
    String checkLogin(String user_name);


    void updateUserInfoByUserId(UserInfo userInfo);






}
