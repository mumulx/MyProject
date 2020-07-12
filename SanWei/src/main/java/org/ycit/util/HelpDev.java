package org.ycit.util;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.IOUtils;
import org.apache.ibatis.cache.Cache;
import org.json.JSONObject;
import org.json.XML;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DataAccessException;
import org.springframework.data.redis.connection.RedisConnection;
import org.springframework.data.redis.core.RedisCallback;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.ycit.entity.SubmitRecord;
import java.io.*;
import java.util.*;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@Component("helpDev")
public class HelpDev {
    private final static Logger logger = LoggerFactory.getLogger(HelpDev.class);

    //window本地
    //定义上传prt保存的本地文件夹
    public static final String FILEUPLADURL = "C:\\workplace\\IDEA\\MyProject\\fileUpload";
    /*UG环境*/
    public static final String CHECKMATEPATH = "C:\\Program Files\\Siemens\\NX 12.0\\UGII";
    /*获取文件预览图的exe文件位置*/
    public static final String JPGEXEPATH = "C:\\Users\\26069\\Desktop\\nx项目\\需求分析\\ImgDos";
    //本次检测预计的时间：一个文件假设需要5s
    public static final int TESTFILETIME = 5;

    //部署在linux
    //private static final String UPLADMIMGSRC = "/app/tools";

    //MD5加密
    public String md5Encode(byte[] input) {
        return DigestUtils.md5Hex(input);//byte[]--->String
    }

    //将xml文件转为Json
    public JSONObject xmlToJson(String fileName) throws IOException {
        FileInputStream inputStream = new FileInputStream(new File(fileName));
        String xmlStr = IOUtils.toString(inputStream, "UTF-8");
        JSONObject object = XML.toJSONObject(xmlStr);
        return object;
    }

    /**
     * 使用UUID生成文件名称
     */
    public static String UUIDPathName() {
        String filePathName = UUID.randomUUID().toString();//构建文件名称
        return filePathName;
    }

    /**
     * 处理prt文件上传，文件存储到FILEUPLADURL文件存储路径+用户id文件夹+随机字符串文件夹中
     */
    public Map<String, Object> handlePrtUpload(int userId, List<MultipartFile> prts) throws IOException {

        /*key为文件保存的文件夹，value为文件夹中的所有文件的文件名集合*/
        Map<String, Object> files = new HashMap<>();

        /*所有文件名集合*/
        List<String> fileNames = new ArrayList<>();

        /*产生随机字符串用于存储本次提交记录的prt，即文件存储的文件夹名称*/
        String uuidPathName = UUIDPathName();

        /*文件存储路径由，存储根目录：FILEUPLADURL+用户id：userId+随机字符串：uuidPathName*/
        String prtFilesUploadPath = FILEUPLADURL + "\\" + userId + "\\" + uuidPathName + "\\";

        File prtSaveFile = new File(prtFilesUploadPath);
        /*创建文件目录*/
        if (!prtSaveFile.exists()) {
            prtSaveFile.mkdirs();
        }
        /*处理文件*/
        for (MultipartFile prt : prts) {
            if (!prt.isEmpty()) {
                /*文件真实的名称*/
                String FileName = prt.getOriginalFilename();
                /**拼成完整的文件保存路径加文件**/
                String prtFilePath = prtFilesUploadPath + FileName;
                File prtFile = new File(prtFilePath);
                prt.transferTo(prtFile);
                fileNames.add(FileName);
            }
        }
        files.put("filePath", uuidPathName);
        files.put("fileNames", fileNames);
        return files;
    }


    /*使用check-mate进行文件测试*/
    public void dosCheckXmlUtil(String prtFilePath, String logSavePath, List<String> checkRules) throws IOException {
        /*这里使用StringBuilder而不是String，是因为有频繁的String拼接，会产生大量的垃圾*/
        StringBuilder checkCmd = new StringBuilder();
        // Java调用 dos命令
        //可以使用 & 来连接两条命令
        String init = "cmd /c cd " + CHECKMATEPATH;
        checkCmd.append("ug_check_part -checker ");
        for (String checkRule : checkRules) {
            //checkCmd=checkCmd+" "+checkRule+",";
            checkCmd.append(checkRule + ",");
        }
        //去掉最后一个','
        checkCmd.deleteCharAt(checkCmd.length() - 1);
        checkCmd.append(" " + prtFilePath);
        checkCmd.append(" -log_dir " + logSavePath);
        String cmd = init + " & " + checkCmd;
        /*执行*/
        Process process = Runtime.getRuntime().exec(cmd);
        getExeOut(process);
    }
    //获取exe输出
    private List<String> getExeOut(Process process) throws IOException {
        BufferedReader input = new BufferedReader(new InputStreamReader(process.getInputStream(), "GBK"));
        List<String> lines = new ArrayList<>();
        String line = null;
        /*读取返回结果*/
        while ((line = input.readLine()) != null) {
            lines.add(line);
        }
        logger.error("--------------------------------运行exe给出的响应，给出的响应");
        logger.info("{}",lines);
        //System.out.println(lines);
        return lines;
    }

