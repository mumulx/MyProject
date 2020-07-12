package org.ycit.util.redis;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import java.util.ArrayList;
import java.util.List;
import java.util.Set;
import java.util.concurrent.TimeUnit;

/* 操作redis工具类
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/5/2
 *  Time: 14:42
 */
@Component("redisUtil")
public final class RedisUtil {
    private final static Logger logger = LoggerFactory.getLogger(RedisUtil.class);

    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    public void setRedisTemplate(RedisTemplate<String, Object> redisTemplate) {
        this.redisTemplate = redisTemplate;
    }



    /**
     *  修改值但是不改变时效时间
     * @author mumulx
     * @creed: mumulx编写
     * @email: 2606964863@qq.com
     * @date 2020/5/6 9:54
     * @param key
     * @param value
     * @return java.lang.Boolean
     *
     */
    public Boolean update(String key, Object value){
        boolean result = false;
        try {
            ValueOperations<String, Object> operations = redisTemplate.opsForValue();

            /*获取失效时间；此方法返回单位为秒过期时长*/
            Long seconds = operations.getOperations().getExpire(key);
            operations.set(key, value,seconds,TimeUnit.SECONDS);
            result = true;
        } catch (Exception e) {
            logger.error("更新redis中数据出错，不改变失效时间的更新");
            e.printStackTrace();
        }
        return result;
    }
    /**
     *      * 写入缓存
     *      * 
     *      * @param key
     *      * @param value
     *      * @return
     *      
     */
    public boolean set(final String key, Object value) {
        boolean result = false;
        try {
            ValueOperations<String, Object> operations = redisTemplate.opsForValue();
            operations.set(key, value);
            result = true;
        } catch (Exception e) {
            e.printStackTrace();
            logger.error("向redis中存储数据出错");
        }
        return result;
    }


    /*有时效的数据*/
    public boolean set(final String key, Object value,long time, TimeUnit timeUnit) {
        boolean result = false;
        try {
            ValueOperations<String, Object> operations = redisTemplate.opsForValue();
            operations.set(key, value,time,timeUnit);
            result = true;
        } catch (Exception e) {
            logger.error("向redis中存储有时效的数据出错");
            e.printStackTrace();
        }
        return result;
    }

    /**
     *      * 读取缓存
     *      * 
     *      * @param key
     *      * @return
     *      
     */
    public Object get(final String key) {
        Object result = null;
        ValueOperations<String, Object> operations = redisTemplate.opsForValue();
        result = operations.get(key);
        return result;
    }

    /**
     *      * 删除对应的value
     *      * 
     *      * @param key
     *      
     */
    public void remove(final String key) {
        if (exists(key)) {
            redisTemplate.delete(key);
        }
    }

    /**
     *      * 批量读取缓存
     *      * @param pattern
     *      * @return
     *      
     */

    public List<Object> getBatch(final String pattern) {
        List<Object> result = new ArrayList<Object>();
        Set<String> keys = redisTemplate.keys(pattern);
        for (String key : keys) {
            result.add(key);
        }
        return result;
    }

    /**
     *      * 批量删除对应的value
     *      * 
     *      * @param keys
     *      
     */
    public void removeBatch(final String... keys) {
        for (String key : keys) {
            remove(key);
        }
    }

    /**
     *      * 模糊匹配批量删除key
     *      * 
     *      * @param pattern
     *      
     */
    public void removePattern(final String pattern) {
        Set<String> keys = redisTemplate.keys(pattern);
        if (keys.size() > 0)
            redisTemplate.delete(keys);
    }

    /**
     *      * 判断缓存中是否有对应的value
     *      * 
     *      * @param key
     *      * @return
     *      
     */
    public boolean exists(final String key) {
        return redisTemplate.hasKey(key);
    }

    /**
     *      * 写入缓存(规定缓存时间)
     *      * 
     *      * @param key
     *      * @param value
     *      * @return
     *      
     */
    public boolean set(final String key, Object value, Long expireTime) {
        boolean result = false;
        try {
            ValueOperations<String, Object> operations = redisTemplate.opsForValue();
            operations.set(key, value);
            redisTemplate.expire(key, expireTime, TimeUnit.SECONDS);
            result = true;
        } catch (Exception e) {
            logger.error("向redis中存放，时效以秒为单位的数据出错");
            e.printStackTrace();
        }
        return result;
    }

    public long increment(final String key, long delta) {
        return redisTemplate.opsForValue().increment(key, delta);
    }

}

