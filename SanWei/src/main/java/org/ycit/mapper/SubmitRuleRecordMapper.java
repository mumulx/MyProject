package org.ycit.mapper;

import org.ycit.entity.SubmitRuleRecord;

import java.util.List;

public interface SubmitRuleRecordMapper {


    void addSRR(SubmitRuleRecord submitRuleRecord);

    /*增加测试记录的 测试选项记录*/
    void addSRRList(List<SubmitRuleRecord> srrs);

    /*获取用户测试记录对应的测试选项名*/
    List<SubmitRuleRecord> queryRuleRecordListBysrid(int srId);

    /*根据测试记录id，删除本次测试的测试选项信息*/
    void deleteRuleRecordBySrId(int srId);

}
