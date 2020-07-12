package org.ycit.util.exception;

import org.apache.log4j.Logger;
import org.springframework.jdbc.CannotGetJdbcConnectionException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MaxUploadSizeExceededException;
import org.ycit.util.RespBean;

/*统一异常处理
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/5/10
 *  Time: 17:56
 */
@ControllerAdvice
public class ExceptionHandle {
    private static Logger logger = Logger.getLogger(ExceptionHandle.class);
    /*上传文件太大，报异常*/
    @ExceptionHandler(value = MaxUploadSizeExceededException.class)
    @ResponseBody
    public RespBean maxUploadSizeExceededException() {
        logger.error("*********************************文件太大");
        return RespBean.error("文件长传太大！");
    }
    @ExceptionHandler(value = CannotGetJdbcConnectionException.class)
    @ResponseBody
    public RespBean cannotGetJdbcConnectionException() {
        logger.error("*********************************数据库连接异常");
        return RespBean.error("数据库连接异常！");
    }

    /*其他异常*/
    @ExceptionHandler(value = Exception.class)
    @ResponseBody
    public RespBean otherException() {
        logger.error("*********************************其他异常");

        return RespBean.error("系统异常！");
    }
}
