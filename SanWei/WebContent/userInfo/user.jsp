<%--
  Created by IntelliJ IDEA.
  User: 李旭
  Date: 2020/4/11
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";

%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
    <title>三维模型质量检查-个人中心</title>
    <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
    <link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
    <link rel="shortcut icon" href="<%=basePath %>favicon.ico">
</head>
<body style="margin-top:70px;background: #E3E7EA">

<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
    <ul class="nav nav-tabs">
        <li role="presentation"><a href="<%=basePath%>teamProject/team.jsp">我的项目</a></li>
        <li role="presentation" class="active"><a href="<%=basePath %>userInfo/user.jsp">我的主页</a></li>
    </ul>
    <ul class="breadcrumb" style="background: #E3E7EA;border-bottom: 1px solid #d4c4b7;">
        <li class="disabled"><p>我的主页</p></li>
        <li><a href="<%=basePath %>userInfo/user.jsp">个人信息列表</a></li>

    </ul>

    <div class="panel panel-default" style="border: 0px;">
        <div class="panel-body" style="background: #E3E7EA;border: 0px;">


            <form class="form-horizontal" name="userInfoEditForm" id="userInfoEditForm"
                  enctype="multipart/form-data" method="post" >

                <div class="form-group">
                    <label for="userInfo_edit_userName" class="col-sm-2 control-label">昵称</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input readonly type="text" class="form-control" placeholder="请输入昵称" id="userInfo_edit_userName" name="userInfo.userName">
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userName_btn">点击修改</button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="userInfo_edit_userTel" class="col-sm-2 control-label">联系电话</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input readonly type="text" class="form-control" placeholder="请输入联系电话" id="userInfo_edit_userTel" name="userInfo.userTel">
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userTel_btn">点击修改</button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="userInfo_edit_userEmail" class="col-sm-2 control-label">电子邮箱</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input readonly type="text" class="form-control" placeholder="xxx.xx@example.com" id="userInfo_edit_userEmail" name="userInfo.userEmail">
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userEmail_btn">点击修改</button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="userInfo_edit_userPwd" class="col-sm-2 control-label">登录密码</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input readonly type="text" class="form-control" placeholder="密码由6-20个字母、数字、下划线组成" id="userInfo_edit_userPwd" name="userInfo.userPwd">
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userPwd_btn">点击修改</button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group" id="userInfo_edit_confirmPassword_div" style="display: none">
                    <label for="userInfo_edit_confirmPassword" class="col-sm-2 control-label">确认密码</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input type="text" class="form-control" placeholder="确认密码" id="userInfo_edit_confirmPassword" name="userInfo.confirmPassword" >
                            <span class="input-group-btn">
                                <button disabled class="btn btn-warning" type="button">点击修改</button>
                            </span>
                        </div>

                    </div>
                </div>


                <div class="form-group">
                    <label for="userInfo_edit_birthdayDiv" class="col-sm-2 control-label">出生日期</label>
                    <div class="col-sm-8">
                        <div id="userInfo_edit_birthdayDiv"
                             class="input-group date userInfo_user_birthday col-md-12"
                             data-link-field="userInfo_birthday"
                             data-link-format="yyyy-mm-dd">

                            <input class="form-control" id="userInfo_edit_userBirthday"
                                   name="userInfo.userBirthday" size="16" type="text"
                                   placeholder="请选择出生日期" readonly/>


                            <span class="input-group-addon">
								<span class="glyphicon glyphicon-remove"></span>
							</span>

                            <span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span>
							</span>
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userBirthday_btn">点击修改</button>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label for="userInfo_edit_userSex" class="col-sm-2 control-label">性别</label>
                    <div class="col-md-8" id="userInfo_edit_userSex" name="userInfo_edit_userSex">

                        <div class="input-group">

                            <label class="radio-inline">
                                <input type="radio" value='1' id="userInfo_edit_userSex1" name="userInfo.userSex" disabled/>男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" value="0" id="userInfo_edit_userSex0" name="userInfo.userSex" disabled/> 女
                            </label>
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userSex_btn">点击修改</button>
                            </span>
                        </div>

                    </div>
                </div>
                <div class="form-group">
                    <label for="userInfo_edit_userAddress" class="col-sm-2 control-label">家庭住址</label>
                    <div class="col-sm-8">
                        <div class="input-group">
                            <input readonly type="text" class="form-control" placeholder="请输入家庭地址" id="userInfo_edit_userAddress" name="userInfo.userAddress">
                            <span class="input-group-btn">
                                <button class="btn btn-info" type="button" id="userInfo_edit_userAddress_btn">点击修改</button>
                            </span>
                        </div>
                    </div>
                </div>


                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="button" id="userInfoEditForm_submit" class="btn btn-success">&nbsp;&nbsp;修改&nbsp;&nbsp;</button>
                        <button type="button" id="userInfoEditForm_cancel" class="btn btn-danger">&nbsp;&nbsp;取消&nbsp;&nbsp;</button>

                    </div>

                </div>

            </form>
        </div>
    </div>







