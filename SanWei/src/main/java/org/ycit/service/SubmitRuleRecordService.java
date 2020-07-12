package org.ycit.service;

import org.ycit.entity.SubmitRecord;
import org.ycit.entity.SubmitRuleRecord;
import java.util.List;
import java.util.Map;

public interface SubmitRuleRecordService {

    /*增加单个SubmitRuleRecord*/
    void addSRR(SubmitRuleRecord submitRuleRecord);
    /*增加SubmitRuleRecord集合*/
    void addSRRList(int srId, List<Integer> rules);


    /**
     * 获取用户测试记录对应的测试选项名
     * @author mumulx
     * @creed: mumulx编写
     * @email: 2606964863@qq.com
     * @date 2020/5/1 10:14
     * @param submitRecords 用户测试记录
     * @return java.util.Map<java.lang.Integer,java.util.List<java.lang.String>>
     *
     */
    Map<Integer, List<String>> queryRuleRecordListBysrid(List<SubmitRecord> submitRecords);


    /*根据测试记录id，删除本次测试的测试选项信息*/
    void deleteRuleRecordBySrId(int srId);

    /*根据测试记录id，获取测试规则的checker集合*/
    List<String> queryCheckerListBySrId(int srId);





}
