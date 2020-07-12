package org.ycit.controller;

import com.aliyuncs.utils.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.ycit.entity.*;
import org.ycit.service.SubmitFileRecordService;
import org.ycit.service.SubmitRecordService;
import org.ycit.service.SubmitRuleRecordService;
import org.ycit.util.HelpDev;
import org.ycit.util.redis.RedisUtil;
import org.ycit.util.RespBean;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.*;
import java.util.concurrent.TimeUnit;

/*
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/28
 *  Time: 22:51
 */
@Controller
@RequestMapping("/submitRecord")
public class SubmitRecordController {

    private static Logger logger = Logger.getLogger(SubmitRecordController.class);

    @Resource
    RedisUtil redisUtil;
    @Resource
    HelpDev helpDev;
    @Resource
    SubmitRecordService submitRecordService;

    @Resource
    SubmitFileRecordService submitFileRecordService;

    @Resource
    SubmitRuleRecordService submitRuleRecordService;

    /*处理文件长传*/
    @PostMapping("/filesupload")
    @ResponseBody
    public RespBean uploadFiles(@RequestParam(value = "files", required = true) List<MultipartFile> files,
                                @RequestParam(value = "rules", required = true) List<Integer> rules, HttpSession session) {

        /*判断用户是否登录*/
        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        int user_id = (int) userId;
        /*存储prt文件*/

        /*上传文件的真实名字，与保存名字集合*/
        Map<String, Object> fileNames = null;
        try {
            /*1. 将文件保存到本地文件夹中，返回文件保存时的名字集合*/
            fileNames = helpDev.handlePrtUpload(user_id, files);

        } catch (IOException e) {
            e.printStackTrace();
        }

        /*2. 记录此次测试记录*/
        SubmitRecord submitRecord = new SubmitRecord();
        submitRecord.setSrUserId(user_id);
        submitRecord.setSrFileNumber(files.size());
        submitRecord.setSrRuleNumber(rules.size());
        /*其余参数在service中设置，这里只设置部分属性*/
        int srId = submitRecordService.addSR(submitRecord);
        /*3. 记录此次测试文件*/
        submitFileRecordService.addSFSList(srId, fileNames);
        /*4. 记录此次测试规则*/
        submitRuleRecordService.addSRRList(srId, rules);

        /*5. 将文件数量放到redis中:key为用户id_srId;时效为30分钟*/
        boolean set = redisUtil.set(user_id + "_" + srId, String.valueOf(files.size()), 30, TimeUnit.MINUTES);
        if (!set) {
            return RespBean.error("系统错误！");
        }

        /*6. 需要返回的数据有
         *
         * 1. 本次提交检测记录id，srId
         * 2. 本次提交检测记录文件数:files.size()
         * 3. 本次检测预计的时间：一个文件假设需要10s
         * */
        Map<String, Integer> resultMap = new HashMap<>();
        resultMap.put("srId", srId);
        resultMap.put("fileNum", files.size());
        resultMap.put("testTime", files.size() * HelpDev.TESTFILETIME);
        logger.info("文件上传处理成功！");
        return RespBean.ok("上传成功", resultMap);
    }



