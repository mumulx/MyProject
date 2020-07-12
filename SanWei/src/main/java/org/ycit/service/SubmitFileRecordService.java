package org.ycit.service;

import org.ycit.entity.SubmitFileRecord;
import org.ycit.entity.SubmitRecord;

import java.util.List;
import java.util.Map;

public interface SubmitFileRecordService {


    /*插入一个SubmitFileRecord*/
    void addSFS(SubmitFileRecord submitFileRecord);

    /*增加 一次测试记录的所有文件  的测试集合 记录；插入SubmitFileRecord集合*/
    void addSFSList(int srId, Map<String, Object> fileNames);

    /**
     * 获取用户测试记录对应的文件名
     * @author mumulx
     * @creed: mumulx编写
     * @email: 2606964863@qq.com
     * @date 2020/5/1 10:13
     * @param submitRecords 用户测试记录集合
     * @return java.util.Map<java.lang.Integer,java.util.List<org.ycit.entity.SubmitFileRecord>>
     *
     */
    Map<Integer,List<SubmitFileRecord>> queryFileRecordListBysrid(List<SubmitRecord> submitRecords);

    /*根据srid获取测试文件列表*/
    List<SubmitFileRecord> queryFileRecordsBysrid(int srId);

    /*根据测试记录id，删除此次测试记录的文件记录*/
    void deleteFileRecordBySrId(int srId,SubmitRecord submitRecord);

    SubmitFileRecord queryFileRecordBySfrId(int sfrId);

}
