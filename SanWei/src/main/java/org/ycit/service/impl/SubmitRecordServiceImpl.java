package org.ycit.service.impl;

import org.apache.log4j.Logger;
import org.json.JSONObject;
import org.springframework.stereotype.Service;
import org.ycit.entity.PageHelp;
import org.ycit.entity.SubmitFileRecord;
import org.ycit.entity.SubmitRecord;
import org.ycit.mapper.SubmitRecordMapper;
import org.ycit.service.SubmitRecordService;
import org.ycit.util.HelpDev;
import org.ycit.util.redis.RedisUtil;

import javax.annotation.Resource;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.*;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:51
 */
@Service("submitRecordService")
public class SubmitRecordServiceImpl implements SubmitRecordService {

    private static Logger logger = Logger.getLogger(SubmitRecordServiceImpl.class);

    @Resource
    SubmitRecordMapper submitRecordMapper;

    @Resource
    HelpDev helpDev;
    @Resource
    RedisUtil redisUtil;



    @Override
    public int addSR(SubmitRecord submitRecord) {
        /*获取当前时间*/
        LocalDateTime localDateTime = LocalDateTime.now();
        /*时间格式化*/
        String dateTime = localDateTime.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        submitRecord.setSrDate(dateTime);
        submitRecord.setSrFileSaveURL(HelpDev.FILEUPLADURL);
        submitRecordMapper.addSR(submitRecord);
        return submitRecord.getSrId();
    }

    @Override
    public List<SubmitRecord> queryRecordListByUserId(int userId, int currentPage) {
        int pageSize = PageHelp.pageSize;
        int startIndex = (currentPage-1) * pageSize;
        return submitRecordMapper.queryRecordListByUserId(userId, startIndex, pageSize);

    }

    /*获取用户测试记录总数*/
    @Override
    public int queryRecordCountByUserId(int userId) {
        return submitRecordMapper.queryRecordCountByUserId(userId);
    }

    /*删除本次测试记录，根据测试记录id*/
    @Override
    public void deleteRecordBySrId(int srId) {
        //删除记录
        submitRecordMapper.deleteRecordBySrId(srId);
    }

    /*根据测试记录id获取测试记录所有信息*/
    @Override
    public SubmitRecord queryRecordBySrId(int srId) {
        return submitRecordMapper.queryRecordBySrId(srId);
    }



