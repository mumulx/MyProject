package org.ycit.service.impl;

import com.alibaba.fastjson.JSONObject;
import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import org.springframework.stereotype.Service;
import org.ycit.service.SendSmsService;

import java.util.Map;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/5/2
 *  Time: 9:31
 */
@Service("sendSms")
public class SendSmsServiceImpl implements SendSmsService {

    @Override
    public Boolean send(String phoneNum, String templateCode, Map<String, Object> code) {

        /*链接阿里云*/
        DefaultProfile profile = DefaultProfile.getProfile("cn-hangzhou", "LTAI4GHGGH4WxLQohz7ApCVt", "WqD9T2kgCdPbYJ5jZ2RiQOUwNeL4eo");
        /*构建了一个客户端*/
        IAcsClient client = new DefaultAcsClient(profile);

        /*构建请求！*/
        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");//不要东
        request.setVersion("2017-05-25");//不要动
        request.setAction("SendSms");
        /*自定义的参数（手机号，验证码，签名，模板）*/

        /*手机号*/
        request.putQueryParameter("PhoneNumbers", phoneNum);
        /*签名*/
        request.putQueryParameter("SignName", "三维模型质量检测");

        /*模板*/
        request.putQueryParameter("TemplateCode", templateCode);

        /*构建短信验证码*/

        request.putQueryParameter("TemplateParam", JSONObject.toJSONString(code));
        try {
            /*进行发送，获得响应*/
            CommonResponse response = client.getCommonResponse(request);
            System.out.println(response.getData());
            return response.getHttpResponse().isSuccess();
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }

        return false;

    }
}