    /*给出默认的预览图*/
    public void initPrtJpg(String jpgFilePath) {
        InputStream in = null;
        OutputStream out = null;
        try {
            //->内存
            //给出默认的预览图
            in = new FileInputStream(FILEUPLADURL + "\\init.png");
            //预览图文件地址
            out = new FileOutputStream(jpgFilePath);
            //开辟1024字节的内存
            byte[] buf = new byte[1024];
            int len = -1;
            while ((len = in.read(buf)) != -1) {//in ->buf
                out.write(buf, 0, len);//buf->out
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        } finally {
            try {
                if (out != null) out.close();
                if (in != null) in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    /*获取指定prt的预览图，并将图保存到指定位置*/
    public void dosJpgExeUtil(String prtFilePath, String jpgFilePath) throws IOException {
        /*环境准备*/
        String init = "cmd /c cd " + JPGEXEPATH;

        /*调用exe进行抓图*/
        String checkCmd = ".\\test04.exe " + prtFilePath + " " + jpgFilePath;
        String cmd = init + " & " + checkCmd;
        /*执行*/
        Process process = Runtime.getRuntime().exec(cmd);
        //List<String> lines

        List<String> lines = getExeOut(process);
        /**dos框返回参数
         * -3:未知异常 ：1.参数不对  2.文件不存在
         * -2：//文件没有预览图，返回-2  会给一个默认的预览图（这种情况可能不会发生，）
         * -1：参数类型不对
         * 0：文件加载失败：即文件不存在
         * 1：成功
         */
        String result = lines.get(0);
        /*给出默认预览图*/
        if (!"1".equals(result)) {
            initPrtJpg(jpgFilePath);
        }
        /*if ("1".equals(result)) {
        }else if("-2".equals(result)){
            initPrtJpg(jpgFilePath);
        }else {
            initPrtJpg(jpgFilePath);
        }*/
    }

    /**
     * 删除文件夹中的所有内容，包括文件夹
     *
     * @param directory
     */
    public static void delAllFile(File directory) {
        if (!directory.isDirectory()) {
            directory.delete();
        } else {
            File[] files = directory.listFiles();
            // 空文件夹
            if (files.length == 0) {
                directory.delete();
                return;
            }
            // 删除子文件夹和子文件
            for (File file : files) {
                if (file.isDirectory()) {
                    delAllFile(file);
                } else {
                    file.delete();
                }
            }
            // 删除文件夹本身
            directory.delete();
        }
    }

    public void deleteUserPrts(SubmitRecord submitRecord, String sfrFilePath) {
        //删除文件
        /*用户id*/
        int srUserId = submitRecord.getSrUserId();
        /*文件保存路径*/
        String srFileSaveURL = submitRecord.getSrFileSaveURL();
        //文件真正的存储路径在 保存路径/用户id文件夹中
        String fileRealSavePath = srFileSaveURL + "\\" + srUserId + "\\" + sfrFilePath;
        File directory = new File(fileRealSavePath);
        delAllFile(directory);
        logger.info("删除用户本次提交记录的所有文件信息成功");
    }

    /**
     * 验证手机号是否合法
     *
     * @return
     */
    public static boolean isMobileNO(String mobile) {
        if (mobile.length() != 11) {
            return false;
        } else {
            /**
             * 移动号段正则表达式
             */
            String pat1 = "^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
            /**
             * 联通号段正则表达式
             */
            String pat2 = "^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
            /**
             * 电信号段正则表达式
             */
            String pat3 = "^((133)|(153)|(177)|(18[0,1,9])|(149))\\d{8}$";
            /**
             * 虚拟运营商正则表达式
             */
            String pat4 = "^((170))\\d{8}|(1718)|(1719)\\d{7}$";

            Pattern pattern1 = Pattern.compile(pat1);
            Matcher match1 = pattern1.matcher(mobile);
            boolean isMatch1 = match1.matches();
            if (isMatch1) {
                return true;
            }
            Pattern pattern2 = Pattern.compile(pat2);
            Matcher match2 = pattern2.matcher(mobile);
            boolean isMatch2 = match2.matches();
            if (isMatch2) {
                return true;
            }
            Pattern pattern3 = Pattern.compile(pat3);
            Matcher match3 = pattern3.matcher(mobile);
            boolean isMatch3 = match3.matches();
            if (isMatch3) {
                return true;
            }
            Pattern pattern4 = Pattern.compile(pat4);
            Matcher match4 = pattern4.matcher(mobile);
            boolean isMatch4 = match4.matches();
            if (isMatch4) {
                return true;
            }
            return false;
        }
    }


    // 批量文件压缩成zip包
    public File zipFiles(List<File> fileList, String zipPath, String zipName) throws IOException {
        // 如果被压缩文件中有重复，会重命名
        Map<String, String> namePathMap = getTransferName(fileList);
        File zipPathFile = new File(zipPath);
        // 文件夹不存在则创建
        if (!zipPathFile.exists()) {
            zipPathFile.mkdirs();
        }
        File zipFile = new File(zipPath + File.separator + zipName);
        if (!zipFile.exists()) {
            zipFile.createNewFile();
        }
        ZipOutputStream zos = null;
        BufferedInputStream bis = null;
        try {
            // 存放的目标文件
            zos = new ZipOutputStream(new BufferedOutputStream(new FileOutputStream(zipFile.getPath())));
            Set<String> keySet = namePathMap.keySet();
            ZipEntry zipEntry = null;
            for (String key : keySet) { // key是文件名，value是path
                // 指定源文件
                File sourceFile = new File(namePathMap.get(key));
                // 创建ZIP实体，并添加进压缩包,指定压缩文件中的文件名
                zipEntry = new ZipEntry(key);
                zos.putNextEntry(zipEntry);
                // 读取待压缩的文件并写进压缩包里
                bis = new BufferedInputStream(new BufferedInputStream(new FileInputStream(sourceFile), 1024 * 10));
                byte[] bufs = new byte[1024 * 10];
                int read = 0;
                while ((read = (bis.read(bufs, 0, 1024 * 10))) != -1) {
                    zos.write(bufs, 0, read);
                }
                if (bis != null) {
                    bis.close();
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        } finally {
// 关闭流
            if (bis != null) {
                bis.close();
            }
            if (null != zos) {
                zos.close();
            }
        }
        return zipFile;
    }


    // 计算压缩包如果已存在重复的名称，则在重复文件后面跟上数字 如: 文件(1).doc,文件(2).doc
    public Map<String, String> getTransferName(List<File> fileList) {
        if (fileList == null || fileList.size() == 0) {
            return new HashMap<String, String>();
        }
        // key存放文件名，value存放path
        Map<String, String> fileNameMap = new HashMap<>();
        List<String> fileNames = new ArrayList<>();
        for (File file : fileList) {
            // 获取文件名
            String fileName = file.getName();
            int count = 0;

            for (String name : fileNames) {
                if (name != null && name.equals(fileName)) {
                    count++;
                }
            }
            fileNames.add(fileName);
            if (count > 0) {
                int lastIndex = fileName.lastIndexOf('.');
                String name = fileName.substring(0, lastIndex);
                String type = fileName.substring(lastIndex + 1, fileName.length());
                fileName = new StringBuilder().append(name).append("(").append(count).append(")").append(".")
                        .append(type).toString();
                fileNameMap.put(fileName, file.getPath());
            } else {
                fileNameMap.put(fileName, file.getPath());
            }
        }
        return fileNameMap;
    }


    /*
     *  Created by IntelliJ IDEA.
     *  User: 木木
     *  Date: 2020/5/5
     *  Time: 22:47
     */
    public static class RedisCache implements Cache //实现类
    {
        private static final Logger logger = LoggerFactory.getLogger(RedisCache.class);

        private static RedisTemplate<String,Object> redisTemplate;

        private final String id;

        /**
         * The {@code ReadWriteLock}.
         */
        private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();

        @Override
        public ReadWriteLock getReadWriteLock()
        {
            return this.readWriteLock;
        }

        public static void setRedisTemplate(RedisTemplate redisTemplate) {
            RedisCache.redisTemplate = redisTemplate;
        }

        public RedisCache(final String id) {
            if (id == null) {
                throw new IllegalArgumentException("Cache instances require an ID");
            }
            logger.debug("MybatisRedisCache:id=" + id);
            this.id = id;
        }

        @Override
        public String getId() {
            return this.id;
        }

        @Override
        public void putObject(Object key, Object value) {
            try{
                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>putObject: key="+key+",value="+value);
                if(null!=value)
                    redisTemplate.opsForValue().set(key.toString(),value,60, TimeUnit.SECONDS);
            }catch (Exception e){
                e.printStackTrace();
                logger.error("redis保存数据异常！");
            }
        }

        @Override
        public Object getObject(Object key) {
            try{
                logger.info(">>>>>>>>>>>>>>>>>>>>>>>>getObject: key="+key);
                if(null!=key)
                    return redisTemplate.opsForValue().get(key.toString());
            }catch (Exception e){
                e.printStackTrace();
                logger.error("redis获取数据异常！");
            }
            return null;
        }

        @Override
        public Object removeObject(Object key) {
            try{
                if(null!=key)
                    return redisTemplate.expire(key.toString(),1,TimeUnit.DAYS);
            }catch (Exception e){
                e.printStackTrace();
                logger.error("redis获取数据异常！");
            }
            return null;
        }

        @Override
        public void clear() {
            Long size=redisTemplate.execute(new RedisCallback<Long>() {
                @Override
                public Long doInRedis(RedisConnection redisConnection) throws DataAccessException {
                    Long size = redisConnection.dbSize();
                    //连接清除数据
                    redisConnection.flushDb();
                    redisConnection.flushAll();
                    return size;
                }
            });
            logger.info(">>>>>>>>>>>>>>>>>>>>>>>>clear: 清除了" + size + "个对象");
        }

        @Override
        public int getSize() {
            Long size = redisTemplate.execute(new RedisCallback<Long>() {
                @Override
                public Long doInRedis(RedisConnection connection)
                        throws DataAccessException {
                    return connection.dbSize();
                }
            });
            return size.intValue();
        }
    }
}
