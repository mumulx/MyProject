package org.ycit.service;

import org.ycit.entity.Rule;

import java.util.List;

public interface RuleService {
    /*获取所有的检查选项*/
    public List<Rule> getAllRules();

    /*根据规则id获取规则名（中文）*/
    String queryRuleNameByRuleId(int ruleId);

    /*根据ruleId获取所有的checker名称*/
    String queryCheckerByRuleId(int ruleId);

    Rule getRuleByEnglishName(String englishName);
}
