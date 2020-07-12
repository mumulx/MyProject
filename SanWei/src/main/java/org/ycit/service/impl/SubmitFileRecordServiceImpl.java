package org.ycit.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.ResponseBody;
import org.ycit.entity.SubmitFileRecord;
import org.ycit.entity.SubmitRecord;
import org.ycit.mapper.SubmitFileRecordMapper;
import org.ycit.service.SubmitFileRecordService;
import org.ycit.util.HelpDev;

import javax.annotation.Resource;
import java.util.*;
import java.util.logging.Logger;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:48
 */
@Service("submitFileRecordService")
public class SubmitFileRecordServiceImpl implements SubmitFileRecordService {


    @Resource
    SubmitFileRecordMapper submitFileRecordMapper;


    @Resource
    HelpDev helpDev;
    /*插入一个SubmitFileRecord*/
    @Override
    public void addSFS(SubmitFileRecord submitFileRecord) {

    }
    /*增加 一次测试记录的所有文件  的测试集合 记录；插入SubmitFileRecord集合*/
    @Override
    public void addSFSList(int srId, Map<String, Object> fileNames) {

        List<SubmitFileRecord> sfrs = new ArrayList<>();
        /*文件保存路径*/
        String pathName = (String) fileNames.get("filePath");
        /*文件名集合*/
        List<String> prtNames = new ArrayList<>();
        prtNames=(ArrayList<String>)fileNames.get("fileNames");

        for (String prtName:prtNames){
            SubmitFileRecord submitFileRecord = new SubmitFileRecord();
            submitFileRecord.setSfrFilePath(pathName);
            submitFileRecord.setSfrFileName(prtName);
            submitFileRecord.setSfrsrId(srId);
            sfrs.add(submitFileRecord);
        }
        submitFileRecordMapper.addSFSList(sfrs);
    }

    @Override
    public Map<Integer, List<SubmitFileRecord>> queryFileRecordListBysrid(List<SubmitRecord> submitRecords) {

        Map<Integer, List<SubmitFileRecord>> sfrs = new HashMap<>();
        for (SubmitRecord submitRecord : submitRecords) {
            int srId = submitRecord.getSrId();
            List<SubmitFileRecord> submitFileRecords = submitFileRecordMapper.queryFileRecordListBysrid(srId);
            sfrs.put(srId, submitFileRecords);
        }
        return sfrs;
    }

    @Override
    public List<SubmitFileRecord> queryFileRecordsBysrid(int srId) {
        return submitFileRecordMapper.queryFileRecordListBysrid(srId);
    }

    /*根据测试记录id，删除此次测试记录的文件记录*/
    @Override
    public void deleteFileRecordBySrId(int srId,SubmitRecord submitRecord) {

        /*获取文件名集合，根据测试记录id*/
        List<SubmitFileRecord> submitFileRecords = submitFileRecordMapper.queryFileRecordListBysrid(srId);
        SubmitFileRecord submitFileRecord = submitFileRecords.get(0);
        /*获取保存的文件夹名*/
        String sfrFilePath = submitFileRecord.getSfrFilePath();
        //删除本地文件（文件夹及文件夹中的所有记录）
        helpDev.deleteUserPrts(submitRecord,sfrFilePath);
        //删除记录
        submitFileRecordMapper.deleteFileRecordBySrId(srId);
    }

    @Override
    public SubmitFileRecord queryFileRecordBySfrId(int sfrId) {
        return submitFileRecordMapper.queryFileRecordBySfrId(sfrId);
    }


}
