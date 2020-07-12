<%--
  Created by IntelliJ IDEA.
  User: 李旭
  Date: 2020/4/30
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

    <style type="text/css">

        .table{
            margin-bottom: 0px;
            cursor:pointer;

        }
        .table th, .table td {
            text-align: left;
            vertical-align: middle !important;


        }
        .list-group{
            cursor:pointer;

        }
        .resultInfo li {

            text-align: right;
        }
        .resultInfo li:hover {
            background: #f5f5f5;

        }
        .resultInfo li button{

            margin-left: 10px;
            margin-right: 10px;
        }

        #noTestRecord{

            margin-top: 50px;
            text-align: center;
            display: none;
        }
        #testRecordPageDiv{
            display: none;
        }

        #recordShowDiv{
            display: none;
        }

    </style>

</head>
<body style="margin-top:70px;background: #E3E7EA">

<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
    <div class="alert alert-danger" role="alert" id="noTestRecord">
        <strong>您还没有测试记录，点击</strong>
        <a href="<%=basePath%>fileupload/fileupload.jsp" class="alert-link">提交检查</a>前往测试！
    </div>

    <div class="row" id="testRecordPageDiv">
        <div class="col-md-8 col-md-offset-3">
            <nav class="pull-right">
                <ul class="pagination" id="page_value_init">
                    <li>

                        <div class="col-md-4">
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
                        <div class="col-md-5 pull-right">
                            <div class="pull-right" style="line-height:34px;" >共有<span id="recordNumber_value"></span>条记录，当前第 <span id="currentPage_value"></span>/<span id="totalPage_value"></span>页</div>
                        </div>
                    </li>
                    <%--<li>
                        <div class="col-md-4">
                            <div class="pull-right" style="line-height:34px;" >共有<span id="recordNumber_value"></span>条记录，当前第 <span id="currentPage_value"></span>/<span id="totalPage_value"></span>页</div>
                        </div>
                    </li>--%>
                </ul>
            </nav>
        </div>
    </div>


    <div class="panel-group" id="recordShowDiv" role="tablist" aria-multiselectable="true">
        <div class="panel panel-default" id="recordShowDivTitle">
            <div class="panel-heading" role="tab" id="headingtitle">
                <h4 class="panel-title">
                    <table class="table table-hover">
                        <thead>
                        <td class="col-sm-3">序号</td>
                        <td class="col-sm-3">测试日期</td>
                        <td class="col-sm-3">测试文件数</td>
                        <td class="col-sm-3">测试规则数</td>
                        </thead>
                    </table>
                </h4>
            </div>

        </div>



        <%--<div class="panel panel-default">
            <div class="panel-heading" role="tab" id="heading01">
                <h4 class="panel-title">
                    <div data-toggle="collapse" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse01" aria-expanded="false" aria-controls="collapse01">
                        <table class="table table-hover">
                            <thead>
                                <td class="col-sm-3">1</td>
                                <td class="col-sm-3">2019-1-1 10:23:23</td>
                                <td class="col-sm-3">5</td>
                                <td class="col-sm-3">3</td>
                            </thead>
                        </table>
                    </div>
                </h4>
            </div>
            <div id="collapse01" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading01">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="list-group">
                                <a class="list-group-item list-group-item-info" id="testFileTitle">
                                    测试文件列表
                                </a>
                                <a class="list-group-item">asafdasfd.prt</a>
                                <a class="list-group-item">asafdasfd.prt</a>
                                <a class="list-group-item">asdfasafdasfd.prt</a>
                                <a class="list-group-item">Vestibulumasafdasfd.prt</a>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="list-group">
                                <a class="list-group-item list-group-item-info" id="testRuleTitle">
                                    测试选项列表
                                </a>
                                <a class="list-group-item">Dapibus ac facilisis in</a>
                                <a class="list-group-item">Morbi leo risus</a>
                                <a class="list-group-item">Porta ac consectetur ac</a>
                                <a class="list-group-item">Vestibulum at eros</a>
                                <a class="list-group-item">Dapibus ac facilisis in</a>
                                <a class="list-group-item">Morbi leo risus</a>
                                <a class="list-group-item">Porta ac consectetur ac</a>
                                <a class="list-group-item">Vestibulum at eros</a>
                            </div>
                        </div>
                    </div>
                    <ul class="list-group resultInfo">
                        <li class="list-group-item">
                            <button recordId="1" type="button" class="btn btn-success resultInfo_info">查看详情</button>
                            <button recordId="1" type="button" class="btn btn-danger resultInfo_remove">删除此条记录</button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>--%>



    </div>











