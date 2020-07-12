package org.ycit.mapper;

import org.ycit.entity.Rule;

import java.util.List;

public interface RuleMapper {



    List<Rule> getAllRulesByParentId(Integer pid);

    /*根据规则id获取规则名*/
    String queryRuleNameByRuleId(int ruleId);

    /*根据ruleId获取所有的checker名称*/
    String queryCheckerByRuleId(int ruleId);

    Rule getRuleByEnglishName(String englishName);
}