</div>

    <script src="<%=basePath%>plugins/jquery.min.js"></script>
    <script src="<%=basePath%>plugins/bootstrap.js"></script>
    <script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script>

    $ (document). ready (function() {

        $("#userInfo_edit_userName_btn").click(function () {
            $(this).attr("class","btn btn-warning");
            $("#userInfo_edit_userName").removeAttr("readonly");

        })
        $("#userInfo_edit_userTel_btn").click(function () {
            $(this).attr("class","btn btn-warning");
            $("#userInfo_edit_userTel").removeAttr("readonly");

        })
        $("#userInfo_edit_userEmail_btn").click(function () {
            $(this).attr("class","btn btn-warning");
            $("#userInfo_edit_userEmail").removeAttr("readonly");

        })
        $("#userInfo_edit_userBirthday_btn").click(function () {


                $(this).attr("class","btn btn-warning");
                //出生日期组件
                $('#userInfo_edit_birthdayDiv').datetimepicker({
                    language:  'zh-CN',  //显示语言
                    format: 'yyyy-mm-dd',
                    minView: 2,
                    weekStart: 1,
                    todayBtn:  1,
                    autoclose: 1,
                    minuteStep: 1,
                    todayHighlight: 1,
                    startView: 2,
                    forceParse: 0
                }).on('hide',function(e) {
                    //下面这行代码解决日期组件改变日期后不验证的问题
                    $('#userInfoEditForm').data('bootstrapValidator').updateStatus('userInfo.userBirthday', 'NOT_VALIDATED',null).validateField('userInfo.userBirthday');
                });


        })
        $("#userInfo_edit_userSex_btn").click(function () {
            $(this).attr("class","btn btn-warning");
            $("#userInfo_edit_userSex input").each(function () {
                $(this).removeAttr("disabled")
            })

        })




        $("#userInfo_edit_userPwd_btn").click(function () {
            $(this).attr("class","btn btn-warning");
            $("#userInfo_edit_userPwd").removeAttr("readonly");
            $("#userInfo_edit_confirmPassword_div").show();

        })





        $("#userInfo_edit_userAddress_btn").click(function () {
            $("#userInfo_edit_userAddress").removeAttr("readonly");
        })

        $("#userInfoEditForm_submit").click(function () {
            //提交之前先验证表单
            $("#userInfoEditForm").data('bootstrapValidator').validate();
            if(!$("#userInfoEditForm").data('bootstrapValidator').isValid()){
                return;
            }

            if (confirm("确定要修改吗？")){


                $.ajax({
                    url :  "<%=basePath%>" + "UserInfo/"+'${sessionScope.user_id}'+"/updateUserInfo",
                    type : "post",
                    dataType: "json",
                    data: new FormData($("#userInfoEditForm")[0]),
                    success : function (obj, response, status) {
                        if(obj.success){
                            alert("信息修改成功！");
                            $("#userInfoQueryForm").submit();

                        }else{
                            alert(obj.message);
                        }
                        window.location.reload();
                    },
                    processData: false,
                    contentType: false,
                });
            }else {
                window.location.reload();

            }

        })
    })
    $("#userInfoEditForm_cancel").click(function () {
        window.location.reload();
    })
    function initUserInfo(){
        $.ajax({
            url : "<%=basePath%>" + "UserInfo/userInfoList",
            type : 'get',
            dataType: "json",
            data : {},
            success : function (obj, response, status) {
                if (obj.success) {
                    $("#userInfo_edit_userName").val(obj.obj.userName);
                    $("#userInfo_edit_userTel").val(obj.obj.userTel);
                    $("#userInfo_edit_userEmail").val(obj.obj.userEmail);
                    $("#userInfo_edit_userBirthday").val(obj.obj.userBirthday);
                    $("#userInfo_edit_userAddress").val(obj.obj.userAddress);
                    if(obj.obj.userSex=="男"){
                        $("#userInfo_edit_userSex1").attr("checked","true");

                    }else{
                        $("#userInfo_edit_userSex0").attr("checked","true");
                    }
                } else {

                    alert(obj.message);
                    //console.log(a);
                    //history.back();
                    window.location.href = "<%=basePath%>";
                }
            }
        });
    }
    $(function() {
        //初始化用户数据
        initUserInfo();
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $(this).css("background","lightgreen");
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
        //验证用户添加表单字段
        $('#userInfoEditForm').bootstrapValidator({

            fields : {
                "userInfo.userName" : {
                    validators : {
                        notEmpty : {
                            message : "昵称不能为空",
                        }
                    }
                },"userInfo.userTel" : {
                    validators : {
                        notEmpty : {
                            message : "联系电话不能为空",
                        },
                        regexp : {
                            regexp : /^1(3|4|5|6|7|8|9)\d{9}$/,
                            message : '电话格式不正确'
                        }
                    }
                },
                "userInfo.userPwd" : {
                    validators : {
                        regexp : {
                            regexp : /^(\w){6,20}$/,
                            message : '密码只能由6-20个字母、数字、下划线组成'
                        }
                    }
                },
                "userInfo.confirmPassword" : {
                    validators : {

                       identical: {
                            field: 'userInfo.userPwd',
                            message: '2次密码不一致'
                        }
                    }
                },
                "userInfo.userEmail" : {
                    validators : {
                        notEmpty : {
                            message : "电子邮箱不能为空",
                        },
                        regexp : {
                            regexp : /^([a-zA-Z]|[0-9])(\w|\-)+@[a-zA-Z0-9]+\.([a-zA-Z]{2,4})$/,
                            message : '电子邮箱格式不正确'
                        }
                    }
                },

                "userInfo.userBirthday" : {
                    validators : {
                        notEmpty : {
                            message : "出生日期不能为空",
                        }
                    }
                },
                "userInfo.userAddress" : {
                    validators : {
                        notEmpty : {
                            message : "家庭地址不能为空",
                        }
                    }
                },
            }
        });


    });



</script>

</body>
</html>