    /*获取测试记录集合，分页*/
    @GetMapping("/testRecordList")
    @ResponseBody
    public RespBean teamList(Integer currentPage, HttpSession session) {
        /*判断用户是否登录*/
        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        int user_id = (int) userId;

        /*获取用户测试记录总数*/
        int recordNumber = submitRecordService.queryRecordCountByUserId(user_id);
        /*用户没有提交记录*/
        if (recordNumber < 1) {
            return RespBean.inputError("您还没有测试记录，请先进行测试！");
        }
        /*分页*/
        PageHelp pageHelp = new PageHelp();
        pageHelp.setCurrentPage(currentPage);
        pageHelp.setRecordNumber(recordNumber);
        pageHelp.computeTotalPag();

        /*判断跳转页面是否合法*/
        int totalPage = pageHelp.getTotalPage();
        if (currentPage < 1 || currentPage > totalPage) {
            return RespBean.error("跳转页面超过总页面，请输入正确的要跳转的页面");
        }
        /*获取当前页用户测试记录*/
        List<SubmitRecord> submitRecords = submitRecordService.queryRecordListByUserId(user_id, currentPage);

        /*获取用户测试记录对应的文件名*/
        Map<Integer, List<SubmitFileRecord>> fileRecords = submitFileRecordService.queryFileRecordListBysrid(submitRecords);

        /*获取用户测试记录对应的测试选项名*/
        Map<Integer, List<String>> ruleRecords = submitRuleRecordService.queryRuleRecordListBysrid(submitRecords);
        /*
         * 对返回结果submitRecords进行处理，将文件名集合，测试选项集合与submitRecord对象封装在一个集合元素中
         *
         * 每一个result中应当包括
         *
         * submitRecord对象的所有信息
         *
         * 文件名集合
         *
         * 测试规则名集合
         * */
        List<Map<String, Object>> result = new ArrayList<>();

        for (SubmitRecord submitRecord : submitRecords) {
            Map<String, Object> rs = new HashMap<>();
            int srId = submitRecord.getSrId();
            rs.put("submitRecord", submitRecord);
            List<SubmitFileRecord> fileNames = fileRecords.get(srId);
            List<String> ruleNames = ruleRecords.get(srId);
            rs.put("fileNames", fileNames);
            rs.put("ruleNames", ruleNames);
            result.add(rs);
        }

        /*处理结果*/
        Map<String, Object> results = new HashMap<>();
        results.put("page", pageHelp);
        results.put("result", result);
        logger.info("用户查看测试记录成功");
        return RespBean.ok("查询成功!", results);
    }

    /*根据测试记录id删除信息*/
    @DeleteMapping("/deleteRecordBySrId")
    @ResponseBody
    public RespBean deleteRecordBySrId(int recordId) {
        /*
         * 删除三个表中的数据
         *
         * 将本地文件进行删除
         * */
        /*获取该记录对象，根据测试记录id获取测试记录所有信息*/
        SubmitRecord submitRecord = submitRecordService.queryRecordBySrId(recordId);
        //先删除子表
        submitFileRecordService.deleteFileRecordBySrId(recordId, submitRecord);
        submitRuleRecordService.deleteRuleRecordBySrId(recordId);
        /*在删除测试记录*/
        submitRecordService.deleteRecordBySrId(recordId);
        logger.info("本次测试记录的所有信息删除成功！");
        return RespBean.ok("删除成功");
    }

    /*定时获取文件检测进度*/
    @GetMapping("/getProgress")
    @ResponseBody
    public RespBean getProgress(@RequestParam(value = "srId", required = true) int srId, HttpSession session) {
        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        int user_id = (int) userId;
        /*向redis中获取，该用户的此时待检测的文件数量*/
        String o = (String) redisUtil.get(user_id + "_" + srId);
        /*数据失效*/
        if (StringUtils.isEmpty(o)) {
            String message = "测试记录过期！";
            return RespBean.error(message);
        }
        /*获取还没检查的文件数*/
        int fileNums = Integer.parseInt(o);
        return RespBean.ok("查询成功！", fileNums);
    }

    /*开始测试本次提交的文件*/
    @GetMapping("/beginTestFiles")
    @ResponseBody
    public RespBean beginTestFiles(@RequestParam(value = "srId", required = true) int srId, HttpSession session) {
        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }

        /*根据本次测试记录id，获取测试信息*/
        SubmitRecord submitRecord = submitRecordService.queryRecordBySrId(srId);
        /*获取本次测试记录的文件记录集合*/
        Map<Integer, List<SubmitFileRecord>> integerListMap = submitFileRecordService.queryFileRecordListBysrid(Arrays.asList(submitRecord));
        List<SubmitFileRecord> submitFileRecords = integerListMap.get(srId);

        /*获取本次测试记录的，测试规则的checker集合*/
        List<String> checkers = submitRuleRecordService.queryCheckerListBySrId(srId);
        /*开始测试文件*/
        submitRecordService.beginTestFiles(String.valueOf(((int) userId)), submitRecord, submitFileRecords, checkers);

