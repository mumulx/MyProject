package org.ycit.controller;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;
import com.aliyuncs.utils.StringUtils;
import org.json.JSONException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.ycit.entity.UserInfo;
import org.ycit.service.SendSmsService;
import org.ycit.service.UserInfoService;
import org.ycit.util.HelpDev;
import org.ycit.util.redis.RedisUtil;
import org.ycit.util.RespBean;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.concurrent.TimeUnit;

@Controller
@RequestMapping("/UserInfo")
public class UserInfoController{
	
	@Autowired
	UserInfoService userInfoService;

	@Resource
	SendSmsService sendSmsService;
	@Resource
	RedisUtil redisUtil;
	@Resource
	private RedisTemplate<String, String> redisTemplate;


	//实现参数绑定，前端传来的参数的前缀等，参数绑定
	@InitBinder("userInfo")
	public void initBinderUserInfo(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("userInfo.");
	}

	/* 客户端ajax方式提交添加用户信息 */
	@PostMapping(value = "/add")
	@ResponseBody
	public RespBean add(@Valid UserInfo userInfo, BindingResult result, HttpServletRequest request, HttpServletResponse response){
		String message=null;
		if (result.hasErrors()) {
			message = "输入信息不符合要求！";
			return RespBean.error(message);
		}
		//添加用户先判断用户是否存在,根据手机号判断用户是否存在
		if (userInfoService.getUserInfoByUserTel(userInfo.getUserTel()) != null) {
			message = "该手机号已被注册，请更换手机号！";
			return RespBean.error(message);
		}
		//添加用户
		userInfoService.addUserInfo(userInfo);
		message = "用户添加成功!";
		return RespBean.ok(message);
	}


	// 检查验证码
	@PostMapping(value = { "/checkAuthCode" })
	@ResponseBody
	public Map<String, Boolean> checkAuthCode(@RequestParam("login_authCode") String checkcodeClient, HttpServletRequest request,
							  HttpServletResponse response) throws IOException, JSONException {
		Map<String, Boolean> rs = new HashMap<>();
		boolean isTrue = false;
		// 真实的验证码值
		String checkcodeServer = (String) request.getSession().getAttribute("CKECKCODE");
		if (checkcodeServer.equals(checkcodeClient)) {
			isTrue = true;
		}
		rs.put("valid", isTrue);
        return rs;
	}
	/*发送短信验证码*/
	@GetMapping("/sendSms")
	@ResponseBody
	public RespBean sendSms(@RequestParam("userTel") String userTel){

		/*验证手机号码是否合法*/
		boolean mobileNO = HelpDev.isMobileNO(userTel);
		if (!mobileNO){
			return RespBean.error("手机号不合法");
		}
		//调用方法发送(使用radis缓存)
		String code = (String)redisUtil.get(userTel);

		/*用户已经发送过验证码，并且验证码还有效*/
		if (!StringUtils.isEmpty(code)){
			return RespBean.error("验证码五分钟内有效，请不要重新发送！");
		}

		/*随机生成100-9999的数字*/
		int ran = (int)( Math.random()*9000) +1000 ;
		/*验证码*/
		code=String.valueOf(ran) ;
		Map<String, Object> param = new HashMap<>();
		param.put("code", code);

		/*向手机号发送短息*/
		Boolean isSend = sendSmsService.send(userTel, "SMS_189620691", param);
		/*发送成功*/
		if (isSend) {
			/*向redis中放入短信验证码*/
			redisUtil.set(userTel, code,5,TimeUnit.MINUTES);
			return RespBean.ok("发送成功！");
		}else {
			return RespBean.error("发送失败！");

		}

	}
	// 检查验证码
	@PostMapping(value = {"/checkSmsCode"})
	@ResponseBody
	public Map<String, Boolean> checkSmsCode(@RequestParam("userTel") String userTel,@RequestParam("checkCode") String checkCode){
		Map<String, Boolean> rs = new HashMap<>();
		//调用方法发送(使用radis缓存)
		String code = (String)redisUtil.get(userTel);
		/*验证码失效*/
		if (StringUtils.isEmpty(code)){

			rs.put("valid", false);
			return rs;
		}
		/*验证码相等*/
		if (code.equals(checkCode)) {

			rs.put("valid", true);
			return rs;
		} else {
			rs.put("valid", false);
			return rs;

		}

	}


	// 前台用户登录
	/**
	 * @author mumulx
	 * @creed: mumulx编写
	 * @email: 2606964863@qq.com
	 * @date 2020/4/29 10:42
	 * @param userName:用户名，这里的用户名指的是用户的手机号
	 * @param password：用户密码
	 * @param response
	 * @param session
	 * @return org.ycit.util.RespBean
	 */
	@PostMapping(value = "/frontLogin")
	@ResponseBody
	public RespBean frontLogin(@RequestParam(value = "login_username", required = true) String userName,
						   @RequestParam(value = "login_password", required = true) String password, HttpServletResponse response,
						   HttpSession session) {
		boolean success = true;
		String message = "";

		RespBean respBean = userInfoService.checkLogin(userName, password);
		success = respBean.getSuccess();
		if (success) {

			UserInfo user = userInfoService.getUserInfoByUserTel(userName);

			session.setAttribute("user_id",user.getUserId());//用户真实的id，手机号
			session.setAttribute("user_name", user.getUserName());//用户名，昵称
		}
		return respBean;
	}


	@GetMapping(value = "/userInfoList")
	@ResponseBody
	public RespBean showuserinfo(HttpServletRequest request,HttpServletResponse response,HttpSession session){

		Object userId = session.getAttribute("user_id");

		if (userId==null){

            String message="您还没有登录，请先登录！";
            //writeAlertMessageResponse(response,message);
			return RespBean.error(message);
		}
		UserInfo user = userInfoService.getUserInfoByUserId((int)userId);
		user.setUserPwd(null);
		return RespBean.ok(user);


	}
	@PostMapping(value = "/{userId}/updateUserInfo")
	@ResponseBody
	public RespBean updateUserInfo(UserInfo userInfo,HttpServletRequest request,HttpServletResponse response, HttpSession session){
		String message = null;

		UserInfo userInfoByUserTel = userInfoService.getUserInfoByUserTel(userInfo.getUserTel());
		//联系电话被注册
		if (userInfoByUserTel!=null){
			if(userInfoByUserTel.getUserId()!=userInfo.getUserId()){//该联系电话被注册的用户不是该用户,用户想修改的联系电话已经被别人使用了
				message = "该手机号已被注册，请更换手机号！";
				return RespBean.error(message);
			}
		}
		userInfoService.updateUserInfoByUserId(userInfo);
		session.setAttribute("user_tel",userInfo.getUserTel());//用户真实的标识，手机号
		session.setAttribute("user_name", userInfo.getUserName());//用户名，昵称
		message = "修改成功！";
		return RespBean.ok(message);
	}






}