</div>

<script src="<%=basePath%>plugins/jquery.min.js"></script>
<script src="<%=basePath%>plugins/bootstrap.js"></script>
<script src="<%=basePath%>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath%>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath%>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>

<script>

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
        $("#recordShowDivTitle").siblings("div").remove();

        //alert(currentPage);
        initTestRecord(currentPage);
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
        $("#testRecordPageDiv").show();
    }

    function initRuleDiv(ruleNames) {
        var $ruleDiv = $("<div class=\"col-sm-6\"></div>");
        var $ruleListGroup = $("<div class=\"list-group\"></div>");
        var $testRuleTitle=$("<a class=\"list-group-item list-group-item-info\" id=\"testRuleTitle\">\n" +
            "                                    测试选项列表\n" +
            "                                </a>");
        $ruleListGroup.append($testRuleTitle);
        ruleNames.forEach(function (data,index) {
            var $rulea=$("<a class=\"list-group-item\">"+data+"</a>");

            $ruleListGroup.append($rulea);
        })
        $ruleDiv.append($ruleListGroup);
        return $ruleDiv;
    }
    function initFileDiv(fileNames) {
        var $fileDiv = $("<div class=\"col-sm-6\"></div>");
        var $fileListGrop = $("<div class=\"list-group\"></div>");
        var $testFileTitle = $("<a class=\"list-group-item list-group-item-info\" id=\"testFileTitle\">\n" +
            "                    测试文件列表\n" +
            "                    </a>");
        $fileListGrop.append($testFileTitle);
        fileNames.forEach(function (data,index) {
            var sfrRealName = data.sfrFileName;
            var sfrId = data.sfrId;
            var $fileLi = $('<a sfrId="'+sfrId+'" class="list-group-item">'+sfrRealName+'</a>');
            $fileListGrop.append($fileLi);

        })
        $fileDiv.append($fileListGrop);
        return $fileDiv;

    }
    function resultInfo_remove_click(recordId){

        if(confirm("是否要删除！")){

            $.ajax({
                url : "<%=basePath%>" + "submitRecord/deleteRecordBySrId",
                type : 'post',
                dataType: "json",
                data : {
                    "_method" : "delete",   // 将请求转变为PUT请求
                    "recordId":recordId},
                success : function (obj, response, status) {
                    if (obj.success) {

                        alert(obj.message);
                        location.reload();
                    } else {
                        alert(obj.message);
                    }
                }
            });


        }
    }
    function resultInfo_info_click(recordId) {

        var f=document.createElement('form');
        f.style.display='none';
        f.action="<%=basePath%>"+"testresult/testresult.jsp";
        f.method='post';
        f.innerHTML="<input type=\"hidden\" name=\"recordId\" value=\""+recordId+"\"/>";
        document.body.appendChild(f);
        f.submit();

    }

    function initTestRecordData(value,index) {
        /*模板*/

        /*<div class="panel panel-default">
           <div class="panel-heading" role="tab" id="heading01">
               <h4 class="panel-title">
                   <div data-toggle="collapse" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapse01" aria-expanded="false" aria-controls="collapse01">
                       <table class="table table-hover">
                           <thead>
                               <td class="col-sm-3">1</td>
                               <td class="col-sm-3">2019-1-1 10:23:23</td>
                               <td class="col-sm-3">5</td>
                               <td class="col-sm-3">3</td>
                           </thead>
                       </table>
                   </div>
               </h4>
           </div>
           <div id="collapse01" class="panel-collapse collapse" role="tabpanel" aria-labelledby="heading01">
               <div class="panel-body">
                   <div class="row">
                       <div class="col-sm-6">
                           <div class="list-group">
                               <a class="list-group-item list-group-item-info" id="testFileTitle">
                                   测试文件列表
                               </a>
                               <a class="list-group-item">asafdasfd.prt</a>
                               <a class="list-group-item">asafdasfd.prt</a>
                               <a class="list-group-item">asdfasafdasfd.prt</a>
                               <a class="list-group-item">Vestibulumasafdasfd.prt</a>
                           </div>
                       </div>
                       <div class="col-sm-6">
                           <div class="list-group">
                               <a class="list-group-item list-group-item-info" id="testRuleTitle">
                                   测试选项列表
                               </a>
                               <a class="list-group-item">Dapibus ac facilisis in</a>
                               <a class="list-group-item">Morbi leo risus</a>
                               <a class="list-group-item">Porta ac consectetur ac</a>
                               <a class="list-group-item">Vestibulum at eros</a>
                               <a class="list-group-item">Dapibus ac facilisis in</a>
                               <a class="list-group-item">Morbi leo risus</a>
                               <a class="list-group-item">Porta ac consectetur ac</a>
                               <a class="list-group-item">Vestibulum at eros</a>
                           </div>
                       </div>
                   </div>
                   <ul class="list-group resultInfo">
                       <li class="list-group-item">
                           <button recordId="1" type="button" class="btn btn-success resultInfo_info">查看详情</button>
                           <button recordId="1" type="button" class="btn btn-danger resultInfo_remove">删除此条记录</button>
                       </li>
                   </ul>
               </div>
           </div>
        </div>*/

        /*获取数据*/
        var submitRecord = value.submitRecord;
        var ruleNames = value.ruleNames;
        var fileNames = value.fileNames;
        /*序号*/
        var serialNumber = index + 1;

        /*构造页面*/
        var $pannel = $(" <div class=\"panel panel-default\"></dev>");
        /*构造header*/
        var $pannelHeader = $("<div class=\"panel-heading\" role=\"tab\" id=\"heading"+serialNumber+"\">\n" +
            "                <h4 class=\"panel-title\">\n" +
            "                    <div data-toggle=\"collapse\" role=\"button\" data-toggle=\"collapse\" data-parent=\"#recordShowDiv\" href=\"#collapse"+serialNumber+"\" aria-expanded=\"false\" aria-controls=\"collapse"+serialNumber+"\">\n" +
            "                        <table class=\"table table-hover\">\n" +
            "                            <thead>\n" +
            "                                <td class=\"col-sm-3\">"+serialNumber+"</td>\n" +
            "                                <td class=\"col-sm-3\">"+submitRecord.srDate+"</td>\n" +
            "                                <td class=\"col-sm-3\">"+submitRecord.srFileNumber+"</td>\n" +
            "                                <td class=\"col-sm-3\">"+submitRecord.srRuleNumber+"</td>\n" +
            "                            </thead>\n" +
            "                        </table>\n" +
            "                    </div>\n" +
            "                </h4>\n" +
            "            </div>");
        var $collapseIIndex=$("<div id=\"collapse"+serialNumber+"\" class=\"panel-collapse collapse\" role=\"tabpanel\" aria-labelledby=\"heading"+serialNumber+"\"></div>");
        var $pannelBody=$("<div class=\"panel-body\"></div>");

        var $row=$("<div class=\"row\"></div>");
        var $fileDiv = initFileDiv(fileNames);
        var $ruleDiv = initRuleDiv(ruleNames);
        $row.append($fileDiv);
        $row.append($ruleDiv);
       var $buttonUl=$("<ul class=\"list-group resultInfo\">\n" +
           "                        <li class=\"list-group-item\">\n" +
           "                            <button onclick=\"resultInfo_info_click("+submitRecord.srId+")\" type=\"button\" class=\"btn btn-success resultInfo_info\">查看详情</button>\n" +
           "                            <button onclick=\"resultInfo_remove_click("+submitRecord.srId+")\" type=\"button\" class=\"btn btn-danger resultInfo_remove\">删除此条记录</button>\n" +
           "                        </li>\n" +
           "                    </ul>");


        $pannelBody.append($row);
        $pannelBody.append($buttonUl);
        $collapseIIndex.append($pannelBody);
        $pannel.append($pannelHeader);
        $pannel.append($collapseIIndex);

        $("#recordShowDiv").append($pannel);

        $("#recordShowDiv").show();

    }



    function initTestRecord(currentPage){

        $.ajax({
            url : "<%=basePath%>" + "submitRecord/testRecordList",
            type : 'get',
            dataType: "json",
            data : {"currentPage":currentPage},
            success : function (obj, response, status) {
                if (obj.success) {
                    console.log(obj);
                    initPage(obj.obj.page.currentPage,obj.obj.page.totalPage,obj.obj.page.recordNumber);
                    obj.obj.result.forEach(function (value,index) {

                        initTestRecordData(value,index);
                    })
                } else {
                    /*用户输入异常！测试记录为0*/
                    if (obj.status==400){

                        $("#noTestRecord").show();
                        $("#recordShowDiv").hide();
                        $("#testRecordPageDiv").hide();


                    }else {
                        //console.log(obj);
                        alert(obj.message);
                        window.location.href = "<%=basePath%>";
                    }

                }
            }
        });


    }

    $(function() {
        initTestRecord(1);
    });



</script>

</body>
</html>
