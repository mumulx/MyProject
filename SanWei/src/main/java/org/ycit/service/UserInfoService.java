package org.ycit.service;

import org.ycit.entity.UserInfo;
import org.ycit.util.RespBean;

public interface UserInfoService {
	/*
	 * public String userLogin(String userid); public void register(UserInfo
	 * userinfo);
	 */

	/*客户端ajax方式提交添加用户信息*/
	void addUserInfo(UserInfo userInfo);

	/*根据手机号获取用户信息*/
	UserInfo getUserInfoByUserTel(String userTel);

	/*根据用户id获取用户信息*/
	UserInfo getUserInfoByUserId(int UserId);
	//前台用户登录检查用户信息
	RespBean checkLogin(String userName, String password);


	void updateUserInfoByUserId (UserInfo userInfo);
}
