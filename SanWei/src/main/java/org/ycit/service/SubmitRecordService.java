package org.ycit.service;

import org.ycit.entity.SubmitFileRecord;
import org.ycit.entity.SubmitRecord;

import java.io.IOException;
import java.util.List;
import java.util.Map;

public interface SubmitRecordService {

    /*增加测试记录*/
    int addSR(SubmitRecord submitRecord);

    /**
     * 获取当前页面用户测试记录
     * @author mumulx
     * @creed: mumulx编写
     * @email: 2606964863@qq.com
     * @date 2020/5/1 10:11
     * @param userId 用户id
     * @param currentPage  当前页
     * @return java.util.List<org.ycit.entity.SubmitRecord>
     *
     */
    List<SubmitRecord> queryRecordListByUserId(int userId, int currentPage);

    /**
     * 获取用户测试记录总数
     * @author mumulx
     * @creed: mumulx编写
     * @email: 2606964863@qq.com
     * @date 2020/5/1 10:05
     * @param userId 用户id
     * @return int 记录总数
     *
     */
    int queryRecordCountByUserId(int userId);



    /*删除本次测试记录，根据测试记录id*/
    void deleteRecordBySrId(int srId);

    /*根据测试记录id获取测试记录所有信息*/
    SubmitRecord queryRecordBySrId(int srId);

    /*开始测试prt文件*/
    void beginTestFiles(String userId ,SubmitRecord submitRecord,List<SubmitFileRecord> submitFileRecords,List<String> checkers);

    Map<String, String> getThePrtTestResult(int userId, SubmitRecord submitRecord, SubmitFileRecord submitFileRecord) throws IOException;




}
