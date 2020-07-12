package org.ycit.util.redis;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/5/5
 *  Time: 22:45
 */
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.ycit.util.HelpDev;

public class RedisCacheTransfer {
    @Autowired
    public void setRedisTemplate(RedisTemplate redisTemplate) {
        HelpDev.RedisCache.setRedisTemplate(redisTemplate);
    }
}