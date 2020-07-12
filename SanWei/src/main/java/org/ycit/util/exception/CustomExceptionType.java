package org.ycit.util.exception;

public enum CustomExceptionType {
    USER_INPUT_ERROR(400,"用户输入异常"),
    SYSTEM_ERROR (500,"系统服务异常"),
    OTHER_ERROR(999,"其他未知异常"),
    STATUS_SUCCESS(200,"一切正常"),
    JPGEXE_ERROR(501,"该prt文件不存在，或DOS输入参数有误，请检查输入参数！"),
    JPGEXE_FILENOTPREVIEW(502,"该prt文件没有预览图！");

    CustomExceptionType(int code, String typeDesc) {
        this.code = code;
        this.typeDesc = typeDesc;
    }
    private String typeDesc;//异常类型中文描述

    private int code; //code

    public String getTypeDesc() {
        return typeDesc;
    }

    public int getCode() {
        return code;
    }
}