    /*开始进行文件测试*/
    @Override
    public void beginTestFiles(String userId,SubmitRecord submitRecord, List<SubmitFileRecord> submitFileRecords, List<String> checkers){
        /*文件保存根地址*/
        String srFileSaveURL = submitRecord.getSrFileSaveURL();
        /*文件url地址*/
        int fileNums = submitFileRecords.size();
        /*文件保存路径*/
        String prtFilePath = srFileSaveURL+"\\"+userId+"\\"+submitFileRecords.get(0).getSfrFilePath();

       /* //使用线程池，优化测试时间,因为nx是不支持多线程的，因此不能使用将多个文件放到多个线程中，同时执行
        ExecutorService pool = Executors.newFixedThreadPool(5);
        CountDownLatch latch = new CountDownLatch(fileNums);

        for (SubmitFileRecord submitFileRecord : submitFileRecords) {
            pool.execute(()->{
                //获取文件名
                String sfrFileName = submitFileRecord.getSfrFileName();
                //根据文件名，给出对应的jpg文件名
                String jpgName = sfrFileName.substring(0, sfrFileName.lastIndexOf("."))+".jpg";
                try {
                    logger.info("*****************开始抓图！");
                    helpDev.dosJpgExeUtil(prtFilePath + "\\" + sfrFileName, prtFilePath + "\\" + jpgName);
                    //开始测试文件
                    logger.info("*************开始测试文件");
                    helpDev.dosCheckXmlUtil(prtFilePath + "\\" + sfrFileName,prtFilePath,checkers);
                    //lambda 必须使用final的值，不能使用--fileNums,因此需要提前将该值减一
                    int file_nums = fileNums-1;
                    //redis计数减一
                    logger.info("**************redis计数减一");
                    redisUtil.update(userId + "_" + submitRecord.getSrId(), String.valueOf(file_nums));

                } catch (IOException e) {
                    //出现异常
                    e.printStackTrace();
                }finally {
                    //每检测完成一个文件后，线程计数减一
                    logger.info("一个文件检测结束");
                    latch.countDown();

                }
                //不使用线程池的情况
                //1.抓图
//                helpDev.dosJpgExeUtil(prtFilePath + "\\" + sfrFileName, prtFilePath + "\\" + jpgName);
//                2.测试文件
//                helpDev.dosCheckXmlUtil(prtFilePath + "\\" + sfrFileName,prtFilePath,checkers);
//
            });
        }
        //主线程等待 线程池中的任务全部完成在执行下面的代码，即latch中的数据变为1
        try {
            latch.await();
        } catch (InterruptedException e) {
            logger.error("CountDownLatch线程池出错！");
            e.printStackTrace();
        }
        //关闭线程池
        pool.shutdown();*/

        //使用线程池，优化测试时间,虽然nx不支持多线程，但是我们可以将一个文件的抓图，和检测放到两个线程中去，因此这里需要两个线程
        ExecutorService pool = Executors.newFixedThreadPool(2);
        for (SubmitFileRecord submitFileRecord : submitFileRecords) {
            //获取文件名
            String sfrFileName = submitFileRecord.getSfrFileName();
            //根据文件名，给出对应的jpg文件名
            String jpgName = sfrFileName.substring(0, sfrFileName.lastIndexOf("."))+".jpg";
            //用于记录线程池中的任务有没有完成！两个线程所以值为2
            CountDownLatch latch = new CountDownLatch(2);
            //1.抓图
            pool.submit(() -> {
                try {
                    logger.info("开始抓图");
                    helpDev.dosJpgExeUtil(prtFilePath + "\\" + sfrFileName, prtFilePath + "\\" + jpgName);

                } catch (IOException e) {
                    e.printStackTrace();
                    logger.error("抓图出现错误");
                }finally {
                    logger.info("******************************该文件的抓图结束");
                    //线程每完成一个任务，数量就减一
                    latch.countDown();
                }
            });
            //2.测试文件
            pool.submit(() -> {
                try {
                    logger.info("开始测试文件！");
                    helpDev.dosCheckXmlUtil(prtFilePath + "\\" + sfrFileName, prtFilePath, checkers);

                } catch (IOException e) {
                    logger.error("测试文件出现错误！");
                    e.printStackTrace();
                }finally {
                    logger.info("********************************该文件的测试结束！");
                    //线程每完成一个任务，数量就减一
                    latch.countDown();
                }
            });
            //主线程等待 线程池中的任务全部完成在执行下面的代码，即latch中的数据变为1
            try {
                latch.await();
            } catch (InterruptedException e) {
                logger.error("CountDownLatch线程池出错！");
                e.printStackTrace();
            }
            //logger.error("线程池出错");
//            不使用线程池的情况
//            1.抓图
//            helpDev.dosJpgExeUtil(prtFilePath + "\\" + sfrFileName, prtFilePath + "\\" + jpgName);
//            2.测试文件
//            helpDev.dosCheckXmlUtil(prtFilePath + "\\" + sfrFileName,prtFilePath,checkers);
            logger.info("修改redis中待检测文件的数量，不改变失效时间的");
            redisUtil.update(userId + "_" + submitRecord.getSrId(), String.valueOf(--fileNums));
        }
        //关闭线程池
        pool.shutdown();
    }

    @Override
    public Map<String, String> getThePrtTestResult(int userId, SubmitRecord submitRecord, SubmitFileRecord submitFileRecord) throws IOException {
        //prt文件路径
        StringBuilder fileName = new StringBuilder();
        //fileName = submitRecord.getSrFileSaveURL() + "\\" + userId + "\\" + submitFileRecord.getSfrFilePath() + "\\" + submitFileRecord.getSfrFileName();
        fileName.append(submitRecord.getSrFileSaveURL());
        fileName.append("\\");
        fileName.append(userId);
        fileName.append("\\");
        fileName.append(submitFileRecord.getSfrFilePath());
        fileName.append("\\");
        String sfrFileName = submitFileRecord.getSfrFileName();
        /*根据文件名，给出对应的xml文件名*/
        String xmlFileName = sfrFileName.substring(0, sfrFileName.lastIndexOf("."))+".xml";
        String jpgFileName = sfrFileName.substring(0, sfrFileName.lastIndexOf("."))+".jpg";
        /*将本地的xml文件，转为json对象*/
        JSONObject jsonObject = helpDev.xmlToJson(fileName.toString()+xmlFileName);

        //构建prt预览图路径
        /*jpg保存在本地的文件夹中，访问时需要配置tomcat的虚拟路径
        *访问http://localhost:8888/SanWei/img实际访问的是文件保存路径HelpDev.FILEUPLADURL即submitFileRecord.getSfrFilePath()
        *即C:\workplace\IDEA\MyProject\fileUpload
        *
        *所以<img> 标签的src路径应该为<%=basePath%>img/
         *
        * */
        StringBuilder jpgFilePath = new StringBuilder();
        jpgFilePath.append("img/");
        jpgFilePath.append(userId);
        jpgFilePath.append("/");
        jpgFilePath.append(submitFileRecord.getSfrFilePath());
        jpgFilePath.append("/");
        jpgFilePath.append(jpgFileName);
        /*返回结果*/
        Map<String, String> maps = new HashMap<>();

        maps.put("jpgFilePath",jpgFilePath.toString() );

        maps.put("xmlFile", jsonObject.toString().replaceAll("chk:","chk_"));

        return maps;
    }
}
