package org.ycit.mapper;

import org.ycit.entity.SubmitFileRecord;

import java.util.List;

public interface SubmitFileRecordMapper {



    /*插入一个SubmitFileRecord*/
    void addSFS(SubmitFileRecord submitFileRecord);


    /*插入SubmitFileRecord集合*/
    void addSFSList(List<SubmitFileRecord> sfrs);

    /*获取用户测试记录对应的文件名*/
    List<SubmitFileRecord> queryFileRecordListBysrid(int srId);


    /*删除此次测试记录的文件记录*/
    void deleteFileRecordBySrId(int srId);


    SubmitFileRecord queryFileRecordBySfrId(int sfrId);
}
