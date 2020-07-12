package org.ycit.service.impl;

import org.springframework.stereotype.Service;
import org.ycit.entity.UserInfo;
import org.ycit.mapper.UserInfoMapper;
import org.ycit.service.UserInfoService;
import org.ycit.util.HelpDev;
import org.ycit.util.RespBean;

import javax.annotation.Resource;

@Service("userInfoService")
public class UserInfoServiceImpl implements UserInfoService {
	@Resource
	private UserInfoMapper userInfoMapper;

	public UserInfoMapper getUserInfoMapper() {
		return userInfoMapper;
	}

	public void setUserInfoMapper(UserInfoMapper userInfoMapper) {
		this.userInfoMapper = userInfoMapper;
	}

	@Resource
	HelpDev helpDev;

	/*客户端ajax方式提交添加用户信息*/
	@Override
	public void addUserInfo(UserInfo userInfo) {
		//性别处理
		String sex = userInfo.getUserSex();
		userInfo.setUserSex(sex.equals("1") ? "男" : "女");
		//密码加密
		String pwdMD5 = helpDev.md5Encode(userInfo.getUserPwd().getBytes());
		userInfo.setUserPwd(pwdMD5);
		userInfoMapper.addUserInfo(userInfo);
	}

	//根据手机号获取用户信息
	@Override
	public UserInfo getUserInfoByUserTel(String userTel) {
		return userInfoMapper.getUserInfoByUserTel(userTel);
	}

	/*根据用户id获取用户信息*/
	@Override
	public UserInfo getUserInfoByUserId(int UserId) {
		return userInfoMapper.getUserInfoByUserId(UserId);
	}

	//前台用户登录检查用户信息
	@Override
	public RespBean checkLogin(String userName, String password) {
		String pw = userInfoMapper.checkLogin(userName);

		//进行加密
		String pwdMD5 = helpDev.md5Encode(password.getBytes());
		if (pw == null) {
			//用户不存在
			//helpDev.setErrMessage("用户不存在");
			return RespBean.error("用户不存在");
		} else if (!pw.equals(pwdMD5)) {
			//密码错误
			return RespBean.error("密码错误");
		}
		return RespBean.ok();
	}


	@Override
	public void updateUserInfoByUserId(UserInfo userInfo) {
		String sex = userInfo.getUserSex();
		if (sex!=null){//用户对性别没有修改
			userInfo.setUserSex(sex.equals("1") ? "男" : "女");
		}
		String userPwd = userInfo.getUserPwd();

		//用户对密码进行了修改，进行加密
		if(userPwd!=null && !userPwd.equals("")) {
			userPwd=helpDev.md5Encode(userPwd.getBytes());
			//userInfoMapper.updateUserInfo(userInfo);
		}else {
			//没进行密码修改给密码赋默认值，方便mybatis进行更新
			userPwd=null;
		}

		userInfo.setUserPwd(userPwd);
		userInfoMapper.updateUserInfoByUserId(userInfo);
	}


}