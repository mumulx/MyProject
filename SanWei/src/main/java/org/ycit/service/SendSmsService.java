package org.ycit.service;

import java.util.Map;

/**
 * 阿里云短信验证
 * @author mumulx
 * @creed: mumulx编写
 * @email: 2606964863@qq.com
 * @date 2020/6/10 14:56
 *
 */
public interface SendSmsService {
    public Boolean send(String phoneNum, String templateCode, Map<String, Object> code);
}
