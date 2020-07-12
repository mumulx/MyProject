package org.ycit.service.impl;

import org.springframework.stereotype.Service;
import org.ycit.entity.SubmitRecord;
import org.ycit.entity.SubmitRuleRecord;
import org.ycit.mapper.SubmitRuleRecordMapper;
import org.ycit.service.RuleService;
import org.ycit.service.SubmitRuleRecordService;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:44
 */
@Service("submitRuleRecordService")
public class SubmitRuleRecordServiceImpl implements SubmitRuleRecordService {


    @Resource
    SubmitRuleRecordMapper submitRuleRecordMapper;

    @Resource
    RuleService ruleService;

    /*增加单个SubmitRuleRecord*/
    @Override
    public void addSRR(SubmitRuleRecord submitRuleRecord) {
        submitRuleRecordMapper.addSRR(submitRuleRecord);
    }

    /*增加SubmitRuleRecord集合*/
    @Override
    public void addSRRList(int srId, List<Integer> rules) {
        List<SubmitRuleRecord> srrs = new ArrayList<>();
        for (int rule:rules){
            SubmitRuleRecord srr = new SubmitRuleRecord();
            srr.setSrrRuleId(rule);
            srr.setSrrsrId(srId);
            srrs.add(srr);
        }

        submitRuleRecordMapper.addSRRList(srrs);

    }

    @Override
    public Map<Integer, List<String>> queryRuleRecordListBysrid(List<SubmitRecord> submitRecords) {
        /*结果*/
        Map<Integer, List<String>> ruleRecords = new HashMap<>();
        for (SubmitRecord submitRecord : submitRecords) {
            int srId = submitRecord.getSrId();
            /*每一次测试选项的规则集合（仅包含规则id）*/
            List<SubmitRuleRecord> submitRuleRecords = submitRuleRecordMapper.queryRuleRecordListBysrid(srId);
            /*每一次记录的测试选项名（中文）*/
            List<String> ruleNames = new ArrayList<>();
            /*根据规则id获取规则名（中文）*/
            for (SubmitRuleRecord submitRuleRecord : submitRuleRecords) {
                String ruleName = ruleService.queryRuleNameByRuleId(submitRuleRecord.getSrrRuleId());
                ruleNames.add(ruleName);
            }
            ruleRecords.put(srId, ruleNames);
        }
        return ruleRecords;
    }

    /*根据测试记录id，删除本次测试的测试选项信息*/
    @Override
    public void deleteRuleRecordBySrId(int srId) {
        submitRuleRecordMapper.deleteRuleRecordBySrId(srId);
    }

    /*根据测试记录id，获取测试规则的checker集合*/
    @Override
    public List<String> queryCheckerListBySrId(int srId) {

        /*根据测试记录id，获取测试规则信息集合*/
        List<SubmitRuleRecord> submitRuleRecords = submitRuleRecordMapper.queryRuleRecordListBysrid(srId);
        /*所有的checker集合*/
        List<String> checkers = new ArrayList<>();
        for (SubmitRuleRecord submitRuleRecord : submitRuleRecords) {
            /*根据ruleId获取所有的checker名称*/
            String checker = ruleService.queryCheckerByRuleId(submitRuleRecord.getSrrRuleId());
            checkers.add(checker);
        }
        return checkers;
    }
}
