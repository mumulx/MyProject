package org.ycit.util;

public enum TpmIdentity {
    //数据库中的类型为enum，插入时enum类型的值需要加''
    ADMIN("项目成员","ADMIN","0"),
    MEMBER("管理员","MEMBER","1");
    TpmIdentity(){
    }
    private String message;
    private String identity;
    private String id;
    TpmIdentity(String message,String identity,String id){
        this.message = message;
        this.identity = identity;
        this.id = id;
    }
    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getIdentity() {
        return identity;
    }

    public void setIdentity(String identity) {
        this.identity = identity;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}
