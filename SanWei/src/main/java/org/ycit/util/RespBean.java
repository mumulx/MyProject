package org.ycit.util;

import lombok.Getter;
import lombok.Setter;
import org.ycit.util.exception.CustomExceptionType;

/*  ajax 返回信息json工具类
 *  Created by IntelliJ IDEA.
 *  User: 木木
 *  Date: 2020/4/29
 *  Time: 10:52
 *  使用单例模式创建一个数据返回的对象
 */
@Setter
@Getter
public class RespBean {
    private Integer status;//状态码
    private Boolean success;//是否成功
    private String message;//信息
    private Object obj;//对象

    public static RespBean build() {
        return new RespBean();
    }

    public static RespBean ok() {
        return new RespBean(CustomExceptionType.STATUS_SUCCESS.getCode(), true, "",null);
    }
    public static RespBean ok(String message) {
        return new RespBean(CustomExceptionType.STATUS_SUCCESS.getCode(), true, message,null);
    }
    public static RespBean ok(Object obj) {
        return new RespBean(CustomExceptionType.STATUS_SUCCESS.getCode(), true, null,obj);
    }

    public static RespBean ok(String message, Object obj) {
        return new RespBean(CustomExceptionType.STATUS_SUCCESS.getCode(),true, message, obj);
    }
    public static RespBean error() {
        return new RespBean(CustomExceptionType.SYSTEM_ERROR.getCode(), false,"",null);
    }
    public static RespBean error(String message) {
        return new RespBean(CustomExceptionType.SYSTEM_ERROR.getCode(), false,message,null);
    }

    public static RespBean error(String message, Object obj) {
        return new RespBean(CustomExceptionType.SYSTEM_ERROR.getCode(),false,message, obj);
    }


    public static RespBean inputError(String message, Object obj) {
        return new RespBean(CustomExceptionType.USER_INPUT_ERROR.getCode(),false,message, obj);
    }

    public static RespBean inputError() {
        return new RespBean(CustomExceptionType.USER_INPUT_ERROR.getCode(),false,"", null);
    }
    public static RespBean inputError(String message) {
        return new RespBean(CustomExceptionType.USER_INPUT_ERROR.getCode(),false,message, null);
    }


    private RespBean() {
    }
    private RespBean(Integer status, Boolean success, String message, Object obj) {
        this.status = status;
        this.success = success;
        this.message = message;
        this.obj = obj;
    }

    private RespBean(Integer status, String message, Object obj) {
        this.status = status;
        this.message = message;
        this.obj = obj;
    }
}