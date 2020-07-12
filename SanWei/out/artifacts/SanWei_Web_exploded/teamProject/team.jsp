<%--
  Created by IntelliJ IDEA.
  User: 李旭
  Date: 2020/4/11
  Time: 15:14
  To change this template use File | Settings | File Templates.
--%>

<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
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
    <link rel="shortcut icon" href="<%=basePath %>favicon.ico" >
    <link href="<%=basePath %>css/userTeam/userTeam_team.css" rel="stylesheet">

</head>
<body  style="">

<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
    <ul class="nav nav-tabs">
        <li role="presentation" class="active"><a href="<%=basePath %>TeamInfo/teamList">我的项目</a></li>
        <li role="presentation"><a href="<%=basePath %>userInfo/user.jsp">我的主页</a></li>
    </ul>
    <ul class="breadcrumb">
        <li><p>我的项目</p></li>
        <li><a href="<%=basePath %>teamProject/team.jsp">项目列表</a></li>
        <li class="active"></li>
    </ul>

    <div>
        <div class="col" id="create_team_div">
            <div class="col-xs-6 col-md-3 create_team" onclick="opencreateTeamDialog()">
                <a href="#" class="thumbnail">
                    <div class="row" >
                        <div class="col-md-12" >
                            <p class="text-center create_team_big">+</p>
                        </div>

                        <div class="col-md-12">
                            <p class="text-center"> 创建项目</p>
                        </div>

                    </div>

                </a>
            </div>

        </div>
    </div>
   <%-- <div class="col">
        <div class="col-xs-6 col-md-3">
            <a href="#" class="thumbnail">
                <div class="row" >
                    <div class="col-md-12" id="team_div">
                        <div class="col-md-12">
                            <input type="hidden" value="11">
                            <p>&nbsp</p>
                            <p id="teamName" class="text-center">减速器</p>
                        </div>
                        <div class="col-md-12">
                            <p id="teamCreateTime" class="text-center">2019-1-1</p>

                        </div>
                    </div>

                    <div class="col-md-12 team_div_btn">
                        <div class="col-md-7" >
                            <button type="button" class="btn btn-block team_div_btn_button" style="outline: none;">项目内容</button>

                        </div>
                        <div class="col-md-5">
                            <button type="button" class="btn btn-block team_div_btn_button" style="outline: none;">设置</button>

                        </div>
                    </div>

                </div>

            </a>
        </div>
    </div>
    --%>
    <div class="row">
        <div class="col-md-12">
            <nav class="pull-left">
                <ul class="pagination" id="page_value_init">


                    <li>
                        <div class="col-lg-3">
                            <div class="input-group">
                                <input type="hidden" id="totalPage">
                                <input type="hidden" id="recordNumber">
                                <input type="hidden" id="currentPage">

                                <input onkeyup="this.value=this.value.replace(/\D/g,'')" type="text" id="pageValue" class="form-control" placeholder="跳转到指定页面">
                                <span class="input-group-btn">
												        <button class="btn btn-default" type="button" onclick="goPage(-1)">Go</button>
												      </span>
                            </div>
                        </div>
                    </li>
                    <li>
                        <div class="col-lg-4">
                            <div class="pull-right" style="line-height:34px;" >共有<span id="recordNumber_value"></span>条记录，当前第 <span id="currentPage_value"></span>/<span id="totalPage_value"></span>页</div>
                        </div>
                    </li>
                </ul>
            </nav>
        </div>
    </div>


</div>



<div id="createTeamDialog" class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"
                        aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">
                    <i class="fa fa-reorder"></i>&nbsp;创建项目
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" name="createTeamForm" id="createTeamForm"
                      enctype="multipart/form-data" method="post" class="mar_t15">

                    <div class="form-group">
                        <label for="teamForm_tpName" class="col-md-3 text-right">项目名称:</label>
                        <div class="col-md-8">
                            <input type="text" id="teamForm_tpName" name="teamProject.tpName"
                                   class="form-control" placeholder="项目名称">
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="teamForm_tpMsg" class="col-md-3 text-right">项目描述:</label>
                        <div class="col-md-8">
                            <input type="text" id="teamForm_tpMsg" name="teamProject.tpMsg"
                                   class="form-control" placeholder="请输入项目描述">
                        </div>
                    </div>

                </form>
                <style>
                    #bookTypeAddForm .form-group {
                        margin-bottom: 10px;
                    }
                </style>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" onclick="ajaxCreateTeamProject();">添加</button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal-dialog -->
</div>

























    <script src="<%=basePath%>plugins/jquery.min.js"></script>
    <script src="<%=basePath%>plugins/bootstrap.js"></script>
    <script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
    <script type="text/javascript" src="<%=basePath%>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
    <script type="text/javascript" src="<%=basePath %>js/index.js"></script>


