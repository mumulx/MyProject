package org.ycit.service.impl;

import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.ycit.entity.Rule;
import org.ycit.mapper.RuleMapper;
import org.ycit.service.RuleService;

import javax.annotation.Resource;
import java.util.List;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/25
 *  Time: 20:29
 */
@Service("rules")
@Transactional(propagation= Propagation.REQUIRED, rollbackFor=Exception.class)
public class RuleServiceImpl implements RuleService {
/**
 *
 * 缓存机制说明：所有有缓存注解的查询结果都放进了缓存，也就是把MySQL查询的结果放到了redis中去，
 * 然后第二次发起该条查询时就可以从redis中去读取查询的结果，从而不与MySQL交互，从而达到优化的效果，
 * redis的查询速度之于MySQL的查询速度相当于 内存读写速度 /硬盘读写速度
 *
 * @Cacheable(value="xxx" key="zzz")注解：标注该方法查询的结果进入缓存，再次访问时直接读取缓存中的数据
 * 1.对于有参数的方法，指定value(缓存区间)和key(缓存的key)；
 * 	   对于无参数的方法，只需指定value,存到数据库中数据的key通过com.ssm.utils.RedisCacheConfig中重写的generate()方法生成。
 * 2.调用该注解标识的方法时，会根据value和key去redis缓存中查找数据，如果查找不到，则去数据库中查找，然后将查找到的数据存放入redis缓存中；
 * 3.向redis中填充的数据分为两部分：
 * 		1).用来记录xxx缓存区间中的缓存数据的key的xxx~keys(zset类型)
 * 		2).缓存的数据，key：数据的key；value：序列化后的从数据库中得到的数据
 * 4.第一次执行@Cacheable注解标识的方法，会在redis中新增上面两条数据
 * 5.非第一次执行@Cacheable注解标识的方法，若未从redis中查找到数据，则执行从数据库中查找，并：
 * 		1).新增从数据库中查找到的数据
 * 		2).在对应的zset类型的用来记录缓存区间中键的数据中新增一个值，新增的value为上一步新增的数据的key
 */
    @Resource
    RuleMapper ruleMapper;


    /*将所有的测试选项信息放到redis中*/
    @Cacheable("rules")
    @Override
    public List<Rule> getAllRules() {
        return ruleMapper.getAllRulesByParentId(-1);
    }

    /*根据规则id获取规则名*/
    @Override
    public String queryRuleNameByRuleId(int ruleId) {
        return ruleMapper.queryRuleNameByRuleId(ruleId);
    }

    @Override
    public String queryCheckerByRuleId(int ruleId) {
        return ruleMapper.queryCheckerByRuleId(ruleId);
    }

    @Override
    public Rule getRuleByEnglishName(String englishName) {
        return ruleMapper.getRuleByEnglishName(englishName);
    }


}
