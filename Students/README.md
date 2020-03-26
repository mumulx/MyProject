# 说明

本项目是在git上找的一个开源的git项目，并非原创（经过了自己的一些修改）

本项目是一个整合了ssh的Demo，里面的数据库（自己的阿里云服务器上部署的MySQL）已经配置好了，

只需要将本项目拷贝到本地，在eclipse中导入该项目，部署到tomcat（我使用的是tomcat9）容器中即可。

jar包也已经配置好了

可能jdk版本与各位不同，可以在eclipse导入项目后，右键项目Build Path-->configure build path里面配置jdk环境和tomcat环境。

然后就是启动tomcat9；访问

```
localhost:tomcat端口（默认是8080）/项目名
```

可以通过

```
用户名：zhangsan
密码：123456
```

登录，里面很简单，没写具体的业务代码