        return RespBean.ok();
    }


    @GetMapping("/getTestResultFileList")
    @ResponseBody
    public RespBean getTestResult(@RequestParam(value = "srId") String srId, HttpSession session) {
        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        if (StringUtils.isEmpty(srId)) {

            String message = "请选择一条测试记录！";
            return RespBean.error(message);
        }

        SubmitRecord submitRecord = submitRecordService.queryRecordBySrId(Integer.valueOf(srId));


        /*根据srId获取测试文件列表*/
        List<SubmitFileRecord> submitFileRecords = submitFileRecordService.queryFileRecordsBysrid(Integer.valueOf(srId));

        Map<String, Object> maps = new HashMap<>();
        maps.put("fileList", submitFileRecords);
        maps.put("submitRecord", submitRecord);


        return RespBean.ok("查询文件提交列表成功！", maps);
    }

    @GetMapping("/getThePrtTestResult")
    @ResponseBody
    public RespBean getThePrtTestResult(@RequestParam(value = "sfrId") String sfrId, HttpSession session) {
        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        if (StringUtils.isEmpty(sfrId)) {
            String message = "请选择要查看结果的文件！";
            return RespBean.error(message);
        }

        /*根据sfrId获取测试文件对象*/
        SubmitFileRecord submitFileRecord = submitFileRecordService.queryFileRecordBySfrId(Integer.valueOf(sfrId));

        /*根据srId获取测试记录对象*/
        SubmitRecord submitRecord = submitRecordService.queryRecordBySrId(submitFileRecord.getSfrsrId());
        Map<String, String> thePrtTestResult = null;
        try {
            /*
             * jpgFilePath：jpg文件地址，<img>src属性为<%=basePath%>+jpgFilePath
             * xmlFile：xml文件转为json对象toString
             * */
            thePrtTestResult = submitRecordService.getThePrtTestResult((int) userId, submitRecord, submitFileRecord);


        } catch (IOException e) {
            e.printStackTrace();

            return RespBean.error("系统错误");

        }

        return RespBean.ok("文件测试结果查询成功！", thePrtTestResult);
    }

    @GetMapping("/downloadZip")
    @ResponseBody
    public RespBean downloadZip(@RequestParam(value = "srId") String srId, HttpSession session, HttpServletResponse response) {

        Object userId = session.getAttribute("user_id");
        if (userId == null) {
            String message = "您还没有登录，请先登录！";
            return RespBean.error(message);
        }
        int user_id = (int) userId;
        if (StringUtils.isEmpty(srId)) {
            String message = "请选择要下载的测试记录！";
            return RespBean.error(message);
        }
        SubmitRecord submitRecord = submitRecordService.queryRecordBySrId(Integer.valueOf(srId));

        List<SubmitFileRecord> submitFileRecords = submitFileRecordService.queryFileRecordsBysrid(Integer.valueOf(srId));
        String fileFolderPath = submitRecord.getSrFileSaveURL() + "\\" + user_id + "\\" + submitFileRecords.get(0).getSfrFilePath();

        File file = new File(fileFolderPath);
        // 获取所有文件
        List<File> fileList = Arrays.asList(file.listFiles());

        String zipFileName = UUID.randomUUID().toString() + ".zip";
        try {
            File zipFile = helpDev.zipFiles(fileList, submitRecord.getSrFileSaveURL() + "\\" + user_id + "\\zip", zipFileName);
            // 如果压缩文件大于20兆,返回提示
            Integer maxSize = 20;
            if (maxSize * 1024 * 1024 < zipFile.length()) {
                return RespBean.error("压缩包超过规定的20兆大小,限制下载");
            } else {
                // 将文件写出
                writeOut(response, zipFile);
                zipFile.delete();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return RespBean.ok("下载准备完成");
    }
    /**
     *将文件写出到流 【方法名】{方法的功能/动作描述}
     */
    private void writeOut(HttpServletResponse response, File zipFile) throws IOException {
        response.reset();
        response.setContentType("application/zip");
        response.setCharacterEncoding("utf-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + zipFile.getName());
        OutputStream outputStream = response.getOutputStream();
        FileInputStream fis = null;
        try {
            fis = new FileInputStream(zipFile.getPath());
            int len = 0;
            byte[] buffer = new byte[1024];
            while ((len = fis.read(buffer)) > 0) {
                outputStream.write(buffer, 0, len);
            }
            outputStream.flush();
        } finally {
            if (null != fis) {
                fis.close();
            }
            if (null != outputStream) {
                outputStream.close();
            }
        }
    }

}
