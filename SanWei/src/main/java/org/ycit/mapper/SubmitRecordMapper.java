package org.ycit.mapper;

import org.ycit.entity.SubmitRecord;

import java.util.List;

public interface SubmitRecordMapper {

    /*增加测试记录*/
    void addSR(SubmitRecord submitRecord);


    /*获取当前页用户测试记录*/
    List<SubmitRecord> queryRecordListByUserId(int userId, int startIndex, int pageSize);

    /*获取用户测试记录总数*/
    int queryRecordCountByUserId(int userId);

    /*删除本次测试记录，根据测试记录id*/
    void deleteRecordBySrId(int srId);

    /*根据测试记录id获取测试记录所有信息*/
    SubmitRecord queryRecordBySrId(int srId);


}