<script>
    function opencreateTeamDialog() {

        $("#createTeamDialog input").val("");
        $('#createTeamDialog').modal('show');

    }
    function ajaxCreateTeamProject () {

//提交之前先验证表单
        $("#createTeamForm").data('bootstrapValidator').validate();
        if(!$("#createTeamForm").data('bootstrapValidator').isValid()){
            return;
        }
        jQuery.ajax({
            type : "post",
            url : basePath + "TeamProject/add",
            dataType : "json" ,
            data: new FormData($("#createTeamForm")[0]) ,
            processData: false,   // jQuery不要去处理发送的数据
            contentType: false,
            success : function(obj) {
                if(obj.success){
                    alert(obj.message);
                    $("#createTeamForm").find("input").val("");
                    $('#createTeamDialog').modal('hide');
                    window.location.reload();

                } else {

                    alert(obj.message);
                    window.location.href="<%=basePath%>index.jsp";
                }
            }
        });


    }

    function initTeamProjectData(tpId,tpName,tpDate) {
        var $divTag=$("<div class=\"col\">\n" +
            "        <div class=\"col-xs-6 col-md-3\">\n" +
            "            <a href=\"#\" class=\"thumbnail\">\n" +
            "                <div class=\"row\" >\n" +
            "                    <div class=\"col-md-12\" id=\"team_div\">\n" +
            "                        <div class=\"col-md-12\">\n" +
            "                            <input id='tpDate' type=\"hidden\" value=\""+tpId+"\">\n" +
            "                            <p>&nbsp</p>\n" +
            "                            <p id=\"teamName\" class=\"text-center\">"+tpName+"</p>\n" +
            "                        </div>\n" +
            "                        <div class=\"col-md-12\">\n" +
            "                            <p id=\"teamCreateTime\" class=\"text-center\">"+tpDate+"</p>\n" +
            "\n" +
            "                        </div>\n" +
            "                    </div>\n" +
            "\n" +
            "                    <div class=\"col-md-12 team_div_btn\">\n" +
            "                        <div class=\"col-md-7\" >\n" +
            "                            <button type=\"button\" class=\"btn btn-block team_div_btn_button\" style=\"outline: none;\">项目内容</button>\n" +
            "\n" +
            "                        </div>\n" +
            "                        <div class=\"col-md-5\">\n" +
            "                            <button type=\"button\" class=\"btn btn-block team_div_btn_button\" style=\"outline: none;\">设置</button>\n" +
            "\n" +
            "                        </div>\n" +
            "                    </div>\n" +
            "\n" +
            "                </div>\n" +
            "\n" +
            "            </a>\n" +
            "        </div>\n" +
            "\n" +
            "    </div>");
        $("#create_team_div").after($divTag);

    }
    function initPage(currentPage,totalPage,recordNumber) {
        $("#currentPage").val(currentPage);
        $("#totalPage").val(totalPage);
        $("#recordNumber").val(recordNumber);

        $("#currentPage_value").text(currentPage);
        $("#totalPage_value").text(totalPage);
        $("#recordNumber_value").text(recordNumber);

        $("#page_value_init").children("li").filter(".page_init_item").remove();

        var $pageValueTem;
        $pageValueTem=$("<li class='page_init_item'><a href=\"#\" onclick=\"goPage("+(currentPage+1)+");\"><span aria-hidden=\"true\">&raquo;</span></a></li>\n")
        $("#page_value_init").prepend($pageValueTem);

        for (var i=totalPage;i>0;i--){
            if (i==currentPage){
                $pageValueTem=$("<li class=\"active page_init_item\"><a href=\"#\"  onclick=\"goPage("+i+");\">"+i+"</a></li>");

            } else{
                $pageValueTem =$("<li class='page_init_item'><a href=\"#\"  onclick=\"goPage("+i+");\">"+i+"</a></li>");
            }

            $("#page_value_init").prepend($pageValueTem);

        }
        $pageValueTem=$("<li class='page_init_item'><a href=\"#\" onclick=\"goPage("+(currentPage-1)+");\" aria-label=\"Previous\"><span aria-hidden=\"true\">&laquo;</span></a></li>\n");

        $("#page_value_init").prepend($pageValueTem);


    }
    function initTeamProject(currentPage){
        $.ajax({
            url : basePath + "TeamProject/teamList",
            type : 'get',
            dataType: "json",
            data : {currentPage:currentPage},
            success : function (obj, response, status) {
                if (obj.success) {

                    obj.obj.obj.forEach(function (objValue) {
                        //console.log(objValue);
                        initTeamProjectData(objValue.tpId,objValue.tpName,objValue.tpDate);
                    })
                    initPage(obj.obj.page.currentPage,obj.obj.page.totalPage,obj.obj.page.recordNumber);
                    //console.log(obj.obj);

                } else {

                    alert(obj.message);
                    window.location.href = "<%=basePath%>";
                }
            }
        });
    }

    function goPage(currentPage){
        var totalPage = $("#totalPage").val();
        //说明是跳转页面通过点击Gobutton；跳转的页面的值在pageValue文本框中
        if (currentPage==-1){
            currentPage =$("#pageValue").val();
            //用户是否输入跳转页面的值，进行非空判断
            if (currentPage.length<=0){
                alert("请输入跳转页面");
                return;
            }
        }
        //页面不存在
        if (!((parseInt(currentPage)>0)&&(parseInt(currentPage)<=parseInt(totalPage)))) {
            alert("页面不存在");
            return;
        }
        //先将已经加载的项目信息删除掉
        $("#create_team_div").siblings("div").remove();
        //alert(currentPage);
        initTeamProject(currentPage);
    }
    $(function() {
        initTeamProject(1);
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $(this).css("background","lightgreen");
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();


        //验证用户添加表单字段
        $('#createTeamForm').bootstrapValidator({
            feedbackIcons : {
                valid : 'glyphicon glyphicon-ok',
                invalid : 'glyphicon glyphicon-remove',
                validating : 'glyphicon glyphicon-refresh'
            },
            fields : {
                "teamProject.tpName" : {
                    validators : {
                        notEmpty : {
                            message : "项目名不能为空",
                        },stringLength: {
                            min: 1,
                            max: 30,
                            message: '请输入1-30个字符'
                        }
                    }
                },"teamProject.tpMsg" : {
                    validators : {
                        notEmpty : {
                            message : "项目描述不能为空",
                        },stringLength: {
                            min: 1,
                            max: 100,
                            message: '请输入1-100个字符'
                        },
                    }
                }
            }
        });




    })














    $ (document). ready (function() {














    })




</script>
</body>
</html>
